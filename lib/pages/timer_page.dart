import 'package:flutter/material.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:test_navbar/common/colors.dart' as colors;
import 'package:test_navbar/common/strings.dart' as strings;

class TimerPage extends StatefulWidget {
  const TimerPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  final CountdownController _controller =
      CountdownController(autoStart: false);
  int _seconds = 0; // Default value

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 24,
            ),
            Countdown(
              controller: _controller,
              seconds: _seconds,
              build: (_, double time) => Text(
                time.toString(),
                style: const TextStyle(
                  fontSize: 100,
                  color: colors.primaryColor,
                ),
              ),
              interval: const Duration(milliseconds: 100),
              onFinished: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Timer is done!'),
                  ),
                );
              },
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: colors.contrastColor,
                      backgroundColor: colors.secondaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: () {
                      _controller.start();
                    },
                    child: const Text('Start'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: colors.contrastColor,
                      backgroundColor: colors.secondaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: () {
                      _controller.pause();
                    },
                    child: const Text('Pause'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: colors.contrastColor,
                      backgroundColor: colors.secondaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: () {
                      _controller.resume();
                    },
                    child: const Text('Resume'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: colors.contrastColor,
                      backgroundColor: colors.secondaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: () {
                      _controller.restart();
                    },
                    child: const Text('Restart'),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    _seconds = int.parse(value);
                  });
                },
                keyboardType: TextInputType.number,
                decoration:  InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: const OutlineInputBorder(),
                  labelText: strings.timerLabel,
                  prefixIcon:
                      const Icon(Icons.timer, color: colors.primaryColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
