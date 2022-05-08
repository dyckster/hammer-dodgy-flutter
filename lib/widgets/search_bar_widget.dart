import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  SearchBarWidget({Key? key, required this.onPressed}) : super(key: key);

  final Function(String) onPressed;
  final TextEditingController movieIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: TextField(
            controller: movieIdController,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintStyle: TextStyle(color: Colors.white),
              hintText: 'Enter Movie Id',
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: ElevatedButton(
              onPressed: () => onPressed(movieIdController.text),
              child: const Text("GO")),
        )
      ],
    );
  }
}
