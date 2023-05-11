import 'package:flutter/material.dart';
import 'package:flutter_fight_club/resources/fight_club_colors.dart';
import 'package:flutter_fight_club/widgets/action_button.dart';
import 'package:flutter_fight_club/widgets/secondary_action_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StatisticsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FightClubColors.background,
      body: SafeArea(
        child: Column(children: [
          Container(
            height: 40,
            alignment: Alignment.center,
            child: Text(
              "Statistics".toUpperCase(),
              style: TextStyle(
                  color: FightClubColors.blackButton,
                  fontWeight: FontWeight.w900,
                  fontSize: 16),
            ),
          ),
          Expanded(child: SizedBox()),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Won:',
                        style: TextStyle(
                            color: FightClubColors.blackButton,
                            fontWeight: FontWeight.w400,
                            fontSize: 16),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Container(
                        child: FutureBuilder<int?>(
                            future: SharedPreferences.getInstance().then(
                                (sharedPreferences) => sharedPreferences
                                    .getInt('won_stat')),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData || snapshot.data == null) {
                                return const Text("0");
                              }
                              return Text(
                                snapshot.data!.toString(),
                                style: TextStyle(
                                    color: FightClubColors.blackButton,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16),
                              );
                            }),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Drow:',
                        style: TextStyle(
                            color: FightClubColors.blackButton,
                            fontWeight: FontWeight.w400,
                            fontSize: 16),
                      ),
                      SizedBox(
                        width: 16,
                      ),
              Container(
                child: FutureBuilder<int?>(
                    future: SharedPreferences.getInstance().then(
                            (sharedPreferences) => sharedPreferences
                            .getInt('draw_stat')),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData || snapshot.data == null) {
                        return const Text("0");
                      }
                      return Text(
                        snapshot.data!.toString(),
                        style: TextStyle(
                            color: FightClubColors.blackButton,
                            fontWeight: FontWeight.w400,
                            fontSize: 16),
                      );
                    }),
              ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Lost:',
                        style: TextStyle(
                            color: FightClubColors.blackButton,
                            fontWeight: FontWeight.w400,
                            fontSize: 16),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Container(
                        child: FutureBuilder<int?>(
                            future: SharedPreferences.getInstance().then(
                                    (sharedPreferences) => sharedPreferences
                                    .getInt('lost_stat')),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData || snapshot.data == null) {
                                return const Text("0");
                              }
                              return Text(
                                snapshot.data!.toString(),
                                style: TextStyle(
                                    color: FightClubColors.blackButton,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16),
                              );
                            }),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(child: SizedBox()),
          Container(
            width: 400,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
                border: Border.all(
              width: 2,
              color: Colors.black,
            )),
            child: SecondaryActionButton(
                onTap: () => {Navigator.of(context).pop()}, title: "BACK"),
          ),
          Expanded(
              child: SizedBox(
            height: 16,
          )),
        ]),
      ),
    );
  }
}
