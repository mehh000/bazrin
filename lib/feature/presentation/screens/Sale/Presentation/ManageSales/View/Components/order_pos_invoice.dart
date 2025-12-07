import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:bazrin/feature/presentation/common/Components/iconEvButton.dart';
import 'package:bazrin/feature/presentation/screens/products/Presentation/Product/View/view_product.dart';
import 'package:barcode/barcode.dart';

class OrderPosInvoice extends StatefulWidget {
  final dynamic profile;
  final dynamic invoice;
  const OrderPosInvoice({
    super.key,
    required this.profile,
    required this.invoice,
  });

  @override
  State<OrderPosInvoice> createState() => _OrderPosInvoiceState();
}

class _OrderPosInvoiceState extends State<OrderPosInvoice> {
  late final String barcode;

  @override
  void initState() {
    super.initState();

    final bc = Barcode.code128();
    barcode = bc.toSvg(
      '2q34234', // your barcode data
      drawText: false, // hide the number text
      width: 200, // width of barcode
      height: 40, // height of barcode lines
    );
  }

  @override
  Widget build(BuildContext context) {
    dynamic profile = widget.profile;
    dynamic invoice = widget.invoice;
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 12),
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 25),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Container(
                  color: Colors.blue.shade50,
                  width: 60,
                  height: 60,
                  child:
                      (profile?['setting']?['appearance']?['logo']?['md'] !=
                          null)
                      ? Image.network(
                          'https://bazrin.com/${profile?['setting']?['appearance']?['logo']?['lg']}',
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
                SizedBox(height: 8),
                Text(
                  '${profile['setting']['name']}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),

                Text(
                  'Address :${profile['setting']['location']['address']}',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                ),
                Text(
                  '${profile['setting']['location']['country']}',
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  'Mobile:${profile['contact']['phone']}',
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  'Email:${profile['contact']['email']}',
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(height: 8),
                RowComponent('Invoice ID', '${invoice['saleId']}'),
                RowComponent(
                  'Date',
                  "${DateTime.parse(invoice['saleDate']).toLocal().year}-${DateTime.parse(invoice['saleDate']).toLocal().month.toString().padLeft(2, '0')}-${DateTime.parse(invoice['saleDate']).toLocal().day.toString().padLeft(2, '0')} ${DateTime.parse(invoice['saleDate']).toLocal().hour.toString().padLeft(2, '0')}:${DateTime.parse(invoice['saleDate']).toLocal().minute.toString().padLeft(2, '0')}",
                ),
                RowComponent(
                  'Customer Name',
                  '${invoice['customerInfo']['name']}',
                ),
                Text(
                  'INVOICE',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SvgPicture.string(barcode, width: 200, height: 40),
                SizedBox(height: 8),
                Table(
                  columnWidths: {
                    0: FlexColumnWidth(0.6), // first column = min width
                    1: FlexColumnWidth(5), // Name column = expands more
                    2: FlexColumnWidth(1), // QTY
                    3: FlexColumnWidth(2), // Price
                    4: FlexColumnWidth(2), // Amount
                  },
                  children: [
                    TableRow(
                      children: [
                        Text(
                          "SL",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Name",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "QTY",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Price",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Amount",
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        Text("1", style: TextStyle(fontSize: 14)),
                        Text(
                          "${invoice['lineItems'][0]['name']}",
                          style: TextStyle(fontSize: 14),
                        ),
                        Text(
                          "${invoice['lineItems'][0]['quantity']}",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14),
                        ),
                        Text(
                          "${invoice['lineItems'][0]['unitPrice']}",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14),
                        ),
                        Text(
                          "${invoice['lineItems'][0]['totalAmount']}",
                          textAlign: TextAlign.end,
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 2),
                Divider(height: 1, color: Colors.grey, thickness: 1.5),
                SizedBox(height: 2),
                Rowlinedatashow(
                  left: 'Total:',
                  right: "${invoice['lineItems'][0]['totalAfterDiscount']}",
                ),
                Rowlinedatashow(
                  left: 'Order tax:',
                  right: "${invoice['vat'] ?? '0'}",
                ),
                Rowlinedatashow(
                  left: 'Delivery Charge:',
                  right: "${invoice['deliveryCost'] ?? '0'}",
                ),
                Rowlinedatashow(
                  left: 'Discount:',
                  right: "${invoice['discount']['value']}",
                ),
                Rowlinedatashow(
                  left: 'Amount paid:',
                  right: "${invoice['totalPaid']}",
                ),
                Rowlinedatashow(
                  left: 'Due:',
                  right: "${invoice['totalRemaining']}",
                ),
                SizedBox(height: 6),
                Text(
                  'Payment',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 6),
                Table(
                  columnWidths: {
                    0: FlexColumnWidth(0.6), // first column = min width
                    1: FlexColumnWidth(2), // Price
                    2: FlexColumnWidth(2), // Amount
                  },
                  children: [
                    TableRow(
                      children: [
                        Text(
                          "SL",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        Text(
                          "Payment Method",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Amount",
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        Text("1", style: TextStyle(fontSize: 14)),

                        Text(
                          "${invoice['payments'][0]['account']['type']}",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14),
                        ),
                        Text(
                          "${invoice['payments'][0]['amount'].toString()}",

                          textAlign: TextAlign.end,
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Rowlinedatashow(
                  left: 'Previous Point Balance:',
                  right: "${invoice['previousRemaining']}",
                ),
                Rowlinedatashow(
                  left: 'Current Point Balance:',
                  right: "${invoice['finalRemaining']}",
                ),
                SizedBox(height: 2),
                Divider(height: 1, color: Colors.black, thickness: 1.5),
                Rowlinedatashow(
                  left: 'Total Point Balance:',
                  right: "${invoice['lineItems'][0]['totalAfterDiscount']}",
                ),
                SizedBox(height: 20),
                Text(
                  'Thank you for choosing us!',
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
                ),
                Text(
                  '© Powered by Bazrin',
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
                ),
              ],
            ),
          ), 
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Iconevbutton(
                  title: 'Email',
                  colorData: Color(0xFFE88F00),
                  iconName: Icons.email_outlined,
                ),
                Iconevbutton(
                  title: 'Share',
                  colorData: const Color.fromARGB(255, 18, 182, 23),
                  iconName: Icons.wechat_sharp,
                ),
                Iconevbutton(
                  title: 'Print',
                  colorData: const Color.fromARGB(255, 19, 144, 247),
                  iconName: Icons.print,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
