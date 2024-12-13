import 'package:flutter/material.dart';
import 'package:stat_admin/home_page.dart';
import 'package:stat_admin/gold_league.dart';
import 'package:stat_admin/login_page.dart';
import 'package:stat_admin/points_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    GoldLeague(),
    PointsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final supabase = Supabase.instance.client;
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 300,
                maxHeight: 60,
              ),
              child: AspectRatio(
                aspectRatio: 3, // Adjust based on your logo's aspect ratio
                child: Image.asset(
                  'assets/stat_font_black.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(70),
                  bottomRight: Radius.circular(70)),
              gradient: LinearGradient(
                colors: [
                  Color(0xFF7C9FC9),
                  Color(0xFFADDBEF),
                  Color(0xFFB6D9E8)
                ],
                stops: [0.0, 1.0, 1.0],
                begin: AlignmentDirectional(1.0, 0.0),
                end: AlignmentDirectional(-1.0, 0),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              // Navigation buttons
              Container(
                color: Colors.transparent,
                child: Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildNavButton('Schedule', 0, size),
                      _buildNavButton('Gold League', 1, size),
                      _buildNavButton('Points\nTable', 2, size),
                    ],
                  ),
                ),
              ),

              // Content area
              Container(
                height: size.height * 0.9, // 75% of screen height
                child: _pages[_selectedIndex],
              ),
            ],
          ),
        ),
        floatingActionButton: _selectedIndex != 2
            ? FloatingActionButton.extended(
                onPressed: () async {
                  if (supabase.auth.currentUser == null) {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ),
                    );
                    setState(() {}); // Refresh after pop
                  } else {
                    await supabase.auth.signOut();
                    setState(() {});
                  }
                },
                label: Text(
                    supabase.auth.currentUser == null ? "Login" : "Logout"),
              )
            : null);
  }

  Widget _buildNavButton(String title, int index, Size size) {
    return OutlinedButton(
      onPressed: () => setState(() => _selectedIndex = index),
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25))),
        side: BorderSide(
          color: _selectedIndex == index ? Colors.blue : Colors.black,
          width: 2.0,
        ),
        foregroundColor: _selectedIndex == index ? Colors.white : Colors.black,
        backgroundColor: _selectedIndex == index
            ? const Color.fromARGB(255, 0, 81, 73)
            : Colors.blueGrey.shade100,
        textStyle: TextStyle(
            fontFamily: 'Poppins',
            fontSize: size.width * 0.034,
            fontWeight: FontWeight.bold),
        minimumSize: Size(MediaQuery.of(context).size.width * 0.2,
            MediaQuery.of(context).size.height * 0.1),
      ),
      child: Text(title, textAlign: TextAlign.center),
    );
  }
}
