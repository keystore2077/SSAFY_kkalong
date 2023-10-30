// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class ClosetDetail extends StatefulWidget {
//   const ClosetDetail({super.key, this.storage});

//   final storage;

//   @override
//   State<ClosetDetail> createState() => ClosetDetailState();
// }

// class ClosetDetailState extends State<ClosetDetail> {
//   @override
//   void initState() {
//     super.initState();
//     // 초기화 작업 수행
//   }

//   final clothdetail = {
//     "list": [
//       {"image": "Assets/Image/logo.png"},
//       {"image": "Assets/Image/logo.png"},
//       {"image": "Assets/Image/logo.png"},
//       {"image": "Assets/Image/logo.png"},
//     ]
//   };
// // BearList? bearList;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       appBar: AppBar(
//         backgroundColor: const Color(0xFFF5BEB5),
//         toolbarHeight: 55,
//         title: const Text('씅쑤신다람쥐의 옷장'),
//         centerTitle: true,
//         elevation: 0,
//         leading: const Text(''),
//       ),
//       body: Container(
//         padding: const EdgeInsets.all(30),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               margin: const EdgeInsets.fromLTRB(0, 0, 0, 35),
//               child: const Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(
//                     child: Padding(
//                       padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
//                       child: Text(
//                         '안녕하세요,',
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                   ),
//                   Row(
//                     children: [
//                       Padding(
//                         padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
//                         child: Text(
//                           '나는야김싸피',
//                           style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.w600,
//                             color: Color(0xFFF5BEB5),
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
//                         child: Text(
//                           '님',
//                           style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   Padding(
//                     padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
//                     child: Text(
//                       '오늘도 깔롱쟁이와 멋쟁이 돼보아요!',
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(
//                     child: Padding(
//                       padding: const EdgeInsets.fromLTRB(0, 0, 0, 12),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text(
//                             'My깔롱',
//                             style: TextStyle(
//                               fontSize: 22,
//                               fontWeight: FontWeight.w700,
//                               color: Color(0xFFF5BEB5),
//                             ),
//                           ),
//                           ElevatedButton(
//                             onPressed: () async {
//                               final ImagePicker picker = ImagePicker();
//                               final XFile? image = await picker.pickImage(
//                                   source: ImageSource.camera);

//                               if (image != null) {
//                                 // 이미지가 선택되면 처리할 작업을 여기에 추가합니다.
//                                 // image.path를 사용하여 이미지 파일에 접근할 수 있습니다.
//                               }
//                             },
//                             style: ElevatedButton.styleFrom(
//                               shape: RoundedRectangleBorder(
//                                 borderRadius:
//                                     BorderRadius.circular(5.0), // 원하는 각진 정도로 설정
//                               ),
//                               // 다른 스타일 속성들
//                             ),
//                             child: const Text(' + 옷장등록'),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   // Expanded(
//                   //   child:
//                   const Column(
//                     children: [
//                       SizedBox(
//                         child: Padding(
//                           padding: EdgeInsets.fromLTRB(0, 0, 0, 2),
//                         ),
//                       ),
//                     ],
//                   ),
//                   // ),

//                   Expanded(
//                     child: GridView.builder(
//                       gridDelegate:
//                           const SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 2, // Number of columns in the grid
//                         crossAxisSpacing: 5.0, // Spacing between columns
//                         mainAxisSpacing: 5.0, // Spacing between rows
//                       ),
//                       itemCount: clothdetail['list']?.length ?? 0,
//                       itemBuilder: (BuildContext context, int index) {
//                         final item = clothdetail['list']?[index];
//                         if (item == null) {
//                           return const SizedBox(); // 빈 위젯 반환
//                         }
//                         return GestureDetector(
//                           onTap: () {
//                             // 클릭이벤트
//                           },
//                           // child: Card(
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: <Widget>[
//                               Image.asset(
//                                   item["image"] ?? "Assets/Image/logo.png",
//                                   height: 200,
//                                   width: 200),
//                               // Text(
//                               //   item["name"] ?? "Unknown",
//                               //   style: const TextStyle(
//                               //     fontSize: 16,
//                               //     fontWeight: FontWeight.w600,
//                               //   ),
//                               // ),
//                             ],
//                           ),
//                           // ),
//                         );
//                       },
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// void showSnackBar(BuildContext context, String text) {
//   final snackBar = SnackBar(
//     content: Text(text),
//     backgroundColor: const Color(0xFFF5BEB5),
//   );

//   // ScaffoldMessenger.of(context).showSnackBar(snackBar);
// }

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_mycloset/user/mypage.dart';
import 'package:flutter_mycloset/user/nampage.dart';
import '../closet/closetcloth.dart';

class ClosetDetail extends StatefulWidget {
  const ClosetDetail({super.key, this.category});

  final category;

  @override
  State<ClosetDetail> createState() => _ClosetDetailState();
}

class _ClosetDetailState extends State<ClosetDetail> {
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: DefaultTabController(
          length: 4,
          child: NestedScrollView(
            controller: scrollController,
            headerSliverBuilder: (context, isScrolled) {
              return [
                SliverAppBar(
                  title: const Text(
                    '씅쑤신다람쥐의 옷장',
                    style: TextStyle(color: Colors.white), // 텍스트의 색상을 흰색으로 설정
                  ),
                  centerTitle: true,
                  backgroundColor: const Color.fromARGB(255, 246, 212, 206),
                  iconTheme: const IconThemeData(color: Colors.black),
                  collapsedHeight: 325,
                  expandedHeight: 325,
                  flexibleSpace: Image.asset(
                    'Assets/Image/ccloset.png',
                  ),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.edit_outlined), // 두 번째 아이콘
                      onPressed: () {
                        // 두 번째 아이콘을 클릭했을 때 실행할 작업
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete_forever_outlined),
                      onPressed: () {},
                    ),
                  ],
                ),
                SliverPersistentHeader(
                  delegate: MyDelegate(const TabBar(
                      labelColor: Colors.black,
                      indicatorWeight: 4,
                      unselectedLabelColor: Color(0xffD0D0D0),
                      labelPadding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                      labelStyle:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                      indicatorColor: Color.fromARGB(255, 68, 25, 80),
                      indicatorSize: TabBarIndicatorSize.label,
                      tabs: [
                        Text('행거1'),
                        Text('행거2'),
                        Text('선반1'),
                        Text('선반2'),
                      ])),
                  floating: true,
                  pinned: true,
                )
              ];
            },
            body: const TabBarView(children: [
              ClosetClothList(),
              ClosetClothList(),
              ClosetClothList(),
              ClosetClothList(),
            ]),
          ),
        ),

        // floatingActionButton: FloatingActionButton.small(
        //   onPressed: () {
        //     scrollController.animateTo(
        //       scrollController.position.minScrollExtent,
        //       duration: const Duration(milliseconds: 500),
        //       curve: Curves.fastOutSlowIn,
        //     );
        //   },
        //   backgroundColor: Colors.grey[50],
        //   shape: RoundedRectangleBorder(
        //       side: const BorderSide(width: 1, color: Color(0xFFF5BEB5)),
        //       borderRadius: BorderRadius.circular(12)),
        //   child:
        //       const Icon(Icons.arrow_upward_sharp, color: Color(0xFFF5BEB5)),
        // )

        floatingActionButton: ElevatedButton(
          onPressed: () async {
            final ImagePicker picker = ImagePicker();
            final XFile? image =
                await picker.pickImage(source: ImageSource.camera);

            if (image != null) {
              // 이미지가 선택되면 처리할 작업을 여기에 추가합니다.
              // image.path를 사용하여 이미지 파일에 접근할 수 있습니다.
            } else {
              // 이미지가 선택되지 않았을 때 처리할 작업을 추가합니다.
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey[50],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0), // 원하는 각진 정도로 설정
            ),
            // 다른 스타일 속성들
          ),
          child: const Text(' + 옷등록'),
        ),
      ),
    );
  }
}

class MyDelegate extends SliverPersistentHeaderDelegate {
  MyDelegate(this.tabBar);

  final TabBar tabBar;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.grey[50],
      child: tabBar,
    );
  }

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
