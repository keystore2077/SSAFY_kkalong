// import 'package:flutter/material.dart';
// import 'package:flutter_mycloset/avata/loadingna.dart';
// import '../avata/clothslide.dart';
// import 'package:image_picker/image_picker.dart';
// import '../avata/namedavata.dart';

// // import 'package:flutter_mycloset/category/categoryselect.dart';

// class ChoiceCloth extends StatefulWidget {
//   final int photoSeq;
//   final String? imageUrl;
//   final String sortName;

//   const ChoiceCloth(
//       {super.key,
//       this.storage,
//       required this.photoSeq,
//       required this.imageUrl,
//       required this.sortName});

//   final storage;

//   @override
//   State<ChoiceCloth> createState() => ChoiceClothState();
// }

// class ChoiceClothState extends State<ChoiceCloth> {
//   @override
//   void initState() {
//     super.initState();
//     // 초기화 작업 수행
//   }

//   final savecloset = {
//     "list": [
//       {"image": "Assets/Image/TShirt.png"},
//     ]
//   };

//   final clomenue = {
//     "list": [
//       {"image": "Assets/Image/TShirt.png", "name": "Top"},
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
//       backgroundColor: const Color.fromARGB(255, 255, 255, 254),
//       body: CustomScrollView(
//         slivers: <Widget>[
//           const SliverAppBar(
//             backgroundColor: Color(0xFFF5BEB5),
//             expandedHeight: 55.0,
//             floating: true,
//             pinned: true,
//             title: Text(
//               '깔롱의 옷입히기',
//               style: TextStyle(color: Colors.white),
//             ),
//             centerTitle: true,
//             elevation: 0,
//             leading: Text(''),
//           ),
//           SliverList(
//             delegate: SliverChildListDelegate(
//               [
//                 AppBar(
//                   toolbarHeight: 55,
//                   title: Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.fromLTRB(0, 0, 10.0, 0),
//                         child: Image.asset(
//                           'Assets/Image/TShirt.png',
//                           width: 70.0,
//                           height: 70.0,
//                         ),
//                       ),
//                       Text(
//                         widget.sortName,
//                         style: TextStyle(
//                           fontSize: 22,
//                           color: Color.fromARGB(255, 0, 0, 0),
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ],
//                   ),
//                   centerTitle: false,
//                 ),
//               ],
//             ),
//           ),
//           SliverPadding(
//             padding: const EdgeInsets.fromLTRB(20, 1, 20, 20),
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
//                   return Image.network(
//                     widget.imageUrl ?? "Assets/Image/logo.png",
//                     height: 125,
//                     width: 180,
//                     errorBuilder: (context, error, stackTrace) {
//                       return Image.asset(
//                         "Assets/Image/logo.png",
//                         height: 125,
//                         width: 180,
//                       );
//                     },
//                     loadingBuilder: (BuildContext context, Widget child,
//                         ImageChunkEvent? loadingProgress) {
//                       if (loadingProgress == null) return child;
//                       return Center(
//                         child: CircularProgressIndicator(
//                           value: loadingProgress.expectedTotalBytes != null
//                               ? loadingProgress.cumulativeBytesLoaded /
//                                   loadingProgress.expectedTotalBytes!
//                               : null,
//                         ),
//                       );
//                     },
//                   );
//                 },
//                 childCount: savecloset['list']?.length ?? 0,
//               ),
//             ),
//           ),
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: const EdgeInsets.fromLTRB(30, 2, 10, 0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const Padding(
//                     padding: EdgeInsets.fromLTRB(8, 0, 0, 12),
//                     child: Text(
//                       '옷선택',
//                       style: TextStyle(
//                         fontSize: 22,
//                         fontWeight: FontWeight.w700,
//                         color: Color(0xFFF5BEB5),
//                       ),
//                     ),
//                   ),
//                   const Spacer(),
//                   Padding(
//                       padding: const EdgeInsets.fromLTRB(30, 1, 10, 10),
//                       child: OutlinedButton(
//                         onPressed: () {},
//                         style: OutlinedButton.styleFrom(
//                           // backgroundColor: const Color.fromARGB(255, 250, 250, 250),
//                           foregroundColor:
//                               const Color.fromARGB(255, 232, 170, 170),
//                           side: const BorderSide(
//                               color: Color.fromARGB(255, 232, 170, 170),
//                               width:
//                                   1.0), // Adjusting border color and thickness
//                           shape: RoundedRectangleBorder(
//                             borderRadius:
//                                 BorderRadius.circular(20.0), // 원하는 각진 정도로 설정
//                           ),
//                           // 다른 스타일 속성들
//                         ),
//                         child: const Text(
//                           '+ 다른 옷',
//                           style: TextStyle(
//                             fontSize: 12,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       )),
//                   Padding(
//                     padding: const EdgeInsets.fromLTRB(2, 1, 20, 10),
//                     child: OutlinedButton(
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => const NamedAvata()),
//                         );
//                       },
//                       style: OutlinedButton.styleFrom(
//                         backgroundColor: const Color(0xFFF5BEB5),
//                         foregroundColor: Colors.white,
//                         side: const BorderSide(
//                             color: Color(0xFFF5BEB5), width: 1.0),
//                         shape: RoundedRectangleBorder(
//                           borderRadius:
//                               BorderRadius.circular(20.0), // 원하는 각진 정도로 설정
//                         ),
//                         // 다른 스타일 속성들
//                       ),
//                       child: const Text(
//                         ' 저장 ',
//                         style: TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//           ClothSlide(sortName: widget.sortName)
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_mycloset/avata/loadingna.dart';
import '../avata/namedavata.dart';
import 'package:provider/provider.dart';
import '../store/userstore.dart';
import 'package:dio/dio.dart';

// import 'package:flutter_mycloset/category/categoryselect.dart';

class ChoiceCloth extends StatefulWidget {
  final int photoSeq;
  String imageUrl =
      'https://kkalong.s3.ap-northeast-2.amazonaws.com/logol.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20231116T062506Z&X-Amz-SignedHeaders=host&X-Amz-Expires=604800&X-Amz-Credential=AKIA5RRQZSI64T25QVH5%2F20231116%2Fap-northeast-2%2Fs3%2Faws4_request&X-Amz-Signature=d19ada1250a2e03d0eecddfee57db8ebff5e84c7eba3354f779f918bc8428540",';
  String fileName = '';
  final String sortName;
  int? selectedIndex;
  int? selectedClothSeq;
  List<dynamic> cloList = [];

  // bool isLoading = true;

  ChoiceCloth({
    super.key,
    this.storage,
    required this.photoSeq,
    required this.imageUrl,
    required this.sortName,
  });

  final storage;

  @override
  State<ChoiceCloth> createState() => ChoiceClothState();
}

class ChoiceClothState extends State<ChoiceCloth> {
  Dio dio = Dio();
  final serverURL = 'http://k9c105.p.ssafy.io:8761';
  @override
  void initState() {
    super.initState();
    // 초기화 작업 수행
    fetchData();
  }

  void fetchData() async {
    var accessToken = context.read<UserStore>().accessToken;
    // Dio dio = Dio();
    // const serverURL = 'http://k9c105.p.ssafy.io:8761';
    // const serverURL = 'http://192.168.100.37:8761';

    try {
      Map<String, dynamic> headers = {};
      if (accessToken.isNotEmpty) {
        headers['Authorization'] = 'Bearer $accessToken';
      }

      final response = await dio.get(
        '$serverURL/api/cloth/sort/${widget.sortName}',
        options: Options(headers: headers),
      );
      print('옷슬라이드-------------디오요청했음-------------');
      print('리스판스데이터--------------');
      print(response.data);
      // var cloList = response.data['body'];
      setState(() {
        widget.cloList = response.data['body'];
        //추가한부분___________
        // widget.isLoading = false;
      });
      print('클로리스트출력');
      print(widget.cloList);
      return response.data;
    } catch (e) {
      print('에러: $e');
    }
  }

  final savecloset = {
    "list": [
      {"image": "Assets/Image/TShirt.png"},
    ]
  };

  final clomenue = {
    "list": [
      {"image": "Assets/Image/TShirt.png", "name": "Top"},
      {"image": "Assets/Image/Pants.png", "name": "Pants"},
      {"image": "Assets/Image/Suit.png", "name": "Outer"},
      {"image": "Assets/Image/Skirt.png", "name": "Skirts"},
      {"image": "Assets/Image/Dress.png", "name": "Dress"},
      {"image": "Assets/Image/Ellipsis.png", "name": "ect"},
    ]
  };

  @override
  Widget build(BuildContext context) {
    bool mixok = false;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 254),
      body: CustomScrollView(
        slivers: <Widget>[
          const SliverAppBar(
            backgroundColor: Color(0xFFF5BEB5),
            expandedHeight: 55.0,
            floating: true,
            pinned: true,
            title: Text(
              '깔롱의 옷입히기',
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
            elevation: 0,
            leading: Text(''),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                AppBar(
                  toolbarHeight: 55,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 10.0, 0),
                        child: Image.asset(
                          'Assets/Image/cate/${widget.sortName}.png',
                          // "Assets/Image/TShirt.png",
                          width: 70.0,
                          height: 70.0,
                        ),
                      ),
                      Text(
                        widget.sortName,
                        style: TextStyle(
                          fontSize: 22,
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  centerTitle: false,
                ),
              ],
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 1, 20, 20),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                crossAxisSpacing: 20.0,
                mainAxisSpacing: 20.0,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  final item = savecloset['list']?[index];
                  if (item == null) {
                    return const SizedBox(); // 빈 위젯 반환
                  }
                  return Image.network(
                    widget.imageUrl ??
                        "https://kkalong.s3.ap-northeast-2.amazonaws.com/logol.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20231116T062506Z&X-Amz-SignedHeaders=host&X-Amz-Expires=604800&X-Amz-Credential=AKIA5RRQZSI64T25QVH5%2F20231116%2Fap-northeast-2%2Fs3%2Faws4_request&X-Amz-Signature=d19ada1250a2e03d0eecddfee57db8ebff5e84c7eba3354f779f918bc8428540",
                    height: 125,
                    width: 180,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        "Assets/Image/logol.png",
                        height: 125,
                        width: 180,
                      );
                    },
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                  );
                },
                childCount: savecloset['list']?.length ?? 0,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 2, 10, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(8, 0, 0, 12),
                    child: Text(
                      '옷선택',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFF5BEB5),
                      ),
                    ),
                  ),
                  const Spacer(),
                  // Padding(
                  //     padding: const EdgeInsets.fromLTRB(30, 1, 10, 10),
                  //     child:
                  //     OutlinedButton(
                  //       onPressed: () {},
                  //       style: OutlinedButton.styleFrom(
                  //         // backgroundColor: const Color.fromARGB(255, 250, 250, 250),
                  //         foregroundColor:
                  //             const Color.fromARGB(255, 232, 170, 170),
                  //         side: const BorderSide(
                  //             color: Color.fromARGB(255, 232, 170, 170),
                  //             width:
                  //                 1.0), // Adjusting border color and thickness
                  //         shape: RoundedRectangleBorder(
                  //           borderRadius:
                  //               BorderRadius.circular(20.0), // 원하는 각진 정도로 설정
                  //         ),
                  //         // 다른 스타일 속성들
                  //       ),
                  //       child: const Text(
                  //         '+ 다른 옷',
                  //         style: TextStyle(
                  //           fontSize: 12,
                  //           fontWeight: FontWeight.w600,
                  //         ),
                  //       ),
                  //     )
                  //     ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(2, 1, 20, 10),
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NamedAvata(
                                  imageUrl: widget.imageUrl,
                                  fileName: widget.fileName)),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: const Color(0xFFF5BEB5),
                        foregroundColor: Colors.white,
                        side: const BorderSide(
                            color: Color(0xFFF5BEB5), width: 1.0),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(20.0), // 원하는 각진 정도로 설정
                        ),
                        // 다른 스타일 속성들
                      ),
                      child: const Text(
                        ' 저장 ',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  )
                  //수정중
                  // Padding(
                  //   padding: const EdgeInsets.fromLTRB(2, 1, 20, 10),
                  //   child: OutlinedButton(
                  //     onPressed: mixok
                  //         ? () {
                  //             Navigator.push(
                  //               context,
                  //               MaterialPageRoute(
                  //                   builder: (context) => NamedAvata(
                  //                       imageUrl: widget.imageUrl,
                  //                       fileName: widget.fileName)),
                  //             );
                  //           }
                  //         : null, // mixok가 false일 경우, 버튼 비활성화
                  //     style: OutlinedButton.styleFrom(
                  //       backgroundColor: Color.fromARGB(255, 255, 220, 215),
                  //       foregroundColor: Colors.white,
                  //       side: const BorderSide(
                  //           color: Color.fromARGB(255, 255, 218, 212),
                  //           width: 1.0),
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius:
                  //             BorderRadius.circular(20.0), // 원하는 각진 정도로 설정
                  //       ),
                  //       // 다른 스타일 속성들
                  //     ),
                  //     child: const Text(
                  //       ' 저장 ',
                  //       style: TextStyle(
                  //         fontSize: 12,
                  //         fontWeight: FontWeight.w600,
                  //       ),
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              width: 1500,
              height: 170,
              margin: const EdgeInsets.fromLTRB(7, 8, 7, 0),
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  // itemCount: cloList.length,
                  itemCount:
                      widget.cloList.isNotEmpty ? widget.cloList.length : 0,
                  itemBuilder: (c, i) {
                    return Container(
                      width: 120,
                      height: 150,
                      margin: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  setState(() {
                                    widget.selectedIndex = i;
                                    mixok = false;
                                    widget.imageUrl =
                                        'https://kkalong.s3.ap-northeast-2.amazonaws.com/logol.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20231116T062506Z&X-Amz-SignedHeaders=host&X-Amz-Expires=604800&X-Amz-Credential=AKIA5RRQZSI64T25QVH5%2F20231116%2Fap-northeast-2%2Fs3%2Faws4_request&X-Amz-Signature=d19ada1250a2e03d0eecddfee57db8ebff5e84c7eba3354f779f918bc8428540';
                                  });
                                  if (widget.cloList[i]
                                      .containsKey('clothSeq')) {
                                    print(widget.cloList[i]['clothSeq']);
                                    setState(() {
                                      widget.selectedClothSeq =
                                          widget.cloList[i]['clothSeq'];
                                    });
                                  } else {
                                    print('키없음');
                                  }

                                  var accessToken =
                                      context.read<UserStore>().accessToken;
                                  print(accessToken);

                                  try {
                                    print('어디까지 왔나');
                                    Map<String, dynamic> headers = {};
                                    if (accessToken.isNotEmpty) {
                                      headers['Authorization'] =
                                          'Bearer $accessToken';
                                    }

                                    FormData formData = FormData.fromMap({
                                      "photoSeq": widget.photoSeq,
                                      "clothSeq": widget.selectedClothSeq,
                                    });

                                    final response = await dio.post(
                                      '$serverURL/api/photo/mix',
                                      data: formData,
                                      options: Options(
                                        headers: headers,
                                      ), // 수정된 부분
                                    );

                                    print('사진합성요청완료---------------------');
                                    print(response.data);
                                    setState(() {
                                      widget.imageUrl =
                                          response.data['body']['url'];
                                    });
                                    setState(() {
                                      widget.fileName =
                                          response.data['body']['fileName'];
                                    });

                                    print('파일네임잘담겼나???______________');
                                    print(widget.fileName);
                                    return response.data;
                                  } catch (e) {
                                    print('그밖의 에러ㅜㅜㅜㅜㅜㅜㅜㅜㅜ: $e');
                                  } finally {}

                                  print('사진합성완료---------------------');
                                  setState(() {
                                    mixok = true;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: i == widget.selectedIndex
                                        ? Border.all(
                                            color: const Color(0xFFF5BEB5),
                                            width: 3.0)
                                        : null,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Image.network(
                                      widget.cloList[i]['imgUrl'] ??
                                          'https://kkalong.s3.ap-northeast-2.amazonaws.com/logol.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20231116T062506Z&X-Amz-SignedHeaders=host&X-Amz-Expires=604800&X-Amz-Credential=AKIA5RRQZSI64T25QVH5%2F20231116%2Fap-northeast-2%2Fs3%2Faws4_request&X-Amz-Signature=d19ada1250a2e03d0eecddfee57db8ebff5e84c7eba3354f779f918bc8428540',
                                      width: 100,
                                      height: 120,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(12, 5, 0, 0),
                            child: Text(
                              // ranking[i]['clothName']이 null이 아닌지 확인하고, 그에 따라 조건부 로직을 실행합니다.
                              '${widget.cloList[i]['clothName'] != null && widget.cloList[i]['clothName']!.length > 6 ? widget.cloList[i]['clothName']!.substring(0, 6) : widget.cloList[i]['clothName'] ?? ''}' // null일 경우 빈 문자열을 사용합니다.
                              '${widget.cloList[i]['clothName'] != null && widget.cloList[i]['clothName']!.length > 6 ? ".." : ""}',
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          )
          // SliverToBoxAdapter(
          //   child: Container(
          //     width: 1500,
          //     height: 170,
          //     margin: const EdgeInsets.fromLTRB(7, 8, 7, 0),
          //     child: widget.isLoading
          //         ? Center(
          //             child: CircularProgressIndicator(),
          //           )
          //         : widget.cloList.isNotEmpty
          //             ? ListView.builder(
          //                 scrollDirection: Axis.horizontal,
          //                 itemCount: widget.cloList.length,
          //                 itemBuilder: (c, i) {
          //                   return Container(
          //                     width: 120,
          //                     height: 150,
          //                     margin: const EdgeInsets.fromLTRB(15, 0, 0, 0),
          //                     child: Column(
          //                       crossAxisAlignment: CrossAxisAlignment.start,
          //                       children: [
          //                         Stack(
          //                           children: [
          //                             GestureDetector(
          //                               onTap: () async {
          //                                 setState(() {
          //                                   widget.selectedIndex = i;
          //                                 });
          //                                 if (widget.cloList[i]
          //                                     .containsKey('clothSeq')) {
          //                                   print(
          //                                       widget.cloList[i]['clothSeq']);
          //                                   setState(() {
          //                                     widget.selectedClothSeq =
          //                                         widget.cloList[i]['clothSeq'];
          //                                   });
          //                                 } else {
          //                                   print('키없음');
          //                                 }

          //                                 var accessToken = context
          //                                     .read<UserStore>()
          //                                     .accessToken;
          //                                 print(accessToken);

          //                                 try {
          //                                   print('어디까지 왔나');
          //                                   Map<String, dynamic> headers = {};
          //                                   if (accessToken.isNotEmpty) {
          //                                     headers['Authorization'] =
          //                                         'Bearer $accessToken';
          //                                   }

          //                                   FormData formData =
          //                                       FormData.fromMap({
          //                                     "photoSeq": widget.photoSeq,
          //                                     "clothSeq":
          //                                         widget.selectedClothSeq,
          //                                   });

          //                                   final response = await dio.post(
          //                                     '$serverURL/api/photo/mix',
          //                                     data: formData,
          //                                     options: Options(
          //                                       headers: headers,
          //                                     ), // 수정된 부분
          //                                   );

          //                                   print(
          //                                       '사진합성요청완료---------------------');
          //                                   print(response.data);
          //                                   setState(() {
          //                                     widget.imageUrl =
          //                                         response.data['body']['url'];
          //                                   });
          //                                   setState(() {
          //                                     widget.fileName = response
          //                                         .data['body']['fileName'];
          //                                   });

          //                                   print('파일네임잘담겼나???______________');
          //                                   print(widget.fileName);
          //                                   return response.data;
          //                                 } catch (e) {
          //                                   print('그밖의 에러ㅜㅜㅜㅜㅜㅜㅜㅜㅜ: $e');
          //                                 } finally {}

          //                                 print('사진합성완료---------------------');
          //                               },
          //                               child: Container(
          //                                 decoration: BoxDecoration(
          //                                   borderRadius:
          //                                       BorderRadius.circular(5),
          //                                   border: i == widget.selectedIndex
          //                                       ? Border.all(
          //                                           color:
          //                                               const Color(0xFFF5BEB5),
          //                                           width: 3.0)
          //                                       : null,
          //                                 ),
          //                                 child: ClipRRect(
          //                                   borderRadius:
          //                                       BorderRadius.circular(5),
          //                                   child: Image.network(
          //                                     widget.cloList[i]['imgUrl'] ??
          //                                         'https://images.unsplash.com/photo-1551963831-b3b1ca40c98e',
          //                                     width: 100,
          //                                     height: 120,
          //                                     fit: BoxFit.cover,
          //                                   ),
          //                                 ),
          //                               ),
          //                             )
          //                           ],
          //                         ),
          //                         Container(
          //                           margin:
          //                               const EdgeInsets.fromLTRB(12, 5, 0, 0),
          //                           child: Text(
          //                             // ranking[i]['clothName']이 null이 아닌지 확인하고, 그에 따라 조건부 로직을 실행합니다.
          //                             '${widget.cloList[i]['clothName'] != null && widget.cloList[i]['clothName']!.length > 6 ? widget.cloList[i]['clothName']!.substring(0, 6) : widget.cloList[i]['clothName'] ?? ''}' // null일 경우 빈 문자열을 사용합니다.
          //                             '${widget.cloList[i]['clothName'] != null && widget.cloList[i]['clothName']!.length > 6 ? ".." : ""}',
          //                             style: const TextStyle(
          //                               fontSize: 15,
          //                               fontWeight: FontWeight.w600,
          //                             ),
          //                           ),
          //                         ),
          //                       ],
          //                     ),
          //                   );
          //                 },
          //               )
          //             : Center(
          //                 child: Text(
          //                   "옷이 없습니다! 옷을 저장해보세요",
          //                   style: TextStyle(
          //                     fontSize: 18,
          //                     fontWeight: FontWeight.bold,
          //                   ),
          //                 ),
          //               ),
          //   ),
          // )
          // SliverToBoxAdapter(
          //   child: Container(
          //     width: 1500,
          //     height: 170,
          //     margin: const EdgeInsets.fromLTRB(7, 8, 7, 0),
          //     child: widget.cloList.isNotEmpty
          //         ? ListView.builder(
          //             scrollDirection: Axis.horizontal,
          //             itemCount: widget.cloList.length,
          //             itemBuilder: (c, i) {
          //               return
          //                Container(
          //                 width: 120,
          //                 height: 150,
          //                 margin: const EdgeInsets.fromLTRB(15, 0, 0, 0),
          //                 child: Column(
          //                   crossAxisAlignment: CrossAxisAlignment.start,
          //                   children: [
          //                     Stack(
          //                       children: [
          //                         GestureDetector(
          //                           onTap: () async {
          //                             setState(() {
          //                               widget.selectedIndex = i;
          //                             });
          //                             if (widget.cloList[i]
          //                                 .containsKey('clothSeq')) {
          //                               print(widget.cloList[i]['clothSeq']);
          //                               setState(() {
          //                                 widget.selectedClothSeq =
          //                                     widget.cloList[i]['clothSeq'];
          //                               });
          //                             } else {
          //                               print('키없음');
          //                             }

          //                             var accessToken =
          //                                 context.read<UserStore>().accessToken;
          //                             print(accessToken);

          //                             try {
          //                               print('어디까지 왔나');
          //                               Map<String, dynamic> headers = {};
          //                               if (accessToken.isNotEmpty) {
          //                                 headers['Authorization'] =
          //                                     'Bearer $accessToken';
          //                               }

          //                               FormData formData = FormData.fromMap({
          //                                 "photoSeq": widget.photoSeq,
          //                                 "clothSeq": widget.selectedClothSeq,
          //                               });

          //                               final response = await dio.post(
          //                                 '$serverURL/api/photo/mix',
          //                                 data: formData,
          //                                 options: Options(
          //                                   headers: headers,
          //                                 ), // 수정된 부분
          //                               );

          //                               print('사진합성요청완료---------------------');
          //                               print(response.data);
          //                               setState(() {
          //                                 widget.imageUrl =
          //                                     response.data['body']['url'];
          //                               });
          //                               setState(() {
          //                                 widget.fileName =
          //                                     response.data['body']['fileName'];
          //                               });

          //                               print('파일네임잘담겼나???______________');
          //                               print(widget.fileName);
          //                               return response.data;
          //                             } catch (e) {
          //                               print('그밖의 에러ㅜㅜㅜㅜㅜㅜㅜㅜㅜ: $e');
          //                             } finally {}

          //                             print('사진합성완료---------------------');
          //                           },
          //                           child: Container(
          //                             decoration: BoxDecoration(
          //                               borderRadius: BorderRadius.circular(5),
          //                               border: i == widget.selectedIndex
          //                                   ? Border.all(
          //                                       color: const Color(0xFFF5BEB5),
          //                                       width: 3.0)
          //                                   : null,
          //                             ),
          //                             child: ClipRRect(
          //                               borderRadius: BorderRadius.circular(5),
          //                               child: Image.network(
          //                                 widget.cloList[i]['imgUrl'] ??
          //                                     'https://images.unsplash.com/photo-1551963831-b3b1ca40c98e',
          //                                 width: 100,
          //                                 height: 120,
          //                                 fit: BoxFit.cover,
          //                               ),
          //                             ),
          //                           ),
          //                         )
          //                       ],
          //                     ),
          //                     Container(
          //                       margin: const EdgeInsets.fromLTRB(12, 5, 0, 0),
          //                       child: Text(
          //                         // ranking[i]['clothName']이 null이 아닌지 확인하고, 그에 따라 조건부 로직을 실행합니다.
          //                         '${widget.cloList[i]['clothName'] != null && widget.cloList[i]['clothName']!.length > 6 ? widget.cloList[i]['clothName']!.substring(0, 6) : widget.cloList[i]['clothName'] ?? ''}' // null일 경우 빈 문자열을 사용합니다.
          //                         '${widget.cloList[i]['clothName'] != null && widget.cloList[i]['clothName']!.length > 6 ? ".." : ""}',
          //                         style: const TextStyle(
          //                           fontSize: 15,
          //                           fontWeight: FontWeight.w600,
          //                         ),
          //                       ),
          //                     ),
          //                   ],
          //                 ),
          //               );
          //             },
          //           )
          //         : Center(
          //             child: Text(
          //               "옷이 없습니다! 옷을 저장해보세요",
          //               style: TextStyle(
          //                 fontSize: 18,
          //                 fontWeight: FontWeight.bold,
          //               ),
          //             ),
          //           ),
          //   ),
          // )
        ],
      ),
    );
  }
}
