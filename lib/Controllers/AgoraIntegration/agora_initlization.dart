import 'dart:async';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_uikit/controllers/rtc_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:school_system/Presentation/common/views/loginScreen.dart';
import 'package:school_system/Presentation/utils/colors.dart';
import 'package:school_system/Presentation/utils/custom_widget/custom_app_bar.dart';
import 'package:school_system/Presentation/utils/custom_widget/custom_widgets.dart';

// class AgoraInit {
//   Future<void> initAgora() async {
//     final RtcEngine engine;
//     // retrieve permissions
//     await [Permission.microphone, Permission.camera].request();
//
//     //create the engine
//     engine = createAgoraRtcEngine();
//     await engine.initialize(const RtcEngineContext(
//       appId: appId,
//       channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
//     ));
//
//     engine.registerEventHandler(RtcEngineEventHandler(
//       onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
//         debugPrint("local user ${connection.localUid} joined");
//         // setState(() {
//         //   _localUserJoined = true;
//         // });
//       },
//       onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
//         debugPrint("remote user $remoteUid joined");
//         // setState(() {
//         //   _remoteUid = remoteUid;
//         // });
//       },
//       onUserOffline: (RtcConnection connection, int remoteUid,
//           UserOfflineReasonType reason) {
//         debugPrint("remote user $remoteUid left channel");
//         // setState(() {
//         //   _remoteUid = null;
//         // });
//       },
//       onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
//         debugPrint(
//             '[onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token');
//       },
//     ));
//     await engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
//     await engine.enableVideo();
//     await engine.startPreview();
//
//     await engine.joinChannel(
//       channelId: channel,
//       uid: 0,
//       options: const ChannelMediaOptions(),
//       token: token,
//     );
//   }
// }

const appId = "e0b79f7364044422aa152978dd675b02";
const token =
    "007eJxTYPj758AXkVedB1ZNXaufunyL8qaCUD5rR4+ZDHblGhNvFBcrMKQaJJlbppkbm5kYmJiYGBklJhqaGlmaW6SkmJmbJhkYZd6xT20IZGRQb/rLxMgAgSA+N0NearlvaklJZl56MQMDAF4PIhs=";

class Agora extends StatefulWidget {
  const Agora({Key? key, required this.meatingID}) : super(key: key);

  final String meatingID;

  @override
  State<Agora> createState() => _AgoraState();
}

class _AgoraState extends State<Agora> {
  int? _remoteUid;
  bool _localUserJoined = false;
  late RtcEngine _engine;
  int secondsRemaining = 50;
  late Timer timer;

  bool voiceOff = false;

  @override
  void initState() {
    super.initState();
    _engine = createAgoraRtcEngine();
    // _remoteUid = 10;
    initAgora();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(
        () {
          if (timer.tick == 60) {
            if (secondsRemaining > 0) {
              secondsRemaining--;
            } else {
              // Timer is complete, show a dialog
              timer.cancel();
            }
          }
        },
      );
      // Stop the timer
    });
  }

  Future<void> initAgora() async {
    // retrieve permissions
    await [Permission.microphone, Permission.camera].request();

    //create the engine

    await _engine.initialize(const RtcEngineContext(
      appId: appId,
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
    ));

    _engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          debugPrint("local user ${connection.localUid} joined");
          setState(() {
            _localUserJoined = true;
          });
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          debugPrint("remote user $remoteUid joined");
          setState(() {
            _remoteUid = remoteUid;
          });
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          debugPrint("remote user $remoteUid left channel");
          setState(() {
            _remoteUid = null;
          });
        },
        onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
          debugPrint(
              '[onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token');
        },
      ),
    );

    await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await _engine.enableVideo();
    await _engine.startPreview();

    await _engine.joinChannel(
      token: token,
      channelId: "newMettings",
      uid: 0,
      options: const ChannelMediaOptions(),
    );
  }

  // Create UI with local view and remote view
  @override
  Widget build(BuildContext context) {
    print("voice off >???????????????${voiceOff}");

    return SafeArea(
      child: Scaffold(
        // appBar: const CustomAppBar(),
        body: Stack(
          children: [
            Center(
              child: _remoteVideo(),
            ),
            // Positioned(
            //   top: 20.sp,
            //   left: 20.sp,
            //   child: Container(
            //     width: 120,
            //     height: 170,
            //     decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(15.sp),
            //         color: Colors.redAccent),
            //   ),
            // ),
            Positioned(
              top: 20.sp,
              left: 20.sp,
              child: SizedBox(
                height: 150,
                width: 100.sp,
                child: AgoraVideoView(
                  controller: VideoViewController(
                    rtcEngine: _engine,
                    canvas: const VideoCanvas(
                      mirrorMode: VideoMirrorModeType.videoMirrorModeAuto,
                      renderMode: RenderModeType.renderModeAdaptive,
                      uid: 0,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
                top: 40.sp,
                child: Center(child: Text(secondsRemaining.toString()))),
            Positioned(
              bottom: 40.sp,
              left: 35.sp,
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      if (voiceOff == false) {
                        voiceOff = true;
                        _engine.disableAudio();
                      } else {
                        voiceOff = false;
                        _engine.enableAudio();
                      }

                      setState(() {});
                    },
                    child: CircleAvatar(
                      backgroundColor: kPrimaryColor,
                      child: Icon(
                        voiceOff == false ? Icons.volume_up : Icons.volume_off,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20.sp,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                        fixedSize: MaterialStatePropertyAll(Size(170.w, 30.h)),
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                        shape: MaterialStatePropertyAll(BeveledRectangleBorder(
                            borderRadius: BorderRadius.circular(5.sp)))),
                    onPressed: () {},
                    // Customize text color
                    child: const Text("End Call"),
                  ),
                  SizedBox(
                    width: 20.sp,
                  ),
                  InkWell(
                    onTap: () {
                      _engine.switchCamera();
                      setState(() {});
                    },
                    child: const CircleAvatar(
                      backgroundColor: kPrimaryColor,
                      child: Icon(
                        Icons.flip_camera_android,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Display remote user's video
  Widget _remoteVideo() {
    if (_remoteUid != null) {
      return AgoraVideoView(
        controller: VideoViewController.remote(
          rtcEngine: _engine,
          canvas: VideoCanvas(uid: _remoteUid),
          connection: RtcConnection(channelId: widget.meatingID),
        ),
      );
    } else {
      return const Text(
        'Please wait for remote user to join',
        textAlign: TextAlign.center,
      );
    }
  }
}
