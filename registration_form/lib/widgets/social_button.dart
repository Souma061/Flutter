import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:registration_form/palette.dart';

class SocialButton extends StatelessWidget {
  final String iconPath;
  final String label;
  final double horizontalPadding;
  final VoidCallback onPressed;
  const SocialButton({super.key, required this.iconPath, required this.label, this.horizontalPadding = 60, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: SvgPicture.asset(
        iconPath,
        height: 30,
        width: 30,
        colorFilter: const ColorFilter.mode(
          Pallete.whiteColor,
          BlendMode.srcIn,
        ),
      ),
      label: Text(
        label,
        style: const TextStyle(color: Pallete.whiteColor, fontSize: 16),
      ),
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: horizontalPadding),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
          side: const BorderSide(color: Pallete.borderColor, width: 3),
        ),
      ),
    );
  }
}
