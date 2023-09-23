import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../bottom_bar_parent/profile_screens/subscription_screen.dart';
import 'container_decoration.dart';

class MenuCustomTab {
  static customTab(
      BuildContext context, String title, VoidCallback onTap, String image) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        decoration: ContinerDecoration.continerDecoration(),
        child: ListTile(
          leading: Container(
              height: 40,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: const Color(0xffdbeffe),
                  borderRadius: BorderRadius.circular(50)),
              child: Image.asset("$image")),
          title: Text(
            title,
            style: GoogleFonts.acme(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
          ),
          trailing: IconButton(
              onPressed: onTap, icon: const Icon(Icons.keyboard_arrow_right)),
        ),
      ),
    );
  }
}
