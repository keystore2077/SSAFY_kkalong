import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(
      MaterialApp(
          theme: ThemeData(),
          home: ClosetInfo()
      )
  );
}

class ClosetInfo extends StatefulWidget {
  const ClosetInfo({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<ClosetInfo> {
  final TextEditingController inputController = TextEditingController();
  final List<String> sections = ['행거', '수납장', '선반', '박스'];
  List<Widget> hangars = [];
  List<Widget> drawers = [];
  List<Widget> shelves = [];
  List<Widget> boxes = [];

  getData() async {
    var result = await http.get(Uri.parse('https://codingapple1.github.io/app/data.json'));
    print(result.body);
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  void _addHangar() {
    setState(() {
      int index = hangars.length + 1;
      hangars.add(
        GestureDetector(
          onTap: _removeHangar,
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
            child: Center(child: Text(
              '행거$index X',
              style: TextStyle(
                color: Color(0xFFF5BEB5),
              ),
            )),
          ),
        ),
      );
    });
  }

  void _removeHangar() {
    setState(() {
      if (hangars.isNotEmpty) {
        hangars.removeLast();
      }
    });
  }

  void _addDrawer() {
    setState(() {
      int index = drawers.length + 1;
      drawers.add(
        GestureDetector(
          onTap: _removeDrawer,
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
            child: Center(child: Text(
              '수납장$index X',
              style: TextStyle(
                color: Color(0xFFF5BEB5),
              ),
            )),
          ),
        ),
      );
    });
  }

  void _removeDrawer() {
    setState(() {
      if (drawers.isNotEmpty) {
        drawers.removeLast();
      }
    });
  }

  void _addShelf() {
    setState(() {
      int index = shelves.length + 1;
      shelves.add(
        GestureDetector(
          onTap: _removeShelf,
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
            child: Center(child: Text(
              '선반$index X',
              style: TextStyle(
                color: Color(0xFFF5BEB5),
              ),
            )),
          ),
        ),
      );
    });
  }

  void _removeShelf() {
    setState(() {
      if (shelves.isNotEmpty) {
        shelves.removeLast();
      }
    });
  }

  void _addBox() {
    setState(() {
      int index = boxes.length + 1;
      boxes.add(
        GestureDetector(
          onTap: _removeBox,
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
            child: Center(child: Text(
              '박스$index X',
              style: TextStyle(
                color: Color(0xFFF5BEB5),
              ),
            )),
          ),
        ),
      );
    });
  }

  void _removeBox() {
    setState(() {
      if (boxes.isNotEmpty) {
        boxes.removeLast();
      }
    });
  }

  List<Widget> _getListForSection(String section) {
    switch (section) {
      case '행거':
        return hangars;
      case '수납장':
        return drawers;
      case '선반':
        return shelves;
      case '박스':
        return boxes;
      default:
        return [];
    }
  }

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
            onPressed: () {
              // 해당 섹션의 추가 메소드를 호출
              switch (section) {
                case '행거':
                  _addHangar();
                  break;
                case '수납장':
                  _addDrawer();
                  break;
                case '선반':
                  _addShelf();
                  break;
                case '박스':
                  _addBox();
                  break;
                default:
                  break;
              }
            },
            child: Text('$section+'),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _getListForSection(section),
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
                                width: 1.5,
                                color: Color(0xFFF5BEB5))),
                        border: OutlineInputBorder(),
                        labelText: '옷장에 이름을 지어주세요!',
                        focusColor: Color(0xFFF5BEB5)),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: sections.map((section) => _buildSection(section)).toList(),
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
    );
  }
}