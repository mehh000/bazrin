import 'package:bazrin/feature/presentation/common/Components/simple_input.dart';
import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:flutter/material.dart';

class Pagination extends StatefulWidget {
  final int totalPages;
  final Function(int)? onPageChanged;

  const Pagination({super.key, required this.totalPages, this.onPageChanged});

  @override
  State<Pagination> createState() => _PaginationState();
}

class _PaginationState extends State<Pagination> {
  int selectedPage = 1;

  // We show maximum 3 pages at a time
  int startPage = 1;

  void _selectPage(int page) {
    setState(() {
      selectedPage = page;

      // Adjust startPage if selectedPage goes out of the current window
      if (selectedPage < startPage) {
        startPage = selectedPage;
      } else if (selectedPage >= startPage + 3) {
        startPage = selectedPage - 2;
      }
    });

    if (widget.onPageChanged != null) {
      widget.onPageChanged!(page);
    }
  }

  void _previousPage() {
    if (selectedPage > 1) {
      _selectPage(selectedPage - 1);
    }
  }

  void _nextPage() {
    if (selectedPage < widget.totalPages ) {
      _selectPage(selectedPage + 1);
    }
  }

  List<int> _getVisiblePages() {
    final endPage = (startPage + 2).clamp(1, widget.totalPages);
    return List.generate(endPage - startPage + 1, (index) => startPage + index);
  }

  @override
  Widget build(BuildContext context) {
    final visiblePages = _getVisiblePages();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 20, bottom: 60),
      child: Column(
        spacing: 12,
        children: [
          Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              SizedBox(
                height: 50,
                child: ButtonEv(
                  title: 'Pre',
                  colorData: AppColors.Colorprimary,
                ),
              ),
              // Left Arrow
              IconButton(
                icon: const Icon(Icons.keyboard_arrow_left_outlined),
                onPressed: _previousPage,
              ),

              // Page Numbers
              ...visiblePages.map((page) {
                final isSelected = page == selectedPage;
                return GestureDetector(
                  onTap: () => _selectPage(page),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.Colorprimary
                          : Colors.transparent,
                      border: Border.all(color: AppColors.Colorprimary),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      '$page',
                      style: TextStyle(
                        color: isSelected
                            ? Colors.white
                            : AppColors.Colorprimary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                );
              }).toList(),

              // Right Arrow
              IconButton(
                icon: const Icon(Icons.keyboard_arrow_right_outlined),
                onPressed: _nextPage,
              ),
              SizedBox(
                height: 50,
                child: ButtonEv(
                  title: 'Next',
                  colorData: AppColors.Colorprimary,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 10,
            children: [
              SizedBox(
                height: 50,
                child: ButtonEv(
                  title: 'Go to',
                  colorData: AppColors.Colorprimary,
                ),
              ),
              SizedBox(
                height: 50,
                width: 70,
                child: SimpleInput(hintText: "1...2"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
