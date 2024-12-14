import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:stat_admin/Widgets/card_widget.dart';
import 'package:stat_admin/Widgets/card_widget_silver.dart';
import 'package:stat_admin/Widgets/card_widget_bronze.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final supabase = Supabase.instance.client;
  List<Map<String, dynamic>> scheduleData = [];
  List<Map<String, dynamic>> silverData = [];
  List<Map<String, dynamic>> bronzeData = [];

  @override
  void initState() {
    super.initState();
    fetchResult();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: fetchResult,
        child: (scheduleData.isEmpty &&
                silverData.isEmpty &&
                bronzeData.isEmpty)
            ? Center(
                child: LottieBuilder.network(
                  "https://lottie.host/9f1cd1bc-2a49-409b-8fb0-a66e23f2a755/nAmyxB8JtI.json",
                  repeat: false,
                  frameRate: FrameRate(30),
                ),
              )
            : ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  if (scheduleData.isNotEmpty) ...[
                    Padding(
                      padding:
                          EdgeInsets.only(bottom: screenSize.height * 0.05),
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: scheduleData.length,
                        itemBuilder: (context, index) {
                          return ScheduleCard(schedule: scheduleData[index]);
                        },
                      ),
                    ),
                  ],
                  if (silverData.isNotEmpty) ...[
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        "Silver League",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(bottom: screenSize.height * 0.05),
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: silverData.length,
                        itemBuilder: (context, index) {
                          return ScheduleCardSilver(
                              schedule: silverData[index]);
                        },
                      ),
                    ),
                  ],
                  if (bronzeData.isNotEmpty) ...[
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        "Bronze League",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(bottom: screenSize.height * 0.05),
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: bronzeData.length,
                        itemBuilder: (context, index) {
                          return ScheduleCardBronze(
                              schedule: bronzeData[index]);
                        },
                      ),
                    ),
                  ],
                ],
              ),
      ),
    );
  }

  Future fetchResult() async {
    final response = await supabase.from('Schedule').select();
    final responseSilver = await supabase.from('silverleaguefixture').select();
    final responseBronze = await supabase.from('bronzeleaguefixture').select();

    setState(() {
      scheduleData = List<Map<String, dynamic>>.from(response)
        ..sort((a, b) => a['id'].compareTo(b['id']));
      silverData = List<Map<String, dynamic>>.from(responseSilver)
        ..sort((a, b) => a['id'].compareTo(b['id']));
      bronzeData = List<Map<String, dynamic>>.from(responseBronze)
        ..sort((a, b) => a['id'].compareTo(b['id']));
    });
  }
}
