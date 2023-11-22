import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_mycloset/user/nampage%20copy.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import '../store/userstore.dart';

class Swipe extends StatefulWidget {
  const Swipe({
    super.key,
    this.storage,
  });

  final storage;

  @override
  State<Swipe> createState() => SwipeState();
}

class SwipeState extends State<Swipe> {
  static final storage = FlutterSecureStorage();
  String? accessToken;

  @override
  void initState() {
    super.initState();
    final userStore = Provider.of<UserStore>(context, listen: false);
    accessToken = userStore.accessToken;
    dioData(accessToken);

    // 5초 후에 투명도를 0으로 변경
    // Future.delayed(Duration(seconds: 5), () {
    //   setState(() {
    //     opacity = 0.0;
    //   });
    // });

    // 5초 후에 이미지를 숨기고 카드 크기 변경
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        imageOpacity = 0.0;
        textOpacity = 1.0;
      });
    });

    Future.delayed(Duration(seconds: 4), () {
      setState(() {
        showImage = false;  // 이미지 숨기기
        showText = true;
        cardWidth = 300;    // 카드 너비 증가
        cardHeight = 400;   // 카드 높이 증가
      });
    });
  }

  final TextEditingController inputController = TextEditingController();
  final Dio dio = Dio(); // Dio HTTP 클라이언트 초기화
  final serverURL = 'http://k9c105.p.ssafy.io:8761';

  var data = [];
  var imgUrl =
      'https://media.istockphoto.com/id/1330667863/ko/%EB%B2%A1%ED%84%B0/%EA%B0%90%EC%82%AC%ED%95%A9%EB%8B%88%EB%8B%A4-%EC%9D%8C%EC%84%B1-%EA%B1%B0%ED%92%88-%EA%B7%B8%EB%A6%BC.jpg?s=612x612&w=0&k=20&c=bK1rF2rhz15ccP3yDVQFRIBxQFJjbLGx-5i-ur6kWNQ=';
  var fashionSeq = 0;
  var fashionName = '';
  var nickName = '아무개';

  // double opacity = 1.0; // 초기 투명도는 1.0 (완전 불투명)
  double imageOpacity = 1.0;
  double textOpacity = 0.0;
  bool showImage = true;
  bool showText = false;
  double cardWidth = 200;
  double cardHeight = 300;

  Future<dynamic> dioData(token) async {
    try {
      final response = await dio.get('$serverURL/api/assess',
          // queryParameters: {'userEmail': id}
          options: Options(
            headers: {
              'Authorization': 'Bearer $token', // 토큰을 'Bearer' 스타일로 포함
              // 다른 헤더도 필요한 경우 여기에 추가할 수 있습니다.
            },
          ));
      var result = response.data['body'][0];
      setState(() {
        imgUrl = result['imgUrl'];
        fashionSeq = result['fashionSeq'];
        fashionName = result['fashionName'];
        nickName = result['memberNickName'];
      });
      print(imgUrl);
      return response.data;
    } catch (e) {
      print(e);
      if (e is DioError) {
        // DioError를 확인
        // _showErrorDialog('오류 발생: ${e.response?.statusCode}\n더이상 평가할 사진이 없습니다!');
      } else {
        _showErrorDialog('더이상 평가할 사진이 없습니다!');
      }
    }
  }

  Future<dynamic> likeData(token) async {
    Response response;
    try {
      // final deviceToken = getMyDeviceToken();
      final response = await dio.post('$serverURL/api/assess',
          options: Options(
            headers: {
              'Authorization': 'Bearer $token', // 토큰을 'Bearer' 스타일로 포함
              // 다른 헤더도 필요한 경우 여기에 추가할 수 있습니다.
            },
          ),
          data: {
            'fashionSeq': fashionSeq,
            'like': true,
          });
      return response.data;
    } catch (e) {
      print(e);
      if (e is DioError) {
        // DioError를 확인
        // _showErrorDialog('오류 발생: ${e.response?.statusCode}\n더이상 평가할 사진이 없습니다!');
      } else {
        _showErrorDialog('더이상 평가할 사진이 없습니다!');
      }
    }
  }

  Future<dynamic> hateData(token) async {
    Response response;
    try {
      // final deviceToken = getMyDeviceToken();
      final response = await dio.post('$serverURL/api/assess',
          options: Options(
            headers: {
              'Authorization': 'Bearer $token', // 토큰을 'Bearer' 스타일로 포함
              // 다른 헤더도 필요한 경우 여기에 추가할 수 있습니다.
            },
          ),
          data: {
            'fashionSeq': fashionSeq,
            'like': false,
          });
      return response.data;
    } catch (e) {
      print(e);
      if (e is DioError) {
        // DioError를 확인
        // _showErrorDialog('오류 발생: ${e.response?.statusCode}\n더이상 평가할 사진이 없습니다!');
      } else {
        _showErrorDialog('더이상 평가할 사진이 없습니다!');
      }
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          '평가 완료 ✨',
          textAlign: TextAlign.center, // 타이틀 중간 정렬
        ),
        content: Text(
          message,
          textAlign: TextAlign.center, // 내용 중간 정렬
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center, // 버튼 중앙 정렬
            children: [
              TextButton(
                child: Text('확인'),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          const SliverAppBar(
            backgroundColor: Color(0xFFF5BEB5),
            expandedHeight: 55.0,
            floating: true,
            pinned: true,
            title: Text(
              '코디 평가',
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
            elevation: 0,
            leading: Text(''),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            Container(
              padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NamPage2(nick: nickName)),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                      child: Text(
                        nickName,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFF5BEB5),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: Text(
                      '님의 코디',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ])),
          SliverPadding(
              padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
              sliver: SliverToBoxAdapter(
                child: Container(
                    padding: const EdgeInsets.fromLTRB(30, 25, 30, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Center(
                          child: AnimatedContainer(
                            duration: Duration(seconds: 1),
                            width: cardWidth,
                            height: cardHeight,
                            child: Center(
                              child: Dismissible(
                                key: Key(imgUrl),
                                onDismissed: (direction) {
                                  final previousImgUrl = imgUrl;
                                  // 오른쪽에서 왼쪽으로 스와이프한 경우 싫어요
                                  if (direction ==
                                      DismissDirection.endToStart) {
                                    hateData(accessToken);
                                  }
                                  // 왼쪽에서 오른쪽으로 스와이프한 경우 좋아요
                                  else if (direction ==
                                      DismissDirection.startToEnd) {
                                    likeData(accessToken);
                                  }
                                  dioData(accessToken);
                                },
                                child: Card(
                                  child: Container(
                                    // height: 300,
                                    // width: 200,
                                    alignment: Alignment.center,
                                    child: Image.network(
                                      imgUrl,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        if (showImage) // 이미지가 표시되어야 하는 경우에만 표시
                        AnimatedOpacity(
                          opacity: imageOpacity,
                          duration: Duration(seconds: 1),
                          child: Center(child: Image.asset('Assets/Image/swipe.png')),
                        ),
                        if (showText)
                        AnimatedOpacity(
                          opacity: textOpacity,
                          duration: Duration(seconds: 1),
                          child: Center(child: Text(
                        '스와이프하여 평가해주세요!',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFF5BEB5),
                        ),
                      )),
                        ),
                      ],
                    )),
              )),
        ],
      ),
    );
  }
}
