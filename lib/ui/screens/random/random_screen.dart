import 'package:cryptools/core/crypto/crypto_encode_service.dart';
import 'package:cryptools/ui/screens/random/random_controller.dart';
import 'package:cryptools/ui/widgets/encoding_type_selector.dart';
import 'package:cryptools/ui/widgets/tooltip_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class RandomScreen extends StatelessWidget {
  final RandomController _controller = Get.find();

  RandomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 24,
          children: [
            _EncodingTypeForm(controller: _controller),
            _ByteLengthForm(controller: _controller),
            FilledButton(
              onPressed: _controller.generateRandomValue,
              child: const Text('Generate Random Value'),
            ),
            _ResultField(controller: _controller),
          ],
        ),
      ),
    );
  }
}

class _EncodingTypeForm extends StatelessWidget {
  final RandomController _controller;

  const _EncodingTypeForm({required RandomController controller})
    : _controller = controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      children: [
        EncodingTypeSelector(
          initialSelection: EncodingTypes.hex,
          entries: const [
            // ascii and utf8 encoding output (for printable characters)
            // requires more processing to ensure uniform distribution
            // for example: rejection sampling
            EncodingTypes.base64,
            EncodingTypes.base64Url,
            EncodingTypes.hex,
          ],
          onSelected: _controller.setEncodingType,
        ),
        TooltipIcon(
          message: 'Encoding can be changed for existing random value',
        ),
      ],
    );
  }
}

class _ByteLengthForm extends StatelessWidget {
  final RandomController _controller;

  const _ByteLengthForm({required RandomController controller})
    : _controller = controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: _controller.byteLengthFormKey,
      controller: _controller.byteLengthTextController,
      decoration: const InputDecoration(
        labelText: 'Length (bytes)',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      maxLines: 1,
      validator: _controller.validateByteLength,
      autovalidateMode: AutovalidateMode.always,
    );
  }
}

class _ResultField extends StatelessWidget {
  final RandomController _controller;

  const _ResultField({required RandomController controller})
    : _controller = controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: TextField(
        controller: _controller.outputTextController,
        decoration: InputDecoration(
          labelText: 'Result',
          floatingLabelBehavior: FloatingLabelBehavior.always,
          border: const OutlineInputBorder(),
        ),
        textAlignVertical: TextAlignVertical.top,
        readOnly: true,
        maxLines: null,
        minLines: null,
        expands: true,
      ),
    );
  }
}
