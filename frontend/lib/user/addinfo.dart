import 'package:flutter/material.dart';

class AddInfo extends StatefulWidget {
  const AddInfo({super.key, this.user, this.storage});
  final user;
  final storage;
  // const AddInfo({super.key});
  // const AddInfo({Key? key, this.user, this.storage});

  @override
  State<AddInfo> createState() => _AddInfoState();
}

class _AddInfoState extends State<AddInfo> {
  TextEditingController controller = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();
  String? birthday;
  String? gender;
  List<String> genderList = [
    '남성',
    '여성',
  ];
  String selectedGender = '남성';
  String selectedGenderString = 'm';
  List<String> veganList = [
    'none',
    'vegan',
    'lacto',
    'ovo',
    'lacto-ovo',
    'pesco',
    'pollo',
    'flexi',
  ];
  String selectedVegan = 'none';
  int selectedVeganNumber = 0;
  List<String> allergieList = ['없음', '있음'];
  String havAllergie = '없음';
  List<dynamic> allergieNameList = [
    '난류',
    '우유',
    '메밀',
    '땅콩',
    '대두',
    '밀',
    '고등어',
    '게',
    '새우',
    '돼지고기',
    '복숭아',
    '토마토',
    '호두',
    '닭고기',
    '쇠고기',
    '오징어',
    '조개류'
  ];
  List<Object?> selectedAllergie = [];
  List<dynamic> selectedAllergieNumber = [];

  bool algdropdown = false;

  bool yearcheck = false;
  bool monthcheck = false;
  bool daycheck = false;

  @override
  void initState() {
    super.initState();

    // if (widget.user['userGender'] == "f") {
    //   setState(() {
    //     selectedGender = '여성';
    //   });
    //   selectedGenderString = 'f';
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '',
          style: TextStyle(
              fontSize: 25, color: Colors.black, fontWeight: FontWeight.w700),
        ),
        elevation: 0.0,
        backgroundColor: Colors.grey[50],
        centerTitle: true,
        toolbarHeight: 65,
        leading: IconButton(
          color: Colors.black,
          icon: const Icon(Icons.keyboard_backspace_rounded),
          onPressed: () {},
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.values.first,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '(선택)추가 정보',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                    Text('맞춤 정보 제공을 위해\n자율적으로 추가 정보를 입력해주세요.'),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                child: Row(
                  children: [
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '생년월일',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          DropdownButton(
                            alignment: Alignment.bottomLeft,
                            value: selectedVegan,
                            items: veganList.map((String item) {
                              return DropdownMenuItem<String>(
                                value: item,
                                child: Text(item),
                              );
                            }).toList(),
                            onChanged: (dynamic value) {
                              setState(() {
                                selectedVegan = value;
                              });
                              for (int i = 0; i < veganList.length; i++) {
                                if (veganList[i] == selectedVegan) {
                                  selectedVeganNumber = i;
                                }
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '성별',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          DropdownButton(
                            alignment: Alignment.bottomLeft,
                            value: selectedGender,
                            items: genderList.map((String item) {
                              return DropdownMenuItem<String>(
                                value: item,
                                child: Text(item),
                              );
                            }).toList(),
                            onChanged: (dynamic value) {
                              setState(() {
                                selectedGender = value;
                              });
                              if (selectedGender == '남자') {
                                selectedGenderString = 'm';
                              } else {
                                selectedGenderString = 'f';
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
