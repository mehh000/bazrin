import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:bazrin/feature/presentation/common/classes/prettyPrint.dart';

class Productcard extends StatefulWidget {
  final dynamic posItems;
  final Function addfuntion;
  final Function addremovefuntion;
  const Productcard({
    super.key,
    this.posItems,
    required this.addfuntion,
    required this.addremovefuntion,
  });

  @override
  State<Productcard> createState() => _ProductcardState();
}

class _ProductcardState extends State<Productcard> {
  int currentQty = 0;
  final int maxQty = 20;
  String selectedModel = "";
  bool addfuntionActive = false;
  void showbuttomfuntion() {
    setState(() {
      addfuntionActive = !addfuntionActive;
    });
  }

  void selectModel(model) {
    final updated = {...widget.posItems, "selectedModel": model};

    setState(() {
      selectedModel = model;
    });

    showbuttomfuntion();
    Navigator.of(context).pop();

    widget.addfuntion(updated);

    PrettyPrint.print(updated);
  }

  void showModel() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 35),
          child: Container(
            width: double.infinity,
            // padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.grey, width: 1),
                    ),
                  ),
                  child: Text(
                    'Choose A Model',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Center(
                  child: (widget.posItems['coverImage']['md'] != null)
                      ? Image.network(
                          'https://bazrin.com/${widget.posItems['coverImage']['md']}',
                          height: 150,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(
                                Icons.store,
                                size: 30,
                                color: Colors.grey,
                              ),
                        )
                      : const Icon(Icons.store, size: 30, color: Colors.grey),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    spacing: 12,
                    children: [
                      InputComponent(hintitle: "Search a model", preicon: true),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Table(
                          columnWidths: {
                            0: FlexColumnWidth(1), // first column = min width
                            1: FlexColumnWidth(5), // Name column = expands more
                            2: FlexColumnWidth(2), // QTY
                          },
                          children: [
                            TableRow(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    width: 1,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 2.0,
                                  ),
                                  child: Text(
                                    "N0.",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Text(
                                  "Model",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "Action",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            ...List.generate(widget.posItems['models'].length, (
                              index,
                            ) {
                              return TableRow(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      width: 1,
                                      color:
                                          index ==
                                              widget.posItems['models'].length -
                                                  1
                                          ? Colors.white
                                          : Colors.grey,
                                    ),
                                  ),
                                ),
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 2.0,
                                    ),
                                    child: Text(
                                      "${1 + index}",
                                      style: TextStyle(fontSize: 14, height: 3),
                                    ),
                                  ),
                                  Text(
                                    "${widget.posItems['models'][index]}",

                                    style: TextStyle(fontSize: 14, height: 3),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      selectModel(
                                        widget.posItems['models'][index],
                                      );
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(top: 8),
                                      width: double.infinity,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        color:
                                            widget.posItems['models'][index] ==
                                                selectedModel
                                            ? AppColors
                                                  .Colorprimary.withOpacity(0.2)
                                            : AppColors.Colorprimary,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Select',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    dynamic posItems = widget.posItems;
    // PrettyPrint.print(posItems);
    return GestureDetector(
      onTap: () {
        if (addfuntionActive) {
          showbuttomfuntion();
          return;
        }
        if (posItems['type'] == "MODEL") {
          showModel();
        } else {
          widget.addfuntion(widget.posItems);
          showbuttomfuntion();
        }
      },
      child: Container(
        margin: EdgeInsets.only(right: 8, bottom: 8, left: 8),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: (posItems['coverImage']['md'] != null)
                      ? Image.network(
                          'https://bazrin.com/${posItems['coverImage']['md']}',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(
                                Icons.store,
                                size: 30,
                                color: Colors.grey,
                              ),
                        )
                      : const Icon(Icons.store, size: 30, color: Colors.grey),
                ),

                const SizedBox(height: 5),
                Text(
                  "${posItems['name'].length > 20 ? "${posItems['name'].substring(0, 19)}..." : posItems['name'] ?? ''}",
                  style: TextStyle(
                    color: Color(0xFF212B36),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 5),
                const DottedBorderComponent(
                  child: SizedBox(width: double.infinity),
                  topBorder: true,
                  fullBorder: false,
                ),

                const SizedBox(height: 5),
                Text(
                  '${posItems['salePriceRange'] == null ? '' : posItems['salePriceRange'][0]} ${posItems['salePriceRange'] == null ? "" : '-'} ${posItems['salePrice'] == null ? "" : posItems['salePrice']}',
                  style: TextStyle(
                    color: Color(0xFF212B36),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 8),

                /// ---------------------------
                /// Animated Expandable Section
                /// ---------------------------
                AnimatedSize(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.fastOutSlowIn,
                  child: addfuntionActive
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (currentQty > 0) currentQty--;
                                });
                                widget.addremovefuntion({
                                  ...posItems,
                                  "posQty": currentQty,
                                });
                              },
                              child: Container(
                                width: 50,
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: AppColors.Colorprimary,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Icon(
                                  Icons.remove,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ),
                            ),
                            Container(
                              width: 60,
                              height: 30,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                '$currentQty',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (currentQty < posItems['stock'])
                                    currentQty++;
                                });
                                widget.addremovefuntion({
                                  ...posItems,
                                  "posQty": currentQty,
                                });
                              },
                              child: Container(
                                width: 50,
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: AppColors.Colorprimary,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ),
                            ),
                          ],
                        )
                      : const SizedBox(),
                ),
              ],
            ),

            // Top-right qty badge
            Positioned(
              child: Container(
                width: 50,
                height: 25,
                decoration: BoxDecoration(
                  color: posItems['stock'] == 0
                      ? Colors.red
                      : Color(0xFF22c55e),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Center(
                  child: Text(
                    'Qty:${posItems['stock']}',
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
