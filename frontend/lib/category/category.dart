import 'package:flutter/material.dart';
// import 'package:flutter_mycloset/category/categoryselect.dart';
import './categoryselect.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({
    super.key,
    this.storage,
  });

  final storage;

  @override
  State<CategoryPage> createState() => CategoryPageState();
}

class CategoryPageState extends State<CategoryPage> {
  @override
  void initState() {
    super.initState();
    // 초기화 작업 수행
  }

  final savecloset = {
    "list": [
      {"image": "Assets/Image/TShirt.png", "name": "Top"},
      {"image": "Assets/Image/Pants.png", "name": "Pants"},
      {"image": "Assets/Image/Suit.png", "name": "Outer"},
      {"image": "Assets/Image/Skirt.png", "name": "Skirts"},
      {"image": "Assets/Image/Dress.png", "name": "Dress"},
      {"image": "Assets/Image/Ellipsis.png", "name": "Etc"},
    ]
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 202, 198, 197),
      body: CustomScrollView(
        slivers: <Widget>[
          const SliverAppBar(
            backgroundColor: Color(0xFFF5BEB5),
            expandedHeight: 55.0,
            floating: true,
            pinned: true,
            title: Text(
              '나의 옷장',
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
            elevation: 0,
            leading: Text(''),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                // Container(
                //   padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Container(
                //         margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                //         child: const Column(
                //           crossAxisAlignment: CrossAxisAlignment.center,
                //           children: [
                //             SizedBox(
                //               child: Padding(
                //                 padding: EdgeInsets.fromLTRB(0, 5, 0, 2),
                //                 child: Text(
                //                   'Category',
                //                   style: TextStyle(
                //                     fontSize: 25,
                //                     fontWeight: FontWeight.w600,
                //                   ),
                //                 ),
                //               ),
                //             ),
                //           ],
                //         ),
                //       ),
                //     ],
                //   ),
                // ),

                AppBar(
                  toolbarHeight: 100,
                  leading: IconButton(
                    icon: const Icon(
                        Icons.arrow_back_ios_outlined), // 원하는 아이콘으로 변경할 수 있습니다.
                    onPressed: () {
                      // 아이콘을 탭할 때 수행할 동작을 여기에 작성합니다.
                      // 예를 들면, Drawer를 열거나, 이전 페이지로 돌아가는 동작 등을 구현할 수 있습니다.
                    },
                  ),
                  backgroundColor: const Color.fromARGB(255, 251, 235, 233),
                  centerTitle: true,
                  title: const Text(
                    'Category',
                    style: TextStyle(
                        fontSize: 25,
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontWeight: FontWeight.w600),
                  ),
                )
              ],
            ),
          ),
          // SliverPadding(
          //   padding: const EdgeInsets.fromLTRB(2, 2, 2, 1),
          //   sliver: SliverGrid(
          //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          //       crossAxisCount: 2,
          //       crossAxisSpacing: 2.0,
          //       mainAxisSpacing: 2.0,
          //     ),
          //     delegate: SliverChildBuilderDelegate(
          //       (BuildContext context, int index) {
          //         final item = savecloset['list']?[index];
          //         if (item == null) {
          //           return const SizedBox(); // 빈 위젯 반환
          //         }
          //         return GestureDetector(
          //           onTap: () {
          //             // 클릭이벤트
          //           },
          //           child: Column(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: <Widget>[
          //               Image.asset(
          //                 item["image"] ?? "Assets/Image/logo.png",
          //                 height: 120,
          //                 width: 180,
          //               ),
          //               Text(
          //                 item["name"] ?? "Unknown",
          //                 style: const TextStyle(
          //                   fontSize: 20,
          //                   fontWeight: FontWeight.w500,
          //                 ),
          //               ),
          //             ],
          //           ),
          //         );
          //       },
          //       childCount: savecloset['list']?.length ?? 0,
          //     ),
          //   ),
          // ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(0, 1, 0, 0),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 1.0,
                mainAxisSpacing: 1.0,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  final item = savecloset['list']?[index];
                  if (item == null) {
                    return const SizedBox(); // 빈 위젯 반환
                  }
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CategorySelect(category: index)),
                      );
                    },
                    child: Container(
                      color: const Color.fromARGB(
                          255, 251, 235, 233), // "점선"의 색상입니다.
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            item["image"] ?? "Assets/Image/logo.png",
                            height: 125,
                            width: 180,
                          ),
                          Text(
                            item["name"] ?? "Unknown",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
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
        ],
      ),
    );
  }
}
