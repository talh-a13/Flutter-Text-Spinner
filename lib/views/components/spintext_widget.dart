import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SpinnerText extends StatelessWidget {
  final String text;

  const SpinnerText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: 3,
      child: Container(
        foregroundDecoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            stops: const [0.0, 0.2, 0.8],
            colors: [
              Colors.transparent,
              const Color(0xFF0A0A0A).withValues(alpha: 0.9),
              Colors.transparent,
            ],
          ),
        ),
        child: ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Colors.white, Color(0xFF6C63FF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(bounds),
          child: Text(
            text,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 100,
              fontWeight: FontWeight.w800,
              letterSpacing: -2,
            ),
          ),
        ),
      ),
    );
  }
}
