import 'package:flutter/material.dart';
import 'package:flutter_mycloset/avata/choicecloth.dart';

class Completecody extends StatefulWidget {
  String memberNickname;
  String fashionName;
  String imgUrl;

  Completecody(
      {super.key,
      this.storage,
      required this.fashionName,
      required this.memberNickname,
      required this.imgUrl});

  final storage;

  @override
  State<Completecody> createState() => CompletecodyState();
}

class CompletecodyState extends State<Completecody> {
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    // 초기화 작업 수행
  }

  final savecloset = {
    "list": [
      {"image": "Assets/Image/TShirt.png"},
    ]
  };

  final clomenue = {
    "list": [
      {"image": "Assets/Image/Dress.png", "name": "Top"},
      {"image": "Assets/Image/Pants.png", "name": "Pants"},
      {"image": "Assets/Image/Suit.png", "name": "Outer"},
      {"image": "Assets/Image/Skirt.png", "name": "Skirts"},
      {"image": "Assets/Image/Dress.png", "name": "Dress"},
      {"image": "Assets/Image/Ellipsis.png", "name": "ect"},
    ]
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Color(0xFFF5BEB5),
            expandedHeight: 55.0,
            floating: true,
            pinned: true,
            title: Text(
              '${widget.memberNickname}의 깔롱코디',
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
            elevation: 0,
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                crossAxisSpacing: 20.0,
                mainAxisSpacing: 20.0,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  final item = savecloset['list']?[index];
                  if (item == null) {
                    return const SizedBox(); // 빈 위젯 반환
                  }
                  return GestureDetector(
                    onTap: () {},
                    child: Container(
                      color: const Color.fromARGB(255, 251, 235, 233),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.network(
                            widget.imgUrl ??
                                "https://example.com/default_image.png",
                            height: 300,
                            width: 300,
                            fit: BoxFit.cover,
                            errorBuilder: (BuildContext context, Object error,
                                StackTrace? stackTrace) {
                              // 이미지 로드 실패 시 대체 이미지 표시
                              return Image.asset(
                                "Assets/Image/logo.png",
                                height: 200,
                                width: 180,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
                childCount: savecloset['list']?.length ?? 0,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(18, 2, 18, 2),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
                      child: Text(
                        widget.fashionName,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          // color: Color(0xFFF5BEB5),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                      padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
                      child: SizedBox(
                        child: Text(
                          widget.fashionName,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            // color: Color(0xFFF5BEB5),
                          ),
                        ),
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
