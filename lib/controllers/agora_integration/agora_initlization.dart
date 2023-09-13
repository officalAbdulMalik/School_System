import 'package:agora_uikit/agora_uikit.dart';
import 'package:flutter/material.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({Key? key}) : super(key: key);

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  final AgoraClient client = AgoraClient(
    agoraConnectionData: AgoraConnectionData(
        appId: "66d61963e8ee436ca70353cedcf2161c",
        channelName: "test",
        uid: 1,
        username: "user",
        tempToken:
            "007eJxTYOD4m+Xp78c54X6Nw+IF57e3MC4953DmXPuVtx6ycziU3f8pMJiZpZgZWpoZp1qkppoYmyUnmhsYmxonp6YkpxkZmhkmn+HRSPaO00zeN+EkCyMDBIL4LAwlqcUlDAwAYPIgkw=="),
    enabledPermission: [Permission.camera, Permission.microphone],
  );
  @override
  void initState() {
    initAgora();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              AgoraVideoViewer(client: client),
              AgoraVideoButtons(client: client)
            ],
          ),
        ),
      ),
    );
  }

  void initAgora() async {
    await client.initialize();
  }
}
