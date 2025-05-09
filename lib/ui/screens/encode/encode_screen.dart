import 'package:cryptools/core/crypto/crypto_encode_service.dart';
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
              initialSelection: EncodingTypes.utf8,
              onSelected: _controller.setFirstEncodingType,
            ),
            _FirstInputForm(controller: _controller),
            _Divider(),
            EncodingTypeSelector(
              initialSelection: EncodingTypes.utf8,
              onSelected: _controller.setSecondEncodingType,
            ),
            _SecondInputForm(controller: _controller),
          ],
        ),
      ),
    );
  }
}

class _FirstInputForm extends StatelessWidget {
  const _FirstInputForm({required EncodeController controller})
    : _controller = controller;

  final EncodeController _controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: TextField(
        controller: _controller.firstInputTextController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
        expands: true,
        minLines: null,
        maxLines: null,
        onChanged: (value) {
          _controller.processFirstInput();
        },
        textAlignVertical: TextAlignVertical.top,
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider()),
        Icon(Icons.swap_vert, color: Theme.of(context).dividerColor, size: 40),
        const Expanded(child: Divider()),
      ],
    );
  }
}

class _SecondInputForm extends StatelessWidget {
  const _SecondInputForm({required EncodeController controller})
    : _controller = controller;

  final EncodeController _controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: TextField(
        controller: _controller.secondInputTextController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
        expands: true,
        minLines: null,
        maxLines: null,
        onChanged: (value) {
          _controller.processSecondInput();
        },
        textAlignVertical: TextAlignVertical.top,
      ),
    );
  }
}
