import 'package:flutter/material.dart';

import '../resources/fight_club_colors.dart';

class ActionButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final Color bcolor;

  const ActionButton(
      {super.key,
        required this.onTap,
        required this.bcolor,
        required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: bcolor,
        height: 40,
        alignment: Alignment.center,
        child: Container(

          child: Text(
            title.toUpperCase(),
            style: TextStyle(
                color: FightClubColors.whiteText,
                fontWeight: FontWeight.w900,
                fontSize: 16),
          ),
        ),
      ),
    );


  }

}
