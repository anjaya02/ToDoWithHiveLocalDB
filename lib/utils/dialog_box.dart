import 'package:flutter/material.dart';
import 'package:todo/utils/my_button.dart';

class DialogBox extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 183, 76, 202),
      content: SizedBox(
        height: 120,
        child: Column(
          children: [
            // get user input
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Add a new Task",
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            // buttons -> save + cancel
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyButton(
                  text: "Save",
                  onPressed: () {
                    onSave();
                    Navigator.of(context).pop(); // Close the dialog
                  },
                ),
                MyButton(
                  text: "Cancel",
                  onPressed: () {
                    onCancel();
                    Navigator.of(context).pop(); // Close the dialog
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
