import 'package:cross_file/cross_file.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class FileInputContainer extends StatefulWidget {
  final ValueChanged<XFile?> onFileSet;

  const FileInputContainer({super.key, required this.onFileSet});

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
      onTap:
          file == null
              ? () async {
                final result = await FilePicker.platform.pickFiles();
                final resultPlatformFile = result?.files.firstOrNull;

                if (resultPlatformFile != null) {
                  final resultFile = XFile(resultPlatformFile.path!);
                  final resultFilename = resultPlatformFile.name;

                  setState(() {
                    file = resultFile;
                    filename = resultFilename;

                    widget.onFileSet(resultFile);
                  });
                }
              }
              : null,
      child: DropTarget(
        enable: file == null,
        onDragDone: (details) {
          final dropItem = details.files.firstOrNull;

          if (dropItem != null) {
            final resultFile = XFile(dropItem.path);
            final resultFilename = dropItem.name;

            file = resultFile;
            filename = resultFilename;

            widget.onFileSet(resultFile);
          }
        },
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
                        onPressed: () {
                          clearFile();
                        },
                        style: FilledButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.error,
                        ),
                        child: Text('Clear File'),
                      ),
                    ],
                  )
                  : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 8,
                    children: [
                      Icon(Icons.file_open, size: 64),
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

  void clearFile() {
    setState(() {
      file = null;
      filename = null;

      widget.onFileSet(null);
    });
  }
}
