import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_system/views/bottom_bar_parent/profile_screens/support_screen.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../../utils/colors.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: kButtonColor,
        title: Text(
          'Subscription',
          style: GoogleFonts.acme(
            color: Colors.white,
            fontSize: 15,
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
          ToggleSwitch(
            cornerRadius: 10,
            initialLabelIndex: 0,
            totalSwitches: 2,
            minWidth: 180,
            activeBgColor: const [Colors.white],
            activeFgColor: Colors.blue,
            inactiveBgColor: kH2Color,
            inactiveFgColor: Colors.white,
            labels: const ['Active', 'Expired'],
            onToggle: (index) {
              print('switched to: $index');
            },
          ),
          const SizedBox(
            height: 25,
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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SupportScreen()));
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
