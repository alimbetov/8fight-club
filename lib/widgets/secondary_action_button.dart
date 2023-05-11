import 'package:flutter/material.dart';
import 'package:flutter_fight_club/widgets/action_button.dart';

import '../resources/fight_club_colors.dart';

class SecondaryActionButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const SecondaryActionButton(
      {super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        alignment: Alignment.center,
        child: Container(
          child: Text(
            title,
            style: TextStyle(
                color: FightClubColors.blackButton,
                fontWeight: FontWeight.w900,
                fontSize: 16),
          ),
        ),
      ),
    );


  }
}
