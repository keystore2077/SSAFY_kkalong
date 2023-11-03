import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

void main() {
  runApp(
      MaterialApp(
          theme: ThemeData(),
          home: ClothInfo()
      )
  );
}

class ClothInfo extends StatefulWidget {
  const ClothInfo({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<ClothInfo> {
  final TextEditingController inputController = TextEditingController();
  final TextEditingController inputController2 = TextEditingController();
  List<Widget> tags = [];

  final List<String> closets = [
    '공주옷장',
    '할머니옷장',
    '아재옷장',
  ];
  String? selectedCloset;

  final List<String> sections = [
    '행거1',
    '행거2',
    '수납장1',
    '선반1',
    '선반2',
    '박스1',
  ];
  String? selectedSection;

  final List<String> clothes = [
    'Top',
    'Pants',
    'Outer',
    'Skirts',
    'Dress',
    'Etc',
  ];
  String? selectedCloth;

  void _addTag() {
    setState(() {
      String tagText = inputController2.text;

      if (tagText.isNotEmpty) {
        tags.add(
          Container(
            margin: EdgeInsets.all(8.0),
            padding: EdgeInsets.all(8.0),
            width: 70,
            decoration: BoxDecoration(
              border: Border.all(
                color: Color(0xFFF5BEB5),
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Center(child: Text(
              '#$tagText',
              style: TextStyle(
                color: Color(0xFFF5BEB5),
              ),
            )),
          ),
        );
        inputController2.clear();
      }
    });
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
            '나의 옷',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          elevation: 0,
          leading: const Text(''),
        ),
        body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
              padding: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Image.asset('assets/오레노턴완.jpg'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: SizedBox(
                      height: 50,
                      child: TextField(
                        controller: inputController,
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 30.0),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1.5,
                                    color: Color(0xFFF5BEB5))),
                            border: OutlineInputBorder(),
                            labelText: '옷이름',
                            focusColor: Color(0xFFF5BEB5)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
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
                            contentPadding: const EdgeInsets.symmetric(vertical: 16),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFF5BEB5)), // 포커스가 있을 때의 테두리 색상을 보라색으로 설정
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
                            //Do something when selected item is changed.
                          },
                          onSaved: (value) {
                            selectedCloset = value.toString();
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
                      Flexible(
                          fit: FlexFit.tight,
                          flex: 1,
                          child: SizedBox()),
                      Flexible(
                        fit: FlexFit.tight,
                        flex: 12,
                        child: DropdownButtonFormField2<String>(
                          isExpanded: true,
                          decoration: InputDecoration(
                            // Add Horizontal padding using menuItemStyleData.padding so it matches
                            // the menu padding when button's width is not specified.
                            contentPadding: const EdgeInsets.symmetric(vertical: 16),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFF5BEB5)), // 포커스가 있을 때의 테두리 색상을 보라색으로 설정
                            ),
                            // Add more decoration..
                          ),
                          hint: const Text(
                            '옷장 세부구역',
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
                              return '세부구역을 선택해주세요.';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            //Do something when selected item is changed.
                          },
                          onSaved: (value) {
                            selectedSection = value.toString();
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
                    height: 20,
                  ),
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
                        borderSide: BorderSide(color: Color(0xFFF5BEB5)), // 포커스가 있을 때의 테두리 색상을 보라색으로 설정
                      ),
                      // Add more decoration..
                    ),
                    hint: const Text(
                      '옷 종류',
                      style: TextStyle(fontSize: 14),
                    ),
                    items: clothes
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
                        return '옷 종류를 선택해주세요.';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      //Do something when selected item is changed.
                    },
                    onSaved: (value) {
                      selectedCloth = value.toString();
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
                            autofocus: true,
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
                              labelText: '기타 태그',
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
                              _addTag();
                              // 태그 추가 수행하는 코드 추가
                            },
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    5.0), // 각진 정도 조절
                              ),
                              side: const BorderSide(
                                color:
                                Color(0xFFF5BEB5), // 외곽선 색상 설정
                                width: 1, // 외곽선 두께 설정
                              ),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.fromLTRB(
                                  0.2, 0.2, 0.2, 0.2),
                              child: Text(
                                '태그 추가',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color:
                                  Color(0xFFF5BEB5), // 글자 색상 설정
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
                      children: [
                        ...tags,
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 60,
                    child: Padding(
                      padding:
                      const EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: ButtonTheme(
                          child: TextButton(
                              onPressed: () async {

                              },
                              style:
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
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
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