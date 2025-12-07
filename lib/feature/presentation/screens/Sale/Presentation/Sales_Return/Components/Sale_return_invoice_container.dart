import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:bazrin/feature/presentation/common/Components/iconEvButton.dart';
import 'package:number_to_words/number_to_words.dart';

class SaleReturnInvoiceContainer extends StatelessWidget {
  final dynamic purchaseDetails;
  final dynamic profileData;
  const SaleReturnInvoiceContainer({
    super.key,
    required this.purchaseDetails,
    required this.profileData,
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
              Container(
                color: Colors.blue.shade50,
                width: 60,
                height: 50,
                child:
                    (profileData?['setting']?['appearance']?['logo']?['md'] !=
                        null)
                    ? Image.network(
                        'https://bazrin.com/${profileData?['setting']?['appearance']?['logo']?['lg']}',
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
              Rowlinedatashow(
                left: "To",
                right: "From",
                leftTextColor: AppColors.colorGray,
                rightTextColor: AppColors.colorGray,
              ),

              Row(
                spacing: 50,
                children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 1,
                            color: AppColors.colorBlack,
                          ),
                        ),
                      ),
                      child: Text(
                        ' ${purchaseDetails['customer']['name'] ?? ''}',
                      ),
                    ),
                  ),

                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 1,
                            color: AppColors.colorBlack,
                          ),
                        ),
                      ),
                      child: Text(
                        '${profileData['name'] ?? ''}',
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ),
                ],
              ),

              Rowlinedatashow(
                left: "${purchaseDetails['customer']['phone'] ?? ''}",
                leftIcon: true,
                rightIcon: true,
                right: '${profileData['contact']['phone'] ?? ''}',
                leftTextColor: AppColors.colorBlack,
                rightTextColor: AppColors.colorBlack,
              ),

              Rowlinedatashow(
                left: "${purchaseDetails['customer']['email'] ?? ''}",
                leftIcon: true,
                lefticonName: Icons.mail,
                righticonName: Icons.mail,
                rightIcon: true,
                right: '${profileData['contact']['email'] ?? ''}',
                leftTextColor: AppColors.colorBlack,
                rightTextColor: AppColors.colorBlack,
              ),

              Align(
                alignment: AlignmentGeometry.topRight,
                child: Text(
                  '${profileData['setting']['location']['address'] ?? ''}',
                ),
              ),

              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Column(
                      children: [
                        // 🟦 Header Row
                        Container(
                          color: AppColors.Colorprimary,
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 8,
                          ),
                          child: Row(
                            children: const [
                              Expanded(
                                flex: 1,
                                child: Text('SL', style: _headerStyle),
                              ),
                              Expanded(
                                flex: 3,
                                child: Text('Description', style: _headerStyle),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text('Qty', style: _headerStyle),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text('Unit Price', style: _headerStyle),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  'Total',
                                  textAlign: TextAlign.end,
                                  style: _headerStyle,
                                ),
                              ),
                            ],
                          ),
                        ),

                        ...purchaseDetails['items'].asMap().entries.map((
                          entry,
                        ) {
                          int index = entry.key;
                          final item = entry.value;

                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 8,
                            ),
                            child: Row(
                              children: [
                                Expanded(flex: 1, child: Text("${index + 1}")),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    item['productName'] ?? '',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Center(
                                    child: Text(
                                      "${item['returnQuantity']}",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Center(
                                    child: Text(
                                      "${item['returnPrice']}",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Center(
                                    child: Text(
                                      "${item['totalReturnPrice']}",
                                      textAlign: TextAlign.end,
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 20),
                              Text(
                                'Payment Method',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                'Cash On Delivery',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.colorTextGray,
                                ),
                              ),

                              Text(
                                'Payment Method',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              ),

                              Text(
                                '${purchaseDetails['note'] ?? ''}',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.colorTextGray,
                                ),
                              ),

                              Text(
                                'In Words:  ${NumberToWord().convert('en-in', purchaseDetails['totalAmount'].toInt())}',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              left: BorderSide(color: Colors.grey),
                              right: BorderSide(color: Colors.grey),
                              bottom: BorderSide(color: Colors.grey),
                            ), // outer gray border
                          ),
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(4),
                                width: double.infinity,
                                color: AppColors.graysecond,

                                child: Rowlinedatashow(
                                  left: "Sub Total",
                                  right:
                                      '৳ ${purchaseDetails['totalAmount'].toString()} ',
                                  fontSize: 14,
                                ),
                              ),
                              // Container(
                              //   padding: EdgeInsets.all(4),
                              //   width: double.infinity,

                              //   child: Rowlinedatashow(
                              //     left: "Other Cost",
                              //     right: '৳ ${purchaseDetails['totalRemaining'].toString()} ',
                              //     fontSize: 14,
                              //   ),
                              // ),
                              Container(
                                padding: EdgeInsets.all(4),
                                width: double.infinity,

                                // color: AppColors.graysecond,
                                child: Rowlinedatashow(
                                  left: "Total Paid",
                                  right:
                                      '৳ ${purchaseDetails['totalPaid'].toString()} ',
                                  fontSize: 14,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(4),
                                width: double.infinity,
                                color: AppColors.graysecond,
                                child: Rowlinedatashow(
                                  left: "Due",
                                  right:
                                      '৳  ${purchaseDetails['totalRemaining'].toString()} ',
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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
