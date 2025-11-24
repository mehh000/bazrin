// its for flowing icon button and no seach option

//  bool _isExpanded = false;

//   void _toggleExpand() {
//     if (_isExpanded) {
//       Navigator.of(context).push(
//         SlidePageRoute(page: AddProducts(), direction: SlideDirection.right),
//       );
//     } else {
//       setState(() {
//         _isExpanded = !_isExpanded;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         floatingActionButton: FlowtingIconButton(
//           isExpanded: _isExpanded,
//           toggleExpand: _toggleExpand,
//           title: 'Add Product',
//         ),
//         appBar: AppBar(
//           backgroundColor: AppColors.Colorprimary,
//           leading: Row(
//             children: [
//               SizedBox(width: 20),
//               GestureDetector(
//                 onTap: () {
//                   Navigator.of(context).push(
//                     SlidePageRoute(
//                       page: HomeScreen(),
//                       direction: SlideDirection.left,
//                     ),
//                   );
//                 },
//                 child: Icon(Icons.arrow_back, color: Colors.white),
//               ),
//             ],
//           ),
//           title: Text(
//             'Expense Product',
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 16,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ),
//         backgroundColor: AppColors.Colorprimary,
//         body: Stack(
//           children: [
//             Column(
//               children: [
//                 SizedBox(height: 20),

//                 Expanded(
//                   child: Container(
//                     width: double.infinity,
//                     padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//                     decoration: BoxDecoration(
//                       color: Color(0xFFF5F5F7),
//                       borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(20),
//                         topRight: Radius.circular(20),
//                       ),
//                     ),
//                     child: SingleChildScrollView(
//                       child: Column(spacing: 5, children: []),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             if (_isExpanded)
//               Positioned.fill(
//                 child: GestureDetector(
//                   onTap: () => setState(() => _isExpanded = false),
//                   child: Container(color: Colors.transparent),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//=================================================================ends her===============




//  simple app template =========

//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: AppColors.Colorprimary,
//           leading: Row(
//             children: [
//               SizedBox(width: 20),
//               GestureDetector(
//                 onTap: () {
//                   Navigator.of(context).push(
//                     SlidePageRoute(
//                       page: HomeScreen(),
//                       direction: SlideDirection.left,
//                     ),
//                   );
//                 },
//                 child: Icon(Icons.arrow_back, color: Colors.white),
//               ),
//             ],
//           ),
//           title: Text(
//             'Expense Product',
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 16,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ),
//         backgroundColor: AppColors.Colorprimary,
//         body: Column(
//           children: [
//             SizedBox(height: 20),

//             Expanded(
//               child: Container(
//                 width: double.infinity,
//                 padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//                 decoration: BoxDecoration(
//                   color: Color(0xFFF5F5F7),
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(20),
//                     topRight: Radius.circular(20),
//                   ),
//                 ),
//                 child: SingleChildScrollView(
//                   child: Column(spacing: 5, children: []),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

//=================================== ends here

// form container template

                      // Container(
                      //   width: double.infinity,

                      //   decoration: BoxDecoration(
                      //     color: Colors.white,
                      //     borderRadius: BorderRadius.only(
                      //       bottomLeft: Radius.circular(8),
                      //       bottomRight: Radius.circular(8),
                      //     ),
                      //   ),
                      //   child: Column(
                      //     children: [
                      //       Headercomponent(title: "Basic Information"),
                      //       Container(
                      //         decoration: BoxDecoration(
                      //           borderRadius: BorderRadius.only(
                      //             bottomLeft: Radius.circular(8),
                      //             bottomRight: Radius.circular(8),
                      //           ),
                      //         ),
                      //         padding: EdgeInsets.symmetric(
                      //           horizontal: 20,
                      //           vertical: 15,
                      //         ),
                      //         child: Column(children: [
    
                      //                  ],
                      //        ),
                      //       ),
                      //     ],
                      //   ),
                      // ),


                      