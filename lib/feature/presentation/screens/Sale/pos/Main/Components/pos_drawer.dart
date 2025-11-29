import 'package:bazrin/feature/data/API/Helper/Profile/getmyprofile.dart';
import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:flutter/material.dart';

class PosDrawer extends StatefulWidget {
  const PosDrawer({super.key});

  @override
  State<PosDrawer> createState() => _PosDrawerState();
}

class _PosDrawerState extends State<PosDrawer> {
  dynamic profile = {};
  bool isloaded = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProfile();
  }

  void getProfile() async {
    try {
      final response = await Getmyprofile.getMyProfile();
      setState(() {
        profile = response;
        isloaded = false;
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.only(left: 25, right: 25),
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        spacing: 5,
        children: [
          SizedBox(height: 40),
          Row(
            children: [
              ClipOval(
                child: Container(
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
              ),

              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  profile != null && profile['name'] != null
                      ? Text(
                          profile['name'].length > 10
                              ? profile['name'].substring(0, 11)
                              : profile['name'],
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      : const Text(
                          '',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                ],
              ),
            ],
          ),
          SizedBox(height: 5),
          Divider(thickness: 1, height: 1, color: AppColors.Colorprimary),
          SizedBox(height: 30),

          DrawerContaierButton(IconName: Icons.settings, buttonName: "Setting"),
          DrawerContaierButton(
            IconName: Icons.shopify_sharp,
            buttonName: "Todays Profit",
          ),
          DrawerContaierButton(
            IconName: Icons.today,
            buttonName: "Todays Sale",
          ),
          DrawerContaierButton(
            IconName: Icons.money,
            buttonName: "Cash Register Details",
          ),
          DrawerContaierButton(
            IconName: Icons.fullscreen,
            buttonName: "Full Screen",
          ),
          SizedBox(height: 20),
          DrawerContaierButton(
            IconName: Icons.home_filled,
            buttonName: "Back to home",
          ),
        ],
      ),
    );
  }
}

class DrawerContaierButton extends StatelessWidget {
  final String buttonName;
  final IconData IconName;
  const DrawerContaierButton({
    super.key,
    required this.IconName,
    required this.buttonName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.all(5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 15,

        children: [
          Icon(
            IconName,
            size: 26,
            color: AppColors.Colorprimary.withOpacity(0.7),
          ),
          Text(
            buttonName,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
