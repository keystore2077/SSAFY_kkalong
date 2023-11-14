// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import '../avata/wearcloth.dart';

// // import 'package:flutter_mycloset/category/categoryselect.dart';

// class ChoicePicture extends StatefulWidget {
//   const ChoicePicture({
//     super.key,
//     this.storage,
//   });

//   final storage;

//   @override
//   State<ChoicePicture> createState() => ChoicePictureState();
// }

// class ChoicePictureState extends State<ChoicePicture> {
//   @override
//   void initState() {
//     super.initState();
//     // 초기화 작업 수행
//   }

//   final savecloset = {
//     "list": [
//       {"image": "Assets/Image/TShirt.png", "name": "Top"},
//       {"image": "Assets/Image/Pants.png", "name": "Pants"},
//       {"image": "Assets/Image/Suit.png", "name": "Outer"},
//       {"image": "Assets/Image/Skirt.png", "name": "Skirts"},
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
//               '깔롱의 사진',
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
//                   toolbarHeight: 100,
//                   centerTitle: true,
//                   title: const Text(
//                     '내 사진을 골라주세요!',
//                     style: TextStyle(
//                       fontSize: 25,
//                       color: Color.fromARGB(255, 0, 0, 0),
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//           SliverPadding(
//             padding: const EdgeInsets.fromLTRB(20, 1, 20, 0),
//             sliver: SliverGrid(
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
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
//                           Image.asset(
//                             item["image"] ?? "Assets/Image/logo.png",
//                             height: 125,
//                             width: 180,
//                           ),
//                           Text(
//                             item["name"] ?? "Unknown",
//                             style: const TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.w500,
//                             ),
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
//         ],
//       ),
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.fromLTRB(20, 2, 20, 2),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () {},
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFFF5BEB5),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(5.0),
//                       ),
//                     ),
//                     child: const Text(
//                       '다시선택',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 10),
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => const WearCloth()),
//                       );
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFFF5BEB5),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(5.0),
//                       ),
//                     ),
//                     child: const Text(
//                       '선택완료',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 10),
//             SizedBox(
//                 width: 400,
//                 child: ElevatedButton(
//                   onPressed: () async {
//                     final ImagePicker picker = ImagePicker();
//                     final XFile? image =
//                         await picker.pickImage(source: ImageSource.camera);

//                     if (image != null) {
//                       // 이미지가 선택되면 처리할 작업을 여기에 추가합니다.
//                     }
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFFF5BEB5),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(5.0),
//                     ),
//                   ),
//                   child: const Text(
//                     '사진찍기 ',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                 )),
//             const SizedBox(height: 10),
//             SizedBox(
//                 width: 400,
//                 child: ElevatedButton(
//                   onPressed: () async {
//                     final ImagePicker picker = ImagePicker();
//                     final XFile? image =
//                         await picker.pickImage(source: ImageSource.camera);

//                     if (image != null) {
//                       // 이미지가 선택되면 처리할 작업을 여기에 추가합니다.
//                     }
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFFF5BEB5),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(5.0),
//                     ),
//                   ),
//                   child: const Text(
//                     '내 패션 찰칵 ',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                 )),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import '../avata/avatacamera.dart';
// import '../avata/wearcloth.dart';

// class ChoicePicture extends StatefulWidget {
//   const ChoicePicture({
//     super.key,
//     this.storage,
//   });

//   final storage;

//   @override
//   State<ChoicePicture> createState() => ChoicePictureState();
// }

// class ChoicePictureState extends State<ChoicePicture> {
//   @override
//   void initState() {
//     super.initState();
//     // 초기화 작업 수행
//   }

//   final savecloset = {
//     "list": [
//       {"image": "Assets/Image/TShirt.png", "name": "Top"},
//       {"image": "Assets/Image/Pants.png", "name": "Pants"},
//       {"image": "Assets/Image/Suit.png", "name": "Outer"},
//       {"image": "Assets/Image/Skirt.png", "name": "Skirts"},
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
//               '깔롱의 사진',
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
//                   toolbarHeight: 100,
//                   centerTitle: true,
//                   title: const Text(
//                     '내 사진을 골라주세요!',
//                     style: TextStyle(
//                       fontSize: 25,
//                       color: Color.fromARGB(255, 0, 0, 0),
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//           SliverPadding(
//             padding: const EdgeInsets.fromLTRB(20, 1, 20, 0),
//             sliver: SliverGrid(
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
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
//                           Image.asset(
//                             item["image"] ?? "Assets/Image/logo.png",
//                             height: 125,
//                             width: 180,
//                           ),
//                           Text(
//                             item["name"] ?? "Unknown",
//                             style: const TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.w500,
//                             ),
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
//         ],
//       ),
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.fromLTRB(20, 2, 20, 2),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () {},
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFFF5BEB5),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(5.0),
//                       ),
//                     ),
//                     child: const Text(
//                       '다시선택',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 10),
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => const WearCloth()),
//                       );
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFFF5BEB5),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(5.0),
//                       ),
//                     ),
//                     child: const Text(
//                       '선택완료',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 10),
//             SizedBox(
//                 width: 400,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => const AvataPicture()),
//                     );
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFFF5BEB5),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(5.0),
//                     ),
//                   ),
//                   child: const Text(
//                     '사진찍기 ',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                 )),
//             const SizedBox(height: 10),
//             SizedBox(
//                 width: 400,
//                 child: ElevatedButton(
//                   onPressed: () {},
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFFF5BEB5),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(5.0),
//                     ),
//                   ),
//                   child: const Text(
//                     '내 패션 찰칵 ',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                 )),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import '../avata/avatacamera.dart';
// // import '../avata/wearcloth.dart';
// //api
// import 'package:provider/provider.dart';
// import '../store/userstore.dart';
// import 'package:dio/dio.dart';

// class ChoicePicture extends StatefulWidget {
//   final storage;
//   List<dynamic> photoList = [];

//   ChoicePicture({Key? key, this.storage}) : super(key: key);

//   @override
//   _ChoicePictureState createState() => _ChoicePictureState();
// }

// class _ChoicePictureState extends State<ChoicePicture> {
//   int? selectedIndex;

//   final savecloset = {
//     "list": [
//       {"image": "Assets/Image/TShirt.png", "name": "Top"},
//       {"image": "Assets/Image/Pants.png", "name": "Pants"},
//       {"image": "Assets/Image/Suit.png", "name": "Outer"},
//       {"image": "Assets/Image/Skirt.png", "name": "Skirts"},
//     ]
//   };

//   @override
//   void initState() {
//     super.initState();
//     fetchMyPhoto();
//   }

//   void fetchMyPhoto() async {
//     var accessToken = context.read<UserStore>().accessToken;
//     Dio dio = Dio();
//     const serverURL = 'http://k9c105.p.ssafy.io:8761';

//     try {
//       Map<String, dynamic> headers = {};
//       if (accessToken.isNotEmpty) {
//         headers['Authorization'] = 'Bearer $accessToken';
//       }

//       final response = await dio.get(
//         '$serverURL/api/photo',
//         options: Options(headers: headers),
//       );
//       print('옷사진 초이스칸-------------디오요청했음-------------');
//       print('리스판스데이터--------------');
//       print(response.data);
//       // var cloList = response.data['body'];
//       setState(() {
//         widget.photoList = response.data['body'];
//       });
//       print('초이스픽쳐리스트출력________________');
//       print(widget.photoList);
//       return response.data;
//     } catch (e) {
//       print('에러: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0x0fffffff),
//       body: CustomScrollView(
//         slivers: [
//           // App Bar
//           const SliverAppBar(
//             backgroundColor: Color(0xFFF5BEB5),
//             expandedHeight: 55.0,
//             floating: true,
//             pinned: true,
//             title: Text('깔롱의 사진', style: TextStyle(color: Colors.white)),
//             centerTitle: true,
//             elevation: 0,
//           ),
//           // Message
//           SliverList(
//             delegate: SliverChildListDelegate(
//               [
//                 AppBar(
//                   toolbarHeight: 100,
//                   centerTitle: true,
//                   title: const Text(
//                     '내 사진을 골라주세요!',
//                     style: TextStyle(
//                       fontSize: 25,
//                       color: Colors.black,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//           // Grid of Clothes
//           SliverPadding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             sliver: SliverGrid(
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 20.0,
//                 mainAxisSpacing: 20.0,
//               ),
//               delegate: SliverChildBuilderDelegate(
//                 (BuildContext context, int index) {
//                   final item = savecloset['list']?[index];
//                   if (item == null) {
//                     return const SizedBox.shrink();
//                   }
//                   return GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         selectedIndex = index; // Update the selected index
//                       });
//                     },
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: const Color.fromARGB(255, 255, 244, 242),
//                         border: index == selectedIndex
//                             ? Border.all(
//                                 color: const Color.fromARGB(255, 225, 154, 144),
//                                 width: 3.0)
//                             : null,
//                       ),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Image.asset(
//                             item["image"] ?? "Assets/Image/logo.png",
//                             height: 125,
//                             width: 180,
//                           ),
//                           Text(
//                             item["name"] ?? "Unknown",
//                             style: const TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.w500,
//                             ),
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
//         ],
//       ),
//       // Bottom Navigation Bar
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () {},
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFFF5BEB5),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(5.0),
//                       ),
//                     ),
//                     child: const Text(
//                       '다시선택',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 10),
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () {
//                       // Navigator.push(
//                       //   context,
//                       //   MaterialPageRoute(
//                       //       builder: (context) => const WearCloth()),
//                       // );
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFFF5BEB5),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(5.0),
//                       ),
//                     ),
//                     child: const Text(
//                       '선택완료',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 10),
//             SizedBox(
//               width: 400,
//               child: ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => const AvataPicture()),
//                   );
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xFFF5BEB5),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(5.0),
//                   ),
//                 ),
//                 child: const Text(
//                   '사진찍기',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 10),
//             SizedBox(
//               width: 400,
//               child: ElevatedButton(
//                 onPressed: () {},
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xFFF5BEB5),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(5.0),
//                   ),
//                 ),
//                 child: const Text(
//                   '내 패션 찰칵',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import '../avata/avatacamera.dart';
// import '../avata/wearcloth.dart';
// //api
// import 'package:provider/provider.dart';
// import '../store/userstore.dart';
// import 'package:dio/dio.dart';

// class ChoicePicture extends StatefulWidget {
//   final storage;
//   List<dynamic> photoList = [];

//   ChoicePicture({Key? key, this.storage}) : super(key: key);

//   @override
//   _ChoicePictureState createState() => _ChoicePictureState();
// }

// class _ChoicePictureState extends State<ChoicePicture> {
//   int? selectedIndex;
//   int? selectedPhotoSeq;

//   @override
//   void initState() {
//     super.initState();
//     fetchMyPhoto();
//   }

//   void fetchMyPhoto() async {
//     var accessToken = context.read<UserStore>().accessToken;
//     Dio dio = Dio();
//     const serverURL = 'http://k9c105.p.ssafy.io:8761';

//     try {
//       Map<String, dynamic> headers = {};
//       if (accessToken.isNotEmpty) {
//         headers['Authorization'] = 'Bearer $accessToken';
//       }

//       final response = await dio.get(
//         '$serverURL/api/photo',
//         options: Options(headers: headers),
//       );
//       print('옷사진 초이스칸-------------디오요청했음-------------');
//       print('리스판스데이터--------------');
//       print(response.data);
//       // var cloList = response.data['body'];
//       setState(() {
//         widget.photoList = response.data['body'];
//       });
//       print('초이스픽쳐리스트출력________________');
//       print(widget.photoList);
//       print('데이터는 몇건일까요______________');
//       print(widget.photoList.length);
//       return response.data;
//     } catch (e) {
//       print('에러: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0x0fffffff),
//       body: CustomScrollView(
//         slivers: [
//           // App Bar
//           const SliverAppBar(
//             backgroundColor: Color(0xFFF5BEB5),
//             expandedHeight: 55.0,
//             floating: true,
//             pinned: true,
//             title: Text('깔롱의 사진', style: TextStyle(color: Colors.white)),
//             centerTitle: true,
//             elevation: 0,
//           ),
//           // Message
//           SliverList(
//             delegate: SliverChildListDelegate(
//               [
//                 AppBar(
//                   toolbarHeight: 100,
//                   centerTitle: true,
//                   title: Text(
//                     '내 사진을 골라주세요! (총 ${widget.photoList.length}건)',
//                     // '내 사진을 골라주세요!',
//                     style: TextStyle(
//                       fontSize: 25,
//                       color: Colors.black,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//           // Grid of Clothes
//           SliverPadding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             sliver: SliverGrid(
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 20.0,
//                 mainAxisSpacing: 20.0,
//               ),
//               delegate: SliverChildBuilderDelegate(
//                 (BuildContext context, int index) {
//                   if (index >= widget.photoList.length) {
//                     return const SizedBox
//                         .shrink(); // 유효한 인덱스 범위를 벗어나면 빈 컨테이너 반환
//                   }
//                   final item = widget.photoList[index];
//                   final photoSeq = item['photoSeq'];
//                   final url = item['url'];

//                   return GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         selectedIndex = index; // 선택된 인덱스 업데이트
//                         selectedPhotoSeq = photoSeq;
//                       });
//                     },
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: Color.fromARGB(255, 255, 222, 216),
//                         border: index == selectedIndex
//                             ? Border.all(
//                                 color: const Color.fromARGB(255, 225, 154, 144),
//                                 width: 3.0)
//                             : null,
//                       ),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Image.network(
//                             url ?? "", // 이미지 URL 사용
//                             height: 125,
//                             width: 180,
//                             fit: BoxFit.cover,
//                           ),
//                           // Text(
//                           //   "PhotoSeq: $photoSeq", // PhotoSeq 값을 표시
//                           //   style: const TextStyle(
//                           //     fontSize: 20,
//                           //     fontWeight: FontWeight.w500,
//                           //   ),
//                           // ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//       // Bottom Navigation Bar
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             SizedBox(
//               width: 500,
//               child: ElevatedButton(
//                 onPressed: () {
//                   if (selectedPhotoSeq != null) {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) =>
//                               WearCloth(photoSeq: selectedPhotoSeq!)),
//                     );
//                   }
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xFFF5BEB5),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(5.0),
//                   ),
//                 ),
//                 child: const Text(
//                   '선택완료',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(width: 15),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () {
//                       // Navigator.push(
//                       //   context,
//                       //   MaterialPageRoute(
//                       //       builder: (context) => const AvataPicture()),
//                       // );
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFFF5BEB5),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(5.0),
//                       ),
//                     ),
//                     child: const Text(
//                       '내 패션찰칵',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 10),
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => const AvataPicture()),
//                       );
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFFF5BEB5),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(5.0),
//                       ),
//                     ),
//                     child: const Text(
//                       '사진찍기',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 10),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../avata/avatacamera.dart';
import '../avata/wearcloth.dart';
//api
import 'package:provider/provider.dart';
import '../store/userstore.dart';
import 'package:dio/dio.dart';

class ChoicePicture extends StatefulWidget {
  final storage;
  List<dynamic> photoList = [];

  ChoicePicture({Key? key, this.storage}) : super(key: key);

  @override
  _ChoicePictureState createState() => _ChoicePictureState();
}

class _ChoicePictureState extends State<ChoicePicture> {
  int? selectedIndex;
  int? selectedPhotoSeq;

  @override
  void initState() {
    super.initState();
    fetchMyPhoto();
  }

  void fetchMyPhoto() async {
    var accessToken = context.read<UserStore>().accessToken;
    Dio dio = Dio();
    const serverURL = 'http://k9c105.p.ssafy.io:8761';

    try {
      Map<String, dynamic> headers = {};
      if (accessToken.isNotEmpty) {
        headers['Authorization'] = 'Bearer $accessToken';
      }

      final response = await dio.get(
        '$serverURL/api/photo',
        options: Options(headers: headers),
      );
      print('옷사진 초이스칸-------------디오요청했음-------------');
      print('리스판스데이터--------------');
      print(response.data);
      // var cloList = response.data['body'];
      setState(() {
        widget.photoList = response.data['body'];
      });
      print('초이스픽쳐리스트출력________________');
      print(widget.photoList);
      print('데이터는 몇건일까요______________');
      print(widget.photoList.length);
      return response.data;
    } catch (e) {
      print('에러: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0x0fffffff),
      body: CustomScrollView(
        slivers: [
          // App Bar
          const SliverAppBar(
            backgroundColor: Color(0xFFF5BEB5),
            expandedHeight: 55.0,
            floating: true,
            pinned: true,
            title: Text('깔롱의 사진', style: TextStyle(color: Colors.white)),
            centerTitle: true,
            elevation: 0,
          ),
          // Message
          SliverList(
            delegate: SliverChildListDelegate(
              [
                AppBar(
                  toolbarHeight: 100,
                  centerTitle: true,
                  title: Text(
                    '내 사진을 골라주세요! (총 ${widget.photoList.length}건)',
                    // '내 사진을 골라주세요!',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              ],
            ),
          ),
          // Grid of Clothes
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 14.0,
                mainAxisSpacing: 14.0,
              ),
              // delegate: SliverChildBuilderDelegate(
              //   (BuildContext context, int index) {
              //     final reversedIndex = widget.photoList.length - 1 - index;
              //     if (reversedIndex < 0) {
              //       return const SizedBox
              //           .shrink(); // 유효한 인덱스 범위를 벗어나면 빈 컨테이너 반환
              //     }
              //     final item = widget.photoList[reversedIndex];
              //     final photoSeq = item['photoSeq'];
              //     final url = item['url'];

              //     return GestureDetector(
              //       onTap: () {
              //         setState(() {
              //           selectedIndex = reversedIndex; // 선택된 인덱스 업데이트
              //           selectedPhotoSeq = photoSeq;
              //         });
              //       },
              //       child: Container(
              //         decoration: BoxDecoration(
              //           color: Color.fromARGB(255, 255, 222, 216),
              //           border: index == selectedIndex
              //               ? Border.all(
              //                   color: Color.fromARGB(255, 255, 127, 110),
              //                   width: 3.0)
              //               : null,
              //         ),
              //         child: Column(
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           children: [
              //             Image.network(
              //               url ?? "", // 이미지 URL 사용
              //               height: 125,
              //               width: 180,
              //               fit: BoxFit.cover,
              //             ),
              //             Text(
              //               "PhotoSeq: $photoSeq", // PhotoSeq 값을 표시
              //               style: const TextStyle(
              //                 fontSize: 20,
              //                 fontWeight: FontWeight.w500,
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //     );
              //   },
              // ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  final reversedIndex = widget.photoList.length - 1 - index;
                  if (reversedIndex < 0) {
                    return const SizedBox
                        .shrink(); // 유효한 인덱스 범위를 벗어나면 빈 컨테이너 반환
                  }
                  final item = widget.photoList[reversedIndex];
                  final photoSeq = item['photoSeq'];
                  final url = item['url'];

                  final isSelected = reversedIndex == selectedIndex;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = reversedIndex; // 선택된 인덱스 업데이트
                        selectedPhotoSeq = photoSeq;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 234, 231),
                        border: isSelected
                            ? Border.all(
                                color: Color.fromARGB(255, 255, 165, 153),
                                width: 3.0,
                              )
                            : null,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network(
                            url ?? "", // 이미지 URL 사용
                            height: 150,
                            width: 180,
                            fit: BoxFit.cover,
                          ),
                          // Text(
                          //   "PhotoSeq: $photoSeq", // PhotoSeq 값을 표시
                          //   style: const TextStyle(
                          //     fontSize: 20,
                          //     fontWeight: FontWeight.w500,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      // Bottom Navigation Bar
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 500,
              child: ElevatedButton(
                onPressed: () {
                  if (selectedPhotoSeq != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              WearCloth(photoSeq: selectedPhotoSeq!)),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF5BEB5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                child: const Text(
                  '선택완료',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => const AvataPicture()),
                      // );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF5BEB5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    child: const Text(
                      '내 패션찰칵',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AvataPicture()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF5BEB5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    child: const Text(
                      '사진찍기',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
