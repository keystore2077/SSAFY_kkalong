import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(
      MaterialApp(
          theme: ThemeData(),
          home: ClothDetail()
      )
  );
}

class ClothDetail extends StatefulWidget {
  final clothSeq;
  const ClothDetail({Key? key, this.clothSeq}) : super(key: key);

  @override
  _ClothDetailState createState() => _ClothDetailState();
}

class _ClothDetailState extends State<ClothDetail> {
  var data = [];
  getData() async{
    var result = await http.get(Uri.parse('https://codingapple1.github.io/app/data.json'));
    // var result = await http.get(Uri.parse('https://example.com/api/cloth/${widget.clothSeq}'));
    if (result.statusCode == 200) {
      var result2 = jsonDecode(result.body);
      setState(() {
        data = result2;
      });
      print(data);
    } else {
      _showErrorDialog('오류 발생: ${result.statusCode}');
    }
  }

  deleteCloth() async {
    var result = await http.put(Uri.parse('https://codingapple1.github.io/app/data.json'));
    // var result = await http.put(Uri.parse('https://example.com/api/cloth/${widget.clothSeq}'));
    if (result.statusCode == 200) {
      print('삭제완료');
    } else {
      _showErrorDialog('오류 발생: ${result.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  // void navigateTaglist(BuildContext context, String tagName) {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => TagListPage(tagName: tagName)),
  //   );
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

  final List<String> location = [
    '공주옷장 선반1',
    '할머니옷장 수납장3',
    '아재옷장 박스1',
  ];
  String? selectedLocation;

  final List<String> categories = [
    'Top',
    'Pants',
    'Outer',
    'Skirts',
    'Dress',
    'Etc',
  ];
  String? selectedCategories;

  final List<String> tags = [
    '손세탁',
    '물빠짐 주의',
    '면재질',
  ];
  String? selectedTags;

  final List<String> names = [
    '최애 수영복',
    '듀얼마스타 신욱',
    '무적의 백엔드',
  ];
  String? selectedName;

  @override
  Widget build(BuildContext context) {
    if (data.isNotEmpty){
      return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFF5BEB5),
          toolbarHeight: 55,
          title: Text(
            '나의 옷',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          elevation: 0,
          leading: const Text(''),
          actions: [
            IconButton(onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (c) => Text('옷수정하는 창'))
              );
            }, icon: Icon(
              Icons.border_color,
              color: Color(0xFFfc6474),
            )),
            IconButton(onPressed: () {
              deleteCloth();
              Navigator.push(context,
                  MaterialPageRoute(builder: (c) => Text('옷조회하는 창'))
              );
            }, icon: Icon(
              Icons.delete,
              color: Color(0xFFfc6474),
            )),
          ],
        ),
        body: Center(
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Container(
              padding: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.chevron_left,
                              size: 40,
                              color: Color(0xFF54545b),
                            ),
                            onPressed: (){},
                          ),
                          Image.asset('assets/오레노턴완.jpg',
                            width: 200,
                            height: 350,
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.chevron_right,
                              size: 40,
                              color: Color(0xFF54545b),
                            ),
                            onPressed: (){

                            },
                          ),
                        ],
                      )
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    names[0],
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 20,
                      color: Color(0xFF54545b),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 40.0,
                        color: Color(0xFF54545b),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        location[0],
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                          color: Color(0xFF54545b),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 75,
                    margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xFFF5BEB5),
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(30.0),
                      color: Color(0xFFF5BEB5),
                    ),
                    child: Center(child: Text(
                      '#${categories[4]}',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    )),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: tags.map((tag) => GestureDetector(
                        onTap: () {
                          // navigateTaglist(context, tag);
                        },
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
                            '#${tag}',
                            style: TextStyle(
                              color: Color(0xFFF5BEB5),
                            ),
                          ),
                          ),
                        ),
                      )).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );} else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }}