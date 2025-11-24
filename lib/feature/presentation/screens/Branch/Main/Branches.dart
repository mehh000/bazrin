import 'package:bazrin/feature/data/API/Helper/Branch/getMyBranches.dart';
import 'package:bazrin/feature/data/API/Helper/LogOut/logout.dart';
import 'package:bazrin/feature/data/API/Helper/Profile/getmyprofile.dart';
import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:bazrin/feature/presentation/common/classes/prettyPrint.dart';
import 'package:flutter/material.dart';

class Branches extends StatefulWidget {
  const Branches({super.key});

  @override
  State<Branches> createState() => _BranchesState();
}

class _BranchesState extends State<Branches> {
  dynamic shopBranches;
  dynamic selfBranches;
  dynamic othersBranches;
  bool isloaded = true;
  dynamic isSelected = 'not';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getAllBranches();
  }

  void getAllBranches() async {
    try {
      final response = await Getmyshop.getMyshop();
      setState(() {
        shopBranches = response['data'];
        selfBranches = response['data']['owned'][0]['branches'];
        othersBranches = response['data']['other'];
        isloaded = false;
      });
    } catch (e) {}
  }

  void logOut() {
    Logout.logout(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFF5F5F7),
        body: isloaded
            ? Center(
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(),
                ),
              )
            : Center(
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 25),
                  margin: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 5,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Chosse Your Shop!',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            'A periscope telephoto lens is an advanced telephoto camera system that uses prisms and mirrors to bend light at a right angle.',
                            style: TextStyle(fontSize: 11),
                          ),

                          SizedBox(height: 20),

                          //branches
                          // my own shop branch and sub branch
                          Column(
                            spacing: 8,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Card
                              GestureDetector(
                                onTap: () {
                                  if (isSelected ==
                                      shopBranches['owned'][0]['id']) {
                                    setState(() {
                                      isSelected = 'not';
                                    });
                                  } else {
                                    setState(() {
                                      isSelected =
                                          shopBranches['owned'][0]['id'];
                                    });
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1,
                                      color:
                                          isSelected ==
                                              shopBranches['owned'][0]['id']
                                          ? Colors.blue
                                          : AppColors.colorBlack.withOpacity(
                                              0.3,
                                            ),
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    spacing: 12,
                                    children: [
                                      SizedBox(
                                        height: 60,
                                        width: 60,
                                        child:
                                            (shopBranches['owned'][0]['logo']['md'] !=
                                                null)
                                            ? Image.network(
                                                'https://bazrin.com/${shopBranches['owned'][0]['logo']['md']}',
                                                fit: BoxFit.cover,
                                                errorBuilder:
                                                    (
                                                      context,
                                                      error,
                                                      stackTrace,
                                                    ) => const Icon(
                                                      Icons.store,
                                                      size: 30,
                                                      color: Colors.grey,
                                                    ),
                                              )
                                            : const Icon(
                                                Icons.store,
                                                size: 30,
                                                color: Colors.grey,
                                              ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,

                                        children: [
                                          Text(
                                            '${shopBranches['owned'][0]['name'].length > 27 ? '${shopBranches['owned'][0]['name'].substring(0, 27)}...' : shopBranches['owned'][0]['name'] ?? ''}',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            'Address not available',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              AnimatedSwitcher(
                                duration: Duration(milliseconds: 400),
                                switchOutCurve: Curves.easeOut,
                                transitionBuilder: (child, anim) {
                                  return FadeTransition(
                                    opacity: anim,
                                    child: ScaleTransition(
                                      scale: anim,
                                      child: child,
                                    ),
                                  );
                                },
                                child:
                                    isSelected == shopBranches['owned'][0]['id']
                                    ? Wrap(
                                        key: ValueKey(true),
                                        spacing: 6,
                                        runSpacing: 6,
                                        children: selfBranches
                                            .map<Widget>(
                                              (SB) => Container(
                                                padding: EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  border: Border.all(
                                                    width: 1,
                                                    color: AppColors.colorGray,
                                                  ),
                                                ),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  spacing: 4,
                                                  children: [
                                                    Icon(
                                                      Icons.location_on,
                                                      color: Colors.blue,
                                                      size: 25,
                                                    ),
                                                    Text(
                                                      '${SB['name']}',
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                            .toList(),
                                      )
                                    : SizedBox.shrink(key: ValueKey(false)),
                              ),
                            ],
                          ),

                          Column(
                            children: othersBranches
                                .map<Widget>(
                                  (ob) => Column(
                                    spacing: 8,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Card
                                      GestureDetector(
                                        onTap: () {
                                          if (isSelected == ob['id']) {
                                            setState(() {
                                              isSelected = 'not';
                                            });
                                          } else {
                                            setState(() {
                                              isSelected = ob['id'];
                                            });
                                          }
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(8),
                                          margin: EdgeInsets.symmetric(
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              width: 1,
                                              color: isSelected == ob['id']
                                                  ? Colors.blue
                                                  : AppColors.colorBlack
                                                        .withOpacity(0.3),
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                          child: Row(
                                            spacing: 12,
                                            children: [
                                              SizedBox(
                                                height: 60,
                                                width: 60,
                                                child:
                                                    (ob['logo']['md'] != null)
                                                    ? Image.network(
                                                        'https://bazrin.com/${ob['logo']['md']}',
                                                        fit: BoxFit.cover,
                                                        errorBuilder:
                                                            (
                                                              context,
                                                              error,
                                                              stackTrace,
                                                            ) => const Icon(
                                                              Icons.store,
                                                              size: 30,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                      )
                                                    : const Icon(
                                                        Icons.store,
                                                        size: 30,
                                                        color: Colors.grey,
                                                      ),
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,

                                                children: [
                                                  Text(
                                                    '${ob['name'].length > 27 ? '${ob['name'].substring(0, 27)}...' : ob['name'] ?? ''}',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Address not available',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),

                                      AnimatedSwitcher(
                                        duration: Duration(milliseconds: 400),
                                        switchOutCurve: Curves.easeOut,
                                        transitionBuilder: (child, anim) {
                                          return FadeTransition(
                                            opacity: anim,
                                            child: ScaleTransition(
                                              scale: anim,
                                              child: child,
                                            ),
                                          );
                                        },
                                        child: isSelected == ob['id']
                                            ? Wrap(
                                                key: ValueKey(true),
                                                spacing: 6,
                                                runSpacing: 6,
                                                children: ob['branches']
                                                    .map<Widget>(
                                                      (sob) => Container(
                                                        padding: EdgeInsets.all(
                                                          8,
                                                        ),
                                                        decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                8,
                                                              ),
                                                          border: Border.all(
                                                            width: 1,
                                                            color: AppColors
                                                                .colorGray,
                                                          ),
                                                        ),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          spacing: 4,
                                                          children: [
                                                            Icon(
                                                              Icons.location_on,
                                                              color:
                                                                  Colors.blue,
                                                              size: 25,
                                                            ),
                                                            Text(
                                                              '${sob['name']}',
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                    .toList(),
                                              )
                                            : SizedBox.shrink(
                                                key: ValueKey(false),
                                              ),
                                      ),
                                    ],
                                  ),
                                )
                                .toList(),
                          ),
                        ],
                      ),
                      ButtonEv(
                        title: 'Log Out',
                        textColor: AppColors.colorBlack,
                        colorData: AppColors.colorGray.withOpacity(0.1),
                        buttonFunction: logOut,
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
