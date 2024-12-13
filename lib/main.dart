import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stat_admin/main_dashboard.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://ouvkhirziupvfzmzryln.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im91dmtoaXJ6aXVwdmZ6bXpyeWxuIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzMzOTQ3OTYsImV4cCI6MjA0ODk3MDc5Nn0.G6ejQqOwEoX-M6zl3uXvgIjfVngL2Ia91ei-2CXNQug',
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Dem',
      theme: ThemeData(
        textTheme: GoogleFonts.interTightTextTheme(),
      ),
      home: Dashboard(),
    );
  }
}
