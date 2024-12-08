import 'package:flutter/material.dart';

Widget teamTable(List<List<String>> teamData) {
    const headers = ["Teams", "MP", "W", "D", "L", "GF", "GA", "GD", "Pts"];

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(
                headers[0],
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: Colors.black,
                ),
              ),
            ),
            ...headers.sublist(1).map((header) => Expanded(
                  flex: 1,
                  child: Text(
                    header,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                )),
          ],
        ),
        const SizedBox(height: 8.0),
        Column(
          children: teamData.map((team) {
            return Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    team[0],
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ),
                ...team.sublist(1).map((data) => Expanded(
                      flex: 1,
                      child: Text(
                        data,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ),
                    )),
              ],
            );
          }).toList(),
        ),
        const SizedBox(height: 8.0),
        const Text(
          "MP: Match Played, W: Wins, D: Draw, L: Lose, GF: Goals For, GA: Goals Against, GD: Goal Difference, Pts: Points",
          style: TextStyle(fontSize: 10, color: Colors.black54),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }