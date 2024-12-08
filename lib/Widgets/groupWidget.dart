import 'package:flutter/material.dart';
import 'package:stat_admin/Widgets/teamTableWidget.dart';

Widget groupSection(String groupName, List<List<String>> teamData) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Card(
        color: Colors.blue.shade100,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                groupName,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8.0),
              teamTable(teamData),
            ],
          ),
        ),
      ),
    );
  }