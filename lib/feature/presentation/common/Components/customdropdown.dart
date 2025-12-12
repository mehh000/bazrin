import 'package:flutter/material.dart';

class SearchDropdown extends StatefulWidget {
  final List<Map<String, dynamic>> items;
  final ScrollController scrollController;
  final Function(Map<String, String>) onChanged;
  final Function(String)? searchOnchanged;
  final bool isBorder;
  final String hint;
  final String getter;
  final TextEditingController? textController;

  const SearchDropdown({
    super.key,
    required this.items,
    required this.onChanged,
    required this.scrollController,
    this.isBorder = true,
    this.hint = "search",
    this.getter = "name",
    this.textController,
    this.searchOnchanged,
  });

  @override
  State<SearchDropdown> createState() => _SearchDropdownState();
}

class _SearchDropdownState extends State<SearchDropdown> {
  final LayerLink _layerLink = LayerLink();
  final TextEditingController textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  OverlayEntry? _overlayEntry;

  List<Map<String, String>> filteredList = [];

  @override
  void initState() {
    super.initState();
    filteredList = widget.items
        .map<Map<String, String>>(
          (item) => item.map(
            (key, value) => MapEntry(key.toString(), value?.toString() ?? ''),
          ),
        )
        .toList();

    // Update filtering when user types
    textController.addListener(() {
      filterList();
      updateOverlay();
    });

    // Open overlay when focused
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        openOverlay();
      } else {
        closeOverlay();
      }
    });
  }

  @override
  void didUpdateWidget(covariant SearchDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.items != widget.items) {
      // Schedule update after current frame
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          setState(() {
            filteredList = widget.items
                .map<Map<String, String>>(
                  (item) => item.map(
                    (key, value) =>
                        MapEntry(key.toString(), value?.toString() ?? ''),
                  ),
                )
                .toList();
          });
          updateOverlay();
        }
      });
    }
  }

  void filterList() {
    final query = textController.text.toLowerCase();

    setState(() {
      filteredList = widget.items
          .map<Map<String, String>>(
            (item) => item.map(
              (key, value) => MapEntry(key.toString(), value?.toString() ?? ''),
            ),
          )
          .toList();
    });
  }

  void openOverlay() {
    closeOverlay();
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
  }

  void closeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void updateOverlay() {
    _overlayEntry?.markNeedsBuild();
  }

  @override
  void dispose() {
    closeOverlay();
    textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  // ---------------- CREATE THE DROPDOWN OVERLAY -------------------
  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    return OverlayEntry(
      builder: (context) {
        return Positioned(
          width: size.width,
          child: CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            offset: Offset(0, size.height + 5),
            child: Material(
              elevation: 3,
              borderRadius: BorderRadius.circular(8),
              child: Container(
                constraints: const BoxConstraints(maxHeight: 250),
                child: ListView.builder(
                  controller: widget.scrollController,
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: filteredList.length,
                  itemBuilder: (context, index) {
                    final item = filteredList[index];

                    return ListTile(
                      dense: true,
                      title: Text(item[widget.getter]!),
                      onTap: () {
                        textController.text = item[widget.getter]!;
                        widget.onChanged(item);

                        closeOverlay();
                        _focusNode.unfocus();
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // ---------------- THE INPUT FIELD -------------------
  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: TextField(
        controller: textController,
        focusNode: _focusNode,
        onChanged: (value) {
          widget.searchOnchanged?.call(value);
        },

        decoration: InputDecoration(
          hintText: widget.hint,
          suffixIcon: const Icon(Icons.arrow_drop_down),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          border: widget.isBorder
              ? OutlineInputBorder(borderRadius: BorderRadius.circular(8))
              : OutlineInputBorder(borderSide: BorderSide.none),
        ),
      ),
    );
  }
}
