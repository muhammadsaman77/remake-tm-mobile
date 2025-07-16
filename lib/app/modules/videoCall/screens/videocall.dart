import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:talabang_mandau/app/components/dialog.dart';
import 'package:talabang_mandau/app/data/providers/call_providers.dart';
import 'package:talabang_mandau/app/data/service_provider.dart';
import 'package:talabang_mandau/app/env/colors.dart';
import 'package:talabang_mandau/app/modules/home/views/home_view.dart';
import 'package:talabang_mandau/app/modules/tabDecider/views/tab_decider_view.dart';

import 'package:talabang_mandau/app/modules/videoCall/participant/local_participant.dart';
import 'package:talabang_mandau/app/modules/videoCall/participant/participant.dart';
import 'package:talabang_mandau/app/modules/videoCall/utils/custom_websocket.dart';
import 'package:talabang_mandau/app/modules/videoCall/utils/session.dart';
import 'package:talabang_mandau/app/modules/videoCall/utils/utils.dart';
import 'package:talabang_mandau/app/modules/videoCall/widgets/chat_screen.dart';
import 'package:talabang_mandau/app/modules/videoCall/widgets/custom_draggable.dart';
import 'package:talabang_mandau/app/modules/videoCall/widgets/participant_widget.dart';
import 'package:talabang_mandau/app/modules/videoCall/screens/prepare_videocall.dart';
import 'package:talabang_mandau/app/widgets/text.dart';

class VideocallWidget extends StatefulWidget {
  const VideocallWidget({
    super.key,
    required this.server,
    required this.sessionId,
    required this.userName,
    required this.secret,
    required this.iceServer,
  });

  final String server;
  final String sessionId;
  final String userName;
  final String secret;
  final String iceServer;

  @override
  State<VideocallWidget> createState() => _VideocallWidgetState();
}

class _VideocallWidgetState extends State<VideocallWidget> {
  Session? session;

  @override
  void initState() {
    super.initState();
    // apiService = ApiService(widget.sessionId, widget.server, widget.secret,
    //     (X509Certificate cert, String host, int port) => true);
    // print("apiService:${apiService.sessionId}");
    // print("apiService:${apiService.secret}");
    // print("apiService:${apiService.url}");

    _connect();
  }

  void _hangUp() {
    if (session != null) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => TabDeciderView()));
    }
  }

  void _switchCamera() {
    session?.localParticipant?.switchCamera().then((value) {
      refresh();
    });
  }

  void _toggleVideo() {
    session?.localToggleVideo();
    refresh();
  }

  void _toggleMic() {
    session?.localToggleAudio();
    refresh();
  }

  void _showMessages() {
    if ((session?.unreadMessages ?? 0) > 0) {
      session?.messages.where((m) => !m.isReaded).forEach((msg) {
        msg.isReaded = true;
      });
      setState(() {});
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ChatScreen(
          session: session!,
        ),
        fullscreenDialog: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F6F6),
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0.0,
        title: CText(
          "Video Call",
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
        actions: [
          SizedBox(
            height: 48,
            child: Image.asset(
              "assets/icon/logo_telabang_icon.png",
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
      body: _body(),
    );
  }

  @override
  void dispose() {
    session?.leaveSession();
    super.dispose();
  }

  void refresh() {
    if (context.mounted) {
      setState(() {});
    }
  }

  void startWebSocket() {
    CustomWebSocket webSocket = CustomWebSocket(
      session!,
      customClient: HttpClient()
        ..badCertificateCallback =
            (X509Certificate cert, String host, int port) => true,
    );
    webSocket.onErrorEvent = (error) {
      if (context.mounted) {
        print("startWebSocket error : $error");
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error)));
      }
    };
    webSocket.connect();
    session?.setWebSocket(webSocket);
  }

  Future<void> _connect() async {
    var responseSession = await CallProviders().createSession();
    print("responseSession:$responseSession");
    if (responseSession != null) {
      var responseToken = await CallProviders().createToken(responseSession);
      print("responseToken:$responseToken");

      if (responseToken != null) {
        session = Session("sessionId", responseToken);
        session?.messageStream.listen((message) {
          setState(() {});
        });

        session!.onNotifySetRemoteMediaStream = (String connectionId) {
          refresh();
        } as OnNotifySetRemoteMediaStreamEvent?;
        session!.onAddRemoteParticipant = (String connectionId) {
          refresh();
        } as OnAddRemoteParticipantEvent?;
        session!.onRemoveRemoteParticipant = (String connectionId) {
          refresh();
        } as OnRemoveRemoteParticipantEvent?;

        var localParticipant = LocalParticipant(widget.userName, session!);
        localParticipant.renderer.initialize().then((value) {
          localParticipant.startLocalCamera().then((stream) => refresh());
        });

        startWebSocket();
      } else {
        errorMessage("Gagal melakukan video call",
            "token sesi vidcall tidak ditemukan.");
      }
    } else {
      errorMessage(
          "Gagal melakukan video call", "Session vidcall tidak ditemukan.");
    }

    // apiService.createSession().then((sessionId) {
    //   apiService.createToken().then((token) {

    //   }).catchError((error) {
    //     if (context.mounted) {
    //       print("_connect error : $error");
    //       log("$error");
    //       ScaffoldMessenger.of(context)
    //           .showSnackBar(SnackBar(content: Text(error.toString())));
    //     }
    //   });
    // });
  }

  _body() {
    var remoteParticipants = session?.remoteParticipants.entries ?? [];

    return Stack(children: [
      Column(
        children: <Widget>[
          Expanded(
            child: remoteParticipants.isEmpty
                ? Column(children: [buildLocalRenderer(fullScreen: true)])
                : remoteParticipants.length == 1
                    ? Column(children: [
                        buildRendererContainer(remoteParticipants.elementAt(0)),
                      ])
                    : remoteParticipants.length == 2
                        ? Column(
                            children: remoteParticipants.map((participantPair) {
                              return buildRendererContainer(participantPair);
                            }).toList(),
                          )
                        : remoteParticipants.length == 3
                            ? Column(
                                children: [
                                  buildRendererContainer(
                                      remoteParticipants.elementAt(0)),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        buildRendererContainer(
                                            remoteParticipants.elementAt(1)),
                                        buildRendererContainer(
                                            remoteParticipants.elementAt(2)),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            : remoteParticipants.length == 4
                                ? Column(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            buildRendererContainer(
                                                remoteParticipants
                                                    .elementAt(0)),
                                            buildRendererContainer(
                                                remoteParticipants
                                                    .elementAt(1)),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          children: [
                                            buildRendererContainer(
                                                remoteParticipants
                                                    .elementAt(2)),
                                            buildRendererContainer(
                                                remoteParticipants
                                                    .elementAt(3)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                : GridView.builder(
                                    padding: const EdgeInsets.all(0.0),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount:
                                          2, // Adjust based on desired number of columns
                                      crossAxisSpacing: 1.0,
                                      mainAxisSpacing: 1.0,
                                      childAspectRatio: 1.0,
                                    ),
                                    itemCount: remoteParticipants.length,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        children: [
                                          buildRendererContainer(
                                              remoteParticipants
                                                  .elementAt(index)),
                                        ],
                                      );
                                    },
                                  ),
          ),
          _buttons(),
        ],
      ),
      (session?.remoteParticipants.entries ?? []).isEmpty
          ? const SizedBox.shrink()
          : CustomDraggable(
              initialX: MediaQuery.of(context).size.width - 100,
              initialY: MediaQuery.of(context).size.height - 300,
              width: 100,
              height: 150,
              child: buildLocalRenderer(),
            )
    ]);
  }

  Widget buildLocalRenderer({bool fullScreen = false}) {
    if (session?.localParticipant?.renderer == null) {
      if (fullScreen) {
        return const Expanded(
            child: Center(child: CircularProgressIndicator()));
      }
      return const Center(child: CircularProgressIndicator());
    }

    if (fullScreen) {
      return Expanded(child: buildLocalRendererBody(fullScreen: fullScreen));
    }

    return buildLocalRendererBody(fullScreen: fullScreen);
  }

  buildLocalRendererBody({bool fullScreen = false}) {
    return Container(
      width: fullScreen ? null : 100.0,
      height: fullScreen ? null : 150.0,
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                session!.localParticipant!.isVideoActive
                    ? RTCVideoView(session!.localParticipant!.renderer,
                        mirror:
                            session?.localParticipant?.isFrontCameraActive ??
                                false)
                    : _noVideoInitial(
                        session!.localParticipant!.participantName, fullScreen),
                Positioned(
                    child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(8.0)),
                  ),
                  padding: const EdgeInsets.only(
                      left: 8.0, right: 8.0, bottom: 4.0, top: 2.0),
                  child: session?.localParticipant?.participantName == null
                      ? const SizedBox.shrink()
                      : Text(session!.localParticipant!.participantName,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: fullScreen ? null : 8)),
                ))
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRendererContainer(MapEntry<String, Participant> remotePair) {
    return Expanded(
      child: ParticipantWidget(
        participant: remotePair.value,
      ),
    );
  }

  _noVideoInitial(String participantName, [bool fullScreen = true]) {
    var randomColor = getColorFromString(participantName);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Container(
            width: fullScreen ? 150.0 : 50.0,
            height: fullScreen ? 150.0 : 50.0,
            decoration: BoxDecoration(
              color: randomColor.withOpacity(0.5),
              border: Border.all(color: randomColor, width: 3.0),
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            ),
            child: Center(
              child: Text(participantName[0].toUpperCase(),
                  style: TextStyle(
                      fontSize: fullScreen ? 80 : 20, color: Colors.black)),
            ),
          ),
        )
      ],
    );
  }

  _buttons() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _noHeroFloatingActionButton(
            backgroundColor: primaryColor,
            onPressed: _toggleVideo,
            tooltip: session?.localParticipant?.isVideoActive ?? true
                ? 'Turn on video'
                : 'Turn off video',
            icon: Icon(
              session?.localParticipant?.isVideoActive ?? true
                  ? Icons.videocam
                  : Icons.videocam_off,
              color: Colors.white,
            ),
          ),
          if (session?.localParticipant?.isVideoActive ?? true)
            _noHeroFloatingActionButton(
              backgroundColor: primaryColor,
              onPressed: _switchCamera,
              tooltip: 'Switch Camera',
              icon: const Icon(
                Icons.switch_camera,
                color: Colors.white,
              ),
            ),
          _noHeroFloatingActionButton(
            onPressed: _hangUp,
            tooltip: 'Hang Up',
            backgroundColor: Colors.red,
            icon: const Icon(
              Icons.call_end,
              color: Colors.white,
            ),
          ),
          _noHeroFloatingActionButton(
            backgroundColor: primaryColor,
            onPressed: _toggleMic,
            tooltip: session?.localParticipant?.isAudioActive ?? true
                ? 'Mute Mic'
                : 'Unmute Mic',
            icon: Icon(
              session?.localParticipant?.isAudioActive ?? true
                  ? Icons.mic
                  : Icons.mic_off,
              color: Colors.white,
            ),
          ),
          _noHeroFloatingActionButton(
            backgroundColor: primaryColor,
            onPressed: _showMessages,
            tooltip: 'Messages',
            icon: const Icon(
              Icons.message_sharp,
              color: Colors.white,
            ),
            badge: (session?.unreadMessages ?? 0) == 0
                ? null
                : Text(
                    "${session?.unreadMessages}",
                    style: const TextStyle(color: Colors.white, fontSize: 11.0),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _noHeroFloatingActionButton(
      {required VoidCallback onPressed,
      required String tooltip,
      required Icon icon,
      Color? backgroundColor,
      Widget? badge}) {
    if (badge != null) {
      return Badge(
        label: badge,
        child: FloatingActionButton(
          onPressed: onPressed,
          tooltip: tooltip,
          backgroundColor: backgroundColor,
          child: icon,
        ),
      );
    }

    return FloatingActionButton(
      heroTag: null,
      onPressed: onPressed,
      tooltip: tooltip,
      backgroundColor: backgroundColor,
      child: icon,
    );
  }
}
