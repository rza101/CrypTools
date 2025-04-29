import 'package:cryptools/core/crypto/crypto_hash_service.dart';
import 'package:cryptools/ui/screens/hash/hash_controller.dart';
import 'package:cryptools/ui/widgets/file_input_container.dart';
import 'package:cryptools/ui/widgets/hash_type_selector.dart';
import 'package:cryptools/ui/widgets/input_type_selector.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HashScreen extends StatelessWidget {
  final HashController controller = Get.find();

  HashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4,
              children: [
                Text(
                  'Hash Algorithm',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                HashTypeSelector(
                  initialValue: HashAlgorithms.md5,
                  onSelectedValueChanged: controller.setSelectedHashAlgorithm,
                ),
              ],
            ),
            SizedBox(height: 24),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4,
              children: [
                Text(
                  'Input Type',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Obx(
                  () => InputTypeSelector(
                    selectedType: controller.selectedInputType,
                    onSelectedTypeChanged: controller.setSelectedInputType,
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
            Row(
              spacing: 4,
              children: [
                Text(
                  'HMAC Mode',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Obx(
                  () => Switch(
                    value: controller.isHmacMode,
                    onChanged: controller.setHmacMode,
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
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
                        controller.isAutoHash &&
                        controller.selectedInputType == InputType.text,
                    onChanged:
                        controller.selectedInputType == InputType.text
                            ? controller.setAutoHash
                            : null,
                  ),
                ),
                Obx(
                  () => FilledButton(
                    onPressed:
                        !controller.isAutoHash ||
                                controller.selectedInputType == InputType.file
                            ? controller.processHash
                            : null,
                    child: Text('Hash'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
            Obx(
              () => SizedBox(
                height: 200,
                child: switch (controller.selectedInputType) {
                  InputType.text => TextField(
                    controller: controller.textInputController,
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
                    onFileSet: controller.setSelectedFile,
                  ),
                },
              ),
            ),
            Obx(
              () =>
                  controller.isHmacMode
                      ? Padding(
                        padding: const EdgeInsets.only(top: 24),
                        child: SizedBox(
                          height: 200,
                          child: TextField(
                            controller: controller.hmacKeyInputController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'HMAC Key',
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                            ),
                            enabled: controller.isHmacMode,
                            expands: true,
                            minLines: null,
                            maxLines: null,
                            textAlignVertical: TextAlignVertical.top,
                          ),
                        ),
                      )
                      : const SizedBox.shrink(),
            ),
            SizedBox(height: 24),
            SizedBox(
              height: 200,
              child: TextField(
                controller: controller.hashResultController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Hash Result',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
                canRequestFocus: false,
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
