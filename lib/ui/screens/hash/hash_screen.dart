import 'package:cryptools/core/crypto/crypto_hash_service.dart';
import 'package:cryptools/ui/screens/hash/hash_controller.dart';
import 'package:cryptools/ui/widgets/file_input_container.dart';
import 'package:cryptools/ui/widgets/hash_type_selector.dart';
import 'package:cryptools/ui/widgets/input_type_selector.dart';
import 'package:cryptools/ui/widgets/loading_wrapper.dart';
import 'package:cryptools/ui/widgets/multiline_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HashScreen extends StatelessWidget {
  final HashController _controller = Get.find();

  HashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screen = SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
              () => HashTypeSelector(
                enabled: !_controller.isLoading,
                initialSelection: HashAlgorithms.md5,
                onSelected: _controller.setSelectedHashAlgorithm,
              ),
            ),
            const SizedBox(height: 24),
            _InputTypeForm(controller: _controller),
            const SizedBox(height: 24),
            _HmacModeForm(controller: _controller),
            const SizedBox(height: 24),
            _AutoHashForm(controller: _controller),
            const SizedBox(height: 24),
            _InputDataForm(controller: _controller),
            _HmacKeyForm(controller: _controller),
            const SizedBox(height: 24),
            _ResultForm(controller: _controller),
          ],
        ),
      ),
    );

    return Obx(
      () => LoadingWrapper(isLoading: _controller.isLoading, child: screen),
    );
  }
}

class _InputTypeForm extends StatelessWidget {
  const _InputTypeForm({required HashController controller})
    : _controller = controller;

  final HashController _controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      children: [
        Text('Input Type', style: Theme.of(context).textTheme.titleSmall),
        Obx(
          () => InputTypeSelector(
            selectedType: _controller.selectedInputType,
            onSelectedTypeChanged: _controller.setSelectedInputType,
            enabled: !_controller.isLoading,
          ),
        ),
      ],
    );
  }
}

class _HmacModeForm extends StatelessWidget {
  const _HmacModeForm({required HashController controller})
    : _controller = controller;

  final HashController _controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 4,
      children: [
        Text('HMAC Mode', style: Theme.of(context).textTheme.titleSmall),
        Obx(
          () => Switch(
            value: _controller.isHmacMode,
            onChanged: _controller.isLoading ? null : _controller.setHmacMode,
          ),
        ),
      ],
    );
  }
}

class _AutoHashForm extends StatelessWidget {
  const _AutoHashForm({required HashController controller})
    : _controller = controller;

  final HashController _controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 4,
      children: [
        Text('Auto Hash', style: Theme.of(context).textTheme.titleSmall),
        Obx(
          () => Switch(
            value:
                !_controller.isLoading &&
                _controller.isAutoHash &&
                _controller.selectedInputType == InputType.text,
            onChanged: !_controller.isLoading ? _controller.setAutoHash : null,
          ),
        ),
        Obx(
          () => FilledButton(
            onPressed:
                !_controller.isLoading &&
                        (!_controller.isAutoHash ||
                            _controller.selectedInputType == InputType.file)
                    ? _controller.processHash
                    : null,
            child: Text('Hash'),
          ),
        ),
      ],
    );
  }
}

class _InputDataForm extends StatelessWidget {
  const _InputDataForm({required HashController controller})
    : _controller = controller;

  final HashController _controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Obx(
        () => switch (_controller.selectedInputType) {
          InputType.text => MultilineTextField(
            controller: _controller.plaintextTextController,
            labelText: 'Plaintext',
            enabled: !_controller.isLoading,
          ),
          InputType.file => FileInputContainer(
            onFileSet: _controller.setSelectedFile,
            enabled: !_controller.isLoading,
          ),
        },
      ),
    );
  }
}

class _HmacKeyForm extends StatelessWidget {
  const _HmacKeyForm({required HashController controller})
    : _controller = controller;

  final HashController _controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () =>
          _controller.isHmacMode
              ? Padding(
                padding: const EdgeInsets.only(top: 24),
                child: MultilineTextField(
                  controller: _controller.hmacKeyTextController,
                  labelText: 'HMAC Key',
                  enabled: !_controller.isLoading && _controller.isHmacMode,
                ),
              )
              : const SizedBox.shrink(),
    );
  }
}

class _ResultForm extends StatelessWidget {
  const _ResultForm({required HashController controller})
    : _controller = controller;

  final HashController _controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => MultilineTextField(
        controller: _controller.hashResultTextController,
        labelText: 'Hash Result',
        enabled: !_controller.isLoading,
        readOnly: true,
      ),
    );
  }
}
