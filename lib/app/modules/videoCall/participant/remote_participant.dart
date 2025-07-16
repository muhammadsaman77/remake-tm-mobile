import 'package:talabang_mandau/app/modules/videoCall/utils/session.dart';
import 'package:talabang_mandau/app/modules/videoCall/participant/participant.dart';

typedef OnRemoteParticipantStreamChangeEvent = void Function(
    Map<String, dynamic>);

class RemoteParticipant extends Participant {
  OnRemoteParticipantStreamChangeEvent? onStreamChangeEvent;

  RemoteParticipant(
      String connectionId, String participantName, Session session)
      : super.withConnectionId(connectionId, participantName, session) {
    session.addRemoteParticipant(this);
  }

  changeCameraStatus(bool newValue) {
    mediaStream?.getVideoTracks().forEach((element) {
      element.enabled = newValue;
    });

    isVideoActive = newValue;
  }

  changeMicrophoneStatus(bool newValue) {
    mediaStream?.getAudioTracks().forEach((element) {
      element.enabled = newValue;
    });

    isAudioActive = newValue;
  }
}
