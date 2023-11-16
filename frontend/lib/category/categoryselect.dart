import 'package:flutter/material.dart';
import './categorycloth.dart';
import '../closet/clothcamera.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import '../store/userstore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class CategorySelect extends StatefulWidget {
  const CategorySelect({super.key, required this.category});

  final int category;

  @override
  State<CategorySelect> createState() => _CategorySelectState();
}

class _CategorySelectState extends State<CategorySelect> {
  final ScrollController scrollController = ScrollController();
  static final storage = FlutterSecureStorage();
  String? accessToken;

  late Future<dynamic> Function() childFunction;

  @override
  void initState() {
    super.initState();
    final userStore = Provider.of<UserStore>(context, listen: false);
    accessToken = userStore.accessToken;
    dioData(accessToken);
    closetData(accessToken);
  }

  final Dio dio = Dio(); // Dio HTTP 클라이언트 초기화
  final serverURL = 'http://k9c105.p.ssafy.io:8761';
  List<String> sort = ['Top', 'Pants', 'Outer', 'Skirt', 'Dress', 'Etc'];

  var flag = 0;
  var data = [];
  var data2 = [];
  var data3 = [];
  var movelist = [];

  List<String> closets = [];
  String? selectedCloset;

  List<String> sections = [];
  String? selectedSection;

  // Map<int, bool> itemCheckStates = {};

  // void _handleItem(Map<int, bool> states) {
  //   setState(() {
  //     itemCheckStates = states;
  //   });
  //   // 여기에서 itemCheckStates를 사용하여 데이터 생성 및 POST 요청
  // }

  Future<dynamic> dioData(token) async {
    try {
      final response =
          await dio.get('$serverURL/api/cloth/sort/${sort[widget.category]}',
              // queryParameters: {'userEmail': id}
              options: Options(
                headers: {
                  'Authorization': 'Bearer $token', // 토큰을 'Bearer' 스타일로 포함
                  // 다른 헤더도 필요한 경우 여기에 추가할 수 있습니다.
                },
              ));
      var result = response.data['body'];
      setState(() {
        data = result;
      });
      return response.data;
    } catch (e) {
      print(e);
      if (e is DioError) {
        // DioError를 확인
        _showErrorDialog('오류 발생 diodata select: ${e.response?.statusCode}');
      } else {
        _showErrorDialog('오류발생! diodata select');
      }
    }
  }

  Future<dynamic> closetData(token) async {
    try {
      final response = await dio.get('$serverURL/api/closet/list',
          // queryParameters: {'userEmail': id}
          options: Options(
            headers: {
              'Authorization': 'Bearer $token', // 토큰을 'Bearer' 스타일로 포함
              // 다른 헤더도 필요한 경우 여기에 추가할 수 있습니다.
            },
          ));
      var result = response.data['body'];
      var namesList = result.map((item) => item['name']).toList();
      List<String> strclosets = List<String>.from(namesList);
      setState(() {
        closets = strclosets;
        data2 = result;
      });
      print(data2);
      return response.data;
    } catch (e) {
      print(e);
      if (e is DioError) {
        // DioError를 확인
        _showErrorDialog('오류 발생: ${e.response?.statusCode}');
      } else {
        _showErrorDialog('오류발생!');
      }
    }
  }

  Future<dynamic> sectionData(token, closetSeq) async {
    try {
      final response = await dio.get('$serverURL/api/closet/list/$closetSeq',
          // queryParameters: {'userEmail': id}
          options: Options(
            headers: {
              'Authorization': 'Bearer $token', // 토큰을 'Bearer' 스타일로 포함
              // 다른 헤더도 필요한 경우 여기에 추가할 수 있습니다.
            },
          ));
      var result = response.data['body'];
      print(result);
      var namesList = result.map((item) => item['name']).toList();
      List<String> strsections = List<String>.from(namesList);
      print(strsections);
      setState(() {
        data3 = result;
        sections = strsections;
      });
      print(sections);
      return response.data;
    } catch (e) {
      print(e);
      if (e is DioError) {
        // DioError를 확인
        _showErrorDialog('오류 발생: ${e.response?.statusCode}');
      } else {
        _showErrorDialog('오류발생!');
      }
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('오류 발생!'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text('확인'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: DefaultTabController(
          length: 6,
          initialIndex: widget.category,
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
                  // collapsedHeight: 325,
                  // expandedHeight: 325,
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.local_shipping), // 두 번째 아이콘
                      onPressed: () {
                        if (flag == 0) {
                          setState(() {
                            flag = 1;
                          });
                        } else {
                          setState(() {
                            flag = 0;
                          });
                        }
                      },
                    ),
                    // IconButton(
                    //   icon: const Icon(Icons.delete_forever_outlined),
                    //   onPressed: () {},
                    // ),
                  ],
                ),
                SliverPersistentHeader(
                  delegate: MyDelegate(const TabBar(
                      labelColor: Colors.black,
                      indicatorWeight: 6,
                      unselectedLabelColor: Color(0xffD0D0D0),
                      labelPadding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                      labelStyle:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                      indicatorColor: Color.fromARGB(255, 68, 25, 80),
                      indicatorSize: TabBarIndicatorSize.label,
                      tabs: [
                        Text('Top'),
                        Text('Pants'),
                        Text('Outer'),
                        Text('Skirts'),
                        Text('Dress'),
                        Text('Etc'),
                      ])),
                  floating: true,
                  pinned: true,
                )
              ];
            },
            body: TabBarView(children: [
              CategoryClothList(
                category: 0,
                flag: flag,
                selectedSection: selectedSection,
                callbackFunction: (Future<dynamic> Function() callback) {
                  childFunction = callback;
                },
              ),
              CategoryClothList(
                category: 1,
                flag: flag,
                selectedSection: selectedSection,
                callbackFunction: (Future<dynamic> Function() callback) {
                  childFunction = callback;
                },
              ),
              CategoryClothList(
                category: 2,
                flag: flag,
                selectedSection: selectedSection,
                callbackFunction: (Future<dynamic> Function() callback) {
                  childFunction = callback;
                },
              ),
              CategoryClothList(
                category: 3,
                flag: flag,
                selectedSection: selectedSection,
                callbackFunction: (Future<dynamic> Function() callback) {
                  childFunction = callback;
                },
              ),
              CategoryClothList(
                category: 4,
                flag: flag,
                selectedSection: selectedSection,
                callbackFunction: (Future<dynamic> Function() callback) {
                  childFunction = callback;
                },
              ),
              CategoryClothList(
                category: 5,
                flag: flag,
                selectedSection: selectedSection,
                callbackFunction: (Future<dynamic> Function() callback) {
                  childFunction = callback;
                },
              ),
            ]),
          ),
        ),

        floatingActionButton: flag == 0
            ? ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ClothCamera()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[50],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0), // 원하는 각진 정도로 설정
                  ),
                  // 다른 스타일 속성들
                ),
                child: const Text(' + 옷등록'),
              )
            : ElevatedButton(
                onPressed: () async {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                            width: 300,
                            height: 300,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center, // 이 부분이 중요합니다
                                children: [
                                  Text(
                                    '옮길 구역을 선택하세요',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                            children: [
                        Flexible(
                          fit: FlexFit.tight,
                          flex: 8,
                          child: DropdownButtonFormField2<String>(
                            isExpanded: true,
                            decoration: InputDecoration(
                              // Add Horizontal padding using menuItemStyleData.padding so it matches
                              // the menu padding when button's width is not specified.
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 16),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(
                                        0xFFF5BEB5)), // 포커스가 있을 때의 테두리 색상을 보라색으로 설정
                              ),
                              // Add more decoration..
                            ),
                            hint: const Text(
                              '옷장',
                              style: TextStyle(fontSize: 14),
                            ),
                            items: closets
                                .map((item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ))
                                .toList(),
                            validator: (value) {
                              if (value == null) {
                                return '옷장을 선택해주세요.';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              var matchingItem = data2.firstWhere(
                                (item) => item['name'] == value,
                                orElse: () => null, // 일치하는 요소가 없는 경우 null을 반환합니다.
                              );
                              print(value);
                              print(matchingItem);
                              setState(() {
                                selectedCloset = matchingItem['seq'].toString();
                                selectedSection = '';
                                sectionData(accessToken, selectedCloset);
                                flag = 0;
                              });
                              //Do something when selected item is changed.
                            },
                            onSaved: (value) {
                              setState(() {
                                sectionData(accessToken, selectedCloset);
                              });
                            },
                            buttonStyleData: const ButtonStyleData(
                              padding: EdgeInsets.only(right: 8),
                            ),
                            iconStyleData: const IconStyleData(
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: Colors.black45,
                              ),
                              iconSize: 24,
                            ),
                            dropdownStyleData: DropdownStyleData(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              maxHeight: 200,
                            ),
                            menuItemStyleData: const MenuItemStyleData(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                            ),
                          ),
                        ),
                        Flexible(fit: FlexFit.tight, flex: 1, child: SizedBox()),
                        Flexible(
                          fit: FlexFit.tight,
                          flex: 12,
                          child: DropdownButtonFormField2<String>(
                            isExpanded: true,
                            decoration: InputDecoration(
                              // Add Horizontal padding using menuItemStyleData.padding so it matches
                              // the menu padding when button's width is not specified.
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 16),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(
                                        0xFFF5BEB5)), // 포커스가 있을 때의 테두리 색상을 보라색으로 설정
                              ),
                              // Add more decoration.. 
                            ),
                            hint: const Text(
                              '옷장 세부구역',
                              style: TextStyle(fontSize: 14),
                            ),
                            items: selectedCloset != null
                            ? sections.map((item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    )).toList()
                                : [],
                            validator: (value) {
                              if (value == null) {
                                return '세부구역을 선택해주세요.';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              //Do something when selected item is changed.
                              if (value != null && selectedCloset != null) {
                                var matchingItem = data3.firstWhere(
                                  (item) => item['name'] == value,
                                  orElse: () => null,
                                );
                                if (matchingItem != null) {
                                  setState(() {
                                    selectedSection = matchingItem['seq'].toString();
                                  });
                                }
                              }
                            },
                            onSaved: (value) {
                              // selectedSection = value.toString();
                            },
                            buttonStyleData: const ButtonStyleData(
                              padding: EdgeInsets.only(right: 8),
                            ),
                            iconStyleData: const IconStyleData(
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: Colors.black45,
                              ),
                              iconSize: 24,
                            ),
                            dropdownStyleData: DropdownStyleData(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              maxHeight: 200,
                            ),
                            menuItemStyleData: const MenuItemStyleData(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                            ),
                          ),
                        ),
                                            ],
                                          ),
                                          const SizedBox(
                                height: 15,
                              ),
                                          SizedBox(
                                      height: 40,
                                      width: 250,
                                      child: Row(
                                        children: [
                                          ButtonTheme(
                        child: TextButton(
                            onPressed: () async {
                              var result2 = await childFunction();
                              Navigator.pop(context);
                              showDialog(
                                    context: context,
                                    builder: (ctx) => AlertDialog(
                                      title: Text('이동 완료'),
                                      content: Text('옷 이동이 완료되었습니다!'),
                                      actions: <Widget>[
                                        TextButton(
                                          child: Text('확인'),
                                          onPressed: () {
                                            Navigator.of(ctx).pop();
                                          },
                                        )
                                      ],
                                    ),
                                  );
                            },
                            style:
                            // const ButtonStyle(
                            //     backgroundColor:
                            //         MaterialStatePropertyAll(
                            //             Color(0xFFF5BEB5))),
                            OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(
                                    5.0), // 원하는 각진 정도로 설정
                              ),
                              backgroundColor:
                              const Color(0xFFF5BEB5),
                            ),
                            child: const SizedBox(
                              height: 40,
                              width: 95,
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '확인',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ))),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          ButtonTheme(
                        child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style:
                            // const ButtonStyle(
                            //     backgroundColor:
                            //         MaterialStatePropertyAll(
                            //             Color(0xFFF5BEB5))),
                            OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(
                                    5.0), // 원하는 각진 정도로 설정
                              ),
                              backgroundColor:
                              const Color(0xFFF5BEB5),
                            ),
                            child: const SizedBox(
                              height: 40,
                              width: 95,
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '취소',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ))),
                                        ],
                                      ),
                                    ),
                            ]),
                          )
                        );}
                  );
                  // var result2 = await childFunction();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[50],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0), // 원하는 각진 정도로 설정
                  ),
                  // 다른 스타일 속성들
                ),
                child: const Text('옮기기'),
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
