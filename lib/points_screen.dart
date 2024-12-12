import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stat_admin/Widgets/groupWidget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:stat_admin/home_page.dart';

class PointsScreen extends StatefulWidget {
  @override
  State<PointsScreen> createState() => _PointsScreenState();
}

class _PointsScreenState extends State<PointsScreen> {
  final supabase = Supabase.instance.client;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchResult();
  }

  List<Map<String, dynamic>> grpA = [];
  List<Map<String, dynamic>> grpB = [];
  List<Map<String, dynamic>> grpC = [];
  List<Map<String, dynamic>> grpD = [];
  List<Map<String, dynamic>> grpE = [];
  List<Map<String, dynamic>> grpF = [];
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white, // Set the background color to white
      body: RefreshIndicator(
        onRefresh: fetchResult,
        child: Stack(
          children: [
            grpF.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
                    child: Column(
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
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 3.0),
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
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 10.0, 0.0, 0.0),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HomePage()),
                                      );
                                    },
                                    style: TextButton.styleFrom(
                                      foregroundColor: Colors.black,
                                      textStyle: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 5.0,
                                        letterSpacing: 0.0,
                                      ),
                                      minimumSize: Size(89.0, 76.0),
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16.0, 0.0, 16.0, 0.0),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(24.0),
                                      ),
                                    ),
                                    child: Text('Schedule'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      //Navigator.push(
                                      //context,
                                      //MaterialPageRoute(builder: (context) => GoldLeague()),
                                      //);
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
                                        borderRadius:
                                            BorderRadius.circular(24.0),
                                      ),
                                    ),
                                    child: Text('Gold League'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                PointsScreen()),
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
                                        borderRadius:
                                            BorderRadius.circular(24.0),
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
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            groupSection("Group A", [
                              [
                                "${grpA[0]["Name"]}",
                                "${grpA[0]["MP"]}",
                                "${grpA[0]["W"]}",
                                "${grpA[0]["D"]}",
                                "${grpA[0]["L"]}",
                                "${grpA[0]["GF"]}",
                                "${grpA[0]["GA"]}",
                                "${grpA[0]["GD"]}",
                                "${grpA[0]["Pts"]}"
                              ],
                              [
                                "${grpA[1]["Name"]}",
                                "${grpA[1]["MP"]}",
                                "${grpA[1]["W"]}",
                                "${grpA[1]["D"]}",
                                "${grpA[1]["L"]}",
                                "${grpA[1]["GF"]}",
                                "${grpA[1]["GA"]}",
                                "${grpA[1]["GD"]}",
                                "${grpA[1]["Pts"]}"
                              ],
                              [
                                "${grpA[2]["Name"]}",
                                "${grpA[2]["MP"]}",
                                "${grpA[2]["W"]}",
                                "${grpA[2]["D"]}",
                                "${grpA[2]["L"]}",
                                "${grpA[2]["GF"]}",
                                "${grpA[2]["GA"]}",
                                "${grpA[2]["GD"]}",
                                "${grpA[2]["Pts"]}"
                              ],
                            ]),
                            groupSection("Group B", [
                              [
                                "${grpB[0]["Name"]}",
                                "${grpB[0]["MP"]}",
                                "${grpB[0]["W"]}",
                                "${grpB[0]["D"]}",
                                "${grpB[0]["L"]}",
                                "${grpB[0]["GF"]}",
                                "${grpB[0]["GA"]}",
                                "${grpB[0]["GD"]}",
                                "${grpB[0]["Pts"]}"
                              ],
                              [
                                "${grpB[1]["Name"]}",
                                "${grpB[1]["MP"]}",
                                "${grpB[1]["W"]}",
                                "${grpB[1]["D"]}",
                                "${grpB[1]["L"]}",
                                "${grpB[1]["GF"]}",
                                "${grpB[1]["GA"]}",
                                "${grpB[1]["GD"]}",
                                "${grpB[1]["Pts"]}"
                              ],
                              [
                                "${grpB[2]["Name"]}",
                                "${grpB[2]["MP"]}",
                                "${grpB[2]["W"]}",
                                "${grpB[2]["D"]}",
                                "${grpB[2]["L"]}",
                                "${grpB[2]["GF"]}",
                                "${grpB[2]["GA"]}",
                                "${grpB[2]["GD"]}",
                                "${grpB[2]["Pts"]}"
                              ],
                            ]),
                            groupSection("Group C", [
                              [
                                "${grpC[0]["Name"]}",
                                "${grpC[0]["MP"]}",
                                "${grpC[0]["W"]}",
                                "${grpC[0]["D"]}",
                                "${grpC[0]["L"]}",
                                "${grpC[0]["GF"]}",
                                "${grpC[0]["GA"]}",
                                "${grpC[0]["GD"]}",
                                "${grpC[0]["Pts"]}"
                              ],
                              [
                                "${grpC[1]["Name"]}",
                                "${grpC[1]["MP"]}",
                                "${grpC[1]["W"]}",
                                "${grpC[1]["D"]}",
                                "${grpC[1]["L"]}",
                                "${grpC[1]["GF"]}",
                                "${grpC[1]["GA"]}",
                                "${grpC[1]["GD"]}",
                                "${grpC[1]["Pts"]}"
                              ],
                              [
                                "${grpC[2]["Name"]}",
                                "${grpC[2]["MP"]}",
                                "${grpC[2]["W"]}",
                                "${grpC[2]["D"]}",
                                "${grpC[2]["L"]}",
                                "${grpC[2]["GF"]}",
                                "${grpC[2]["GA"]}",
                                "${grpC[2]["GD"]}",
                                "${grpC[2]["Pts"]}"
                              ],
                            ]),
                            groupSection("Group D", [
                              [
                                "${grpD[0]["Name"]}",
                                "${grpD[0]["MP"]}",
                                "${grpD[0]["W"]}",
                                "${grpD[0]["D"]}",
                                "${grpD[0]["L"]}",
                                "${grpD[0]["GF"]}",
                                "${grpD[0]["GA"]}",
                                "${grpD[0]["GD"]}",
                                "${grpD[0]["Pts"]}"
                              ],
                              [
                                "${grpD[1]["Name"]}",
                                "${grpD[1]["MP"]}",
                                "${grpD[1]["W"]}",
                                "${grpD[1]["D"]}",
                                "${grpD[1]["L"]}",
                                "${grpD[1]["GF"]}",
                                "${grpD[1]["GA"]}",
                                "${grpD[1]["GD"]}",
                                "${grpD[1]["Pts"]}"
                              ],
                              [
                                "${grpD[2]["Name"]}",
                                "${grpD[2]["MP"]}",
                                "${grpD[2]["W"]}",
                                "${grpD[2]["D"]}",
                                "${grpD[2]["L"]}",
                                "${grpD[2]["GF"]}",
                                "${grpD[2]["GA"]}",
                                "${grpD[2]["GD"]}",
                                "${grpD[2]["Pts"]}"
                              ],
                            ]),
                            groupSection("Group E", [
                              [
                                "${grpE[0]["Name"]}",
                                "${grpE[0]["MP"]}",
                                "${grpE[0]["W"]}",
                                "${grpE[0]["D"]}",
                                "${grpE[0]["L"]}",
                                "${grpE[0]["GF"]}",
                                "${grpE[0]["GA"]}",
                                "${grpE[0]["GD"]}",
                                "${grpE[0]["Pts"]}"
                              ],
                              [
                                "${grpE[1]["Name"]}",
                                "${grpE[1]["MP"]}",
                                "${grpE[1]["W"]}",
                                "${grpE[1]["D"]}",
                                "${grpE[1]["L"]}",
                                "${grpE[1]["GF"]}",
                                "${grpE[1]["GA"]}",
                                "${grpE[1]["GD"]}",
                                "${grpE[1]["Pts"]}"
                              ],
                              [
                                "${grpE[2]["Name"]}",
                                "${grpE[2]["MP"]}",
                                "${grpE[2]["W"]}",
                                "${grpE[2]["D"]}",
                                "${grpE[2]["L"]}",
                                "${grpE[2]["GF"]}",
                                "${grpE[2]["GA"]}",
                                "${grpE[2]["GD"]}",
                                "${grpE[2]["Pts"]}"
                              ],
                            ]),
                            groupSection("Group F", [
                              [
                                "${grpF[0]["Name"]}",
                                "${grpF[0]["MP"]}",
                                "${grpF[0]["W"]}",
                                "${grpF[0]["D"]}",
                                "${grpF[0]["L"]}",
                                "${grpF[0]["GF"]}",
                                "${grpF[0]["GA"]}",
                                "${grpF[0]["GD"]}",
                                "${grpF[0]["Pts"]}"
                              ],
                              [
                                "${grpF[1]["Name"]}",
                                "${grpF[1]["MP"]}",
                                "${grpF[1]["W"]}",
                                "${grpF[1]["D"]}",
                                "${grpF[1]["L"]}",
                                "${grpF[1]["GF"]}",
                                "${grpF[1]["GA"]}",
                                "${grpF[1]["GD"]}",
                                "${grpF[1]["Pts"]}"
                              ],
                              [
                                "${grpF[2]["Name"]}",
                                "${grpF[2]["MP"]}",
                                "${grpF[2]["W"]}",
                                "${grpF[2]["D"]}",
                                "${grpF[2]["L"]}",
                                "${grpF[2]["GF"]}",
                                "${grpF[2]["GA"]}",
                                "${grpF[2]["GD"]}",
                                "${grpF[2]["Pts"]}"
                              ],
                            ]),
                          ],
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          resetData();
        },
        child: Icon(Icons.delete),
      ),
    );
  }


  Future resetData() async {
    

    final resA = await supabase.from('GroupA').update({
      'MP': 0,
      'W': 0,
      'D': 0,
      'L': 0,
      'GF': 0,
      'GA': 0,
      'GD': 0,
      'Pts': 0,
    }).neq('Name', '');
    print(resA);


    final resB = await supabase.from('GroupB').update({
      'MP': 0,
      'W': 0,
      'D': 0,
      'L': 0,
      'GF': 0,
      'GA': 0,
      'GD': 0,
      'Pts': 0,
    }).neq('Name', '');
    print(resB);

    final resC = await supabase.from('GroupC').update({
      'MP': 0,
      'W': 0,
      'D': 0,
      'L': 0,
      'GF': 0,
      'GA': 0,
      'GD': 0,
      'Pts': 0,
    }).neq('Name', '');
    print(resC);

    final resD = await supabase.from('GroupD').update({
      'MP': 0,
      'W': 0,
      'D': 0,
      'L': 0,
      'GF': 0,
      'GA': 0,
      'GD': 0,
      'Pts': 0,
    }).neq('Name', '');
    print(resD);

    final resE = await supabase.from('GroupE').update({
      'MP': 0,
      'W': 0,
      'D': 0,
      'L': 0,
      'GF': 0,
      'GA': 0,
      'GD': 0,
      'Pts': 0,
    }).neq('Name', '');
    print(resE);

    final resF = await supabase.from('GroupF').update({
      'MP': 0,
      'W': 0,
      'D': 0,
      'L': 0,
      'GF': 0,
      'GA': 0,
      'GD': 0,
      'Pts': 0,
    }).neq('Name', '');
    print(resF);
  }

  Future fetchResult() async {
    final resA = await supabase.from('GroupA').select();
    print(resA);

    setState(() {
      grpA = List<Map<String, dynamic>>.from(resA);
    });

    setState(() {
      grpA.sort((a, b) => b['Pts'].compareTo(a['Pts']));
    });

    final resB = await supabase.from('GroupB').select();
    print(resB);

    setState(() {
      grpB = List<Map<String, dynamic>>.from(resB);
    });

    setState(() {
      grpB.sort((a, b) => b['Pts'].compareTo(a['Pts']));
    });

    final resC = await supabase.from('GroupC').select();
    print(resC);

    setState(() {
      grpC = List<Map<String, dynamic>>.from(resC);
    });

    setState(() {
      grpC.sort((a, b) => b['Pts'].compareTo(a['Pts']));
    });

    final resD = await supabase.from('GroupD').select();
    print(resD);

    setState(() {
      grpD = List<Map<String, dynamic>>.from(resD);
    });

    setState(() {
      grpD.sort((a, b) => b['Pts'].compareTo(a['Pts']));
    });

    final resE = await supabase.from('GroupE').select();
    print(resE);

    setState(() {
      grpE = List<Map<String, dynamic>>.from(resE);
    });

    setState(() {
      grpE.sort((a, b) => b['Pts'].compareTo(a['Pts']));
    });

    final resF = await supabase.from('GroupF').select();
    print(resF);

    setState(() {
      grpF = List<Map<String, dynamic>>.from(resF);
    });

    setState(() {
      grpF.sort((a, b) => b['Pts'].compareTo(a['Pts']));
    });
  }
}
