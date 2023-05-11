

class FightResult {
   final String result;
  const FightResult._(this.result);


   static const won = FightResult._('WON');
   static const lost = FightResult._('LOST');
   static const drow = FightResult._('DROW');

   static FightResult? calculateResult(int yourLives , int enemyLives) {
     if (yourLives==0 && enemyLives==0){
       return drow;
     } else if (enemyLives==0) {
       return won;
     } else if (yourLives==0) {
       return lost;
     }
     return null;
   }

   @override
  String toString() {
    return 'FightResult{result: $result}';
  }
}