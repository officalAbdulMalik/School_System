import 'package:chat_bubbles/bubbles/bubble_special_two.dart';
import 'package:chat_bubbles/message_bars/message_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/colors.dart';

class ChatDetailsScreen extends StatefulWidget {
  const ChatDetailsScreen({Key? key}) : super(key: key);

  @override
  State<ChatDetailsScreen> createState() => _ChatDetailsScreenState();
}

class _ChatDetailsScreenState extends State<ChatDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.white),
            backgroundColor: kButtonColor,
            centerTitle: true,
            title: Text(
              'Chats',
              style: GoogleFonts.acme(
                color: Colors.white,
              ),
            ),
          ),
          backgroundColor: kPrimaryColor,
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 200,
                        child: ListView.builder(
                          reverse: true,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return BubbleSpecialTwo(
                              text: index == 1
                                  ? 'Hello'
                                  : index == 2
                                      ? "hi"
                                      : 'hello',
                              isSender: index == 1
                                  ? false
                                  : index == 2
                                      ? true
                                      : index == 3
                                          ? false
                                          : true,
                              color: Colors.black,
                              textStyle: TextStyle(
                                  fontFamily: 'SF UI Display',
                                  fontSize: 16,
                                  color: Colors.white),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              MessageBar(
                messageBarColor: kButtonColor,
                sendButtonColor: Colors.white,
                onSend: (chat) {
                  FocusManager.instance.primaryFocus?.unfocus();
                  // Helper.startChat('', chat);
                },
              ),
            ],
          )),
    );
  }
}
