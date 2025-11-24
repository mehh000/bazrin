import 'package:bazrin/feature/presentation/common/classes/imports.dart';

class RichTextEditor extends StatefulWidget {
  final String label;
  final QuillController noteQuillController;
  const RichTextEditor({
    super.key,
    this.label = "Note",
    required this.noteQuillController,
  });

  @override
  State<RichTextEditor> createState() => _RichTextEditorState();
}

class _RichTextEditorState extends State<RichTextEditor> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12,
      children: [
        Text(
          widget.label,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        Container(
          decoration: BoxDecoration(
            // color: Colors.black.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.black.withOpacity(0.1), width: 2),
          ),

          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              QuillSimpleToolbar(
                controller: widget.noteQuillController,
                config: QuillSimpleToolbarConfig(
                  showBoldButton: true,
                  showItalicButton: true,
                  showUnderLineButton: true,
                  showAlignmentButtons: true,
                  showStrikeThrough: false,
                  showFontFamily: false,
                  showFontSize: false,
                  showColorButton: false,
                  showBackgroundColorButton: false,
                  showListNumbers: false,
                  showListBullets: false,
                  showListCheck: false,
                  showCodeBlock: false,
                  showQuote: false,
                  showLink: false,
                  showClearFormat: false,
                  showUndo: false,
                  showRedo: false,
                  showSearchButton: false,
                  showHeaderStyle: false,
                  showDividers: false,
                  showInlineCode: false,
                  multiRowsDisplay: false,
                  color: Colors.black.withOpacity(0.1),
                ),
              ),
              Container(
                height: 200,
                padding: EdgeInsets.all(8),
                child: QuillEditor.basic(
                  controller: widget.noteQuillController,
                  config: QuillEditorConfig(
                    placeholder: "Enter Product Description",
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
