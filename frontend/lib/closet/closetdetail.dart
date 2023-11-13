import 'package:flutter/material.dart';
import 'package:flutter_mycloset/closet/closetchange.dart';
import 'package:flutter_mycloset/main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_mycloset/user/mypage.dart';
import 'package:flutter_mycloset/user/nampage.dart';
import '../closet/closetcloth.dart';
import './clothcamera.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import '../store/userstore.dart';

class ClosetDetail extends StatefulWidget {
  const ClosetDetail({super.key, this.storage, required this.closetSeq});

  final storage;
  final closetSeq;

  @override
  State<ClosetDetail> createState() => _ClosetDetailState();
}

class _ClosetDetailState extends State<ClosetDetail> {
  final ScrollController scrollController = ScrollController();
  static final storage = FlutterSecureStorage();
  String? accessToken;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      final userStore = Provider.of<UserStore>(context, listen: false);
      final accessToken = userStore.accessToken;
      dioData(accessToken);
    });
  }

  final Dio dio = Dio(); // Dio HTTP 클라이언트 초기화
  final serverURL = 'http://k9c105.p.ssafy.io:8761';

  var data = {};
  var sections = [];
  var imgUrl =
      'https://mblogthumb-phinf.pstatic.net/MjAxODEyMTlfMTcz/MDAxNTQ1MjA0MTk4NDQy.-lCTSpFhyK1yb6_e8FaFoZwZmMb_-rRZ04AnFmNijB4g.ID8x5cmkX8obTOxG8yoq39JRURXvKBPjbxY_z5M90bkg.JPEG.cine_play/707211_1532672215.jpg?type=w800';
  // var imgUrl = '';
  var closetName = '';

  Future<dynamic> dioData(token) async {
    try {
      final response =
          await dio.get('$serverURL/api/closet/${widget.closetSeq}',
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
        sections = result['closetSectionList'];
        imgUrl = result['closetPictureUrl'];
        closetName = result['closetName'];
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

  Future<dynamic> deleteCloset(token) async {
    try {
      final userStore = Provider.of<UserStore>(context, listen: false);
      final accessToken2 = userStore.accessToken;

      final response = await dio.put('$serverURL/api/closet/${widget.closetSeq}',
          // queryParameters: {'userEmail': id}
          options: Options(
            headers: {
              'Authorization': 'Bearer $accessToken2', // 토큰을 'Bearer' 스타일로 포함
              // 다른 헤더도 필요한 경우 여기에 추가할 수 있습니다.
            },
          ));
      print('옷삭제 api ${response.data}');
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: sections.isNotEmpty ? 
          DefaultTabController(
            length: sections.length,
            child: NestedScrollView(
              controller: scrollController,
              headerSliverBuilder: (context, isScrolled) {
                return [
                  SliverAppBar(
                    title: Text(
                      closetName,
                      style: TextStyle(color: Colors.white), // 텍스트의 색상을 흰색으로 설정
                    ),
                    centerTitle: true,
                    backgroundColor: const Color.fromARGB(255, 246, 212, 206),
                    iconTheme: const IconThemeData(color: Colors.black),
                    collapsedHeight: 325,
                    expandedHeight: 325,
                    flexibleSpace: Image.network(
                      imgUrl,
                    ),
                    actions: [
                      IconButton(
                        icon: const Icon(Icons.edit_outlined), // 두 번째 아이콘
                        onPressed: () {
                          // 두 번째 아이콘을 클릭했을 때 실행할 작업
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ClosetChange(closetSeq: widget.closetSeq)),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_forever_outlined),
                        onPressed: () {
                          deleteCloset(accessToken);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Main()),
                          );
                        },
                      ),
                    ],
                  ),
                  SliverPersistentHeader(
                    delegate: MyDelegate(TabBar(
                      labelColor: Colors.black,
                      indicatorWeight: 4,
                      unselectedLabelColor: Color(0xffD0D0D0),
                      labelPadding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                      labelStyle:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                      indicatorColor: Color.fromARGB(255, 68, 25, 80),
                      indicatorSize: TabBarIndicatorSize.label,
                      tabs: sections
                          .map((sectionTitle) =>
                              Text(sectionTitle['sectionName']))
                          .toList(),
                    )),
                    floating: true,
                    pinned: true,
                  )
                ];
              },
              body: TabBarView(
                children: sections.map((section) {
                  return ClosetClothList(sectionSeq: section['sectionSeq']);
                }).toList(),
              ),
            ))
            : Center(child: CircularProgressIndicator()),


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
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ClothCamera()),
            );
          },
          // onPressed: () async {
          //   final ImagePicker picker = ImagePicker();
          //   final XFile? image =
          //       await picker.pickImage(source: ImageSource.camera);

          //   if (image != null) {
          //     // 이미지가 선택되면 처리할 작업을 여기에 추가합니다.
          //     // image.path를 사용하여 이미지 파일에 접근할 수 있습니다.
          //   } else {
          //     // 이미지가 선택되지 않았을 때 처리할 작업을 추가합니다.
          //   }
          // },
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
