import 'package:cryptools/core/crypto/crypto_encode_service.dart';
import 'package:cryptools/ui/screens/encode/encode_controller.dart';
import 'package:cryptools/ui/widgets/encoding_type_selector.dart';
import 'package:cryptools/ui/widgets/tooltip_icon.dart';
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
            Row(
              spacing: 8,
              children: [
                EncodingTypeSelector(
                  initialSelection: EncodingTypes.utf8,
                  onSelected: _controller.setFirstEncodingType,
                ),
                TooltipIcon(
                  message:
                      'Text and encoding type can be modified at both input field',
                ),
              ],
            ),
            _FirstInputForm(controller: _controller),
            _FormDivider(),
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
  final EncodeController _controller;

  const _FirstInputForm({required EncodeController controller})
    : _controller = controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: TextFormField(
        key: _controller.firstInputFormKey,
        controller: _controller.firstInputTextController,
        decoration: const InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          border: OutlineInputBorder(),
        ),
        textAlignVertical: TextAlignVertical.top,
        maxLines: null,
        minLines: null,
        expands: true,
        onChanged: (value) {
          _controller.processFirstInput();
        },
        validator: _controller.validateFirstInput,
        autovalidateMode: AutovalidateMode.always,
      ),
    );
  }
}

class _FormDivider extends StatelessWidget {
  const _FormDivider();

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
  final EncodeController _controller;

  const _SecondInputForm({required EncodeController controller})
    : _controller = controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: TextFormField(
        key: _controller.secondInputFormKey,
        controller: _controller.secondInputTextController,
        decoration: const InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          border: OutlineInputBorder(),
        ),
        textAlignVertical: TextAlignVertical.top,
        maxLines: null,
        minLines: null,
        expands: true,
        onChanged: (value) {
          _controller.processSecondInput();
        },
        validator: _controller.validateSecondInput,
        autovalidateMode: AutovalidateMode.always,
      ),
    );
  }
}
