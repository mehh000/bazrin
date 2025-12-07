import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

class SimpleRichEditorComponent extends StatefulWidget {
  const SimpleRichEditorComponent({super.key});

  @override
  State<SimpleRichEditorComponent> createState() =>
      _SimpleRichEditorComponentState();
}

class _SimpleRichEditorComponentState extends State<SimpleRichEditorComponent> {
  late QuillController _controller;

  @override
  void initState() {
    super.initState();
    _controller = QuillController.basic();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Use QuillToolbar.basic instead of QuillSimpleToolbar
        QuillSimpleToolbar(controller: _controller),

        /// Editor
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: QuillEditor.basic(
              controller: _controller,
              
            ),
          ),
        ),
      ],
    );
  }
}
