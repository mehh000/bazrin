import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:bazrin/feature/presentation/common/Components/iconEvButton.dart';
import 'package:number_to_words/number_to_words.dart';

class ExpenseInvoice extends StatelessWidget {
  final dynamic invoiceData;
  final double totalAmount;
  final double totalPaid;
  final double totalRemaining;
  const ExpenseInvoice({
    super.key,
    required this.invoiceData,
    required this.totalAmount,
    required this.totalPaid,
    required this.totalRemaining,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: [
              Row(
                spacing: 50,
                children: [
                  SizedBox(
                    width: 50,
                    height: 60,
                    child: Image.asset(
                      'assets/images/qrbdlogo.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Text(
                    'Expense Voucher',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.blue[700],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),

              Row(children: [

],),

              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                      ), // outer gray border
                    ),
                    child: Column(
                      children: [
                        // 🔹 Table Header
                        Container(
                          color: AppColors.Colorprimary,
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 8,
                          ),
                          child: Row(
                            spacing: 2,
                            children: const [
                              Expanded(
                                flex: 1,
                                child: Text('SL', style: _headerStyle),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text('NAME', style: _headerStyle),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text('QUANTITY', style: _headerStyle),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text('UNIT PRICE', style: _headerStyle),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text('SUB TOTAL', style: _headerStyle),
                              ),
                            ],
                          ),
                        ),

                        // 🔹 One Product Row
                        ...invoiceData.asMap().entries.map<Widget>((entry) {
                          int i = entry.key; // This is the index
                          var rowData = entry.value; // This is the row data

                          return Row(
                            children: [
                              Expanded(flex: 1, child: Text('  ${i + 1}')),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  rowData['name'] ?? 'N/A',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Center(
                                  child: Text(
                                    '${rowData['quantity']}',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Center(
                                  child: Text(
                                    '৳${rowData['unitPrice']}',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Center(
                                  child: Text(
                                    '৳${rowData['totalAmount']}',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                  // table ends
                  Row(
                    spacing: 10,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 1, child: Container()),
                      Expanded(
                        flex: 2,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              left: BorderSide(color: Colors.grey, width: 1),
                              right: BorderSide(color: Colors.grey, width: 1),
                              bottom: BorderSide(color: Colors.grey, width: 1),
                            ), // outer gray border
                          ),
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(4),
                                width: double.infinity,
                                color: AppColors.graysecond,

                                child: Rowlinedatashow(
                                  left: "Total Amount",
                                  right: totalAmount.toString(),
                                  fontSize: 14,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(4),
                                width: double.infinity,

                                child: Rowlinedatashow(
                                  left: "Total Paid",
                                  right: totalPaid.toString(),
                                  fontSize: 14,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(4),
                                width: double.infinity,
                                color: AppColors.graysecond,

                                child: Rowlinedatashow(
                                  left: "Total Due",
                                  right: totalRemaining.toString(),
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'In Words:: ',
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        ),
                        TextSpan(
                          text: NumberToWord().convert(
                            'en-in',
                            totalAmount.toInt(),
                          ),
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF616161),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    width: 150,
                    height: 150,
                    child: Image.asset(
                      'assets/images/qrcode.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                height: 80,
                child: Center(
                  child: Text(
                    'This Quotation generated by Software. No signature or stamp is required.',
                    style: TextStyle(fontSize: 8),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          spacing: 20,
          children: [
            Iconevbutton(
              title: "Download",
              colorData: Colors.blue,
              iconName: Icons.download,
            ),
            Iconevbutton(
              title: "Print",
              colorData: AppColors.Colorprimary,
              iconName: Icons.print,
            ),
          ],
        ),
      ],
    );
  }
}

const _headerStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontSize: 12,
);
