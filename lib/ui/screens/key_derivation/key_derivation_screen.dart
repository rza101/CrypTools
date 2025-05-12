import 'package:cryptools/core/crypto/crypto_hash_service.dart';
import 'package:cryptools/ui/screens/key_derivation/key_derivation_controller.dart';
import 'package:cryptools/ui/widgets/hash_type_selector.dart';
import 'package:cryptools/ui/widgets/key_derivation_algorithm_selector.dart';
import 'package:cryptools/ui/widgets/key_derivation_process_type_selector.dart';
import 'package:cryptools/ui/widgets/loading_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class KeyDerivationScreen extends StatelessWidget {
  final KeyDerivationController _controller = Get.find();

  KeyDerivationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screen = SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 24,
          children: [
            _PlaintextForm(controller: _controller),
            Obx(
              () => KeyDerivationAlgorithmSelector(
                initialSelection: KeyDerivationAlgorithms.bcrypt,
                onSelected: _controller.setKeyDerivationAlgorithm,
                enabled: !_controller.isLoading,
              ),
            ),
            Obx(
              () => switch (_controller.keyDerivationAlgorithm) {
                KeyDerivationAlgorithms.bcrypt => _BcryptParametersForm(
                  controller: _controller,
                ),
                KeyDerivationAlgorithms.pbkdf2 => _Pbkdf2ParametersForm(
                  controller: _controller,
                ),
                KeyDerivationAlgorithms.scrypt => _ScryptParametersForm(
                  controller: _controller,
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
                    enabled: !_controller.isLoading,
                  ),
                  if (_controller.processType ==
                      KeyDerivationProcessType.verify)
                    _DerivedKeyForm(controller: _controller),
                ],
              ),
            ),
            Obx(
              () => FilledButton(
                onPressed:
                    !_controller.isLoading ? _controller.processInputs : null,
                child: Text('Process'),
              ),
            ),
            _ResultField(controller: _controller),
          ],
        ),
      ),
    );

    return Obx(
      () => LoadingWrapper(isLoading: _controller.isLoading, child: screen),
    );
  }
}

class _PlaintextForm extends StatelessWidget {
  final KeyDerivationController _controller;

  const _PlaintextForm({required KeyDerivationController controller})
    : _controller = controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Obx(
        () => TextFormField(
          key: _controller.plaintextFormKey,
          controller: _controller.plaintextInputController,
          decoration: const InputDecoration(
            labelText: 'Plaintext',
            floatingLabelBehavior: FloatingLabelBehavior.always,
            border: OutlineInputBorder(),
          ),
          textAlignVertical: TextAlignVertical.top,
          maxLines: null,
          minLines: null,
          expands: true,
          validator: _controller.validatePlaintext,
          enabled: !_controller.isLoading,
          autovalidateMode: AutovalidateMode.disabled,
        ),
      ),
    );
  }
}

class _BcryptParametersForm extends StatelessWidget {
  final KeyDerivationController _controller;

  const _BcryptParametersForm({required KeyDerivationController controller})
    : _controller = controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => TextFormField(
        key: _controller.bcryptRoundsFormKey,
        controller: _controller.bcryptRoundsInputController,
        decoration: const InputDecoration(
          labelText: 'Rounds (logarithmic, 4-31, only used when deriving key)',
          floatingLabelBehavior: FloatingLabelBehavior.always,
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        maxLines: 1,
        validator: _controller.validateBcryptRounds,
        enabled: !_controller.isLoading,
        autovalidateMode: AutovalidateMode.always,
      ),
    );
  }
}

class _Pbkdf2ParametersForm extends StatelessWidget {
  final KeyDerivationController _controller;

  const _Pbkdf2ParametersForm({required KeyDerivationController controller})
    : _controller = controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 24,
      children: [
        _Pbkdf2KeyLengthForm(controller: _controller),
        _Pbkdf2RoundsForm(controller: _controller),
        _Pbkdf2SaltForm(controller: _controller),
        Obx(
          () => HashTypeSelector(
            initialSelection: HashAlgorithms.sha256,
            onSelected: _controller.setPbkdf2HashAlgorithm,
            enabled: _controller.isLoading,
          ),
        ),
      ],
    );
  }
}

class _Pbkdf2KeyLengthForm extends StatelessWidget {
  final KeyDerivationController _controller;

  const _Pbkdf2KeyLengthForm({required KeyDerivationController controller})
    : _controller = controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => TextFormField(
        key: _controller.pbkdf2KeyLengthFormKey,
        controller: _controller.pbkdf2KeyLengthInputController,
        decoration: const InputDecoration(
          labelText: 'Key Length',
          floatingLabelBehavior: FloatingLabelBehavior.always,
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        maxLines: 1,
        validator: _controller.validateKeyLength,
        enabled: !_controller.isLoading,
        autovalidateMode: AutovalidateMode.always,
      ),
    );
  }
}

class _Pbkdf2RoundsForm extends StatelessWidget {
  final KeyDerivationController _controller;

  const _Pbkdf2RoundsForm({required KeyDerivationController controller})
    : _controller = controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => TextFormField(
        key: _controller.pbkdf2RoundsFormKey,
        controller: _controller.pbkdf2RoundsInputController,
        decoration: const InputDecoration(
          labelText: 'Rounds',
          floatingLabelBehavior: FloatingLabelBehavior.always,
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        maxLines: 1,
        validator: _controller.validatePbkdf2Rounds,
        enabled: !_controller.isLoading,
        autovalidateMode: AutovalidateMode.always,
      ),
    );
  }
}

class _Pbkdf2SaltForm extends StatelessWidget {
  final KeyDerivationController _controller;

  const _Pbkdf2SaltForm({required KeyDerivationController controller})
    : _controller = controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => TextFormField(
        key: _controller.pbkdf2SaltFormKey,
        controller: _controller.pbkdf2SaltInputController,
        decoration: InputDecoration(
          labelText: 'Salt',
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: IconButton(
            onPressed: _controller.generatePbkdf2Salt,
            icon: Icon(Icons.refresh),
          ),
          border: const OutlineInputBorder(),
        ),
        textAlignVertical: TextAlignVertical.top,
        maxLines: 1,
        validator: _controller.validateSalt,
        enabled: !_controller.isLoading,
        autovalidateMode: AutovalidateMode.always,
      ),
    );
  }
}

class _ScryptParametersForm extends StatelessWidget {
  final KeyDerivationController _controller;

  const _ScryptParametersForm({required KeyDerivationController controller})
    : _controller = controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 24,
      children: [
        _ScryptCostForm(controller: _controller),
        _ScryptBlockSizeForm(controller: _controller),
        _ScryptParallelismForm(controller: _controller),
        _ScryptKeyLengthForm(controller: _controller),
        _ScryptSaltForm(controller: _controller),
      ],
    );
  }
}

class _ScryptCostForm extends StatelessWidget {
  final KeyDerivationController _controller;

  const _ScryptCostForm({required KeyDerivationController controller})
    : _controller = controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => TextFormField(
        key: _controller.scryptCostFormKey,
        controller: _controller.scryptCostInputController,
        decoration: const InputDecoration(
          labelText: 'Cost (N)',
          floatingLabelBehavior: FloatingLabelBehavior.always,
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        maxLines: 1,
        validator: _controller.validateScryptCost,
        enabled: !_controller.isLoading,
        autovalidateMode: AutovalidateMode.always,
      ),
    );
  }
}

class _ScryptBlockSizeForm extends StatelessWidget {
  final KeyDerivationController _controller;

  const _ScryptBlockSizeForm({required KeyDerivationController controller})
    : _controller = controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => TextFormField(
        key: _controller.scryptBlockSizeFormKey,
        controller: _controller.scryptBlockSizeInputController,
        decoration: const InputDecoration(
          labelText: 'Block Size (r)',
          floatingLabelBehavior: FloatingLabelBehavior.always,
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        maxLines: 1,
        validator: _controller.validateScryptBlockSize,
        enabled: !_controller.isLoading,
        autovalidateMode: AutovalidateMode.always,
      ),
    );
  }
}

class _ScryptParallelismForm extends StatelessWidget {
  final KeyDerivationController _controller;

  const _ScryptParallelismForm({required KeyDerivationController controller})
    : _controller = controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => TextFormField(
        key: _controller.scryptParallelismFormKey,
        controller: _controller.scryptParallelismInputController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Parallelism (p)',
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        keyboardType: TextInputType.number,
        maxLines: 1,
        validator: _controller.validateScryptParallelism,
        enabled: !_controller.isLoading,
        autovalidateMode: AutovalidateMode.always,
      ),
    );
  }
}

class _ScryptKeyLengthForm extends StatelessWidget {
  final KeyDerivationController _controller;

  const _ScryptKeyLengthForm({required KeyDerivationController controller})
    : _controller = controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => TextFormField(
        key: _controller.scryptKeyLengthFormKey,
        controller: _controller.scryptKeyLengthInputController,
        decoration: const InputDecoration(
          labelText: 'Key Length (bytes)',
          floatingLabelBehavior: FloatingLabelBehavior.always,
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        maxLines: 1,
        validator: _controller.validateKeyLength,
        enabled: !_controller.isLoading,
        autovalidateMode: AutovalidateMode.always,
      ),
    );
  }
}

class _ScryptSaltForm extends StatelessWidget {
  final KeyDerivationController _controller;

  const _ScryptSaltForm({required KeyDerivationController controller})
    : _controller = controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => TextFormField(
        key: _controller.scryptSaltFormKey,
        controller: _controller.scryptSaltInputController,
        decoration: InputDecoration(
          labelText: 'Salt',
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: IconButton(
            onPressed: _controller.generateScryptSalt,
            icon: Icon(Icons.refresh),
          ),
          border: const OutlineInputBorder(),
        ),
        maxLines: 1,
        textAlignVertical: TextAlignVertical.top,
        validator: _controller.validateSalt,
        enabled: !_controller.isLoading,
        autovalidateMode: AutovalidateMode.always,
      ),
    );
  }
}

class _DerivedKeyForm extends StatelessWidget {
  final KeyDerivationController _controller;

  const _DerivedKeyForm({required KeyDerivationController controller})
    : _controller = controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Obx(
        () => TextFormField(
          key: _controller.derivedKeyFormKey,
          controller: _controller.derivedKeyInputController,
          decoration: InputDecoration(
            label: Text(switch (_controller.keyDerivationAlgorithm) {
              KeyDerivationAlgorithms.bcrypt => 'Derived Key',

              KeyDerivationAlgorithms.pbkdf2 ||
              KeyDerivationAlgorithms.scrypt => 'Derived Key (Base64)',
            }),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            border: OutlineInputBorder(),
          ),
          textAlignVertical: TextAlignVertical.top,
          maxLines: null,
          minLines: null,
          expands: true,
          validator: _controller.validateDerivedKey,
          enabled: !_controller.isLoading,
          autovalidateMode: AutovalidateMode.always,
        ),
      ),
    );
  }
}

class _ResultField extends StatelessWidget {
  final KeyDerivationController _controller;

  const _ResultField({required KeyDerivationController controller})
    : _controller = controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Obx(
        () => TextFormField(
          controller: _controller.resultController,
          decoration: const InputDecoration(
            labelText: 'Result',
            floatingLabelBehavior: FloatingLabelBehavior.always,
            border: OutlineInputBorder(),
          ),
          textAlignVertical: TextAlignVertical.top,
          readOnly: true,
          maxLines: null,
          minLines: null,
          expands: true,
          enabled: !_controller.isLoading,
        ),
      ),
    );
  }
}
