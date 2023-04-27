import 'dart:math';
import 'package:flutter/material.dart';

import 'fight_club_icons.dart';
import 'fight_club_colors.dart';
import 'fight_club_images.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  static const maxLives = 5;

  BodyPart? defendingbodypart;
  BodyPart? ataccingbodypart;

  int yourLives = maxLives;
  int enemyLives = maxLives;

  BodyPart? whatEnemyAtacks = BodyPart.random();
  BodyPart? whatEnemyDefends = BodyPart.random();

  String msgBox = "";

  void _selectDefendingBodyPart(final BodyPart value) {
    if (yourLives == 0 || enemyLives == 0) {
      return;
    }
    setState(() {
      defendingbodypart = value;
    });
  }

  void _selectAttacingBodyPart(final BodyPart value) {
    if (yourLives == 0 || enemyLives == 0) {
      return;
    }
    setState(() {
      ataccingbodypart = value;
    });
  }

  Color getGoButtonColor() {
    if (yourLives == 0 || enemyLives == 0) {
      return FightClubColors.blackButton;
    } else if (defendingbodypart != null || ataccingbodypart != null) {
      return FightClubColors.greyButton;
    } else {
      return FightClubColors.blackButton;
    }
  }

  void goButton_on_tap() {
    String text1 = "";
    String text2 = "";
    if (yourLives == 0 || enemyLives == 0) {
      setState(() {
        yourLives = maxLives;
        enemyLives = maxLives;
      });
    } else if (defendingbodypart != null && ataccingbodypart != null) {
      setState(() {
        final bool yourLoseLife = defendingbodypart != whatEnemyAtacks;
        final bool enemyLoseLife = ataccingbodypart != whatEnemyDefends;
        if (yourLoseLife) {
          yourLives -= 1;
          text2 =
              "Enemy's hit your " + whatEnemyAtacks!.name.toLowerCase() + ".";
        } else {
          text2 = "Enemy's attack was locked.";
        }
        if (enemyLoseLife) {
          enemyLives -= 1;
          text1 =
              "Your hit enemy's " + ataccingbodypart!.name.toLowerCase() + ".";
        } else {
          text1 = "Your attack was locked.";
        }
        msgBox = text1 + "\n" + text2;

        if (yourLives == 0 && enemyLives == 0) {
          msgBox = "draw.";
        } else if (yourLives != 0 && enemyLives == 0) {
          msgBox = "You won.";
        } else if (yourLives == 0 && enemyLives != 0) {
          msgBox = "You lost.";
        }

        whatEnemyDefends = BodyPart.random();
        whatEnemyAtacks = BodyPart.random();
        defendingbodypart = null;
        ataccingbodypart = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FightClubColors.background,
      body: SafeArea(
        child: Column(
          children: [
            FightersInfo(
              maxlivesCount: maxLives,
              yourlivesCount: yourLives,
              enemylivesCount: enemyLives,
            ),
            InfoBox(title: msgBox),
            Controlswidjet(
              defendingbodypart: defendingbodypart,
              selectDefendingBodyPart: _selectDefendingBodyPart,
              ataccingbodypart: ataccingbodypart,
              selectAtackingBodyPart: _selectAttacingBodyPart,
            ),
            SizedBox(
              height: 14,
            ),
            GoButton(
              title:
                  yourLives == 0 || enemyLives == 0 ? "start new game" : "go",
              onTap: goButton_on_tap,
              bcolor: getGoButtonColor(),
            ),
            SizedBox(
              height: 16,
            )
          ],
        ),
      ),
    );
  }
}

class GoButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final Color bcolor;

  const GoButton(
      {super.key,
      required this.onTap,
      required this.bcolor,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap: onTap,
        child: SizedBox(
            height: 40,
            child: ColoredBox(
              color: bcolor,
              child: Center(
                child: Text(
                  title.toUpperCase(),
                  style: TextStyle(
                      color: FightClubColors.whiteText,
                      fontWeight: FontWeight.w900,
                      fontSize: 16),
                ),
              ),
            )),
      ),
    );
  }
}

class FightersInfo extends StatelessWidget {
  final int maxlivesCount;
  final int yourlivesCount;
  final int enemylivesCount;

  const FightersInfo({
    super.key,
    required this.maxlivesCount,
    required this.yourlivesCount,
    required this.enemylivesCount,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: ColoredBox(
                  color: FightClubColors.backgroundwhite,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LivesWidjet(
                        overAllLivesCount: maxlivesCount,
                        currentAllLivesCount: yourlivesCount,
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 16,
                          ),
                          Text("YOU"),
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
              ),
              ColoredBox(
                color: Colors.green,
                child: SizedBox(
                  height: 40,
                  width: 40,
                ),
              ),
              Expanded(
                child: ColoredBox(
                  color: FightClubColors.background,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: 16,
                          ),
                          Text("ENEMY"),
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
                      LivesWidjet(
                        overAllLivesCount: maxlivesCount,
                        currentAllLivesCount: enemylivesCount,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BodyPart {
  final String name;

  const BodyPart._(this.name);

  static const head = BodyPart._("Head");
  static const torso = BodyPart._("Torso");
  static const legs = BodyPart._("Legs");

  static const List<BodyPart> _values = [head, torso, legs];

  static BodyPart random() {
    return _values[Random().nextInt(_values.length)];
  }
}

class BodyPartButton extends StatelessWidget {
  final BodyPart bodyPart;
  final bool selected;
  final ValueSetter<BodyPart> bodyPartSetter;

  const BodyPartButton(
      {super.key,
      required this.bodyPart,
      required this.selected,
      required this.bodyPartSetter});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => bodyPartSetter(bodyPart),
      child: SizedBox(
        height: 40,
        width: 158,
        child: ColoredBox(
          color: selected
              ? FightClubColors.blueButton
              : FightClubColors.greyButton,
          child: Center(
            child: Text(
              bodyPart.name.toUpperCase(),
              style: TextStyle(
                  color: selected
                      ? FightClubColors.whiteText
                      : FightClubColors.darkGreyText),
            ),
          ),
        ),
      ),
    );
  }
}

class LivesWidjet extends StatelessWidget {
  final int overAllLivesCount;
  final int currentAllLivesCount;

  const LivesWidjet(
      {Key? key,
      required this.overAllLivesCount,
      required this.currentAllLivesCount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      width: 18,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: List.generate(overAllLivesCount, (index) {
          if (index < currentAllLivesCount) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Image.asset(
                FightClubIcons.heartFull,
                fit: BoxFit.cover,
                width: 18,
                height: 18,
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Image.asset(
                FightClubIcons.heartEmpty,
                fit: BoxFit.cover,
                width: 18,
                height: 18,
              ),
            );
          }
        }),
      ),
    );
  }
}

class Controlswidjet extends StatelessWidget {
  final BodyPart? defendingbodypart;
  final BodyPart? ataccingbodypart;
  final ValueSetter<BodyPart> selectDefendingBodyPart;
  final ValueSetter<BodyPart> selectAtackingBodyPart;

  const Controlswidjet(
      {super.key,
      this.defendingbodypart,
      this.ataccingbodypart,
      required this.selectDefendingBodyPart,
      required this.selectAtackingBodyPart});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 16,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 40,
              ),
              Center(child: Text('defend'.toUpperCase())),
              SizedBox(
                height: 14,
              ),
              BodyPartButton(
                bodyPart: BodyPart.head,
                selected: defendingbodypart == BodyPart.head,
                bodyPartSetter: selectDefendingBodyPart,
              ),
              SizedBox(
                height: 14,
              ),
              BodyPartButton(
                bodyPart: BodyPart.torso,
                selected: defendingbodypart == BodyPart.torso,
                bodyPartSetter: selectDefendingBodyPart,
              ),
              SizedBox(
                height: 14,
              ),
              BodyPartButton(
                bodyPart: BodyPart.legs,
                selected: defendingbodypart == BodyPart.legs,
                bodyPartSetter: selectDefendingBodyPart,
              ),
            ],
          ),
        ),
        SizedBox(
          width: 12,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 40,
              ),
              Center(child: Text('attack'.toUpperCase())),
              SizedBox(
                height: 14,
              ),
              BodyPartButton(
                bodyPart: BodyPart.head,
                selected: ataccingbodypart == BodyPart.head,
                bodyPartSetter: selectAtackingBodyPart,
              ),
              SizedBox(
                height: 14,
              ),
              BodyPartButton(
                bodyPart: BodyPart.torso,
                selected: ataccingbodypart == BodyPart.torso,
                bodyPartSetter: selectAtackingBodyPart,
              ),
              SizedBox(
                height: 14,
              ),
              BodyPartButton(
                bodyPart: BodyPart.legs,
                selected: ataccingbodypart == BodyPart.legs,
                bodyPartSetter: selectAtackingBodyPart,
              ),
            ],
          ),
        ),
        SizedBox(
          width: 16,
        ),
      ],
    );
  }
}

class InfoBox extends StatelessWidget {
  final String title;

  const InfoBox({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ColoredBox(
                  color: FightClubColors.background2,
                  child: SizedBox(
                    height: 146,
                    child: Center(
                        child: Text(
                      title,
                      style: TextStyle(
                          color: FightClubColors.darkGreyText,
                          fontWeight: FontWeight.w400,
                          fontSize: 10),
                    )),
                  )),
            ),
          ),
        ]);
  }
}
