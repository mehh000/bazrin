import 'package:bazrin/feature/presentation/common/classes/imports.dart';

class Advancedialog extends StatelessWidget {
  final dynamic data;
  const Advancedialog({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    print('from the dialog : ${data}');
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Headercomponent(
            title: "Suppliers Name: ${data['supplier']['name']}",
            textWight: FontWeight.w400,
          ),
          Container(
            padding: EdgeInsetsDirectional.symmetric(
              horizontal: 15,
              vertical: 20,
            ),
            child: Column(
              spacing: 10,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Invoice Number:',
                      style: TextStyle(
                        color: AppColors.colorGray,
                        fontSize: 13,
                      ),
                    ),

                    Text(
                      ' ${data['invoiceNumber']}',
                      style: TextStyle(
                        color: AppColors.colorBlack,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Payment Date :',
                      style: TextStyle(
                        color: AppColors.colorGray,
                        fontSize: 13,
                      ),
                    ),

                    Text(
                      ' ${data['date']}',
                      style: TextStyle(
                        color: AppColors.colorBlack,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Dabit:',
                      style: TextStyle(
                        color: AppColors.colorGray,
                        fontSize: 13,
                      ),
                    ),

                    Text(
                      '৳25000',
                      style: TextStyle(
                        color: AppColors.colorBlack,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Cradit:',
                      style: TextStyle(
                        color: AppColors.colorGray,
                        fontSize: 13,
                      ),
                    ),

                    Text(
                      '234',
                      style: TextStyle(
                        color: AppColors.colorBlack,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Balance:',
                      style: TextStyle(
                        color: AppColors.colorGray,
                        fontSize: 13,
                      ),
                    ),

                    Text(
                      '234',
                      style: TextStyle(
                        color: AppColors.colorBlack,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
