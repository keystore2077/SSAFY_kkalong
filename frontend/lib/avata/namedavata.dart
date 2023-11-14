// import 'package:flutter/material.dart';
// import 'package:flutter_mycloset/avata/choicecloth.dart';
// import '../avata/completecody.dart';
// import 'package:provider/provider.dart';
// import '../store/userstore.dart';
// import 'package:dio/dio.dart';

// class NamedAvata extends StatefulWidget {
//   String? imageUrl;

//   NamedAvata({super.key, this.storage, required this.imageUrl});

//   final storage;

//   @override
//   State<NamedAvata> createState() => NamedAvataState();
// }

// class NamedAvataState extends State<NamedAvata> {
//   bool isSelectedYes = false;
//   bool isSelectedNo = false;
//   TextEditingController controller = TextEditingController();
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
//               '깔롱의 아바타1',
//               style: TextStyle(color: Colors.white),
//             ),
//             centerTitle: true,
//             elevation: 0,
//           ),
//           SliverList(
//             delegate: SliverChildListDelegate(
//               [
//                 AppBar(
//                   automaticallyImplyLeading: false,
//                   toolbarHeight: 100,
//                   centerTitle: true,
//                   title: const Text(
//                     '코디가 완성되었습니다!',
//                     style: TextStyle(
//                       fontSize: 22,
//                       color: Color.fromARGB(255, 0, 0, 0),
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
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
//               delegate:

//               SliverChildBuilderDelegate(
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
//                           Image.asset(
//                             item["image"] ?? "Assets/Image/logo.png",
//                             height: 125,
//                             width: 180,
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
//               padding: const EdgeInsets.fromLTRB(18, 2, 18, 2),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   // const SizedBox(
//                   //   width: 400,
//                   //   child: Text(
//                   //     '공개여부',
//                   //     style:
//                   //         TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
//                   //   ),
//                   // ),
//                   SizedBox(
//                     child: Row(
//                       children: [
//                         const Padding(
//                           padding: EdgeInsets.fromLTRB(8, 0, 0, 12),
//                           child: Text(
//                             '공개여부',
//                             style: TextStyle(
//                               fontSize: 22,
//                               fontWeight: FontWeight.w700,
//                               color: Color(0xFFF5BEB5),
//                             ),
//                           ),
//                         ),
//                         const Spacer(),
//                         // Padding(
//                         //   padding: const EdgeInsets.fromLTRB(30, 1, 10, 10),
//                         //   child: TextButton(
//                         //     onPressed: () {},
//                         //     style: TextButton.styleFrom(
//                         //       foregroundColor:
//                         //           const Color.fromARGB(255, 232, 170, 170),
//                         //       side: const BorderSide(
//                         //           color: Color.fromARGB(255, 232, 170, 170),
//                         //           width: 1.0),
//                         //       shape: RoundedRectangleBorder(
//                         //         borderRadius: BorderRadius.circular(20.0),
//                         //       ),
//                         //     ),
//                         //     child: const Text(
//                         //       '아니오',
//                         //       style: TextStyle(
//                         //         fontSize: 12,
//                         //         fontWeight: FontWeight.w600,
//                         //       ),
//                         //     ),
//                         //   ),
//                         // ),
//                         // Padding(
//                         //   padding: const EdgeInsets.fromLTRB(5, 1, 10, 10),
//                         //   child: TextButton(
//                         //     onPressed: () {},
//                         //     style: TextButton.styleFrom(
//                         //       foregroundColor:
//                         //           const Color.fromARGB(255, 232, 170, 170),
//                         //       side: const BorderSide(
//                         //           color: Color.fromARGB(255, 232, 170, 170),
//                         //           width: 1.0),
//                         //       shape: RoundedRectangleBorder(
//                         //         borderRadius: BorderRadius.circular(20.0),
//                         //       ),
//                         //     ),
//                         //     child: const Text(
//                         //       '예',
//                         //       style: TextStyle(
//                         //         fontSize: 12,
//                         //         fontWeight: FontWeight.w600,
//                         //       ),
//                         //     ),
//                         //   ),
//                         // ),
//                         Padding(
//                           padding: const EdgeInsets.fromLTRB(30, 1, 10, 10),
//                           child: TextButton(
//                             onPressed: () {
//                               setState(() {
//                                 isSelectedYes = true;
//                                 isSelectedNo =
//                                     false; // '예' 버튼을 선택하면 '아니오' 버튼은 선택되지 않도록 설정
//                               });
//                             },
//                             style: TextButton.styleFrom(
//                               foregroundColor: isSelectedYes
//                                   ? Color.fromARGB(255, 254, 253, 253)
//                                   : Color.fromARGB(255, 250, 246, 246),
//                               backgroundColor: isSelectedYes
//                                   ? Color.fromARGB(255, 251, 173, 161)
//                                   : Color.fromARGB(255, 247, 203, 203),
//                               side: const BorderSide(
//                                   color: Color.fromARGB(255, 247, 203, 203),
//                                   width: 1.0),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(20.0),
//                               ),
//                             ),
//                             child: const Text(
//                               '예',
//                               style: TextStyle(
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.fromLTRB(5, 1, 10, 10),
//                           child: TextButton(
//                             onPressed: () {
//                               setState(() {
//                                 isSelectedYes =
//                                     false; // '아니오' 버튼을 선택하면 '예' 버튼은 선택되지 않도록 설정
//                                 isSelectedNo = true;
//                               });
//                             },
//                             style: TextButton.styleFrom(
//                               foregroundColor: isSelectedNo
//                                   ? Color.fromARGB(255, 254, 253, 253)
//                                   : Color.fromARGB(255, 252, 247, 247),
//                               backgroundColor: isSelectedNo
//                                   ? Color.fromARGB(255, 251, 173, 161)
//                                   : const Color.fromARGB(255, 247, 203, 203),
//                               side: const BorderSide(
//                                   color: Color.fromARGB(255, 247, 203, 203),
//                                   width: 1.0),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(20.0),
//                               ),
//                             ),
//                             child: const Text(
//                               '아니오',
//                               style: TextStyle(
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                           ),
//                         ),

//                         // Padding(
//                         //   padding: const EdgeInsets.fromLTRB(5, 1, 10, 10),
//                         //   child: TextButton(
//                         //     onPressed: () {},
//                         //     style: TextButton.styleFrom(
//                         //       foregroundColor:
//                         //           const Color.fromARGB(255, 232, 170, 170),
//                         //       side: const BorderSide(
//                         //           color: Color.fromARGB(255, 232, 170, 170),
//                         //           width: 1.0),
//                         //       shape: RoundedRectangleBorder(
//                         //         borderRadius: BorderRadius.circular(20.0),
//                         //       ),
//                         //     ),
//                         //     child: const Text(
//                         //       '예',
//                         //       style: TextStyle(
//                         //         fontSize: 12,
//                         //         fontWeight: FontWeight.w600,
//                         //       ),
//                         //     ),
//                         //   ),
//                         // ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   Padding(
//                       padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
//                       child: SizedBox(
//                         height: 80,
//                         child: TextField(
//                           controller: controller,
//                           decoration: const InputDecoration(
//                               contentPadding: EdgeInsets.symmetric(
//                                   vertical: 15.0, horizontal: 10.0),
//                               focusedBorder: OutlineInputBorder(
//                                   borderSide: BorderSide(
//                                       width: 1.5, color: Color(0xFFF5BEB5))),
//                               prefixIconColor: Color(0xFFF5BEB5),
//                               border: OutlineInputBorder(),
//                               labelText: '  코디 이름  ',
//                               focusColor: Color(0xFFF5BEB5)),
//                           keyboardType: TextInputType.name,
//                         ),
//                       )),
//                   SizedBox(
//                     height: 80,
//                     child: Padding(
//                       padding: const EdgeInsets.fromLTRB(0, 15, 0, 10),
//                       child: ButtonTheme(
//                           child: TextButton(
//                               onPressed: () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) =>
//                                           const Completecody()),
//                                 );
//                               },
//                               style: OutlinedButton.styleFrom(
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(
//                                       4.0), // 원하는 각진 정도로 설정
//                                 ),
//                                 backgroundColor: const Color(0xFFF5BEB5),
//                               ),
//                               child: const SizedBox(
//                                 height: 35,
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Text(
//                                       '저장하기',
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.w700,
//                                           color: Colors.white),
//                                     ),
//                                   ],
//                                 ),
//                               ))),
//                     ),
//                   ),
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
import '../avata/completecody.dart';
import 'package:http_parser/http_parser.dart';
import '../user/mypage.dart';
import './choicepicture.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import '../store/userstore.dart';
import 'package:dio/dio.dart';

class NamedAvata extends StatefulWidget {
  Dio dio = Dio();
  final serverURL = 'http://k9c105.p.ssafy.io:8761';
  final String imageUrl;
  final String fileName;

  final dynamic storage;

  NamedAvata(
      {super.key,
      this.storage,
      required this.imageUrl,
      required this.fileName});

  // final storage;

  @override
  State<NamedAvata> createState() => NamedAvataState();
}

class NamedAvataState extends State<NamedAvata> {
  bool isSelectedYes = false;
  bool isSelectedNo = false;
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    // 초기화 작업 수행
  }

  final savecloset = {
    "list": [
      {"image": "Assets/Image/TShirt.png"},
    ]
  };

  // final clomenue = {
  //   "list": [
  //     {"image": "Assets/Image/TShirt.png", "name": "Top"},
  //     {"image": "Assets/Image/Pants.png", "name": "Pants"},
  //     {"image": "Assets/Image/Suit.png", "name": "Outer"},
  //     {"image": "Assets/Image/Skirt.png", "name": "Skirts"},
  //     {"image": "Assets/Image/Dress.png", "name": "Dress"},
  //     {"image": "Assets/Image/Ellipsis.png", "name": "ect"},
  //   ]
  // };

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 255, 255, 254),
//       body: CustomScrollView(
//         slivers: <Widget>[
//           const SliverAppBar(
//             backgroundColor: Color(0xFFF5BEB5),
//             expandedHeight: 25.0,
//             floating: true,
//             pinned: true,
//             title: Text(
//               '깔롱의 아바타1',
//               style: TextStyle(color: Colors.white),
//             ),
//             centerTitle: true,
//             elevation: 0,
//           ),
//           SliverList(
//             delegate: SliverChildListDelegate(
//               [
//                 AppBar(
//                   automaticallyImplyLeading: false,
//                   toolbarHeight: 100,
//                   centerTitle: true,
//                   title: const Text(
//                     '코디가 완성되었습니다!',
//                     style: TextStyle(
//                       fontSize: 22,
//                       color: Color.fromARGB(255, 0, 0, 0),
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
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
//               padding: const EdgeInsets.fromLTRB(18, 2, 18, 2),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   SizedBox(
//                     child: Row(
//                       children: [
//                         const Padding(
//                           padding: EdgeInsets.fromLTRB(8, 0, 0, 12),
//                           child: Text(
//                             '공개여부',
//                             style: TextStyle(
//                               fontSize: 22,
//                               fontWeight: FontWeight.w700,
//                               color: Color(0xFFF5BEB5),
//                             ),
//                           ),
//                         ),
//                         const Spacer(),
//                         Padding(
//                           padding: const EdgeInsets.fromLTRB(30, 1, 10, 10),
//                           child: TextButton(
//                             onPressed: () {
//                               setState(() {
//                                 isSelectedYes = true;
//                                 isSelectedNo =
//                                     false; // '예' 버튼을 선택하면 '아니오' 버튼은 선택되지 않도록 설정
//                               });
//                             },
//                             style: TextButton.styleFrom(
//                               foregroundColor: isSelectedYes
//                                   ? Color.fromARGB(255, 254, 253, 253)
//                                   : Color.fromARGB(255, 250, 246, 246),
//                               backgroundColor: isSelectedYes
//                                   ? Color.fromARGB(255, 251, 173, 161)
//                                   : Color.fromARGB(255, 250, 220, 220),
//                               side: const BorderSide(
//                                   color: Color.fromARGB(255, 247, 203, 203),
//                                   width: 1.0),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(20.0),
//                               ),
//                             ),
//                             child: const Text(
//                               '예',
//                               style: TextStyle(
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.fromLTRB(5, 1, 10, 10),
//                           child: TextButton(
//                             onPressed: () {
//                               setState(() {
//                                 isSelectedYes =
//                                     false; // '아니오' 버튼을 선택하면 '예' 버튼은 선택되지 않도록 설정
//                                 isSelectedNo = true;
//                               });
//                             },
//                             style: TextButton.styleFrom(
//                               foregroundColor: isSelectedNo
//                                   ? Color.fromARGB(255, 254, 253, 253)
//                                   : Color.fromARGB(255, 252, 247, 247),
//                               backgroundColor: isSelectedNo
//                                   ? Color.fromARGB(255, 251, 173, 161)
//                                   : const Color.fromARGB(255, 247, 203, 203),
//                               side: const BorderSide(
//                                   color: Color.fromARGB(255, 247, 203, 203),
//                                   width: 1.0),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(20.0),
//                               ),
//                             ),
//                             child: const Text(
//                               '아니오',
//                               style: TextStyle(
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   Padding(
//                       padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
//                       child: SizedBox(
//                         height: 80,
//                         child: TextField(
//                           controller: controller,
//                           decoration: const InputDecoration(
//                               contentPadding: EdgeInsets.symmetric(
//                                   vertical: 15.0, horizontal: 10.0),
//                               focusedBorder: OutlineInputBorder(
//                                   borderSide: BorderSide(
//                                       width: 1.5, color: Color(0xFFF5BEB5))),
//                               prefixIconColor: Color(0xFFF5BEB5),
//                               border: OutlineInputBorder(),
//                               labelText: '  코디 이름  ',
//                               focusColor: Color(0xFFF5BEB5)),
//                           keyboardType: TextInputType.name,
//                         ),
//                       )),
//                   SizedBox(
//                     height: 80,
//                     child: Padding(
//                       padding: const EdgeInsets.fromLTRB(0, 15, 0, 10),
//                       child: ButtonTheme(
//                           child: TextButton(
//                               onPressed: () async {
//                                 if (isSelectedYes || isSelectedNo) {
//                                   final String codiName =
//                                       controller.text.trim(); // 코디 이름 가져오기
//                                   if (codiName.isNotEmpty) {
//                                     var accessToken =
//                                         context.read<UserStore>().accessToken;

//                                     print('____코디네임: $codiName');
//                                     print('____선택했니?: $isSelectedYes');
//                                 try {
//   Map<String, dynamic> headers = {};
//   if (accessToken.isNotEmpty) {
//     headers['Authorization'] = 'Bearer $accessToken';
//     headers['Content-Type'] = 'multipart/form-data';
//   }
//   print('___________토큰: $accessToken');

//   // 코디 정보를 Map으로 생성
//   Map<String, dynamic> requestData = {
//     "fashionName": codiName,
//     "ai": true,
//     "fashionPrivate": isSelectedYes,
//   };

//   // FormData 객체 생성
//   FormData formData = FormData();

//   // 이미지 파일을 FormData에 추가
//   formData.files.add(
//     MapEntry(
//       "mFile",
//       await MultipartFile.fromFile(
//         widget.imageUrl,
//         contentType: MediaType('image', 'jpeg'),
//       ),
//     ),
//   );

//   // requestData를 FormData에 추가 (이미지 파일과 함께)
//   formData.fields.add(
//     MapEntry("request", jsonEncode(requestData)),
//   );

//   print('___________폼데이타: $formData');

//   // 코디 정보를 서버에 보내는 API 요청
//   final response = await widget.dio.post(
//     '${widget.serverURL}/api/social/save',
//     data: formData,
//     options: Options(headers: headers),
//   );

//   if (response.statusCode == 200) {
//     // 성공적으로 저장된 경우
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => const Completecody(),
//       ),
//     );
//   } else {
//     // 저장에 실패한 경우
//     // 실패 처리 로직을 추가하세요.
//     print('저장에 실패했습니다.');
//   }
// } catch (e) {
//   print('에러: $e');
// }

//                               style: OutlinedButton.styleFrom(
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(
//                                       4.0), // 원하는 각진 정도로 설정
//                                 ),
//                                 backgroundColor: const Color(0xFFF5BEB5),
//                               );
//                               const SizedBox(
//                                 height: 35,
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                  children: [
//               Text(
//                 '저장하기',
//                 style: TextStyle(
//                   fontWeight: FontWeight.w700,
//                   color: Colors.white,
//                 ),
//               ),
//             ],

//                                 ),
//                               )));
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: CustomScrollView(
        slivers: <Widget>[
          const SliverAppBar(
            backgroundColor: Color(0xFFF5BEB5),
            expandedHeight: 25.0,
            floating: true,
            pinned: true,
            title: Text(
              '깔롱의 아바타1',
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
            elevation: 0,
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                AppBar(
                  automaticallyImplyLeading: false,
                  toolbarHeight: 100,
                  centerTitle: true,
                  title: const Text(
                    '코디가 완성되었습니다!',
                    style: TextStyle(
                      fontSize: 22,
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
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
                    widget.imageUrl ?? "Assets/Image/logo.png",
                    height: 125,
                    width: 180,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        "Assets/Image/logo.png",
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
              padding: const EdgeInsets.fromLTRB(18, 2, 18, 2),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.fromLTRB(8, 0, 0, 12),
                          child: Text(
                            '공개여부',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFFF5BEB5),
                            ),
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(30, 1, 10, 10),
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                isSelectedYes = true;
                                isSelectedNo =
                                    false; // '예' 버튼을 선택하면 '아니오' 버튼은 선택되지 않도록 설정
                              });
                            },
                            style: TextButton.styleFrom(
                              foregroundColor: isSelectedYes
                                  ? Color.fromARGB(255, 254, 253, 253)
                                  : Color.fromARGB(255, 250, 246, 246),
                              backgroundColor: isSelectedYes
                                  ? Color.fromARGB(255, 251, 173, 161)
                                  : Color.fromARGB(255, 250, 220, 220),
                              side: const BorderSide(
                                  color: Color.fromARGB(255, 247, 203, 203),
                                  width: 1.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                            child: const Text(
                              '예',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(5, 1, 10, 10),
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                isSelectedYes =
                                    false; // '아니오' 버튼을 선택하면 '예' 버튼은 선택되지 않도록 설정
                                isSelectedNo = true;
                              });
                            },
                            style: TextButton.styleFrom(
                              foregroundColor: isSelectedNo
                                  ? Color.fromARGB(255, 254, 253, 253)
                                  : Color.fromARGB(255, 252, 247, 247),
                              backgroundColor: isSelectedNo
                                  ? Color.fromARGB(255, 251, 173, 161)
                                  : const Color.fromARGB(255, 247, 203, 203),
                              side: const BorderSide(
                                  color: Color.fromARGB(255, 247, 203, 203),
                                  width: 1.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                            child: const Text(
                              '아니오',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
                    child: SizedBox(
                      height: 80,
                      child: TextField(
                        controller: controller,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 10.0),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1.5, color: Color(0xFFF5BEB5))),
                          prefixIconColor: Color(0xFFF5BEB5),
                          border: OutlineInputBorder(),
                          labelText: '  코디 이름  ',
                          focusColor: Color(0xFFF5BEB5),
                        ),
                        keyboardType: TextInputType.name,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 80,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 15, 0, 10),
                      child: ButtonTheme(
                          child: TextButton(
                        onPressed: () async {
                          if (isSelectedYes || isSelectedNo) {
                            final String codiName =
                                controller.text.trim(); // 코디 이름 가져오기
                            if (codiName.isNotEmpty) {
                              var accessToken =
                                  context.read<UserStore>().accessToken;

                              print('____코디네임: $codiName');
                              print('____선택했니?: $isSelectedYes');
                              print('파일네임');
                              print(widget.fileName);
                              try {
                                Map<String, dynamic> headers = {};
                                if (accessToken.isNotEmpty) {
                                  headers['Authorization'] =
                                      'Bearer $accessToken';
                                  // headers['Content-Type'] =
                                  //     'multipart/form-data';
                                }
                                print('___________토큰: $accessToken');

                                // 코디 정보를 서버에 보내는 API 요청
                                final response = await widget.dio.post(
                                  '${widget.serverURL}/api/social/save',
                                  data: {
                                    "fashionName": codiName,
                                    "ai": true,
                                    "fashionPrivate": isSelectedYes,
                                    "imgName": widget.fileName,
                                  },
                                  options: Options(headers: headers),
                                );
                                print('요청보냄');
                                print(response.data);

                                if (response.data['result']['resultCode'] ==
                                    200) {
                                  // showDialog(
                                  //   context: context,
                                  //   builder: (BuildContext context) {
                                  //     return AlertDialog(
                                  //       title: Text(
                                  //         ' 🎉 저장 성공 🎉 ',
                                  //         textAlign: TextAlign.center, // 여기에 추가
                                  //       ),
                                  //       content: Text(
                                  //         '완성된 코디는 내프로필에 저장됩니다!',
                                  //         textAlign: TextAlign.center, // 여기에 추가
                                  //       ),
                                  //       actions: <Widget>[
                                  //         TextButton(
                                  //           child: Text('확인'),
                                  //           onPressed: () {
                                  //             Navigator.of(context).pop();
                                  //             Navigator.of(context)
                                  //                 .pushReplacement(
                                  //                     MaterialPageRoute(
                                  //               builder: (_) => MyPage(),
                                  //             ));
                                  //           },
                                  //         ),
                                  //       ],
                                  //     );
                                  //   },
                                  // );
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(
                                          ' 🎉 저장 성공 🎉 ',
                                          textAlign: TextAlign.center,
                                        ),
                                        content: Text(
                                          '완성된 코디는 내프로필에 저장됩니다!',
                                          textAlign: TextAlign.center,
                                        ),
                                        actions: <Widget>[
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .center, // 중앙 정렬 설정
                                            children: [
                                              TextButton(
                                                child: Text('확인'),
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pop(); // 대화 상자 닫기
                                                  Navigator.of(context)
                                                      .pushReplacement(
                                                    MaterialPageRoute(
                                                      builder: (_) => MyPage(),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ],
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(
                                          ' 저장실패 ',
                                          textAlign: TextAlign.center,
                                        ),
                                        content: Text(
                                          '코디저장에 실패했습니다!',
                                          textAlign: TextAlign.center,
                                        ),
                                        actions: <Widget>[
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .center, // 중앙 정렬 설정
                                            children: [
                                              TextButton(
                                                child: Text('확인'),
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pop(); // 대화 상자 닫기
                                                  Navigator.of(context)
                                                      .pushReplacement(
                                                    MaterialPageRoute(
                                                      builder: (_) =>
                                                          ChoicePicture(),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ],
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                                return response.data;
                              } catch (e) {
                                print('에러: $e');
                              }
                            }
                          }
                        },
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(4.0), // 원하는 각진 정도로 설정
                          ),
                          backgroundColor: const Color(0xFFF5BEB5),
                        ),
                        child: SizedBox(
                          height: 35,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                '저장하기',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
