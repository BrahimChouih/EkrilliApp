import 'package:flutter/material.dart';

import '../utils/constants.dart';

class MessageField extends StatelessWidget {
  const MessageField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.photo_library_rounded,
              color: deepPrimaryColor,
            ),
          ),
          const Expanded(
            child: TextField(
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.send,
              color: deepPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
