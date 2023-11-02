import 'package:flutter/material.dart';

class ClothSlide extends StatefulWidget {
  const ClothSlide({super.key});

  @override
  State<ClothSlide> createState() => _ClothSlideState();
}

class _ClothSlideState extends State<ClothSlide> {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    var ranking = [
      {'rank': '1', 'title': '깔롱한옷1', 'image': 'exshirts'},
      {'rank': '2', 'title': '깔롱한옷2', 'image': 'exshirts2'},
      {'rank': '3', 'title': '집에가고싶은옷', 'image': 'exshirts3'},
      {'rank': '4', 'title': '집에보내줄옷', 'image': 'exshirts'},
      {'rank': '5', 'title': '졸린다', 'image': 'exshirts'},
      {'rank': '6', 'title': '잠온다', 'image': 'exshirts'},
      {'rank': '7', 'title': '여름에 입으면 예쁠 반바지', 'image': 'exshirts'},
      {'rank': '8', 'title': '오늘 점심은 장각칼국수 셔츠', 'image': 'exshirts'},
      {'rank': '9', 'title': '졸린다람쥐반팔', 'image': 'exshirts'},
      {'rank': '10', 'title': '언제어디서나 반짝반짝한 은갈치슈트', 'image': 'exshirts'},
    ];

    return SliverToBoxAdapter(
      child: Container(
        width: 1500,
        height: 170,
        margin: const EdgeInsets.fromLTRB(7, 8, 7, 0),
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (c, i) {
              return Container(
                width: 120,
                height: 150,
                margin: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Stack(
                    //   children: [
                    //     GestureDetector(
                    //       onTap: () {
                    //         setState(() {
                    //           selectedIndex = i;
                    //         });
                    //         print('선택완료');
                    //       },
                    //       child: Container(
                    //         decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(5),
                    //           border: i == selectedIndex
                    //               ? Border.all(color: Colors.blue)
                    //               : null,
                    //         ),
                    //       ),
                    //       child: ClipRRect(
                    //         borderRadius: BorderRadius.circular(5),
                    //         child: Image.asset(
                    //           'Assets/Image/${ranking[i]['image']}.png',
                    //           width: 100,
                    //           height: 120,
                    //           fit: BoxFit.cover,
                    //         ),
                    //       ),
                    //     )
                    //   ],
                    // ),
                    Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex = i;
                            });
                            print('선택완료');
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: i == selectedIndex
                                  ? Border.all(
                                      color: const Color(0xFFF5BEB5),
                                      width: 3.0)
                                  : null,
                            ),
                            child: ClipRRect(
                              // ClipRRect is now the child of the Container
                              borderRadius: BorderRadius.circular(5),
                              child: Image.asset(
                                'Assets/Image/${ranking[i]['image']}.png',
                                width: 100,
                                height: 120,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),

                    Container(
                        margin: const EdgeInsets.fromLTRB(12, 5, 0, 0),
                        child: Text(
                          '${ranking[i]['title']!.length > 6 ? ranking[i]['title']?.substring(0, 6) : ranking[i]['title']}'
                          '${ranking[i]['title']!.length > 6 ? ".." : ""}',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        )),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
