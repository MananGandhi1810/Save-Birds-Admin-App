import 'package:flutter/material.dart';

class PendingUserDataWidget extends StatelessWidget {
  const PendingUserDataWidget({
    super.key,
    required this.pendingUserWidgets,
  });

  final List<Widget> pendingUserWidgets;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: pendingUserWidgets.isEmpty
            ? const [
                Center(
                  child: Text(
                    "No Pending Users",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ]
            : pendingUserWidgets,
      ),
    );
  }
}
