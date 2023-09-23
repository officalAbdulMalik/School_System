import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../../utils/colors.dart';

class PreferencesScreen extends StatefulWidget {
  const PreferencesScreen({super.key});

  @override
  State<PreferencesScreen> createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends State<PreferencesScreen> {
  bool positive1 = false;
  bool positive2 = false;
  bool positive3 = false;
  String language = "Language";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: kButtonColor,
        title: Text(
          'Preferences',
          style: GoogleFonts.acme(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      backgroundColor: kPrimaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              height: 50,
              width: 340,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(15),
                gradient: const LinearGradient(
                    colors: [
                      Color(0xFFC7CEF1),
                      Color(0xFF8C9BE3),
                    ],
                    begin: FractionalOffset(0.0, 0.0),
                    end: FractionalOffset(1.0, 0.0),
                    stops: [0.1, 1.0],
                    tileMode: TileMode.decal),
              ),
              child: Row(
                children: [
                  Icon(Icons.language),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      flex: 2,
                      child: Text(
                        language,
                        style:
                            GoogleFonts.acme(color: Colors.black, fontSize: 11),
                      )),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: DropdownButton<String>(
                        underline: const SizedBox(),
                        items: <String>[
                          'English',
                          'Scots',
                          'Welsh',
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          language = value!;
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.only(top: 5, bottom: 5, left: 20),
              height: 50,
              width: 340,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(15),
                gradient: const LinearGradient(
                    colors: [
                      Color(0xFFC7CEF1),
                      Color(0xFF8C9BE3),
                    ],
                    begin: FractionalOffset(0.0, 0.0),
                    end: FractionalOffset(1.0, 0.0),
                    stops: [0.1, 1.0],
                    tileMode: TileMode.decal),
              ),
              child: Row(
                children: [
                  Icon(Icons.do_not_disturb_on_total_silence),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      flex: 2,
                      child: Text(
                        "Do not Disturb",
                        style:
                            GoogleFonts.acme(color: Colors.black, fontSize: 11),
                      )),
                  Expanded(
                    child: CustomAnimatedToggleSwitch<bool>(
                      current: positive1,
                      values: [false, true],
                      dif: 0.0,
                      indicatorSize: Size.square(27.0),
                      animationDuration: const Duration(milliseconds: 200),
                      animationCurve: Curves.linear,
                      onChanged: (b) => setState(() => positive1 = b),
                      iconBuilder: (context, local, global) {
                        return const SizedBox();
                      },
                      defaultCursor: SystemMouseCursors.click,
                      onTap: () => setState(() => positive1 = !positive1),
                      iconsTappable: false,
                      wrapperBuilder: (context, global, child) {
                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            Positioned(
                                left: 25.0,
                                right: 25.0,
                                height: 30.0,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: Color.lerp(Colors.black26,
                                        Colors.white, global.position),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(50.0)),
                                  ),
                                )),
                            child,
                          ],
                        );
                      },
                      foregroundIndicatorBuilder: (context, global) {
                        return SizedBox.fromSize(
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: Color.lerp(
                                  Colors.white, kPrimaryColor, global.position),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0)),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black38,
                                    spreadRadius: 0.05,
                                    blurRadius: 1.1,
                                    offset: Offset(0.0, 0.8))
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.only(top: 5, bottom: 5, left: 20),
              height: 50,
              width: 340,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(15),
                gradient: const LinearGradient(
                    colors: [
                      Color(0xFFC7CEF1),
                      Color(0xFF8C9BE3),
                    ],
                    begin: FractionalOffset(0.0, 0.0),
                    end: FractionalOffset(1.0, 0.0),
                    stops: [0.1, 1.0],
                    tileMode: TileMode.decal),
              ),
              child: Row(
                children: [
                  Icon(Icons.notifications),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      flex: 2,
                      child: Text(
                        "Push Notifications",
                        style:
                            GoogleFonts.acme(color: Colors.black, fontSize: 11),
                      )),
                  Expanded(
                    child: CustomAnimatedToggleSwitch<bool>(
                      current: positive2,
                      values: [false, true],
                      dif: 0.0,
                      indicatorSize: Size.square(27.0),
                      animationDuration: const Duration(milliseconds: 200),
                      animationCurve: Curves.linear,
                      onChanged: (b) => setState(() => positive2 = b),
                      iconBuilder: (context, local, global) {
                        return const SizedBox();
                      },
                      defaultCursor: SystemMouseCursors.click,
                      onTap: () => setState(() => positive2 = !positive2),
                      iconsTappable: false,
                      wrapperBuilder: (context, global, child) {
                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            Positioned(
                                left: 25.0,
                                right: 25.0,
                                height: 30.0,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: Color.lerp(Colors.black26,
                                        Colors.white, global.position),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(50.0)),
                                  ),
                                )),
                            child,
                          ],
                        );
                      },
                      foregroundIndicatorBuilder: (context, global) {
                        return SizedBox.fromSize(
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: Color.lerp(
                                  Colors.white, kPrimaryColor, global.position),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0)),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black38,
                                    spreadRadius: 0.05,
                                    blurRadius: 1.1,
                                    offset: Offset(0.0, 0.8))
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.only(top: 5, bottom: 5, left: 20),
              height: 50,
              width: 340,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(15),
                gradient: const LinearGradient(
                    colors: [
                      Color(0xFFC7CEF1),
                      Color(0xFF8C9BE3),
                    ],
                    begin: FractionalOffset(0.0, 0.0),
                    end: FractionalOffset(1.0, 0.0),
                    stops: [0.1, 1.0],
                    tileMode: TileMode.decal),
              ),
              child: Row(
                children: [
                  Icon(Icons.email),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      flex: 2,
                      child: Text(
                        "Email Notifications",
                        style:
                            GoogleFonts.acme(color: Colors.black, fontSize: 11),
                      )),
                  Expanded(
                    child: CustomAnimatedToggleSwitch<bool>(
                      current: positive3,
                      values: [false, true],
                      dif: 0.0,
                      indicatorSize: Size.square(27.0),
                      animationDuration: const Duration(milliseconds: 200),
                      animationCurve: Curves.linear,
                      onChanged: (b) => setState(() => positive3 = b),
                      iconBuilder: (context, local, global) {
                        return const SizedBox();
                      },
                      defaultCursor: SystemMouseCursors.click,
                      onTap: () => setState(() => positive3 = !positive3),
                      iconsTappable: false,
                      wrapperBuilder: (context, global, child) {
                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            Positioned(
                                left: 25.0,
                                right: 25.0,
                                height: 30.0,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: Color.lerp(Colors.black26,
                                        Colors.white, global.position),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(50.0)),
                                  ),
                                )),
                            child,
                          ],
                        );
                      },
                      foregroundIndicatorBuilder: (context, global) {
                        return SizedBox.fromSize(
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: Color.lerp(
                                  Colors.white, kPrimaryColor, global.position),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0)),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black38,
                                    spreadRadius: 0.05,
                                    blurRadius: 1.1,
                                    offset: Offset(0.0, 0.8))
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
