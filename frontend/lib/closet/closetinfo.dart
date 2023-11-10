import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import '../store/userstore.dart';

class ClosetInfo extends StatefulWidget {
  const ClosetInfo({
    super.key,
    this.storage,
  });

  final storage;

  @override
  State<ClosetInfo> createState() => ClosetInfoState();
}

class ClosetInfoState extends State<ClosetInfo> {
  static final storage = FlutterSecureStorage();
  String? accessToken;

  @override
  void initState() {
    super.initState();
    final userStore = Provider.of<UserStore>(context, listen: false);
    accessToken = userStore.accessToken;
  }

  final Dio dio = Dio(); // Dio HTTP 클라이언트 초기화
  final serverURL = 'http://k9c105.p.ssafy.io:8761';
  final TextEditingController inputController = TextEditingController();
  final List<String> sections = ['행거', '수납장', '선반', '박스'];
  Map<String, List<String>> sectionItems = {
    '행거': [],
    '수납장': [],
    '선반': [],
    '박스': [],
  };

  // 항목을 추가하는 메소드
  void _addItem(String sectionType) {
    setState(() {
      int index = sectionItems[sectionType]!.length + 1;
      sectionItems[sectionType]!.add('$sectionType$index');
    });
  }

  // 항목을 제거하는 메소드
  void _removeItem(String sectionType) {
    setState(() {
      if (sectionItems[sectionType]!.isNotEmpty) {
        sectionItems[sectionType]!.removeLast();
      }
    });
  }

  //  데이터 보내는 함수
  var data = [];

  Future<dynamic> sendData(token) async {
    Response response;

    List<Map<String, dynamic>> sectionList = sectionItems.entries.map((entry) {
      // 각 섹션명과 그에 해당하는 아이템 목록을 사용해 리스트를 생성
      return {
        'sectionName': entry.key,
        'sort': entry.value.map((itemName) {
          return {
            'sortSeq': entry.value.indexOf(itemName), // 아이템의 인덱스를 sortSeq로 사용
            'sort': itemName,
            'sortGroup': {'sortGroupSeq': 2, 'groupName': 'section'}
          };
        }).toList()
      };
    }).toList();

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
            'closetName': inputController.text,
            'closetImageName': '',
            'closetSectionList': {'closetSectionList': sectionList},
          });
      return response.data;
    } catch (e) {
      print(e);
      if (e is DioError) {
        // DioError를 확인
        _showErrorDialog('오류 발생: ${e.response?.statusCode}\n더이상 평가할 사진이 없습니다!');
      } else {
        _showErrorDialog('더이상 평가할 사진이 없습니다!');
      }
    }
  }

  // sendData() async {
  //   var request = http.MultipartRequest(
  //       'POST', Uri.parse('https://example.com/api/closet'));

  //   // sectionItems 맵을 순회하면서 closetSectionList를 생성
  //   List<Map<String, dynamic>> sectionList = sectionItems.entries.map((entry) {
  //     // 각 섹션명과 그에 해당하는 아이템 목록을 사용해 리스트를 생성
  //     return {
  //       'sectionName': entry.key,
  //       'sort': entry.value.map((itemName) {
  //         return {
  //           'sortSeq': entry.value.indexOf(itemName), // 아이템의 인덱스를 sortSeq로 사용
  //           'sort': itemName,
  //           'sortGroup': {'sortGroupSeq': 2, 'groupName': 'section'}
  //         };
  //       }).toList()
  //     };
  //   }).toList();

  //   request.fields['closetName'] = inputController.text;
  //   request.fields['closetImageName'] = '';
  //   request.fields['closetSectionList'] =
  //       jsonEncode({'closetSectionList': sectionList});

  // 요청 전송
  // var response = await request.send();

  //   if (response.statusCode == 200) {
  //     var responseData = await response.stream.toBytes();
  //     var responseString = String.fromCharCodes(responseData);
  //     var result = jsonDecode(responseString);
  //     setState(() {
  //       data = result;
  //     });
  //     print(data);
  //   } else {
  //     _showErrorDialog('오류 발생: ${response.statusCode}');
  //   }
  // }

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

  // 리스트에 저장된 항목을 바탕으로 위젯을 생성하는 함수
  List<Widget> _buildItemList(String sectionType) {
    return sectionItems[sectionType]!
        .map(
          (item) => GestureDetector(
            onTap: () => _removeItem(sectionType),
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xFFF5BEB5),
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Center(
                child: Text(
                  '$item X',
                  style: TextStyle(
                    color: Color(0xFFF5BEB5),
                  ),
                ),
              ),
            ),
          ),
        )
        .toList();
  }

// 선반항목 쁘라스버튼
  Widget _buildSection(String section) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        children: [
          ElevatedButton(
            onPressed: () => _addItem(section),
            child: Text('$section+'),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _buildItemList(section),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5BEB5),
        toolbarHeight: 55,
        title: const Text(
          '옷장등록',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
        leading: const Text(''),
      ),
      body: Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Center(
                child: Image.asset('assets/오레노턴완.jpg'),
              ),
              Center(
                child: SizedBox(
                  height: 50,
                  width: 300,
                  child: TextField(
                    controller: inputController,
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 30.0),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1.5, color: Color(0xFFF5BEB5))),
                        border: OutlineInputBorder(),
                        labelText: '옷장에 이름을 지어주세요!',
                        focusColor: Color(0xFFF5BEB5)),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:
                    sections.map((section) => _buildSection(section)).toList(),
              ),
              SizedBox(
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: ButtonTheme(
                      child: TextButton(
                          onPressed: () async {},
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(5.0), // 원하는 각진 정도로 설정
                            ),
                            backgroundColor: const Color(0xFFF5BEB5),
                          ),
                          child: const SizedBox(
                            height: 40,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '등록하기',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ))),
                ),
              ),
            ],
          )),
    );
  }
}
