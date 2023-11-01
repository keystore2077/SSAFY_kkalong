import 'package:flutter/material.dart';

class ClothSlide extends StatefulWidget {
  const ClothSlide({super.key});

  @override
  State<ClothSlide> createState() => _ClothSlideState();
}

class _ClothSlideState extends State<ClothSlide> {
  @override
  Widget build(BuildContext context) {
    var ranking = [
      {'rank': '1', 'title': '여기는1위자리의그것입니다', 'image': 'Pants'},
      {'rank': '2', 'title': '여기는2위자리의제목입니다자를예정이죠', 'image': 'Pants'},
      {'rank': '3', 'title': '여기는3위자리입니다하하', 'image': 'Pants'},
      {'rank': '4', 'title': '여기는4위', 'image': 'Pants'},
      {'rank': '5', 'title': '여기는4위', 'image': 'Pants'},
      {'rank': '6', 'title': '여기는4위', 'image': 'Pants'},
      {'rank': '7', 'title': '여기는4위', 'image': 'Pants'},
      {'rank': '8', 'title': '여기는4위', 'image': 'Pants'},
      {'rank': '9', 'title': '여기는4위', 'image': 'Pants'},
      {'rank': '10', 'title': '여기는4위', 'image': 'Pants'},
    ];

    return SliverToBoxAdapter(
      child: Container(
        width: 1500,
        height: 170,
        margin: const EdgeInsets.fromLTRB(0, 8, 10, 0),
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
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.asset(
                            'Assets/Image/${ranking[i]['image']}.png',
                            width: 120,
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          width: 25,
                          height: 25,
                          decoration: BoxDecoration(
                              color: const Color.fromRGBO(161, 203, 161, 0.8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  blurRadius: 5.0,
                                  spreadRadius: 0.0,
                                  offset: const Offset(3, 3),
                                )
                              ],
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  bottomRight: Radius.circular(5))),
                          child: Center(
                              child: Text(
                            '${ranking[i]['rank']}',
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 15),
                          )),
                        )
                      ],
                    ),
                    Container(
                        margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Text(
                          '${ranking[i]['title']!.length > 15 ? ranking[i]['title']?.substring(0, 15) : ranking[i]['title']}'
                          '${ranking[i]['title']!.length > 15 ? "..." : ""}',
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
