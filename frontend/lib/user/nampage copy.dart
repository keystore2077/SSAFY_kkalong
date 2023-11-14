// import 'package:flutter/material.dart';

// class NamPage extends StatefulWidget {
//   const NamPage({super.key, this.storage});

//   final storage;
//   @override
//   State<NamPage> createState() => NamPageState();
// }

// class NamPageState extends State<NamPage> {

// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     appBar: AppBar(
//       backgroundColor: const Color(0xffA1CBA1),
//       toolbarHeight: 55,
//       title: const Text('마이페이지'),
//       centerTitle: true,
//       elevation: 0,
//       leading: const Text(''),
//     ),
//     body: Container(
//       padding: const EdgeInsets.all(30),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//               margin: const EdgeInsets.fromLTRB(0, 0, 0, 35),
//               child: const Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(
//                       child: Padding(
//                         padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
//                         child: Text(
//                           '안녕하세요,',
//                           style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ),
//                     ),
//                     Row(
//                       children: [
//                         Padding(
//                           padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
//                           child: Text(
//                             '나는야김싸피 ',
//                             style: TextStyle(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.w600,
//                                 color: Color(0xffA1CBA1)),
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
//                           child: Text(
//                             '님',
//                             style: TextStyle(
//                                 fontSize: 20, fontWeight: FontWeight.w600),
//                           ),
//                         ),
//                       ],
//                     ),
//                     Padding(
//                       padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
//                       child: Text(
//                         '오늘도 깔롱쟁이와 멋쟁이 돼보아요!',
//                         style: TextStyle(
//                             fontSize: 20, fontWeight: FontWeight.w600),
//                       ),
//                     ),
//                   ])),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(
//                   child: Padding(
//                     padding: EdgeInsets.fromLTRB(0, 0, 0, 25),
//                     child: Text(
//                       'My깔롱',
//                       style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.w700,
//                           color: Color(0xff164D16)),
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: Column(
//                     children: [
//                       SizedBox(
//                         child: Padding(
//                           padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             crossAxisAlignment: CrossAxisAlignment.end,
//                             children: [
//                               const Row(children: [
//                                 Text(
//                                   '저장한 코디 ',
//                                   style: TextStyle(
//                                       fontSize: 17,
//                                       fontWeight: FontWeight.w600),
//                                 ),
//                                 Text(
//                                   '(3건)',
//                                   style: TextStyle(
//                                       fontSize: 12,
//                                       fontWeight: FontWeight.w600),
//                                 ),
//                               ]),
//                                   GestureDetector(
//                                       onTap: () {
//                                         // Navigator.push(
//                                         //   context,
//                                         //   MaterialPageRoute(
//                                         //       builder: (BuildContext context) =>
//                                         //           FavoriteMoreRec(
//                                         //               favorRec: favorrecipe)),
//                                         // );
//                                       },
//                                       child: const Text('더보기')),
//                                     const Text('')
//                             ],
//                           ),
//                         ),
//                       ),
//                       Container(
//                         margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           crossAxisAlignment: CrossAxisAlignment.end,
//                           children: [
//                             const Row(children: [
//                               Text(
//                                 '식재료 ',
//                                 style: TextStyle(
//                                     fontSize: 17, fontWeight: FontWeight.w600),
//                               ),
//                               Text(
//                                 '(5건)',
//                                 style: TextStyle(
//                                     fontSize: 12, fontWeight: FontWeight.w600),
//                               ),
//                             ]),

//                                  GestureDetector(
//                                     onTap: () {
//                                       // Navigator.push(
//                                       //   context,
//                                       //   MaterialPageRoute(
//                                       //       builder: (BuildContext context) =>
//                                       //           FavoriteMoreFood(
//                                       //               favorIngr:
//                                       //                   favoringredient)),
//                                       // );
//                                     },
//                                     child: const Text('더보기')),
//                                 const Text('')
//                           ],
//                         ),
//                       ),
//                       Expanded(
//                         child: GestureDetector(
//                             onTap:
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (BuildContext context) =>
//                                               FavoriteMoreFood(
//                                                   favorIngr: favoringredient)),
//                                     );

//                                     ),
//                       ),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//           Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//             TextButton(
//               child: const Text('회원정보 수정'),
//               onPressed: () {
//                 // openDialog();
//               },
//             ),
//             const Text('|'),
//             TextButton(
//               onPressed: context.read<UserStore>().userId.substring(0, 1) != '['
//                   ? () {
//                       showDialog(
//                         context: context,
//                         barrierDismissible: false,
//                         builder: ((context) {
//                           return AlertDialog(
//                             title: const Text("비밀번호 변경"),
//                             content: SingleChildScrollView(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Padding(
//                                     padding:
//                                         const EdgeInsets.fromLTRB(1, 0, 1, 10),
//                                     child: TextField(
//                                       maxLength: 20,
//                                       controller: controller,
//                                       keyboardType:
//                                           TextInputType.visiblePassword,
//                                       obscureText: true, // 비밀번호 안보이도록 하는 것
//                                       decoration: const InputDecoration(
//                                           counterText: '',
//                                           contentPadding: EdgeInsets.symmetric(
//                                               vertical: 16.0, horizontal: 10.0),
//                                           focusedBorder: OutlineInputBorder(
//                                               borderSide: BorderSide(
//                                                   width: 1.5,
//                                                   color: Color(0xffA1CBA1))),
//                                           border: OutlineInputBorder(
//                                               borderSide: BorderSide()),
//                                           labelText: '현재 비밀번호',
//                                           focusColor: Color(0xffA1CBA1)),
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding:
//                                         const EdgeInsets.fromLTRB(1, 0, 1, 10),
//                                     child: TextField(
//                                       maxLength: 20,

//                                       controller: controller2,
//                                       keyboardType:
//                                           TextInputType.visiblePassword,
//                                       obscureText: true, // 비밀번호 안보이도록 하는 것
//                                       decoration: const InputDecoration(
//                                           counterText: '',
//                                           contentPadding: EdgeInsets.symmetric(
//                                               vertical: 16.0, horizontal: 10.0),
//                                           focusedBorder: OutlineInputBorder(
//                                               borderSide: BorderSide(
//                                                   width: 1.5,
//                                                   color: Color(0xffA1CBA1))),
//                                           border: OutlineInputBorder(
//                                               borderSide: BorderSide()),
//                                           labelText: '새로운 비밀번호',
//                                           focusColor: Color(0xffA1CBA1)),
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding:
//                                         const EdgeInsets.fromLTRB(1, 0, 1, 0),
//                                     child: TextField(
//                                       maxLength: 20,

//                                       controller: controller3,
//                                       obscureText: true, // 비밀번호 안보이도록 하는 것
//                                       decoration: const InputDecoration(
//                                           counterText: '',
//                                           contentPadding: EdgeInsets.symmetric(
//                                               vertical: 16.0, horizontal: 10.0),
//                                           focusedBorder: OutlineInputBorder(
//                                               borderSide: BorderSide(
//                                                   width: 1.5,
//                                                   color: Color(0xffA1CBA1))),
//                                           border: OutlineInputBorder(
//                                               borderSide: BorderSide()),
//                                           labelText: '비밀번호 확인',
//                                           focusColor: Color(0xffA1CBA1)),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             actions: <Widget>[
//                               Padding(
//                                 padding: const EdgeInsets.fromLTRB(1, 0, 1, 10),
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceEvenly,
//                                   children: [
//                                     ElevatedButton(
//                                         style: const ButtonStyle(
//                                             backgroundColor:
//                                                 MaterialStatePropertyAll(
//                                                     Color(0xffA1CBA1))),
//                                         child: const Text("변경하기"),
//                                         onPressed: () async {
//                                           if (RegExp(r"^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$")
//                                                   .hasMatch(controller2.text) &&
//                                               RegExp(r"^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$")
//                                                   .hasMatch(controller3.text) &&
//                                               controller2.text ==
//                                                   controller3.text) {
//                                             final response =
//                                                 await pageapi.changepassword(
//                                                     context
//                                                         .read<UserStore>()
//                                                         .accessToken,
//                                                     controller.text,
//                                                     controller2.text);

//                                             if (response == 'success') {
//                                               //메인페이지 이동 후 알림창 띄우고 토큰 삭제하기
//                                             } else if (response == 'fail') {
//                                               showDialog(
//                                                   context: context,
//                                                   barrierDismissible:
//                                                       true, //바깥 영역 터치시 닫을지 여부 결정
//                                                   builder: ((context) {
//                                                     return AlertDialog(
//                                                         content: const Text(
//                                                             '현재 비밀번호와 다릅니다.'),
//                                                         actions: <Widget>[
//                                                           Container(
//                                                             child: TextButton(
//                                                               onPressed: () {
//                                                                 Navigator.of(
//                                                                         context)
//                                                                     .pop(); //창 닫기
//                                                               },
//                                                               child: const Text(
//                                                                   "닫기"),
//                                                             ),
//                                                           )
//                                                         ]);
//                                                   }));
//                                             }
//                                           } else if (!RegExp(
//                                                   r"^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$")
//                                               .hasMatch(controller2.text)) {
//                                             showDialog(
//                                                 context: context,
//                                                 barrierDismissible:
//                                                     true, //바깥 영역 터치시 닫을지 여부 결정
//                                                 builder: ((context) {
//                                                   return AlertDialog(
//                                                       content: const Text(
//                                                           '특수문자,영어, 숫자를 포함해 주세요'),
//                                                       actions: <Widget>[
//                                                         Container(
//                                                           child: TextButton(
//                                                             onPressed: () {
//                                                               Navigator.of(
//                                                                       context)
//                                                                   .pop(); //창 닫기
//                                                             },
//                                                             child: const Text(
//                                                                 "닫기"),
//                                                           ),
//                                                         )
//                                                       ]);
//                                                 }));
//                                           } else if (controller2.text !=
//                                               controller3.text) {
//                                             showDialog(
//                                                 context: context,
//                                                 barrierDismissible:
//                                                     true, //바깥 영역 터치시 닫을지 여부 결정
//                                                 builder: ((context) {
//                                                   return AlertDialog(
//                                                       content: const Text(
//                                                           '새로 입력한 비밀번호 같지 않습니다.'),
//                                                       actions: <Widget>[
//                                                         Container(
//                                                           child: TextButton(
//                                                             onPressed: () {
//                                                               Navigator.of(
//                                                                       context)
//                                                                   .pop(); //창 닫기
//                                                             },
//                                                             child: const Text(
//                                                                 "닫기"),
//                                                           ),
//                                                         )
//                                                       ]);
//                                                 }));
//                                           } else {
//                                             showSnackBar(
//                                                 context,
//                                                 const Text(
//                                                     '현재비밀번호가 다릅니다 다시 시도해주세요'));
//                                           }
//                                         }),
//                                     ElevatedButton(
//                                       style: const ButtonStyle(
//                                           backgroundColor:
//                                               MaterialStatePropertyAll(
//                                                   Color(0xffA1CBA1))),
//                                       onPressed: () {
//                                         Navigator.of(context).pop(); //창 닫기
//                                         controller.text = '';
//                                         controller2.text = '';
//                                         controller3.text = '';
//                                       },
//                                       child: const Text("취소하기"),
//                                     ),
//                                   ],
//                                 ),
//                               )
//                             ],
//                           );
//                         }),
//                       );
//                     }
//                   : null,
//               child: const Text(
//                 '비밀번호 변경',
//                 style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
//               ),
//             ),
//             const Text('|'),
//             TextButton(
//                 child: const Text(
//                   '로그아웃',
//                   style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
//                 ),
//                 onPressed: (){}
//                 ),

//           ]),
//         ],
//       ),
//     ),
//   );
// }
// }

// void showSnackBar(BuildContext context, Text text) {
//   final snackBar =
//       SnackBar(content: text, backgroundColor: const Color(0xffA1CBA1));

// // Find the ScaffoldMessenger in the widget tree
// // and use it to show a SnackBar.
//   ScaffoldMessenger.of(context).showSnackBar(snackBar);
// }

import 'package:flutter/material.dart';
import 'package:flutter_mycloset/user/pageapi.dart';
import 'package:provider/provider.dart';
import '../store/userstore.dart';

class NamPage2 extends StatefulWidget {
  const NamPage2({super.key, this.storage, this.nick});

  final storage;
  final nick;

  @override
  State<NamPage2> createState() => NamPage2State();
}

class NamPage2State extends State<NamPage2> {
  final PageApi pageapi = PageApi();

  int followerCount = 0;
  int follwingCount = 0;
  List<dynamic> savecloItem = [];
  List<dynamic> opencloItem = [];
  bool isfollowing = false;


  @override
  void initState() {
    super.initState();
    print(widget.nick);
    Future.delayed(Duration.zero, () async {
      final userStore = Provider.of<UserStore>(context, listen: false);
      final accessToken = userStore.accessToken;
      print(accessToken);

      final profile = await pageapi.getprofile(accessToken, widget.nick);
      print(profile); 
       if (profile != null){
        setState(() {
          followerCount = profile['body']['followerCount'];
          follwingCount = profile['body']['followingCount'];
          savecloItem = profile['body']['fashionList'];
          opencloItem = profile['body']['clothList'];
        });
          print(savecloItem);

       }

       final checkfollow = await pageapi.checkfollow(accessToken, widget.nick);
      print(checkfollow); 
       if (checkfollow != null){
        setState(() {
          isfollowing = checkfollow['body'];
        });
          print(isfollowing);

       }


    });
    // 초기화 작업 수행
  }

  // final savecloItem = {
  //   "list": [
  //     {"image": "Assets/Image/logo.png", "name": "깔쌈한코디1"},
  //     {"image": "Assets/Image/logo.png", "name": "깔쌈코디2"},
  //     {"image": "Assets/Image/logo.png", "name": "깔삼코디3"},
  //     {"image": "Assets/Image/logo.png", "name": "하늘하늘코디3"},
  //   ]
  // };
  // final opencloItem = {
  //   "list": [
  //     {"image": "Assets/Image/logo.png", "name": "깔쌈한코디1"},
  //     {"image": "Assets/Image/logo.png", "name": "깔쌈코디2"},
  //   ]
  // };
// BearList? bearList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5BEB5),
        toolbarHeight: 55,
        title: const Text(
          '프로필',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
        leading: const Text(''),
      ),
      body: 
      CustomScrollView(
        slivers:[
          SliverToBoxAdapter(
            child: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 35),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                        child: Text(
                          widget.nick,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFF5BEB5),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                        child: Text(
                          '님의 프로필',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: Row(
                      children: [
                        Text(
                          'Follower:'+ followerCount.toString(),
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          ' | Following:' + follwingCount.toString(),
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ],
            ),
            ),
          ),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            // onPressed: () {
                            //   final userStore = Provider.of<UserStore>(context, listen: false);
                            //   final accessToken = userStore.accessToken;
                            //   isfollowing? pageapi.unfollow(accessToken, widget.nick): pageapi.follow(accessToken, widget.nick);
                            //   setState(() {
                            //     isfollowing = !isfollowing;
                            //   });
                            //   },
                            onPressed: (){
                              Future.delayed(Duration.zero, () async {
      final userStore = Provider.of<UserStore>(context, listen: false);
      final accessToken = userStore.accessToken;
      print(accessToken);
      isfollowing? await pageapi.unfollow(accessToken, widget.nick): await pageapi.follow(accessToken, widget.nick);
                              setState(() {
                                isfollowing = !isfollowing;
                              });

      final profile = await pageapi.getprofile(accessToken, widget.nick);
      print(profile); 
       if (profile != null){
        setState(() {
          followerCount = profile['body']['followerCount'];
          follwingCount = profile['body']['followingCount'];
        });

       }

       final checkfollow = await pageapi.checkfollow(accessToken, widget.nick);
      print(checkfollow); 
       if (checkfollow != null){
        setState(() {
          isfollowing = checkfollow['body'];
        });
          print(isfollowing);

       }


    });
    // 초기화 작업 수행
  
                            },  
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(5.0), // 원하는 각진 정도로 설정
                              ),
                              // 다른 스타일 속성들
                            ),
                            child: Text(isfollowing ? 'Unfollow' : '🔥Follow🔥'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // 버튼 클릭 이벤트
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(5.0), // 원하는 각진 정도로 설정
                              ),
                              // 다른 스타일 속성들
                            ),
                            child: const Text('💌Message💌'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Expanded(
                  //   child:
                  Column(
                    children: [
                      SizedBox(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(30, 0, 0, 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                               Row(
                                children: [
                                  Text(
                                    '저장한 코디 ',
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    '(${savecloItem.length.toString()}건)',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              // GestureDetector(
                              //   onTap: () {
                              //     // 이동 로직을 추가하세요.
                              //   },
                              //   child: const Text('더보기'),
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
                  // Flexible(
                  //   flex: 3,
                  //   child: GridView.builder(
                  //     gridDelegate:
                  //         const SliverGridDelegateWithFixedCrossAxisCount(
                  //       crossAxisCount: 2, // Number of columns in the grid
                  //       crossAxisSpacing: 5.0, // Spacing between columns
                  //       mainAxisSpacing: 5.0, // Spacing between rows
                  //     ),
                  //     itemCount: savecloItem['list']?.length ?? 0,
                  //     itemBuilder: (BuildContext context, int index) {
                  //       final item = savecloItem['list']?[index];
                  //       if (item == null) {
                  //         return const SizedBox(); // 빈 위젯 반환
                  //       }
                  //       return GestureDetector(
                  //         onTap: () {
                  //           // 클릭이벤트
                  //         },
                  //         child: Card(
                  //           child: Column(
                  //             mainAxisAlignment: MainAxisAlignment.center,
                  //             children: <Widget>[
                  //               Image.asset(
                  //                   item["image"] ?? "Assets/Image/logo.png",
                  //                   height: 100,
                  //                   width: 100),
                  //               Text(
                  //                 item["name"] ?? "Unknown",
                  //                 style: const TextStyle(
                  //                   fontSize: 16,
                  //                   fontWeight: FontWeight.w600,
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       );
                  //     },
                  //   ),
                  // ),
                  SliverPadding(
              padding: const EdgeInsets.all(
                  20), // Use your desired padding value here.
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5.0,
                  mainAxisSpacing: 5.0,
                ),
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    final item = savecloItem?[index];
                    if (item == null) {
                      return const SizedBox(); // If the item is null, return an empty container
                    }
                    return GestureDetector(
                      onTap: () {
                        // 클릭 이벤트
                      },
                      child: Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.network(
                              item["imgUrl"] ?? "Unknown",
                              height: 100,
                              width: 100,
                            ),
                            Text(
                              item["name"] ?? "Unknown",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  childCount: savecloItem?.length ?? 0,
                ),
              ),
            ),
                  // Container(
                  //   margin: const EdgeInsets.only(top: 5),
                  //   child: Column(
                  //     children: [
                  //       SizedBox(
                  //         child: Padding(
                  //           padding: const EdgeInsets.fromLTRB(0, 0, 0, 2),
                  //           child: Row(
                  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //             crossAxisAlignment: CrossAxisAlignment.end,
                  //             children: [
                  //               const Row(
                  //                 children: [
                  //                   Text(
                  //                     '공개한 코디 ',
                  //                     style: TextStyle(
                  //                       fontSize: 17,
                  //                       fontWeight: FontWeight.w600,
                  //                     ),
                  //                   ),
                  //                   Text(
                  //                     '(5건)',
                  //                     style: TextStyle(
                  //                       fontSize: 12,
                  //                       fontWeight: FontWeight.w600,
                  //                     ),
                  //                   ),
                  //                 ],
                  //               ),
                  //               GestureDetector(
                  //                 onTap: () {
                  //                   // 이동 로직을 추가하세요.
                  //                 },
                  //                 child: const Text('더보기'),
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // Expanded(
                  //   child: GridView.builder(
                  //     gridDelegate:
                  //         const SliverGridDelegateWithFixedCrossAxisCount(
                  //       crossAxisCount: 2, // Number of columns in the grid
                  //       crossAxisSpacing: 5.0, // Spacing between columns
                  //       mainAxisSpacing: 5.0, // Spacing between rows
                  //     ),
                  //     itemCount: opencloItem['list']?.length ?? 0,
                  //     itemBuilder: (BuildContext context, int index) {
                  //       final item = opencloItem['list']?[index];
                  //       if (item == null) {
                  //         return const SizedBox(); // 빈 위젯 반환
                  //       }
                  //       return GestureDetector(
                  //         onTap: () {
                  //           // 클릭이벤트
                  //         },
                  //         child: Card(
                  //           child: Column(
                  //             mainAxisAlignment: MainAxisAlignment.center,
                  //             children: <Widget>[
                  //               Image.asset(
                  //                   item["image"] ?? "Assets/Image/logo.png",
                  //                   height: 100,
                  //                   width: 100),
                  //               Text(
                  //                 item["name"] ?? "Unknown",
                  //                 style: const TextStyle(
                  //                   fontSize: 16,
                  //                   fontWeight: FontWeight.w600,
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       );
                  //     },
                  //   ),
                  // ),
                  SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Expanded(
                  //   child:
                  Column(
                    children: [
                      SizedBox(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(30, 0, 30, 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '공개한 옷 ',
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    '(${opencloItem.length.toString()}건)',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              // GestureDetector(
                              //   onTap: () {
                              //     // 이동 로직을 추가하세요.
                              //   },
                              //   child: Text('더보기'),
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(
                  20), // Use your desired padding value here.
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5.0,
                  mainAxisSpacing: 5.0,
                ),
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    final item = opencloItem?[index];
                    if (item == null) {
                      return const SizedBox(); // If the item is null, return an empty container
                    }
                    return GestureDetector(
                      onTap: () {
                        // 클릭 이벤트
                      },
                      child: Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.network(
                              item["imgUrl"] ?? "Unknwon",
                              height: 100,
                              width: 100,
                            ),
                            Text(
                              item["name"] ?? "Unknown",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  childCount: opencloItem?.length ?? 0,
                ),
              ),
            ),
                ],
              ),
            );
  //         ],
  //       ),
  //     ),
  //     ],
  //   ));
  // }
}
}

void showSnackBar(BuildContext context, String text) {
  final snackBar = SnackBar(
    content: Text(text),
    backgroundColor: const Color(0xFFF5BEB5),
  );

  // ScaffoldMessenger.of(context).showSnackBar(snackBar);
}