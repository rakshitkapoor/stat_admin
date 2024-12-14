import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ScorePage extends StatefulWidget {
  const ScorePage(
      {super.key, required this.sched, required this.redirectSource});
  final Map<String, dynamic> sched;
  final String redirectSource;

  @override
  State<ScorePage> createState() => _ScorePageState();
}

class _ScorePageState extends State<ScorePage> {
  final TextEditingController _scoreController1 = TextEditingController();
  final TextEditingController _scoreController2 = TextEditingController();
  final _supabase = Supabase.instance.client;
  bool _isLoading = false;

  Future<void> _submitScore() async {
    // Validate inputs
    if (_scoreController1.text.isEmpty || _scoreController2.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter scores for both teams')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Determine the table to update based on redirectSource
      String tableName;
      switch (widget.redirectSource) {
        case 'gold':
          tableName = 'goldleaguefixture';
          break;
        case 'silver':
          tableName = 'silverleaguefixture';
          break;
        case 'bronze':
          tableName = 'bronzeleaguefixture';
          break;
        case 'home':
          tableName = 'Schedule';
          break;
        default:
          throw Exception('Invalid redirect source');
      }

      // Update the specific row in the appropriate table
      await _supabase
          .from(tableName)
          .update({
            'Score1': _scoreController1.text,
            'Score2': _scoreController2.text,
          })
          .eq('Team1', widget.sched['Team1'])
          .eq('Team2', widget.sched['Team2']);

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'Scores updated successfully for ${widget.sched['Team1']} vs ${widget.sched['Team2']} in $tableName')),
      );

      // Navigate back or reset the form
      Navigator.of(context).pop();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(30, 57, 210, 192),
        title: const Text('Score Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            // Team Names Row
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("${widget.sched['Team1']}",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(fontWeight: FontWeight.w600)),
                  Text("${widget.sched['Team2']}",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(fontWeight: FontWeight.w600)),
                ],
              ),
            ),

            // Scores Input Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Score Input for Team 1
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: TextField(
                      controller: _scoreController1,
                      keyboardType: TextInputType.number,
                      inputFormatters: widget.redirectSource == 'home'
                          ? [FilteringTextInputFormatter.digitsOnly]
                          : [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9()]'))
                            ],
                      decoration: InputDecoration(
                        hintText: 'Score for ${widget.sched['Team1']}',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ),

                // Score Input for Team 2
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: TextField(
                      controller: _scoreController2,
                      keyboardType: TextInputType.number,
                      inputFormatters: widget.redirectSource == 'home'
                          ? [FilteringTextInputFormatter.digitsOnly]
                          : [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9()]'))
                            ],
                      decoration: InputDecoration(
                        hintText: 'Score for ${widget.sched['Team2']}',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Submit Button
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ElevatedButton(
                onPressed: _isLoading ? null : _submitScore,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : const Text(
                        'Submit Score',
                        style: TextStyle(fontSize: 16),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed
    _scoreController1.dispose();
    _scoreController2.dispose();
    super.dispose();
  }
}
