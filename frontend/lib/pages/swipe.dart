import 'package:flutter/material.dart';

class Swipe extends StatefulWidget {
  const Swipe({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Swipe> {
  final TextEditingController inputController = TextEditingController();
  Map<String, dynamic> saveavatar = {
    'list': [], // list를 비워두거나 초기 데이터를 넣을 수 있습니다.
  };


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5BEB5),
        toolbarHeight: 55,
        title: const Text(
          '코디평가',
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
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: Text(
                      '싸피깔롱쟁이',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFF5BEB5),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: Text(
                      '님의 코디',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              SwipeableCards(),
              Center(
                child: Image.asset('assets/swipe.png'),
              ),
            ],
          )),
    );
  }
}


class SwipeableCards extends StatefulWidget {
  @override
  _SwipeableCardsState createState() => _SwipeableCardsState();
}

class _SwipeableCardsState extends State<SwipeableCards> {
  List<String> cards = [
    'https://image.newsis.com/2022/07/08/NISI20220708_0001037503_web.jpg',
    'https://onlyyugioh.com/web/product/big/202205/5df59663bbd221d8148d3986fbe424c1.jpg',
    'https://image.zdnet.co.kr/2023/07/26/f7981bfffc284d23d6335b1223bd554c.jpg',
    'https://cdn.wwdkorea.com/news/photo/202305/4784_188109_5932.jpeg',
    'https://blog.kakaocdn.net/dn/3ZrbN/btqCJlADYIx/Y56IertbI9cyiKnRMK4ys1/img.png',

  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: cards.isEmpty
          ? Text('No more cards')
          : Dismissible(
        key: Key(cards.first),
        onDismissed: (direction) {
          // 오른쪽에서 왼쪽으로 스와이프한 경우
          if (direction == DismissDirection.endToStart) {
            print('Swiped left'); // 원하는 로직으로 대체
          }
          // 왼쪽에서 오른쪽으로 스와이프한 경우
          else if (direction == DismissDirection.startToEnd) {
            print('Swiped right'); // 원하는 로직으로 대체
          }

          setState(() {
            cards.removeAt(0);
          });
        },
        child: Card(
          child: Container(
            height: 300,
            width: 200,
            alignment: Alignment.center,
            child: Image.network(
              cards.first,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}