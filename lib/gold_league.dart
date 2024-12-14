import 'dart:nativewrappers/_internal/vm/lib/ffi_allocation_patch.dart';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:stat_admin/Widgets/card_widget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class GoldLeague extends StatefulWidget {
  const GoldLeague({super.key});

  @override
  State<GoldLeague> createState() => _HomePageState();
}

class _HomePageState extends State<GoldLeague> {
  final supabase = Supabase.instance.client;

  // Function to trigger fixtures generation via RPC
  Future<void> triggerFixtures() async {
    try {
      final response = await supabase.rpc('populate_gold_league_fixtures');
      if (response.error == null) {
        print('Fixtures generated successfully!');
      } else {
        print('Error: ${response.error!.message}');
      }
    } catch (e) {
      print('Exception: $e');
    }
  }

  // Mock function for fetching results
  /*Future<void> fetchResult() async {
    try {
      final response = await supabase.from('GoldLeagueFixture').select().execute();
      if (response.error == null) {
        print('Results fetched');
      } else {
        print('Error');
      }
    } catch (e) {
      print('Exception: $e');
    }
  }*/

  @override
  void initState() {
    super.initState();
    fetchResult();
  }

  List<Map<String, dynamic>> scheduleData = [];
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {});
        },
        child: Column(
          children: [
            supabase.auth.currentUser != null
                ? OutlinedButton(
                    onPressed: triggerFixtures,
                    child: Text("Generate Fixtures"))
                : Container(),
            Expanded(
              child: (scheduleData.isEmpty)
                  ? Center(
                      child: LottieBuilder.network(
                        "https://lottie.host/9f1cd1bc-2a49-409b-8fb0-a66e23f2a755/nAmyxB8JtI.json",
                        repeat: false,
                        frameRate: FrameRate(30),
                      ),
                    )
                  : Padding(
                      padding:
                          EdgeInsets.only(bottom: screenSize.height * 0.05),
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: scheduleData.length,
                        itemBuilder: (context, index) {
                          return ScheduleCard(schedule: scheduleData[index]);
                        },
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Future fetchResult() async {
    final response = await supabase.from('goldleaguefixture').select();
    print(response);

    setState(() {
      scheduleData = List<Map<String, dynamic>>.from(response);
    });

    setState(() {
      scheduleData.sort((a, b) => a['id'].compareTo(b['id']));
    });
  }
}
