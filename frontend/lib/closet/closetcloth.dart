// import 'package:flutter/material.dart';

// class ClosetClothList extends StatefulWidget {
//   const ClosetClothList({super.key, this.scrollController});
//   final scrollController;

//   @override
//   State<ClosetClothList> createState() => _ClosetClothListState();
// }

// class _ClosetClothListState extends State<ClosetClothList> {
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//         future: getCategory(),
//         builder: (BuildContext context, AsyncSnapshot snapshot) {
//           if (snapshot.hasData == false) {
//             return Shimmer.fromColors(
//               baseColor: Colors.grey.shade300,
//               highlightColor: Colors.grey.shade100,
//               child: ListView.builder(
//                 shrinkWrap: true,
//                 itemCount: 2,
//                 itemBuilder: (BuildContext context, int index) {
//                   return Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Shimmer.fromColors(
//                         baseColor: Colors.grey.shade300,
//                         highlightColor: Colors.grey.shade100,
//                         child: Container(
//                           height: 230,
//                           width: double.infinity,
//                           color: Colors.white,
//                         ),
//                       ),
//                       Container(
//                         margin: const EdgeInsets.fromLTRB(20, 15, 20, 30),
//                         child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             ClipRRect(
//                               borderRadius: BorderRadius.circular(50),
//                               child: Container(
//                                 height: 40,
//                                 width: 40,
//                                 color: Colors.white,
//                               ),
//                             ),
//                             const SizedBox(width: 15),
//                             Expanded(
//                               child: Shimmer.fromColors(
//                                 baseColor: Colors.grey.shade300,
//                                 highlightColor: Colors.grey.shade100,
//                                 child: Container(
//                                   height: 20,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   );
//                 },
//               ),
//             );
//           }
//           //error가 발생하게 될 경우 반환
//           else if (snapshot.hasError) {
//             return Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text(
//                 'Error: ${snapshot.error}',
//                 style: const TextStyle(fontSize: 15),
//               ),
//             );
//           }
//           // 데이터를 정상적으로 받아오게 되면 다음 부분을 실행
//           else {
//             return Expanded(
//               child: RefreshIndicator(
//                 color: const Color(0xFFF5BEB5),
//                 onRefresh: () async {
//                   setState(() {});
//                 },
//                 child: ListView.builder(
//                     controller: widget.scrollController,
//                     shrinkWrap: true,
//                     itemCount: snapshot.data.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       return GestureDetector(
//                         onTap: () {},
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             // Image.network(
//                             //     snapshot.data[index]['ClothesThumbnail'],
//                             //     height: 230,
//                             //     width: double.infinity,
//                             //     fit: BoxFit.fill),
//                             Container(
//                                 margin:
//                                     const EdgeInsets.fromLTRB(20, 15, 20, 30),
//                                 child: Row(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     ClipRRect(
//                                       borderRadius: BorderRadius.circular(50),
//                                       child: Image.asset(
//                                         'Assets/Image/logo.png',
//                                         height: 40,
//                                         width: 40,
//                                       ),
//                                     ),
//                                     const SizedBox(
//                                       width: 15,
//                                     ),
//                                     Expanded(
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Text(
//                                             '${snapshot.data[index]['recipeName']}',
//                                             style: const TextStyle(
//                                               fontSize: 18,
//                                               fontWeight: FontWeight.w600,
//                                             ),
//                                             softWrap: true,
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ))
//                           ],
//                         ),
//                       );
//                     }),
//               ),
//             );
//           }
//         });
//   }
// }

import 'package:flutter/material.dart';

class ClosetClothList extends StatelessWidget {
  const ClosetClothList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 3, // 3줄을 나타내도록 설정
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
              onTap: () {
                // 클릭 이벤트 -> 옷상세로 넘어가게 할거임..
              },
              child:
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       crossAxisAlignment: CrossAxisAlignment.center,
                  //       children: [
                  //         Container(
                  //           margin: const EdgeInsets.all(8.0),
                  //           child: ClipRRect(
                  //             borderRadius: BorderRadius.circular(10),
                  //             child: Image.asset(
                  //               'Assets/Image/logo.png',
                  //               height: 100,
                  //               width: 150,
                  //               fit: BoxFit.fill,
                  //             ),
                  //           ),
                  //         ),

                  //         Container(
                  //           padding: const EdgeInsets.only(right: 20),
                  //           child: Text(
                  //             '룰루랄라 오늘은 금요일 이미지ㅇㅇㅇ $index',
                  //             style: const TextStyle(
                  //               fontSize: 18,
                  //               fontWeight: FontWeight.w600,
                  //             ),
                  //             overflow: TextOverflow.clip, // 글자를 자르도록 설정
                  //           ),
                  //         )
                  //       ],
                  //     ),
                  //     const Divider(
                  //       height: 1,
                  //       thickness: 1,
                  //     ), // 구분선
                  //   ],
                  // ),
                  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            'Assets/Image/logo.png',
                            height: 100,
                            width: 150,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Flexible(
                        // Flexible 추가
                        child: Container(
                          padding: const EdgeInsets.only(right: 20),
                          child: Text(
                            '언제입어도 편안한 츄리닝 $index',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.clip, // 글자를 자르도록 설정
                          ),
                        ),
                      )
                    ],
                  ),
                  const Divider(
                    height: 1,
                    thickness: 1,
                  ), // 구분선
                ],
              ));
        },
      ),
    );
  }
}
