import 'package:flutter/material.dart';

class ScorePage extends StatefulWidget {
  const ScorePage({super.key, required this.sched});
  final sched;
  @override
  State<ScorePage> createState() => _ScorePageState();
}

class _ScorePageState extends State<ScorePage> {
  TextEditingController _controller=TextEditingController(); 
  @override
  Widget build(BuildContext context) {
    final screenSize=MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(30, 57, 210, 192),
        title: const Text('Score Page'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                Text("${widget.sched['Team1']}",style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.w600)),
                Text("${widget.sched['Team2']}",style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.w600))
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: screenSize.width*0.2,
                    height: screenSize.height*0.07,
                    color: Colors.amber,
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}