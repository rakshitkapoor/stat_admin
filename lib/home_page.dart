import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:stat_admin/Widgets/card_widget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final supabase = Supabase.instance.client;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchResult();
  }

  List<Map<String, dynamic>> scheduleData = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: (scheduleData.isEmpty)
          ? Center(
              child: LottieBuilder.network(
                "https://lottie.host/9f1cd1bc-2a49-409b-8fb0-a66e23f2a755/nAmyxB8JtI.json",
                repeat: false,
                frameRate: FrameRate(30),
              ),
            )
          : ListView.builder(
              itemCount: scheduleData.length,
              itemBuilder: (context, index) {
                return ScheduleCard(schedule: scheduleData[index],);
              },
            ),
    );
  }

  Future fetchResult() async {
    final response = await supabase.from('Schedule').select();
    print(response);

    setState(() {
      scheduleData = List<Map<String, dynamic>>.from(response);
    });

    setState(() {
      scheduleData.sort((a, b) => a['id'].compareTo(b['id']));
    });
  }
}