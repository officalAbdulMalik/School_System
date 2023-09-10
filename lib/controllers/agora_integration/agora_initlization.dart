// import 'dart:async';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:agora_rtc_engine/agora_rtc_engine.dart';
// class AgoraInit {
//   final String agoraAppId = "YOUR_APP_ID";
//   final String channelName = "test_channel";
//
//   RtcEngine? _engine;
//
//   Future<void> initForAgora() async {
//     // retrieve permissions
//     await [Permission.microphone, Permission.camera].request();
//     String appID = 'e0b79f7364044422aa152978dd675b02';
//     // create the engine for communicating with agora
//     _engine = await RtcEngine.create(appID);
//
//     // set up event handling for the engine
//     _engine?.setEventHandler(RtcEngineEventHandler(
//       joinChannelSuccess: (String channel, int uid, int elapsed) {
//         print('$uid successfully joined channel: $channel ');
//       },
//       userJoined: (int uid, int elapsed) {
//         print('remote user $uid joined channel');
//       },
//       userOffline: (int uid, UserOfflineReason reason) {
//         print('remote user $uid left channel');
//       },
//       rtcStats: (stats) {
//         //updates every two seconds
//       },
//     ));
//     // enable video
//     await _engine?.enableVideo();
//   }
//
//   void startMeeting() async {
//     await _engine?.joinChannel(null, 'channelName', null, 0);
//   }
//
//   void endMeeting() async {
//     await _engine?.leaveChannel();
//     // setState(() {
//     //   _isInChannel = false;
//     // });
//   }
// }
