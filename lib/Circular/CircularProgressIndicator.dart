import 'package:flutter/material.dart';

class CircularProgressIndicatorExample extends StatefulWidget {
  const CircularProgressIndicatorExample({super.key});

  @override
  State<CircularProgressIndicatorExample> createState() =>
      _CircularProgressIndicatorExampleState();
}

class _CircularProgressIndicatorExampleState
    extends State<CircularProgressIndicatorExample>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late BuildContext dialogContext;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _showProgressDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        dialogContext = context; // Store the context for later use
        return AlertDialog(
          title: const Text('Submitting...'),
          content: SizedBox(
            height: 100,
            child: Center(
              child: AnimatedBuilder(
                animation: controller,
                child: const CircularProgressIndicator(
                  strokeWidth: 6.0,
                ),
                builder: (context, child) {
                  return Transform.rotate(
                    angle: controller.value * 6.28, // Full rotation
                    child: child,
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  void _stopProgressDialog() {
    Navigator.of(dialogContext).pop(); // Close the dialog
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Progress Indicator Example')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _showProgressDialog,
              child: const Text('Submit'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _stopProgressDialog,
              child: const Text('Stop'),
            ),
          ],
        ),
      ),
    );
  }
}
