import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(
      MaterialApp(
          theme: ThemeData(),
          home: TagsSelect()
      )
  );
}

class TagsSelect extends StatefulWidget {
  const TagsSelect({Key? key}) : super(key: key);

  @override
  State<TagsSelect> createState() => _TagsSelectState();
}

class _TagsSelectState extends State<TagsSelect> {
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: const Text(
          '태그별 조회',
          style: TextStyle(color: Colors.white), // 텍스트의 색상을 흰색으로 설정
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 246, 212, 206),
        iconTheme: const IconThemeData(color: Colors.black),
        // collapsedHeight: 325,
        // expandedHeight: 325,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(30, 20, 30, 30),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(4, 0, 4, 10),
                  padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xFFF5BEB5),
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Center(child: Text(
                    '#손세탁',
                    style: TextStyle(
                      color: Color(0xFFF5BEB5),
                    ),
                  ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 10, // 3줄을 나타내도록 설정
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                      onTap: () {
                        // 클릭 이벤트 -> 옷상세로 넘어가게 할거임..
                      },
                      child:
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: const EdgeInsets.all(8.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    'assets/오레노턴완.jpg',
                                    height: 100,
                                    width: 150,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              Flexible(
                                // Flexible 추가
                                child: Container(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: Text(
                                    '언제입어도 편안한 츄리닝 $index',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    overflow: TextOverflow.clip, // 글자를 자르도록 설정
                                  ),
                                ),
                              )
                            ],
                          ),
                          const Divider(
                            height: 1,
                            thickness: 1,
                          ), // 구분선
                        ],
                      ));
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () async {
          final ImagePicker picker = ImagePicker();
          final XFile? image =
          await picker.pickImage(source: ImageSource.camera);

          if (image != null) {
            // 이미지가 선택되면 처리할 작업을 여기에 추가합니다.
            // image.path를 사용하여 이미지 파일에 접근할 수 있습니다.
          } else {
            // 이미지가 선택되지 않았을 때 처리할 작업을 추가합니다.
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey[50],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0), // 원하는 각진 정도로 설정
          ),
          // 다른 스타일 속성들
        ),
        child: const Text(' + 옷등록'),
      ),
    ));
  }
}
