import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:bazrin/feature/presentation/common/Components/iconEvButton.dart';
import 'package:barcode/barcode.dart';

class OrderPackageLevel extends StatefulWidget {
  final dynamic packageData;
  final dynamic profile;
  const OrderPackageLevel({
    super.key,
    required this.packageData,
    required this.profile,
  });

  @override
  State<OrderPackageLevel> createState() => _OrderPackageLevelState();
}

class _OrderPackageLevelState extends State<OrderPackageLevel> {
  late final String barcode;
  late final String qrSvg;

  @override
  void initState() {
    super.initState();
    final qr = Barcode.qrCode();
    qrSvg = qr.toSvg(
      '2q34234', // your QR data
      width: 200, // QR size
      height: 200, // QR size (must be square)
      drawText: false,
    );
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
    dynamic package = widget.packageData;
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
            child: Center(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Colors.grey.withOpacity(0.4),
                  ),
                  borderRadius: BorderRadius.circular(6),
                ),

                child: Column(
                  spacing: 12,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.grey.withOpacity(0.4),
                        ),
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'This My Shop',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'Phone: 01949494949',
                                style: TextStyle(fontSize: 12),
                              ),
                              Text(
                                'Address: dhaka and dhaka',
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    Text(
                      'Customer Name:',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                height: 40,
                                width: double.infinity,
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.grey.withOpacity(0.8),
                                  ),
                                  // borderRadius: BorderRadius.circular(2),
                                ),
                                child: Text(
                                  'Customer Name',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Container(
                                height: 40,
                                width: double.infinity,
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.grey.withOpacity(0.8),
                                  ),
                                  // borderRadius: BorderRadius.circular(2),
                                ),
                                child: Text(
                                  '${package['customerInfo']['name']}',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                height: 40,
                                width: double.infinity,
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.grey.withOpacity(0.8),
                                  ),
                                  // borderRadius: BorderRadius.circular(2),
                                ),
                                child: Text(
                                  'Address',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Container(
                                height: 40,
                                width: double.infinity,
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.grey.withOpacity(0.8),
                                  ),
                                  // borderRadius: BorderRadius.circular(2),
                                ),
                                child: Text(
                                  '${package['customerInfo']['address']}',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                height: 40,
                                width: double.infinity,
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.grey.withOpacity(0.8),
                                  ),
                                  // borderRadius: BorderRadius.circular(2),
                                ),
                                child: Text(
                                  'Phone',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Container(
                                height: 40,
                                width: double.infinity,
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.grey.withOpacity(0.8),
                                  ),
                                  // borderRadius: BorderRadius.circular(2),
                                ),
                                child: Text(
                                  '${package['customerInfo']['phone']}',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.grey.withOpacity(0.4),
                        ),
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: Center(
                        child: Text(
                          'Order Id: ${package['saleId']}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    Text(
                      'Package Details:',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    // qr and  details
                    Row(
                      children: [
                        // Left column area
                        Container(
                          width: 170, // same width
                          height: 168, // same height
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      height: 40,
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 1,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Weight',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Container(
                                      height: 40,
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 1,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        '1.5 KG',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      height: 40,
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 1,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Dimensions',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Container(
                                      height: 40,
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 1,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        '12x10x2 in',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              Container(
                                height: 40,
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.grey,
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  'Fragile',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),

                              SizedBox(height: 8),

                              SvgPicture.string(
                                barcode,
                                width: 200,
                                height: 40,
                              ),
                            ],
                          ),
                        ),

                        SizedBox(width: 12),

                        // QR code area (same size)
                        Expanded(
                          child: Container(
                            height: 168,
                            child: SvgPicture.string(
                              qrSvg,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
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
