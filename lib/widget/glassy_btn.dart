import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GlassyButton extends StatefulWidget {
  final String title;
  final Function() onTap;
  const GlassyButton({Key? key, required this.title, required this.onTap})
      : super(key: key);

  @override
  State<GlassyButton> createState() => _GlassyButtonState();
}

class _GlassyButtonState extends State<GlassyButton> {
  bool _isTapped = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (val) {
        setState(() {
          _isTapped = true;
        });
      },
      onTapUp: (val) => setState(() {
        widget.onTap();
        _isTapped = false;
      }),
      child: Stack(
        children: [
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 1),
                borderRadius: BorderRadius.circular(30),
                gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF176376),
                      Color(0xFF2C97B6),
                      Color(0xFF54B3CF)
                    ]),
              ),
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.white, Color(0xFF2C97B6), Colors.white]),
                ),
                child: Text(
                  widget.title,
                  style: GoogleFonts.poppins(fontSize: 18, color: Colors.black),
                ),
              )),
          if (_isTapped)
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 1),
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.grey.withOpacity(.5)),
                child: Container(
                  padding: const EdgeInsets.all(4),
                  child: Text(
                    widget.title,
                    style: GoogleFonts.poppins(
                        fontSize: 18, color: Colors.transparent),
                  ),
                )),
        ],
      ),
    );
  }
}
