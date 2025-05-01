import 'package:cryptools/ui/screens/encode/encode_controller.dart';
import 'package:cryptools/ui/widgets/encoding_type_selector.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EncodeScreen extends StatelessWidget {
  final EncodeController _controller = Get.find();

  EncodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 24,
          children: [
            EncodingTypeSelector(
              onSelectedTypeChanged: _controller.setFirstEncodingType,
            ),
            SizedBox(
              height: 200,
              child: TextField(
                controller: _controller.firstInputController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
                expands: true,
                minLines: null,
                maxLines: null,
                onChanged: (value) {
                  _controller.processFirstInput();
                  print('first');
                },
                textAlignVertical: TextAlignVertical.top,
              ),
            ),
            Row(
              children: [
                Expanded(child: Divider()),
                Icon(
                  Icons.swap_vert,
                  color: Theme.of(context).dividerColor,
                  size: 40,
                ),
                Expanded(child: Divider()),
              ],
            ),
            EncodingTypeSelector(
              onSelectedTypeChanged: _controller.setSecondEncodingType,
            ),
            SizedBox(
              height: 200,
              child: TextField(
                controller: _controller.secondInputController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
                expands: true,
                minLines: null,
                maxLines: null,
                onChanged: (value) {
                  _controller.processSecondInput();
                  print('second');
                },
                textAlignVertical: TextAlignVertical.top,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
