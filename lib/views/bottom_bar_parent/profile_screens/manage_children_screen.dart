import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/colors.dart';
import 'add_child_screen.dart';

class ManageChildrenScreen extends StatefulWidget {
  const ManageChildrenScreen({super.key});

  @override
  State<ManageChildrenScreen> createState() => _ManageChildrenScreenState();
}

class _ManageChildrenScreenState extends State<ManageChildrenScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: kButtonColor,
        title: Text(
          'Children',
          style: GoogleFonts.acme(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topCenter,
          padding: const EdgeInsets.symmetric(horizontal: 21),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                "Manage your Children",
                style: GoogleFonts.acme(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddChildScreen()));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(20), top: Radius.circular(20)),
                    gradient: LinearGradient(
                        colors: [
                          Color(0xFFC7CEF1),
                          Color(0xFF8C9BE3),
                        ],
                        end: FractionalOffset(0.0, 0.0),
                        begin: FractionalOffset(1.0, 0.0),
                        stops: [0.1, 1.0],
                        tileMode: TileMode.decal),
                  ),
                  child: ListTile(
                    leading: Container(
                        height: 60,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: const Color(0xffdbeffe),
                            borderRadius: BorderRadius.circular(50)),
                        child: Image.asset('images/users.png')),
                    title: Text(
                      "Add a child",
                      style: GoogleFonts.acme(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    trailing: IconButton(
                        onPressed: () {}, icon: const Icon(Icons.add)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
