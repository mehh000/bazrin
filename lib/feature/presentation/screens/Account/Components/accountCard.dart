import 'package:bazrin/feature/presentation/common/Components/deleteDialog.dart';
import 'package:bazrin/feature/presentation/common/classes/imports.dart';

class Accountcard extends StatefulWidget {
  final dynamic account;
  final Function delete;
  const Accountcard({super.key, required this.account, required this.delete});

  @override
  State<Accountcard> createState() => _AccountcardState();
}

class _AccountcardState extends State<Accountcard> {
  @override
  Widget build(BuildContext context) {
    void onDelete() {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => Dialog(
          child: Deletedialog(
            title: "Account",
            deleteFuntion: () => widget.delete(widget.account['id']),
          ),
        ),
      );
    }

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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            spacing: 8,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Bank/Provider ',
                      style: TextStyle(fontSize: 14, color: Color(0xFF616161)),
                    ),
                    TextSpan(
                      text:
                          '${widget.account['institutionName'] ?? "Not Found"}',
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Account Name: ',
                      style: TextStyle(fontSize: 14, color: Color(0xFF616161)),
                    ),
                    TextSpan(
                      text: '${widget.account['accountName']}',
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Type: ',
                      style: TextStyle(fontSize: 14, color: Color(0xFF616161)),
                    ),
                    TextSpan(
                      text: '${widget.account['type']}',
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Text(
                    'Status: ',
                    style: TextStyle(fontSize: 14, color: Color(0xFF616161)),
                  ),
                  Text(
                    '${widget.account['status']}',
                    style: TextStyle(fontSize: 14, color: Color(0xFF616161)),
                  ),
                ],
              ),
            ],
          ), // 1st colum ends here

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 5,
            children: [
              GestureDetector(
                onTap: onDelete,
                child: StatusContainer(
                  bgColor: AppColors.colorRed,
                  text: "Delete",
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Navigator.of(context).push(
                  //   SlidePageRoute(
                  //     page: EditExpenseCategory(catData: cat),
                  //     direction: SlideDirection.right,
                  //   ),
                  // );
                },
                child: StatusContainer(
                  bgColor: AppColors.Colorprimary,
                  text: "Edit",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// helper status containe
class StatusContainer extends StatelessWidget {
  final Color bgColor;
  final String text;
  const StatusContainer({super.key, required this.bgColor, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 3),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(2),
      ),
      child: Center(
        child: Text(text, style: TextStyle(color: Colors.white, fontSize: 12)),
      ),
    );
  }
}
