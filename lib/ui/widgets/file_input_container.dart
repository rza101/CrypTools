import 'package:cross_file/cross_file.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class FileInputContainer extends StatefulWidget {
  final ValueChanged<XFile?> _onFileSet;
  final bool _enabled;

  const FileInputContainer({
    super.key,
    required void Function(XFile?) onFileSet,
    bool enabled = true,
  }) : _enabled = enabled,
       _onFileSet = onFileSet;

  @override
  State<FileInputContainer> createState() => _FileInputContainerState();
}

class _FileInputContainerState extends State<FileInputContainer> {
  bool dragging = false;
  XFile? file;
  String? filename;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget._enabled && file == null ? _onTap : null,
      child: DropTarget(
        enable: widget._enabled && file == null,
        onDragDone: _onDragRelease,
        onDragEntered: (detail) {
          setState(() {
            dragging = true;
          });
        },
        onDragExited: (detail) {
          setState(() {
            dragging = false;
          });
        },
        child: Container(
          width: double.infinity,
          height: 240,
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color:
                    dragging
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.outline,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          child:
              file != null
                  ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 8,
                    children: [
                      Text('Selected File: $filename'),
                      FilledButton(
                        onPressed: widget._enabled ? clearFile : null,
                        style: FilledButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.error,
                        ),
                        child: const Text('Clear File'),
                      ),
                    ],
                  )
                  : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 8,
                    children: [
                      const Icon(Icons.file_open, size: 64),
                      Text(
                        dragging
                            ? 'Release file to process'
                            : 'Drag file here or click to select file',
                      ),
                    ],
                  ),
        ),
      ),
    );
  }

  void _onDragRelease(DropDoneDetails details) {
    final dropItem = details.files.firstOrNull;

    if (dropItem != null) {
      final resultFile = XFile(dropItem.path);
      final resultFilename = dropItem.name;

      file = resultFile;
      filename = resultFilename;

      widget._onFileSet(resultFile);
    }
  }

  void _onTap() async {
    final result = await FilePicker.platform.pickFiles();
    final resultPlatformFile = result?.files.firstOrNull;

    if (resultPlatformFile != null) {
      final resultFile = XFile(resultPlatformFile.path!);
      final resultFilename = resultPlatformFile.name;

      setState(() {
        file = resultFile;
        filename = resultFilename;

        widget._onFileSet(resultFile);
      });
    }
  }

  void clearFile() {
    setState(() {
      file = null;
      filename = null;

      widget._onFileSet(null);
    });
  }
}
