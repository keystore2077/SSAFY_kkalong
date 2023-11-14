import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_mycloset/main.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import '../store/userstore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:http_parser/http_parser.dart'; // MediaType을 사용하기 위해 추가

class ClosetChange extends StatefulWidget {
  const ClosetChange({
    super.key,
    this.storage,
    required this.closetSeq,
  });

  final storage;
  final closetSeq;

  @override
  State<ClosetChange> createState() => ClosetChangeState();
}

class ClosetChangeState extends State<ClosetChange> {
  static final storage = FlutterSecureStorage();
  String? accessToken;

  final Dio dio = Dio(); // Dio HTTP 클라이언트 초기화
  final serverURL = 'http://k9c105.p.ssafy.io:8761';
  // final serverURL = 'http://192.168.100.37:8761';
  // 옷장이름
  TextEditingController? inputController;
  // 구역이름
  final TextEditingController inputController2 = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Future.delayed 사용하여 컨텍스트가 완전히 구성된 후 데이터를 가져옴
    Future.delayed(Duration.zero, () async {
      final userStore = Provider.of<UserStore>(context, listen: false);
      accessToken = userStore.accessToken;
      dioData(accessToken).then((_) {
      // dioData가 완료된 후에 inputController를 초기화
      setState(() {
        inputController = TextEditingController(text: closetName);
      });
    });
    });

  }


  final List<String> sections = ['행거', '수납장', '선반', '박스'];
  String? selectedSection;
  Map<String, List<String>> sectionItems = {
    '행거': [],
    '수납장': [],
    '선반': [],
    '박스': [],
  };
  var rmvSections = [];
  var addSections = [];
  var addSorts = [];
  var updateSections = [0];

  var tags2 = [];

  // 항목을 추가하는 메소드
  void _addItem() {
    setState(() {
      String tagText = inputController2.text;

      if (tagText.isNotEmpty) {
        setState(() {
          addSections.add(tagText);
          addSorts.add(selectedSection);
        });
        inputController2.clear();
      }
    });
  }

  // 항목을 제거하는 메소드
  void _removeItem(int index) {
    setState(() {
      if (addSections.isNotEmpty) {
        addSections.removeAt(index);
        addSorts.removeAt(index);
      }
    });
  }

  void _removeItem2(int index) {
    if (sections2.isNotEmpty) {
      setState(() {
        rmvSections.add(sections2[index]);
        sections2.removeAt(index);
        print(rmvSections);
      });
    }
    ;
  }

  var sections2 = [];
  var imgUrl =
      'https://mblogthumb-phinf.pstatic.net/MjAxODEyMTlfMTcz/MDAxNTQ1MjA0MTk4NDQy.-lCTSpFhyK1yb6_e8FaFoZwZmMb_-rRZ04AnFmNijB4g.ID8x5cmkX8obTOxG8yoq39JRURXvKBPjbxY_z5M90bkg.JPEG.cine_play/707211_1532672215.jpg?type=w800';
  // var imgUrl = '';
  var closetName = '';
  var data = {};
  var imgString = '';

// 초기데이터 가져오는 함수
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
        sections2 = result['closetSectionList'];
        imgUrl = result['closetPictureUrl'];
        closetName = result['closetName'];
        inputController = TextEditingController(text: closetName);
      });
      print(result);
      print('diodata');
      getData(accessToken);
      return response.data;
    } catch (e) {
      print(e);
      if (e is DioError) {
        // DioError를 확인
        _showErrorDialog('오류 발생: ${e.response?.statusCode}');
      } else {
        _showErrorDialog('오류발생! diodata');
      }
    }
  }

// 이미지 가져오는 함수
  Future<dynamic> getData(token) async {
    try {
      final response = await dio.get(imgUrl,
          options: Options(responseType: ResponseType.bytes));
      var result = response.data;
      setState(() {
        imgString = base64Encode(response.data);
      });
      // print(result);
      return response.data;
    } catch (e) {
      print(e);
      if (e is DioError) {
        // DioError를 확인
        _showErrorDialog('오류 발생: ${e.response?.statusCode}');
      } else {
        _showErrorDialog('오류발생! img');
        // print(imgUrl);
      }
    }
  }

  //  데이터 보내는 함수
  var data2 = [];

  Future<dynamic> sendData(token) async {
    Response response;

    // 기존의 sectionItems에서 FormData에 추가할 각 항목을 생성
    List<MapEntry<String, String>> closetSectionUpdateListEntries = [];
    for (var i = 0; i < updateSections.length; i++) {
      var itemName = updateSections[i];
      closetSectionUpdateListEntries
          .add(MapEntry('closetSectionUpdateList[$i].sectionSeq', '0'));
      closetSectionUpdateListEntries
          .add(MapEntry('closetSectionUpdateList[$i].sectionName', ''));
      closetSectionUpdateListEntries
          .add(MapEntry('closetSectionUpdateList[$i].sort', ''));
    }

    List<MapEntry<String, String>> closetSectionAddListEntries = [];
    for (var i = 0; i < addSections.length; i++) {
      var itemName = addSections[i];
      var itemSort = addSorts[i];
      closetSectionAddListEntries
          .add(MapEntry('closetSectionAddList[$i].sectionName', itemName));
      closetSectionAddListEntries
          .add(MapEntry('closetSectionAddList[$i].sort', itemSort));
    }

    // delete
    List<MapEntry<String, String>> closetSectionDeleteListEntries = [];
    for (var i = 0; i < rmvSections.length; i++) {
      var itemName = rmvSections[i]['sectionSeq'].toString();
      closetSectionDeleteListEntries
          .add(MapEntry('closetSectionDeleteList[$i]', itemName));
    }

    // closetSectionList를 JSON 문자열로 변환
    // String closetSectionListJson = jsonEncode(sectionList);

    // 파일을 MultipartFile 형식으로 변환
    // var file = await MultipartFile.fromFile(widget.image.path,
    //     filename: widget.image.name);

    MultipartFile multipartFile = MultipartFile.fromString(imgString,
        filename: 'image.jpg', contentType: MediaType('image', 'jpeg'));

    // JSON 데이터와 파일을 포함하는 FormData 생성
    FormData formData = FormData();

    // 파일 추가
    // formData.files.add(MapEntry('file', multipartFile));
    formData.fields.add(MapEntry('closetSeq', widget.closetSeq.toString()));
    formData.fields.add(MapEntry('closetName', inputController?.text ?? ''));
    // formData.fields.addAll(closetSectionUpdateListEntries);
    formData.fields.addAll(closetSectionAddListEntries);
    formData.fields.addAll(closetSectionDeleteListEntries);

    try {
      // final deviceToken = getMyDeviceToken();
      final response = await dio.put('$serverURL/api/closet',
          options: Options(
            headers: {
              'Authorization': 'Bearer $token', // 토큰을 'Bearer' 스타일로 포함
              // 다른 헤더도 필요한 경우 여기에 추가할 수 있습니다.
            },
          ),
          data: formData);
      // print("Response: ${response.data}");
      print(formData.fields);
      print('해치웠나?');
      print(response);
      return response.data;
    } catch (e) {
      print(e);
      if (e is DioError) {
        // DioError를 확인
        _showErrorDialog('오류 발생: ${e.response?.statusCode}');
        print(formData.fields);
        // print(closetSectionListJson);
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

  // 리스트에 저장된 항목을 바탕으로 위젯을 생성하는 함수
  List<Widget> _buildItemList() {
    return addSections.asMap().entries.map((entry) {
      int index = entry.key;
      String tag = entry.value;

      return GestureDetector(
        onTap: () => _removeItem(index),
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
              '#$tag X',
              style: TextStyle(
                color: Color(0xFFF5BEB5),
              ),
            ),
          ),
        ),
      );
    }).toList();
  }

  //원래 있던 태그들
  List<Widget> _buildItemList2() {
    return sections2.asMap().entries.map((entry) {
      int index = entry.key;
      String tag = entry.value['sectionName'];

      return GestureDetector(
        onTap: () => _removeItem2(index),
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
              '#$tag X',
              style: TextStyle(
                color: Color(0xFFF5BEB5),
              ),
            ),
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFF5BEB5),
          toolbarHeight: 55,
          title: const Text(
            '옷장 수정',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          elevation: 0,
          leading: const Text(''),
        ),
        body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Image.network(
                      imgUrl,
                      width: 200,
                      height: 300,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: SizedBox(
                      height: 50,
                      child: TextField(
                        controller: inputController,
                        autofocus: true,
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 30.0),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1.5, color: Color(0xFFF5BEB5))),
                            border: OutlineInputBorder(),
                            labelText: '옷장의 이름을 바꿔보세요!',
                            focusColor: Color(0xFFF5BEB5)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _buildItemList2(),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  // 새로운 구역 추가--------------------------
                  DropdownButtonFormField2<String>(
                    isExpanded: true,
                    decoration: InputDecoration(
                      // Add Horizontal padding using menuItemStyleData.padding so it matches
                      // the menu padding when button's width is not specified.
                      contentPadding: const EdgeInsets.symmetric(vertical: 16),
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
                      '구역 종류',
                      style: TextStyle(fontSize: 14),
                    ),
                    items: sections
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
                        return '세부 구역을 선택해주세요.';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      //Do something when selected item is changed.
                      setState(() {
                        selectedSection = value.toString();
                      });
                    },
                    onSaved: (value) {
                      // selectedCloth = value.toString();
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
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: inputController2,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 16.0,
                                horizontal: 40.0,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1.5,
                                  color: Color(0xFFF5BEB5),
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(),
                              ),
                              labelText: '구역 이름',
                              focusColor: Color(0xFFF5BEB5),
                            ),
                            keyboardType: TextInputType.text,
                            textAlign: TextAlign.start,
                          ),
                        ),
                        const SizedBox(
                          width: 20, // 중복 확인 버튼과 아이디 입력창 사이의 간격 설정
                        ),
                        SizedBox(
                          width: 90,
                          height: 50,
                          child: OutlinedButton(
                            onPressed: () {
                              _addItem();
                              // 태그 추가 수행하는 코드 추가
                              // 종류도 추가
                            },
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(5.0), // 각진 정도 조절
                              ),
                              side: const BorderSide(
                                color: Color(0xFFF5BEB5), // 외곽선 색상 설정
                                width: 1, // 외곽선 두께 설정
                              ),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.fromLTRB(0.2, 0.2, 0.2, 0.2),
                              child: Text(
                                '추가',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFFF5BEB5), // 글자 색상 설정
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _buildItemList(),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 60,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: ButtonTheme(
                          child: TextButton(
                              onPressed: () async {
                                sendData(accessToken);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Main()),
                                );
                              },
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      5.0), // 원하는 각진 정도로 설정
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
        ),
      ),
    );
  }
}
