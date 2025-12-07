import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:bazrin/feature/presentation/common/Components/deleteDialog.dart';
import 'package:bazrin/feature/presentation/screens/Quotation/Presentation/Main/Components/quotation_invoice.dart';
import 'package:bazrin/feature/presentation/screens/Quotation/Presentation/View/quotation_view.dart';
import 'package:bazrin/feature/presentation/screens/products/Presentation/CategoryList/edit_cetagory.dart';

class Quotationcard extends StatefulWidget {
  final dynamic quotation;
  final Function delete;
  const Quotationcard({
    super.key,
    required this.quotation,
    required this.delete,
  });

  @override
  State<Quotationcard> createState() => _QuotationcardState();
}

class _QuotationcardState extends State<Quotationcard> {
  String productTitile = "Security Protection";

  final GlobalKey _menuKey = GlobalKey();

  void onDelete() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Deletedialog(
            title: "Quotaion",
            deleteFuntion: () {
              widget.delete(widget.quotation['id']);
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(width: 1, color: const Color(0xFFD6DDD0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // product info section
          Column(
            mainAxisSize: MainAxisSize.max,
            spacing: 5,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Date & Time: ',
                      style: TextStyle(fontSize: 14, color: Color(0xFF616161)),
                    ),
                    TextSpan(
                      text: '${widget.quotation['date']}',
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Quotation Number:  ',
                      style: TextStyle(fontSize: 12, color: Color(0xFF616161)),
                    ),
                    TextSpan(
                      text: '${widget.quotation['quotationNumber']}',
                      style: TextStyle(fontSize: 12, color: Colors.black),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Customer Name: ',
                      style: TextStyle(fontSize: 14, color: Color(0xFF616161)),
                    ),
                    TextSpan(
                      text: '${widget.quotation['customer']['name']}',
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Amount ',
                    style: TextStyle(fontSize: 14, color: Color(0xFF616161)),
                  ),
                  Text(
                    '৳ ${widget.quotation['totalAmount'].toString()}',
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ],
              ),
              // Text(
              //   productTitile.length > 46
              //       ? '${productTitile.substring(0, 40)}...'
              //       : productTitile,
              //   overflow: TextOverflow.ellipsis,
              //   style: const TextStyle(
              //     fontSize: 14,
              //     fontWeight: FontWeight.w400,
              //   ),
              // ),

              //inner
            ],
          ),

          // 3-dot menu
          GestureDetector(
            key: _menuKey,
            onTapDown: (TapDownDetails details) async {
              final position = details.globalPosition;
              final RenderBox overlay =
                  Overlay.of(context).context.findRenderObject() as RenderBox;

              final selected = await showMenu<String>(
                context: context,
                color: Colors.white,
                position: RelativeRect.fromLTRB(
                  position.dx - 100, // 👈 move left by ~20px
                  position.dy,
                  overlay.size.width - position.dx,
                  overlay.size.height - position.dy,
                ),
                items: [
                  PopupMenuItem<String>(
                    value: 'view',
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [const Text('View')],
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'edit',
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [const Text('Edit')],
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'Sell',
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [const Text('Sell')],
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'delete',
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [const Text('Delete')],
                    ),
                  ),
                ],
              );

              if (selected != null) {
                // handle action here
                if (selected == 'edit') {
                  Navigator.of(context).push(
                    SlidePageRoute(
                      page: EditCetagory(),
                      direction: SlideDirection.right,
                    ),
                  );
                } else if (selected == 'delete') {
                  onDelete();
                } else if (selected == 'view') {
                  Navigator.of(context).push(
                    SlidePageRoute(
                      page: QuotationView(
                        QuotationDetails: widget.quotation['id'],
                      ),
                      direction: SlideDirection.right,
                    ),
                  );
                }
              }
            },
            child: Image.asset('assets/images/3dot.png', height: 16, width: 16),
          ),
        ],
      ),
    );
  }
}
