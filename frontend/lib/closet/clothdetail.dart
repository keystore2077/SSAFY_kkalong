import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

void main() {
  runApp(
      MaterialApp(
          theme: ThemeData(),
          home: ClothDetail()
      )
  );
}

class ClothDetail extends StatefulWidget {
  const ClothDetail({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<ClothDetail> {

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

  void _addTag() {
    setState(() {


    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        actions: [
          IconButton(onPressed: () {}, icon: Icon(
            Icons.border_color,
            color: Color(0xFFfc6474),
          )),
          IconButton(onPressed: () {}, icon: Icon(
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
                children: [
                  Image.asset('assets/오레노턴완.jpg'),
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
                  margin: EdgeInsets.all(8.0),
                  padding: EdgeInsets.all(8.0),
                  width: 70,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xFFF5BEB5),
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(30.0),
                    color: Color(0xFFF5BEB5),
                  ),
                  child: Center(child: Text(
                    '#${categories[0]}',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  )),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
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
                          '#${tags[0]}',
                          style: TextStyle(
                            color: Color(0xFFF5BEB5),
                          ),
                        )),
                      ),
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
                          '#${tags[1]}',
                          style: TextStyle(
                            color: Color(0xFFF5BEB5),
                          ),
                        )),
                      ),
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
                          '#${tags[2]}',
                          style: TextStyle(
                            color: Color(0xFFF5BEB5),
                          ),
                        )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );}
}