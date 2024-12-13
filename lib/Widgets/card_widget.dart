import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:stat_admin/score_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ScheduleCard extends StatefulWidget {
  const ScheduleCard({super.key, required this.schedule});
  final schedule;

  @override
  State<ScheduleCard> createState() => _ScheduleCardState();
}

class _ScheduleCardState extends State<ScheduleCard> {
  final supabase = Supabase.instance.client;
  @override
  Widget build(BuildContext context) {
    print("${widget.schedule}");
    return InkWell(
      onTap: () {
        supabase.auth.currentUser != null
            ? Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ScorePage(
                    sched: widget.schedule,
                  ),
                ),
              )
            : showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text(
                      'Access Denied',
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    content: const Text(
                      'Admin access required to edit score',
                      textAlign: TextAlign.center,
                    ),
                    actions: [
                      TextButton(
                        child: const Text('OK'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  );
                },
              );
      },
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 16.0),
        child: Container(
          width: 416.0,
          height: 165.0,
          decoration: BoxDecoration(
            color: Color(0xE3C2E8FF),
            boxShadow: [
              BoxShadow(
                blurRadius: 3.0,
                color: Color(0x33000000),
                offset: Offset(0.0, 1.0),
                spreadRadius: 0.0,
              )
            ],
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Padding(
            padding: EdgeInsets.all(4.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 2.0, 0.0),
                            child: Text(
                              'Match',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 10.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Text(
                            '${widget.schedule['id']}', // You might want to add a match number logic here
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.grey[600],
                              fontSize: 10.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '${widget.schedule['Time']}',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 10.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '15 December', // You might want to add date logic here
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 10.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 80.0,
                            height: 80.0,
                            //padding: EdgeInsets.only(top: 10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: widget.schedule["Team1"] == "TBD"
                                ? Lottie.network(
                                    "https://lottie.host/6cbc1db1-f63f-4bd2-91c6-ea0b05333b5f/XpYiKXYreE.json")
                                : Image.asset(
                                    "assets/${widget.schedule['Team1']}.png",
                                    width: 80.0,
                                    height: 80.0,
                                    fit: BoxFit.contain,
                                  ),
                          ),
                          Text(
                            '${widget.schedule['Team1']}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '${widget.schedule['Score1']} - ${widget.schedule['Score2']}',
                            style: TextStyle(
                              fontFamily: 'Inter Tight',
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'FT',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 80.0,
                            height: 80.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: widget.schedule["Team1"] == "TBD"
                                ? Lottie.network(
                                    "https://lottie.host/6cbc1db1-f63f-4bd2-91c6-ea0b05333b5f/XpYiKXYreE.json")
                                : Image.asset(
                                    'assets/${widget.schedule['Team2']}.png', // Replace with actual team logo URL
                                    width: 80.0,
                                    height: 80.0,
                                    fit: BoxFit.contain,
                                  ),
                          ),
                          Text(
                            '${widget.schedule['Team2']}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Group ${widget.schedule['Group']}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 13.0,
                      ),
                    ),
                    Text(
                      'Turf ${widget.schedule['Turf']}', // You might want to add venue logic here
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 10.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
