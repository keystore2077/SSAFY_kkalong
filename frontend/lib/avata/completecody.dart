// import 'package:flutter/material.dart';
// import 'package:flutter_mycloset/avata/choicecloth.dart';
// import 'package:intl/intl.dart';

// class Completecody extends StatefulWidget {
//   String memberNickname;
//   String fashionName;
//   String imgUrl;
//   final Map codyinfo;
//   String formattedDate = '';

//   Completecody(
//       {super.key,
//       this.storage,
//       required this.fashionName,
//       required this.memberNickname,
//       required this.imgUrl,
//       required this.codyinfo});

//   final storage;

//   @override
//   State<Completecody> createState() => CompletecodyState();
// }

// class CompletecodyState extends State<Completecody> {
//   TextEditingController controller = TextEditingController();
//   @override
//   void initState() {
//     super.initState();
//     String fashionRegDate = widget.codyinfo['fashionRegDate'];
//     DateTime parsedDate = DateTime.parse(fashionRegDate);
//     widget.formattedDate = DateFormat('yyyy-MM-dd').format(parsedDate);
//     // 초기화 작업 수행
//   }

//   final savecloset = {
//     "list": [
//       {"image": "Assets/Image/TShirt.png"},
//     ]
//   };

//   final clomenue = {
//     "list": [
//       {"image": "Assets/Image/Dress.png", "name": "Top"},
//       {"image": "Assets/Image/Pants.png", "name": "Pants"},
//       {"image": "Assets/Image/Suit.png", "name": "Outer"},
//       {"image": "Assets/Image/Skirt.png", "name": "Skirts"},
//       {"image": "Assets/Image/Dress.png", "name": "Dress"},
//       {"image": "Assets/Image/Ellipsis.png", "name": "ect"},
//     ]
//   };

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 255, 255, 255),
//       body: CustomScrollView(
//         slivers: <Widget>[
//           SliverAppBar(
//             backgroundColor: Color(0xFFF5BEB5),
//             expandedHeight: 55.0,
//             floating: true,
//             pinned: true,
//             title: Text(
//               '${widget.memberNickname}의 깔롱코디',
//               style: TextStyle(color: Colors.white),
//             ),
//             centerTitle: true,
//             elevation: 0,
//           ),
//           SliverPadding(
//             padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
//             sliver: SliverGrid(
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 1,
//                 crossAxisSpacing: 20.0,
//                 mainAxisSpacing: 20.0,
//               ),
//               delegate: SliverChildBuilderDelegate(
//                 (BuildContext context, int index) {
//                   final item = savecloset['list']?[index];
//                   if (item == null) {
//                     return const SizedBox(); // 빈 위젯 반환
//                   }
//                   return GestureDetector(
//                     onTap: () {},
//                     child: Container(
//                       color: const Color.fromARGB(255, 251, 235, 233),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: <Widget>[
//                           Image.network(
//                             widget.imgUrl ??
//                                 "https://example.com/default_image.png",
//                             height: 300,
//                             width: 300,
//                             fit: BoxFit.cover,
//                             errorBuilder: (BuildContext context, Object error,
//                                 StackTrace? stackTrace) {
//                               // 이미지 로드 실패 시 대체 이미지 표시
//                               return Image.asset(
//                                 "Assets/Image/logo.png",
//                                 height: 200,
//                                 width: 180,
//                               );
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//                 childCount: savecloset['list']?.length ?? 0,
//               ),
//             ),
//           ),
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: EdgeInsets.fromLTRB(18, 2, 18, 2),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   SizedBox(
//                     child: Padding(
//                       padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
//                       child: Text(
//                         widget.fashionName,
//                         style: TextStyle(
//                           fontSize: 25,
//                           fontWeight: FontWeight.w600,
//                           // color: Color(0xFFF5BEB5),
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   Padding(
//                       padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
//                       child: SizedBox(
//                         child: Text(
//                           '생성일: ${widget.formattedDate}', // 변수 값을 중괄호로 감싸서 표시
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.w400,
//                             // color: Color(0xFFF5BEB5),
//                           ),
//                         ),
//                       )),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_mycloset/avata/choicecloth.dart';
import 'package:intl/intl.dart';

class Completecody extends StatefulWidget {
  String memberNickname;
  String fashionName;
  String imgUrl;
  final Map codyinfo;
  String formattedDate = '';

  Completecody(
      {super.key,
      this.storage,
      required this.fashionName,
      required this.memberNickname,
      required this.imgUrl,
      required this.codyinfo});

  final storage;

  @override
  State<Completecody> createState() => CompletecodyState();
}

class CompletecodyState extends State<Completecody> {
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    String fashionRegDate = widget.codyinfo['fashionRegDate'];
    DateTime parsedDate = DateTime.parse(fashionRegDate);
    widget.formattedDate = DateFormat('yyyy-MM-dd').format(parsedDate);
    // 초기화 작업 수행
  }

  final savecloset = {
    "list": [
      {"image": "Assets/Image/TShirt.png"},
    ]
  };

  // 삭제 버튼을 눌렀을 때 실행되는 메서드
  void onDeleteButtonPressed() {
    // 삭제 로직을 구현하세요.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Color(0xFFF5BEB5),
            expandedHeight: 55.0,
            floating: true,
            pinned: true,
            title: Text(
              '${widget.memberNickname}의 깔롱코디',
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
            elevation: 0,
          ),
          // SliverPadding(
          //   padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          //   sliver: SliverGrid(
          //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          //       crossAxisCount: 1,
          //       crossAxisSpacing: 20.0,
          //       mainAxisSpacing: 20.0,
          //     ),
          //     delegate: SliverChildBuilderDelegate(
          //       (BuildContext context, int index) {
          //         final item = savecloset['list']?[index];
          //         if (item == null) {
          //           return const SizedBox(); // 빈 위젯 반환
          //         }
          //         return GestureDetector(
          //           onTap: () {},
          //           child: Container(
          //             color: const Color.fromARGB(255, 251, 235, 233),
          //             child: Column(
          //               mainAxisAlignment: MainAxisAlignment.center,
          //               children: <Widget>[
          //                 Image.network(
          //                   widget.imgUrl ??
          //                       "https://example.com/default_image.png",
          //                   height: 300,
          //                   width: 300,
          //                   fit: BoxFit.cover,
          //                   errorBuilder: (BuildContext context, Object error,
          //                       StackTrace? stackTrace) {
          //                     // 이미지 로드 실패 시 대체 이미지 표시
          //                     return Image.asset(
          //                       "Assets/Image/logo.png",
          //                       height: 200,
          //                       width: 180,
          //                     );
          //                   },
          //                 ),
          //                 Row(
          //                   mainAxisAlignment: MainAxisAlignment.center,
          //                   children: <Widget>[
          //                     IconButton(
          //                       icon: Icon(Icons.thumb_up),
          //                       onPressed: () {
          //                         // 좋아요 버튼 누를 때의 동작
          //                       },
          //                     ),
          //                     Text(widget.codyinfo['cntLike']
          //                         .toString()), // 좋아요 수 출력
          //                     IconButton(
          //                       icon: Icon(Icons.thumb_down),
          //                       onPressed: () {
          //                         // 싫어요 버튼 누를 때의 동작
          //                       },
          //                     ),
          //                     Text(widget.codyinfo['cntHate']
          //                         .toString()), // 싫어요 수 출력
          //                   ],
          //                 ),
          //               ],
          //             ),
          //           ),
          //         );
          //       },
          //       childCount: savecloset['list']?.length ?? 0,
          //     ),
          //   ),
          // ),
          SliverToBoxAdapter(
            child: Padding(
              padding:
                  const EdgeInsets.fromLTRB(0, 0, 0, 0), // 원하는 패딩 값으로 수정하세요
              child: Container(
                height: 600,
                color: const Color.fromARGB(255, 251, 235, 233),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.network(
                      widget.imgUrl ?? "https://example.com/default_image.png",
                      height: 500,
                      width: 340,
                      fit: BoxFit.cover,
                      errorBuilder: (BuildContext context, Object error,
                          StackTrace? stackTrace) {
                        // 이미지 로드 실패 시 대체 이미지 표시
                        return Image.asset(
                          "Assets/Image/logo.png",
                          height: 500,
                          width: 300,
                        );
                      },
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: <Widget>[
                    //     IconButton(
                    //       icon: Icon(Icons.thumb_up),
                    //       onPressed: () {},
                    //     ),
                    //     Text(widget.codyinfo['cntLike'].toString()), // 좋아요 수 출력
                    //     IconButton(
                    //       icon: Icon(Icons.thumb_down),
                    //       onPressed: () {},
                    //     ),
                    //     Text(widget.codyinfo['cntHate'].toString()), // 싫어요 수 출력
                    //   ],
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: <Widget>[
                    //     Padding(
                    //       padding: const EdgeInsets.fromLTRB(10, 20, 20, 20),
                    //       child: Icon(
                    //         Icons.thumb_up,
                    //         size: 35, // 아이콘 크기 조절
                    //         color:
                    //             Color.fromARGB(255, 255, 192, 188), // 아이콘 색상 지정
                    //       ),
                    //     ),
                    //     SizedBox(width: 10), // 간격 조절
                    //     Text(
                    //       widget.codyinfo['cntLike'].toString(), // 좋아요 수 출력
                    //       style: TextStyle(fontSize: 25), // 텍스트 스타일 지정
                    //     ),
                    //     SizedBox(width: 50), // 간격 조절
                    //     Padding(
                    //       padding: const EdgeInsets.symmetric(
                    //           horizontal: 10), // 가로 방향 패딩
                    //       child: Icon(
                    //         Icons.thumb_down,
                    //         size: 35, // 아이콘 크기 조절
                    //         color: const Color.fromARGB(
                    //             255, 255, 192, 188), // 아이콘 색상 지정
                    //       ),
                    //     ),
                    //     SizedBox(width: 10), // 간격 조절
                    //     Text(
                    //       widget.codyinfo['cntHate'].toString(), // 싫어요 수 출력
                    //       style: TextStyle(fontSize: 25), // 텍스트 스타일 지정
                    //     ),
                    //   ],
                    // ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                          20, 30, 20, 20), // Row 전체에 패딩 적용
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.thumb_up,
                            size: 35, // 아이콘 크기 조절
                            color:
                                Color.fromARGB(255, 255, 192, 188), // 아이콘 색상 지정
                          ),
                          SizedBox(width: 10), // 간격 조절
                          Text(
                            widget.codyinfo['cntLike'].toString(), // 좋아요 수 출력
                            style: TextStyle(fontSize: 25), // 텍스트 스타일 지정
                          ),
                          SizedBox(width: 50), // 간격 조절
                          Icon(
                            Icons.thumb_down,
                            size: 35, // 아이콘 크기 조절
                            color: const Color.fromARGB(
                                255, 255, 192, 188), // 아이콘 색상 지정
                          ),
                          SizedBox(width: 10), // 간격 조절
                          Text(
                            widget.codyinfo['cntHate'].toString(), // 싫어요 수 출력
                            style: TextStyle(fontSize: 25), // 텍스트 스타일 지정
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(18, 2, 18, 2),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                        2,
                        2,
                        0,
                        2,
                      ),
                      child: Text(
                        widget.fashionName,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                          // color: Color(0xFFF5BEB5),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                      padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
                      child: SizedBox(
                        child: Text(
                          '생성일: ${widget.formattedDate}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            // color: Color(0xFFF5BEB5),
                          ),
                        ),
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
