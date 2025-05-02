import 'package:cryptools/core/crypto/crypto_hash_service.dart';
import 'package:cryptools/ui/screens/hash/hash_controller.dart';
import 'package:cryptools/ui/widgets/file_input_container.dart';
import 'package:cryptools/ui/widgets/hash_type_selector.dart';
import 'package:cryptools/ui/widgets/input_type_selector.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HashScreen extends StatelessWidget {
  final HashController _controller = Get.find();

  HashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HashTypeSelector(
              initialSelection: HashAlgorithms.md5,
              onSelectionChanged: _controller.setSelectedHashAlgorithm,
            ),
            const SizedBox(height: 24),
            Row(
              spacing: 8,
              children: [
                Text(
                  'Input Type',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Obx(
                  () => InputTypeSelector(
                    selectedType: _controller.selectedInputType,
                    onSelectedTypeChanged: _controller.setSelectedInputType,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              spacing: 4,
              children: [
                Text(
                  'HMAC Mode',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Obx(
                  () => Switch(
                    value: _controller.isHmacMode,
                    onChanged: _controller.setHmacMode,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              spacing: 4,
              children: [
                Text(
                  'Auto Hash',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Obx(
                  () => Switch(
                    value:
                        _controller.isAutoHash &&
                        _controller.selectedInputType == InputType.text,
                    onChanged:
                        _controller.selectedInputType == InputType.text
                            ? _controller.setAutoHash
                            : null,
                  ),
                ),
                Obx(
                  () => FilledButton(
                    onPressed:
                        !_controller.isAutoHash ||
                                _controller.selectedInputType == InputType.file
                            ? _controller.processHash
                            : null,
                    child: Text('Hash'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Obx(
              () => SizedBox(
                height: 200,
                child: switch (_controller.selectedInputType) {
                  InputType.text => TextField(
                    controller: _controller.textInputController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Plaintext',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                    expands: true,
                    minLines: null,
                    maxLines: null,
                    textAlignVertical: TextAlignVertical.top,
                  ),
                  InputType.file => FileInputContainer(
                    onFileSet: _controller.setSelectedFile,
                  ),
                },
              ),
            ),
            Obx(
              () =>
                  _controller.isHmacMode
                      ? Padding(
                        padding: const EdgeInsets.only(top: 24),
                        child: SizedBox(
                          height: 200,
                          child: TextField(
                            controller: _controller.hmacKeyInputController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'HMAC Key',
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                            ),
                            enabled: _controller.isHmacMode,
                            expands: true,
                            minLines: null,
                            maxLines: null,
                            textAlignVertical: TextAlignVertical.top,
                          ),
                        ),
                      )
                      : const SizedBox.shrink(),
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 200,
              child: TextField(
                controller: _controller.hashResultController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Hash Result',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
                expands: true,
                minLines: null,
                maxLines: null,
                readOnly: true,
                textAlignVertical: TextAlignVertical.top,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
