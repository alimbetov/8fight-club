import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fight_club/find_result.dart';
import 'package:flutter_fight_club/pages/fight_page.dart';
import 'package:flutter_fight_club/pages/statistics_page.dart';
import 'package:flutter_fight_club/resources/fight_club_colors.dart';
import 'package:flutter_fight_club/resources/fight_club_images.dart';
import 'package:flutter_fight_club/widgets/action_button.dart';
import 'package:flutter_fight_club/widgets/secondary_action_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _MainPageContent();
  }
}

class _MainPageContent extends StatelessWidget {
  const _MainPageContent({Key? key}) : super(key: key);

  Color getFightResultColor(String fight_result) {
    if (fight_result == FightResult.won) {
      return FightClubColors.winColor;
    }
    if (fight_result == FightResult.drow) {
      return FightClubColors.drawColor;
    }
    if (fight_result == FightResult.lost) {
      return FightClubColors.lostColor;
    }
    return Colors.transparent;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FightClubColors.background,
      body: SafeArea(
        child: Column(children: [
          SizedBox(
            height: 24,
          ),
          Center(
            child: Text(
              "The\nfight\nclub".toUpperCase(),
              style: TextStyle(
                fontSize: 30,
                color: FightClubColors.darkGreyText,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(child: SizedBox()),
          Container(
              padding: EdgeInsets.all(12),
              child: Center(
                child: Text("Last fight result"),
              )),
          SizedBox(
            height: 160,
            child: Stack(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                        child: ColoredBox(
                      color: FightClubColors.backgroundwhite,
                    )),
                    Expanded(
                        child: DecoratedBox(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                        FightClubColors.backgroundwhite,
                        FightClubColors.background_darkPurple,
                      ])),
                    )),
                    Expanded(
                        child: ColoredBox(
                      color: FightClubColors.background_darkPurple,
                    )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                height: 16,
                              ),
                              Text(
                                "YOU",
                                style: TextStyle(
                                    color: FightClubColors.darkGreyText),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Image.asset(
                                FightClubImages.youAvatar,
                                fit: BoxFit.cover,
                                width: 92,
                                height: 92,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: FutureBuilder<String?>(
                        future: SharedPreferences.getInstance().then(
                            (sharedPreferences) => sharedPreferences
                                .getString('last_fight_result')),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData || snapshot.data == null) {
                            return const SizedBox();
                          }
                          return Container(
                            height: 36,
                            width: 55,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: (() {
                                  // your code here
                                  if (snapshot.data!.toLowerCase().startsWith("won")) {
                                    FightClubColors.winColor;
                                  } else if (snapshot.data!.toLowerCase().startsWith("lost")) {
                                    FightClubColors.lostColor;
                                  } else if (snapshot.data!.toLowerCase().startsWith("drow")) {
                                    FightClubColors.drawColor;
                                  } else {
                                    FightClubColors.background_darkPurple;
                                  }
                                }()),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Center(
                                child: Text(
                                  snapshot.data!,
                                  style: TextStyle(
                                      color: FightClubColors.darkGreyText,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    /*  Container(
                      height: 36,
                      width: 48,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Center(
                          child:
                          FutureBuilder<String?>(
                              future: SharedPreferences.getInstance().then(
                                      (sharedPreferences) =>
                                      sharedPreferences
                                          .getString('last_fight_result')
                                          ?.toLowerCase()),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData ||
                                    snapshot.data == null) {
                                  return const SizedBox();
                                }
                                return Center(
                                    child: Text(snapshot.data!,
                                      style: TextStyle(
                                          color: FightClubColors.whiteText,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16),
                                    ),
                                );
                              }),


                        ),

                      ),

                    ),
                  */

                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                height: 16,
                              ),
                              Text(
                                "ENEMY",
                                style: TextStyle(
                                    color: FightClubColors.darkGreyText),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Image.asset(
                                FightClubImages.enemyAvatar,
                                fit: BoxFit.cover,
                                width: 92,
                                height: 92,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
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
                  title: "statistics".toUpperCase(),
                  onTap: () => {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => StatisticsPage(),
                        ))
                      })),
          SizedBox(
            height: 16,
          ),
          Container(
            width: 400,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
                border: Border.all(
              width: 2,
              color: Colors.black,
            )),
            child: ActionButton(
                onTap: () => {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => FightPage(),
                      ))
                    },
                bcolor: FightClubColors.blackButton,
                title: "start".toUpperCase()),
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
