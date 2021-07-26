import 'dart:math';

class TambolaTicketGenerator {
  List<bool> numsTaken = [];
  List<bool> col = List<bool>.generate(9, (i) => false, growable: false);
  List<List<String>> tamBoard = List<List<String>>.generate(
      3, (i) => List<String>.generate(9, (i) => " "),
      growable: false);
  Random random = new Random();

  List<List<String>> Generate() {
    List<bool> newNums =
        List<bool>.generate(100, (i) => false, growable: false);
    numsTaken = newNums;
    Fill();
    return tamBoard;
  }

  void Fill() {
    for (int r = 0; r < 2; r++) {
      Set<int> nums = new Set<int>();
      while (nums.length < 5) {
        int RandomIndex = random.nextInt(9);
        nums.add(RandomIndex);
        col[RandomIndex] = true;
      }
      nums.forEach((c) => PutNum(r, c));
    }

    Set<int> nums = FillSet();
    while (nums.length < 5) {
      int RandomIndex = random.nextInt(9);
      nums.add(RandomIndex);
      col[RandomIndex] = true;
    }
    nums.forEach((c) => PutNum(2, c));

    SortColumns();
  }

  void SortColumns() {
    for (int i = 0; i < 9; i++) {
      List<int> nonEmpty = [];

      for (int j = 0; j < 3; j++) {
        if (tamBoard[j][i] != " ") {
          nonEmpty.add(j);
        }
      }

      int n = nonEmpty.length;
      if (n == 2 &&
          int.parse(tamBoard[nonEmpty[0]][i]) >
              int.parse(tamBoard[nonEmpty[1]][i])) {
        String temp = tamBoard[nonEmpty[0]][i];
        tamBoard[nonEmpty[0]][i] = tamBoard[nonEmpty[1]][i];
        tamBoard[nonEmpty[1]][i] = temp;
      }

      if (n == 3) {
        List<String> allThree = [
          tamBoard[0][i],
          tamBoard[1][i],
          tamBoard[2][i]
        ];
        allThree.sort();

        tamBoard[0][i] = allThree[0];
        tamBoard[1][i] = allThree[1];
        tamBoard[2][i] = allThree[2];
      }
    }
  }

  void PutNum(int i, int j) {
    int rangeStart = j == 0 ? 1 : j * 10;
    int range = j == 80 ? 10 : 9, number;
    while (true) {
      number = rangeStart + random.nextInt(range);
      if (!numsTaken[number]) break;
    }
    numsTaken[number] = true;
    String num_text = number.toString();
    tamBoard[i][j] = number < 10 ? '0' + num_text : num_text;
  }

  Set<int> FillSet() {
    Set<int> res = new Set<int>();
    for (int i = 0; i < 9; i++) {
      if (col[i] == false) {
        res.add(i);
      }
    }
    return res;
  }
}

void main() {
  TambolaTicketGenerator t = new TambolaTicketGenerator();
  Print(t.Generate());
}

void Print(List<List<String>> tamBoard) {
  for (int r = 0; r < 3; r++) {
    print(tamBoard[r]);
  }
}
