import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/colors.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kButtonColor,
        title: Text(
          'How to Support ...? ',
          style: GoogleFonts.acme(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      backgroundColor: kPrimaryColor,
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 180,
              width: 180,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Image.asset('images/verfy_email.png'),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'No Active Subscriptions',
            textAlign: TextAlign.center,
            style: GoogleFonts.acme(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          Text(
            "Ohh...You don't have any active subscriptions",
            textAlign: TextAlign.center,
            style: GoogleFonts.acme(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          const Spacer(),
          InkWell(
            onTap: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => const SupportScreen()));
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: 50,
              width: 340,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                gradient: const LinearGradient(
                    colors: [
                      Color(0xFF2A3B5D),
                      Color(0xFF3D529B),
                    ],
                    end: FractionalOffset(0.0, 0.0),
                    begin: FractionalOffset(1.0, 0.0),
                    stops: [0.1, 1.0],
                    tileMode: TileMode.decal),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                      child: Text(
                    'Discover Prime',
                    style: GoogleFonts.acme(color: Colors.white, fontSize: 20),
                  )),
                  const Icon(
                    Icons.arrow_right_alt,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
