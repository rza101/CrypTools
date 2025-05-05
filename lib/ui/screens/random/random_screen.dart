import 'package:cryptools/core/crypto/crypto_encode_service.dart';
import 'package:cryptools/core/extensions.dart';
import 'package:cryptools/ui/screens/random/random_controller.dart';
import 'package:cryptools/ui/widgets/encoding_type_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class RandomScreen extends StatelessWidget {
  final RandomController _controller = Get.find();

  RandomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isWideScreen = context.isWideScreen();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 24,
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
              onSelectedTypeChanged: _controller.setEncodingType,
            ),
            TextField(
              controller: _controller.byteLengthTextController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Length (bytes)',
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.number,
              maxLines: 1,
            ),
            SizedBox(
              height: 200,
              child: TextField(
                controller: _controller.outputTextController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Result',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  suffixIcon:
                      isWideScreen
                          ? null
                          : IconButton(
                            onPressed: _controller.generateRandomValue,
                            icon: Icon(Icons.refresh),
                          ),
                ),
                expands: true,
                minLines: null,
                maxLines: null,
                readOnly: true,
                textAlignVertical: TextAlignVertical.top,
              ),
            ),
            if (isWideScreen)
              FilledButton(
                onPressed: _controller.generateRandomValue,
                child: const Text('Generate Random Value'),
              ),
          ],
        ),
      ),
    );
  }
}
