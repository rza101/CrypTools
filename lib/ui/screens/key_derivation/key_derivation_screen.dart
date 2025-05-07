import 'package:cryptools/core/crypto/crypto_hash_service.dart';
import 'package:cryptools/ui/screens/key_derivation/key_derivation_controller.dart';
import 'package:cryptools/ui/widgets/hash_type_selector.dart';
import 'package:cryptools/ui/widgets/key_derivation_algorithm_selector.dart';
import 'package:cryptools/ui/widgets/key_derivation_process_type_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class KeyDerivationScreen extends StatelessWidget {
  final KeyDerivationController _controller = Get.find();

  KeyDerivationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 24,
          children: [
            SizedBox(
              height: 200,
              child: TextField(
                controller: _controller.plaintextInputController,
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
            ),
            KeyDerivationAlgorithmSelector(
              initialSelection: KeyDerivationAlgorithms.bcrypt,
              onSelected: _controller.setKeyDerivationAlgorithm,
            ),
            Obx(
              () => switch (_controller.keyDerivationAlgorithm) {
                KeyDerivationAlgorithms.bcrypt => TextField(
                  controller: _controller.bcryptRoundsInputController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Rounds',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  maxLines: 1,
                ),
                KeyDerivationAlgorithms.pbkdf2 => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 24,
                  children: [
                    TextField(
                      controller: _controller.pbkdf2KeyLengthInputController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Key Length',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      keyboardType: TextInputType.number,
                      maxLines: 1,
                    ),
                    TextField(
                      controller: _controller.pbkdf2RoundsInputController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Rounds',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      keyboardType: TextInputType.number,
                      maxLines: 1,
                    ),
                    TextField(
                      controller: _controller.pbkdf2SaltInputController,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'Salt',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        suffixIcon: IconButton(
                          onPressed: _controller.generatePbkdf2Salt,
                          icon: Icon(Icons.refresh),
                        ),
                      ),
                      maxLines: 1,
                      textAlignVertical: TextAlignVertical.top,
                    ),
                    HashTypeSelector(
                      initialSelection: HashAlgorithms.sha256,
                      onSelected: _controller.setPbkdf2HashAlgorithm,
                    ),
                  ],
                ),
                KeyDerivationAlgorithms.scrypt => Column(
                  spacing: 24,
                  children: [
                    TextField(
                      controller: _controller.scryptCostInputController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Cost (N)',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      keyboardType: TextInputType.number,
                      maxLines: 1,
                    ),
                    TextField(
                      controller: _controller.scryptBlockSizeInputController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Block Size (r)',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      keyboardType: TextInputType.number,
                      maxLines: 1,
                    ),
                    TextField(
                      controller: _controller.scryptParallelismInputController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Parallelism (p)',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      keyboardType: TextInputType.number,
                      maxLines: 1,
                    ),
                    TextField(
                      controller: _controller.scryptKeyLengthInputController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Key Length (bytes)',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      keyboardType: TextInputType.number,
                      maxLines: 1,
                    ),
                    TextField(
                      controller: _controller.scryptSaltInputController,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'Salt',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        suffixIcon: IconButton(
                          onPressed: _controller.generateScryptSalt,
                          icon: Icon(Icons.refresh),
                        ),
                      ),
                      maxLines: 1,
                      textAlignVertical: TextAlignVertical.top,
                    ),
                  ],
                ),
              },
            ),
            Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 24,
                children: [
                  KeyDerivationProcessTypeSelector(
                    selectedType: _controller.processType,
                    onSelectedTypeChanged: _controller.setProcessType,
                  ),
                  if (_controller.processType ==
                      KeyDerivationProcessType.verify)
                    SizedBox(
                      height: 200,
                      child: TextField(
                        controller: _controller.derivedKeyInputController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Derived Key',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                        expands: true,
                        minLines: null,
                        maxLines: null,
                        textAlignVertical: TextAlignVertical.top,
                      ),
                    ),
                ],
              ),
            ),
            FilledButton(
              onPressed: _controller.processInputs,
              child: Text('Process'),
            ),
            SizedBox(
              height: 200,
              child: TextField(
                controller: _controller.resultController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Result',
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
