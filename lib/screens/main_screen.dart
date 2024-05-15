import 'dart:math';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<List<String>> grid = List.generate(3, (_) => List.filled(3, ''));

  void placeUserSymbol(int row, int col) {
    setState(() {
      if (grid[row][col] == '' && winnerText.isEmpty) {
        grid[row][col] = 'X';
        _checkWinner();
        _placeComputerSymbol();
      }
    });
  }

  void _placeComputerSymbol() {
    Future.delayed(const Duration(milliseconds: 500), () {
      List<int> emptyCells = [];
      for (int i = 0; i < grid.length; i++) {
        for (int j = 0; j < grid[i].length; j++) {
          if (grid[i][j] == '') {
            emptyCells.add(i * grid.length + j);
          }
        }
      }
      if (emptyCells.isNotEmpty && winnerText.isEmpty) {
        int index = Random().nextInt(emptyCells.length);
        int row = emptyCells[index] ~/ grid.length;
        int col = emptyCells[index] % grid.length;
        setState(() {
          grid[row][col] = 'O';
        });
        _checkWinner();
      }
    });
  }

  void _checkWinner() {
    List<List<int>> winningIndices = [
      [0, 1, 2], // Horizontal rows
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6], // Vertical columns
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8], // Diagonals
      [2, 4, 6]
    ];

    int xCount = 0;
    int oCount = 0;

    for (var indices in winningIndices) {
      if (grid[indices[0] ~/ 3][indices[0] % 3] == 'X' &&
          grid[indices[1] ~/ 3][indices[1] % 3] == 'X' &&
          grid[indices[2] ~/ 3][indices[2] % 3] == 'X') {
        xCount++;
      } else if (grid[indices[0] ~/ 3][indices[0] % 3] == 'O' &&
          grid[indices[1] ~/ 3][indices[1] % 3] == 'O' &&
          grid[indices[2] ~/ 3][indices[2] % 3] == 'O') {
        oCount++;
      }
    }

    setState(() {
      if (xCount > 0 && oCount == 0) {
        winnerText = 'X=$xCount : O=$oCount';
      } else if (oCount > 0 && xCount == 0) {
        winnerText = 'X=$xCount : O=$oCount';
      }
    });
  }

  void resetGrid(bool clearWinnerText) {
    setState(() {
      grid = List.generate(3, (_) => List.filled(3, ''));
      if (clearWinnerText) {
        winnerText = '';
      }
    });
  }

  String winnerText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(color: Colors.green.shade700),
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                height: 50,
                child: Row(
                  children: [
                    const SizedBox(
                      width: 150,
                    ),
                    Text(
                      winnerText,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: grid.isEmpty ? 0 : 3,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                ),
                itemCount: grid.isEmpty ? 0 : 9,
                itemBuilder: (BuildContext context, int index) {
                  int row = index ~/ 3;
                  int col = index % 3;
                  return GestureDetector(
                    onTap: () => placeUserSymbol(row, col),
                    child: Container(
                      decoration: BoxDecoration(
                        color: grid[row][col].isEmpty
                            ? Colors.white
                            : Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Center(
                        child: Text(
                          grid[row][col],
                          style: const TextStyle(fontSize: 24),
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 50,
              ),
              Center(
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () => resetGrid(false),
                      child: const Text(
                        "New Game",
                        style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 30),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => resetGrid(true),
                      child: const Text(
                        "Restart Game",
                        style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 30),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
