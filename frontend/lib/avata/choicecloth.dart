import 'package:flutter/material.dart';
import '../avata/clothslide.dart';

// import 'package:flutter_mycloset/category/categoryselect.dart';

class ChoiceCloth extends StatefulWidget {
  const ChoiceCloth({
    super.key,
    this.storage,
  });

  final storage;

  @override
  State<ChoiceCloth> createState() => ChoiceClothState();
}

class ChoiceClothState extends State<ChoiceCloth> {
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
      {"image": "Assets/Image/TShirt.png", "name": "Top"},
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
      backgroundColor: const Color.fromARGB(255, 255, 255, 254),
      body: CustomScrollView(
        slivers: <Widget>[
          const SliverAppBar(
            backgroundColor: Color(0xFFF5BEB5),
            expandedHeight: 55.0,
            floating: true,
            pinned: true,
            title: Text(
              '깔롱의 옷입히기',
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
            elevation: 0,
            leading: Text(''),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                // AppBar(
                //   toolbarHeight: 100,
                //   // centerTitle: true,
                //   title: const Text(
                //     'TOP',
                //     style: TextStyle(
                //       fontSize: 22,
                //       color: Color.fromARGB(255, 0, 0, 0),
                //       fontWeight: FontWeight.w600,
                //     ),
                //   ),
                //   leading: Padding(
                //     padding: const EdgeInsets.fromLTRB(25.0, 0, 0,
                //         0), // padding을 적절히 조절하여 이미지의 크기와 위치를 변경할 수 있습니다.
                //     child: Image.asset(
                //       'Assets/Image/logo.png',
                //       width: 150.0, // 원하는 너비 값을 설정
                //       height: 150.0, // 원하는 높이 값을 설정
                //     ), // 여기에 원하는 이미지 경로를 넣으세요.
                //   ),
                // ),
                AppBar(
                  toolbarHeight: 100,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 10.0, 0),
                        child: Image.asset(
                          'Assets/Image/Suit.png',
                          width: 70.0,
                          height: 70.0,
                        ),
                      ),
                      const Text(
                        'Suit',
                        style: TextStyle(
                          fontSize: 22,
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  centerTitle: false,
                ),
              ],
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
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
                          Image.asset(
                            item["image"] ?? "Assets/Image/logo.png",
                            height: 125,
                            width: 180,
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
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(30, 2, 10, 2),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 400,
                    child: Text(
                      '옷선택',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  SizedBox(height: 10),
                  // SizedBox(
                  //   width: double.infinity,
                  //   height: 150,
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //     children: List<Widget>.from(
                  //         (clomenue["list"] ?? []).map<Widget>((item) {
                  //       return GestureDetector(
                  //         onTap: () {},
                  //         child: Column(
                  //           children: <Widget>[
                  //             Image.asset(
                  //               item["image"] ?? 'Assets/Image/logo.png',
                  //               width: 60,
                  //               height: 100,
                  //             ),
                  //             const SizedBox(height: 5),
                  //             Text(item["name"] ?? 'Unknown'),
                  //           ],
                  //         ),
                  //       );
                  //     })),
                  //   ),
                  // )

                  // SizedBox(
                  //   width: double.infinity,
                  //   height: 150,
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //     children: List<Widget>.from(
                  //         (clomenue["list"] ?? []).map<Widget>((item) {
                  //       return Column(
                  //         children: <Widget>[
                  //           Image.asset(
                  //             item["image"] ?? 'Assets/Image/logo.png',
                  //             width: 60,
                  //             height: 100,
                  //           ),
                  //           const SizedBox(
                  //               height:
                  //                   5), // const 키워드를 제거했지만 이는 필수적인 변경은 아닙니다.
                  //           Text(item["name"] ?? 'Unknown'),
                  //         ],
                  //       );
                  //     })),
                  //   ),
                  // )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
