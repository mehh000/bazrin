import 'package:bazrin/feature/data/API/Helper/Product/getProductList.dart';
import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:bazrin/feature/presentation/common/widgets/currency_picker.dart';
import 'package:bazrin/feature/presentation/common/widgets/search_dropdown.dart';
import 'package:bazrin/feature/presentation/common/widgets/simple_input.dart';
import 'package:bazrin/feature/presentation/screens/Purchase/widgets/selected_product_card.dart';

class AddQuation extends StatefulWidget {
  const AddQuation({super.key});

  @override
  State<AddQuation> createState() => _AddQuationState();
}

class _AddQuationState extends State<AddQuation> {
  final bodyText_controller = QuillController.basic();
  TextEditingController _productSearchController = TextEditingController();
  dynamic productList = [];
  dynamic selectedProductId = [];
  List<Map<String, dynamic>> addproductData = [];
  double sum = 0;

  @override
  void initState() {
    super.initState();
    getProductList();
  }

  void getProductList() async {
    final response = await Getproductlist.getProductList();
    final List<Map<String, dynamic>> parsedList = (response as List)
        .map((e) => Map<String, dynamic>.from(e))
        .toList();
    setState(() {
      productList = parsedList;
    });
  }

  void cheakAndAdd(Map<String, dynamic> pro) {
    final index = addproductData.indexWhere((item) => item['id'] == pro['id']);

    if (index != -1) {
      addproductData[index] = pro;
    } else {
      addproductData.add(pro);
    }

    // print('Updated List: $addexpenseData');
  }

  void deleteProductFromSelect(id) {
    setState(() {
      selectedProductId.removeWhere((product) => product['id'] == id['id']);
      sum = sum - id['sum'];
    });
  }

  List<Map<String, dynamic>> addexpenseDataofSum = [];

  void addOrUpdateAndCalculateTotal(Map<String, dynamic> product) {
    // Check if product exists in the list
    final index = addexpenseDataofSum.indexWhere(
      (item) => item['productId'] == product['productId'],
    );

    if (index != -1) {
      // Replace existing product
      addexpenseDataofSum[index] = product;
    } else {
      // Add new product
      addexpenseDataofSum.add(product);
    }

    // Calculate the total sum of all products
    double totalSum = 0.0;
    for (var item in addexpenseDataofSum) {
      double itemTotal = double.tryParse(item['total']?.toString() ?? '0') ?? 0;
      totalSum += itemTotal;
    }

    // print("✅ Current total sum: $totalSum");
    setState(() {
      sum = totalSum;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.Colorprimary,
          leading: Row(
            children: [
              SizedBox(width: 20),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    SlidePageRoute(
                      page: Quotation(),
                      direction: SlideDirection.left,
                    ),
                  );
                },
                child: Icon(Icons.arrow_back, color: Colors.white),
              ),
            ],
          ),
          title: Text(
            'Add Quotation',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        backgroundColor: AppColors.Colorprimary,
        body: Column(
          children: [
            SizedBox(height: 20), 

            Expanded(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                  color: Color(0xFFF5F5F7),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    spacing: 5,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                        ),
                        child: Column(
                          children: [
                            Headercomponent(title: 'Add Quotation'),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 15,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,

                                spacing: 10,
                                children: [
                                  InputComponent(
                                    hintitle: 'Customer Name',
                                    required: true,
                                    islabel: true,
                                    label: 'Customer Name',
                                  ),
                                  DatePicker(
                                    label: "Quotation Dare",
                                    required: true,
                                  ),

                                  Column(
                                    spacing: 3,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Currency Rate",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                              color: AppColors.colorBlack,
                                            ),
                                          ),
                                          Text(
                                            '*',
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        height: 49,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          border: Border.all(
                                            width: 1,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: CurrencyPickerWidget(
                                                label: "Currency Rate",
                                              ),
                                            ),
                                            SizedBox(
                                              height: 40,
                                              child: VerticalDivider(
                                                color: AppColors.colorBlack
                                                    .withOpacity(0.3),
                                                thickness: 1.5,
                                                width:
                                                    20, // space between widgets
                                              ),
                                            ),
                                            Expanded(
                                              child: SimpleInput(
                                                hintText: '1',
                                                isBorder: false,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  InputComponent(
                                    hintitle: 'Referance No',
                                    required: true,
                                    islabel: true,
                                    label: 'Referance No',
                                  ),
                                  InputComponent(
                                    hintitle: 'Authorrize Person',
                                    required: true,
                                    islabel: true,
                                    label: 'Authorrize Person',
                                  ),
                                  InputComponent(
                                    hintitle: 'Kind Attension',
                                    required: true,
                                    islabel: true,
                                    label: 'Kind Attension',
                                  ),
                                  InputComponent(
                                    hintitle: 'Subject',
                                    required: true,
                                    islabel: true,
                                    label: 'Subject',
                                  ),
                                  Text(
                                    'Body Text',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color: AppColors.colorBlack,
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      // color: Colors.black.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: Colors.black.withOpacity(0.1),
                                        width: 2,
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        QuillSimpleToolbar(
                                          controller: bodyText_controller,
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
                                            color: Colors.black.withOpacity(
                                              0.1,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 200,
                                          padding: EdgeInsets.all(8),
                                          child: QuillEditor.basic(
                                            controller: bodyText_controller,
                                            config: QuillEditorConfig(
                                              placeholder:
                                                  "Enter Product Description",
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: 50,

                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                        255,
                                        247,
                                        247,
                                        247,
                                      ).withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        width: 1,
                                        color: Colors.blueGrey.withOpacity(0.5),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: double.infinity,
                                          width: 50,
                                          color: Colors.black.withOpacity(0.1),
                                          child: Center(
                                            child: Image.asset(
                                              'assets/images/sku.png',
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: MySearchDropdown(
                                            isClear: false,
                                            items: productList,
                                            isBorder: false,
                                            addButtonTitle: "Add New Product",
                                            dropDownSearchController:
                                                _productSearchController,
                                            hint:
                                                'Search By Product Name / SKU / Barcode',
                                            onChanged: (e) {
                                              setState(() {
                                                selectedProductId.add(e);
                                              });
                                              // calculateTotalAmount();
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 12),
                      selectedProductId != null
                          ? Column(
                              spacing: 8,
                              children: selectedProductId
                                  .map<Widget>(
                                    (product) => SelectedPurchaseProductCard(
                                      deleteProductFromSelect:
                                          deleteProductFromSelect,
                                      product: product,
                                      latestData: (e) {
                                        cheakAndAdd(e);
                                      },
                                      latestsum: (e) {
                                        addOrUpdateAndCalculateTotal(e);
                                      },
                                    ),
                                  )
                                  .toList(),
                            )
                          : SizedBox(),
                      SizedBox(height: 12),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 18,
                          children: [
                            InputComponent(
                              hintitle: '100',
                              read: true,
                              islabel: true,
                              label: 'SubTotal :',
                              spcae: 12,
                            ),

                            Container(
                              decoration: BoxDecoration(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: 12,
                                children: [
                                  Text(
                                    'Discount',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color: AppColors.colorBlack,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: SimpleInput(hintText: 'Percent'),
                                      ),
                                      Expanded(
                                        child: SimpleInput(
                                          hintText: 'Percentage',
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            InputComponent(
                              hintitle: '100',
                              read: true,
                              islabel: true,
                              label: 'After Discount :',
                              spcae: 12,
                            ),
                            InputComponent(
                              hintitle: '100',

                              islabel: true,
                              label: 'Vat Percent :',
                              spcae: 12,
                            ),
                            InputComponent(
                              hintitle: '100',

                              islabel: true,
                              label: 'Total Amount :',
                              spcae: 12,
                            ),
                            Text(
                              'Body Text',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: AppColors.colorBlack,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                // color: Colors.black.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Colors.black.withOpacity(0.1),
                                  width: 2,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  QuillSimpleToolbar(
                                    controller: bodyText_controller,
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
                                      controller: bodyText_controller,
                                      config: QuillEditorConfig(
                                        placeholder:
                                            "Enter Product Description",
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              spacing: 15,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(height: 20),
                                Expanded(
                                  child: ButtonEv(
                                    title: 'Cancle',
                                    textColor: AppColors.colorRed,
                                    isBorder: true,
                                    borderColor: AppColors.colorRed,
                                  ),
                                ),

                                Expanded(
                                  child: ButtonEv(
                                    title: 'Add Quotation',
                                    colorData: AppColors.Colorprimary,
                                  ),
                                ),
                                SizedBox(height: 20),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 120),
                    ],
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
