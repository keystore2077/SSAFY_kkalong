import 'package:flutter/material.dart';
import 'package:flutter_mycloset/closet/clothinfo.dart';
import 'package:image_picker/image_picker.dart';
import './categorycloth.dart';
import '../closet/closetcloth.dart';
import '../closet/clothcamera.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import '../store/userstore.dart';

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

  @override
  void initState() {
    super.initState();
    final userStore = Provider.of<UserStore>(context, listen: false);
    accessToken = userStore.accessToken;
    dioData(accessToken);
  }

  final Dio dio = Dio(); // Dio HTTP 클라이언트 초기화
  final serverURL = 'http://k9c105.p.ssafy.io:8761';
  List<String> sort = ['Top', 'Pants', 'Outer', 'Skirt', 'Dress', 'Etc'];

  var flag = 0;
  var data = [];

  Map<int, bool> itemCheckStates = {};

  void _handleItem(Map<int, bool> states) {
    setState(() {
      itemCheckStates = states;
    });
    // 여기에서 itemCheckStates를 사용하여 데이터 생성 및 POST 요청
  }

  Future<dynamic> dioData(token) async {
    try {
      final response =
          await dio.get('$serverURL/api/cloth/sort/${widget.category}',
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
        _showErrorDialog('오류 발생: ${e.response?.statusCode}');
      } else {
        _showErrorDialog('오류발생!');
      }
    }
  }

  Future<dynamic> clothesmove(token) async {
    var movelist = List.generate(data.length, (index) => data[index]['name']);
    // var filteredList = data.where((item) {
    //   // 조건문을 여기에 작성합니다.
    //   // 예시: item의 'type' 필드가 특정 값과 일치하는 경우만 선택
    //   return item['type'] == '특정값';
    // }).map((item) {
    //   // 필터링된 각 요소에 대해 수행할 작업을 정의합니다.
    //   // 예시: 각 요소의 'name' 필드 값을 새 리스트에 추가
    //   return item['name'];
    // }).toList();

    print(movelist);
    try {
      final response = await dio.put('$serverURL/api/cloth/input/section',
          data: {
            "sectionSeq": movelist,
            "clothSeqList": movelist,
          },
          options: Options(
            headers: {
              'Authorization': 'Bearer $token', // 토큰을 'Bearer' 스타일로 포함
              // 다른 헤더도 필요한 경우 여기에 추가할 수 있습니다.
            },
          ));
      print('유저 정보 수정 ${response.data}');
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
                    IconButton(
                      icon: const Icon(Icons.delete_forever_outlined),
                      onPressed: () {},
                    ),
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
              CategoryClothList(category: 0, flag: flag, onStateChanged: _handleItem),
              CategoryClothList(category: 1, flag: flag, onStateChanged: _handleItem),
              CategoryClothList(category: 2, flag: flag, onStateChanged: _handleItem),
              CategoryClothList(category: 3, flag: flag, onStateChanged: _handleItem),
              CategoryClothList(category: 4, flag: flag, onStateChanged: _handleItem),
              CategoryClothList(category: 5, flag: flag, onStateChanged: _handleItem),
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
                onPressed: () {
                  // 옮기기 로직
                  // clothesmove(accessToken);
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
        // floatingActionButton: ElevatedButton(
        //   onPressed: () {
        //     print('여기까지 잘왔니??????');
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(builder: (context) => const ClothCamera()),
        //     );
        //   },
        //   style: ElevatedButton.styleFrom(
        //     backgroundColor: Colors.grey[50],
        //     shape: RoundedRectangleBorder(
        //       borderRadius: BorderRadius.circular(20.0), // 원하는 각진 정도로 설정
        //     ),
        //     // 다른 스타일 속성들
        //   ),
        //   child: const Text(' + 옷등록'),
        // ),
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
