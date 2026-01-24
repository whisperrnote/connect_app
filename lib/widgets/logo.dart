import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/theme/colors.dart';

class Logo extends StatelessWidget {
  final double size;
  final bool showText;

  const Logo({
    super.key,
    this.size = 38,
    this.showText = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: AppColors.electric,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: AppColors.electric.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: Text(
              'C',
              style: GoogleFonts.spaceGrotesk(
                color: Colors.black,
                fontWeight: FontWeight.w900,
                fontSize: size * 0.6,
              ),
            ),
          ),
        ),
        if (showText) ...[
          const SizedBox(width: 12),
          RichText(
            text: TextSpan(
              style: GoogleFonts.spaceGrotesk(
                fontWeight: FontWeight.w900,
                fontSize: size * 0.5,
                color: Colors.white,
                letterSpacing: -0.5,
              ),
              children: const [
                TextSpan(text: 'WHISPERR'),
                TextSpan(
                  text: 'CONNECT',
                  style: TextStyle(color: AppColors.electric),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
