import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:stat_admin/Widgets/card_widget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:stat_admin/points_screen.dart';

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
      body: Column(
        children: [
          Container(
            width: 416.0,
            height: 65.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF7C9FC9),
                  const Color(0xFFADDBEF),
                  const Color(0xFFB6D9E8)
                ],
                stops: const [0.0, 1.0, 1.0],
                begin: AlignmentDirectional(1.0, 0.0),
                end: AlignmentDirectional(-1.0, 0),
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(45.0),
                bottomRight: Radius.circular(45.0),
                topLeft: Radius.circular(0.0),
                topRight: Radius.circular(0.0),
              ),
              shape: BoxShape.rectangle,
            ),
            child: Align(
              alignment: AlignmentDirectional(0.0, 1.0),
              child: Padding(
                padding:
                    const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 3.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(0.0),
                  child: Image.asset(
                    'assets/stat_font_black.png',
                    width: 170.0,
                    height: 70.0,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
            child: Container(
              width: 340.0,
              height: 40.0,
              decoration: BoxDecoration(
                color: Color(0xFFF5F5F5),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25.0),
                  bottomRight: Radius.circular(25.0),
                  topLeft: Radius.circular(25.0),
                  topRight: Radius.circular(25.0),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(4.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.black,
                        //backgroundColor: Colors.white,
                        textStyle: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 10.0,
                          letterSpacing: 0.0,
                        ),
                        minimumSize: Size(89.0, 76.0),
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 0.0, 16.0, 0.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                      ),
                      child: Text('Schedule'),
                    ),
                    TextButton(
                      onPressed: () {
                        /*Navigator.push(
                          context, 
                          MaterialPageRoute(builder: (context) => GoldLeague()),
                        );*/
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.black,
                        textStyle: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 10.0,
                          letterSpacing: 0.0,
                        ),
                        minimumSize: Size(83.0, 76.0),
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 0.0, 16.0, 0.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                      ),
                      child: Text('Gold League'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PointsScreen()),
                        );
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.black,
                        textStyle: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 10.0,
                          letterSpacing: 0.0,
                        ),
                        minimumSize: Size(79.0, 76.0),
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 0.0, 16.0, 0.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                      ),
                      child: Text(
                        'Points\nTable',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: (scheduleData.isEmpty)
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
                      return ScheduleCard(schedule: scheduleData[index]);
                    },
                  ),
          ),
        ],
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
