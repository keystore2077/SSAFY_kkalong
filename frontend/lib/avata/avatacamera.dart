// import 'package:flutter/material.dart';
// import 'package:camera/camera.dart';
// import '../avata/wearcloth.dart';

// class AvataPicture extends StatefulWidget {
//   const AvataPicture({super.key});

//   @override
//   _AvataPictureState createState() => _AvataPictureState();
// }

// class _AvataPictureState extends State<AvataPicture> {
//   late CameraController _controller;
//   late List<CameraDescription> cameras;
//   bool isInitialized = false;

//   @override
//   void initState() {
//     super.initState();
//     initCamera();
//   }

//   Future<void> initCamera() async {
//     cameras = await availableCameras();
//     _controller = CameraController(cameras[0], ResolutionPreset.medium);
//     _controller.initialize().then((_) {
//       if (!mounted) {
//         return;
//       }
//       setState(() {
//         isInitialized = true;
//       });
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 255, 255, 254),
//       body: Stack(
//         children: [
//           // isInitialized
//           //     ? AspectRatio(
//           //         aspectRatio: _controller.value.aspectRatio,
//           //         child: CameraPreview(_controller),
//           //       )
//           //     : const Center(child: CircularProgressIndicator()),
//           // Positioned.fill(
//           //   child: Opacity(
//           //     opacity: 0.8,
//           //     child: Image.asset(
//           //       'Assets/Image/guide.png',
//           //       fit: BoxFit.fitWidth,
//           //     ),
//           //   ),
//           // ),
//           isInitialized
//               ? FittedBox(
//                   fit: BoxFit.cover,
//                   child: SizedBox(
//                     width: _controller.value.previewSize!.height,
//                     height: _controller.value.previewSize!.width,
//                     child: CameraPreview(_controller),
//                   ),
//                 )
//               : const Center(child: CircularProgressIndicator()),

//           // Guide Image
//           Positioned.fill(
//             child: Opacity(
//               opacity: 1,
//               child: Image.asset(
//                 'Assets/Image/guide.png',
//                 fit: BoxFit.fitHeight,
//               ),
//             ),
//           ),
//         ],
//       ),
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.fromLTRB(20, 2, 20, 2),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             SizedBox(
//               width: 400,
//               child: ElevatedButton(
//                 onPressed: () async {
//                   if (isInitialized) {
//                     final imagePath = await _controller.takePicture();
//                     print(imagePath.path);
//                   }

//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xFFF5BEB5),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(5.0),
//                   ),
//                 ),
//                 child: const Text(
//                   '사진찍기',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 10),
//             // SizedBox(
//             //   width: 400,
//             //   child: ElevatedButton(
//             //     onPressed: () {
//             //       Navigator.push(
//             //         context,
//             //         MaterialPageRoute(builder: (context) => const WearCloth()),
//             //       );
//             //     },
//             //     style: ElevatedButton.styleFrom(
//             //       backgroundColor: const Color(0xFFF5BEB5),
//             //       shape: RoundedRectangleBorder(
//             //         borderRadius: BorderRadius.circular(5.0),
//             //       ),
//             //     ),
//             //     child: const Text(
//             //       '선택완료',
//             //       style: TextStyle(
//             //         color: Colors.white,
//             //         fontWeight: FontWeight.w700,
//             //       ),
//             //     ),
//             //   ),
//             // ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'dart:io'; // Import this for File handling
// import 'package:flutter/material.dart';
// import 'package:camera/camera.dart';
// import '../avata/wearcloth.dart';

// class AvataPicture extends StatefulWidget {
//   const AvataPicture({super.key});

//   @override
//   _AvataPictureState createState() => _AvataPictureState();
// }

// class _AvataPictureState extends State<AvataPicture> {
//   late CameraController _controller;
//   late List<CameraDescription> cameras;
//   bool isInitialized = false;
//   File? capturedImage; // Variable to store captured image

//   @override
//   void initState() {
//     super.initState();
//     initCamera();
//   }

//   Future<void> initCamera() async {
//     cameras = await availableCameras();
//     _controller = CameraController(cameras[0], ResolutionPreset.medium);
//     _controller.initialize().then((_) {
//       if (!mounted) {
//         return;
//       }
//       setState(() {
//         isInitialized = true;
//       });
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 255, 255, 254),
//       body: Stack(
//         children: [
//           isInitialized
//               ? FittedBox(
//                   fit: BoxFit.cover,
//                   child: SizedBox(
//                     width: _controller.value.previewSize!.height,
//                     height: _controller.value.previewSize!.width,
//                     child: CameraPreview(_controller),
//                   ),
//                 )
//               : const Center(child: CircularProgressIndicator()),

//           // Display captured image
//           capturedImage != null
//               ? Image.file(capturedImage!, fit: BoxFit.cover)
//               : Container(),

//           // Display guide image only if capturedImage is null
//           capturedImage == null
//               ? Positioned.fill(
//                   child: Opacity(
//                     opacity: 1,
//                     child: Image.asset(
//                       'Assets/Image/guide.png',
//                       fit: BoxFit.fitHeight,
//                     ),
//                   ),
//                 )
//               : Container(),
//         ],
//       ),
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.fromLTRB(20, 2, 20, 2),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             SizedBox(
//               width: 400,
//               child: ElevatedButton(
//                 onPressed: () async {
//                   if (isInitialized) {
//                     final image = await _controller.takePicture();
//                     setState(() {
//                       capturedImage =
//                           File(image.path); // Set captured image path
//                     });
//                   }
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xFFF5BEB5),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(5.0),
//                   ),
//                 ),
//                 child: const Text(
//                   '사진찍기',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 10),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:dio/dio.dart';
import './wearcloth.dart';
import 'package:http_parser/http_parser.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_mycloset/avata/choicepicture.dart';
import 'package:provider/provider.dart';
import '../store/userstore.dart';

// import '../avata/wearcloth.dart';

class AvataPicture extends StatefulWidget {
  const AvataPicture({super.key});

  @override
  _AvataPictureState createState() => _AvataPictureState();
}

class _AvataPictureState extends State<AvataPicture> {
  late CameraController _controller;
  late List<CameraDescription> cameras;
  bool isInitialized = false;
  File? capturedImage;

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  Future<void> initCamera() async {
    cameras = await availableCameras();
    _controller = CameraController(cameras[0], ResolutionPreset.medium);
    _controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {
        isInitialized = true;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // String token = Provider.of<UserStore>(context, listen: false).accessToken;
    // print('가져온 토큰!!!!!!!!!!!!출력!!!!!!!!!!: $token');

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 254),
      body: Stack(
        children: [
          isInitialized
              ? SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.95,
                  child: CameraPreview(_controller),
                )
              // ? FittedBox(
              //     fit: BoxFit.cover,
              //     child: SizedBox(
              //       width: _controller.value.previewSize!.height,
              //       height: _controller.value.previewSize!.width,
              //       child: CameraPreview(_controller),
              //     ),
              //   )
              : const Center(child: CircularProgressIndicator()),

          // Display captured image
          capturedImage != null
              ? SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.95,
                  child: Image.file(capturedImage!, fit: BoxFit.cover),
                )
              : Container(),
          // ? Image.file(capturedImage!, fit: BoxFit.cover)
          // : Container(),

          // capturedImage == null
          //     ? Positioned.fill(
          //         child: Opacity(
          //           opacity: 1,
          //           child: Image.asset(
          //             'Assets/Image/guide.png',
          //             fit: BoxFit.cover,
          //           ),
          //         ),
          //       )
          //     : Container(),
          capturedImage == null
              ?
              // Align(
              //     alignment: Alignment.center,
              //     child: Opacity(
              //       opacity: 1,
              //       child: Image.asset(
              //         'Assets/Image/guide.png',
              //         width: 700.0,
              //         height: 800.0,
              //       ),
              //     ),
              //   )
              //가이드라인이미지 가운데 정렬
              Align(
                  // alignment: Alignment.center,
                  alignment: const Alignment(0, 3.0),
                  child: Container(
                    width: 600.0,
                    height: 700.0,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('Assets/Image/guide.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(20, 2, 20, 2),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            capturedImage == null
                ? buildCaptureButton()
                : buildSaveAndRetakeButtons(),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget buildCaptureButton() {
    return SizedBox(
      width: 400,
      child: ElevatedButton(
        onPressed: () async {
          if (isInitialized) {
            final image = await _controller.takePicture();
            setState(() {
              capturedImage = File(image.path);
            });
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFF5BEB5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        child: const Text(
          '사진찍기',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Widget buildSaveAndRetakeButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () async {
            setState(() {
              capturedImage = null;
            });

            // if (isInitialized) {
            //   final image = await _controller.takePicture();
            //   setState(() {
            //     capturedImage = File(image.path);
            //   });
            // }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFF5BEB5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
          child: const Text(
            '다시찍기↺',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            if (capturedImage != null) {
              var accessToken = context.read<UserStore>().accessToken;
              print(accessToken);

              Dio dio = Dio();
              const serverURL = 'http://k9c105.p.ssafy.io:8761';
              try {
                print('capturedImage path: ${capturedImage!}');
                print('capturedImage path: ${capturedImage!.path}');
                FormData formData = FormData.fromMap({
                  "multipartFile": await MultipartFile.fromFile(
                      capturedImage!.path,
                      contentType: MediaType('image', 'jpeg')),
                });
                print('어디까지 왔나');
                Map<String, dynamic> headers = {};
                if (accessToken.isNotEmpty) {
                  headers['Authorization'] = 'Bearer $accessToken';
                  headers['Content-Type'] = 'multipart/form-data';
                }

                final response = await dio.post(
                  '$serverURL/api/photo',
                  data: formData,
                  options: Options(
                    headers: headers,
                  ), // 수정된 부분
                );

                print('디오요청완료');
                print(response.data);
                var photoSeq = response.data['body']['photoSeq'];

                print('포토시퀀스ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ');
                print(photoSeq);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WearCloth(photoSeq: photoSeq)),
                );
                return response.data;
              } catch (e) {
                print('그밖의 에러ㅜㅜㅜㅜㅜㅜㅜㅜㅜ: $e');
              } finally {}
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFF5BEB5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
          child: const Text(
            '저장하기📁',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}

// import 'dart:convert'; // JSON 처리를 위해 추가
// import 'package:dio/dio.dart';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:camera/camera.dart';
// import 'package:flutter_mycloset/avata/choicepicture.dart';
// import '../avata/wearcloth.dart';

// class AvataPicture extends StatefulWidget {
//   const AvataPicture({super.key});

//   @override
//   _AvataPictureState createState() => _AvataPictureState();
// }

// class _AvataPictureState extends State<AvataPicture> {
//   late CameraController _controller;
//   late List<CameraDescription> cameras;
//   bool isInitialized = false;
//   File? capturedImage;

//   @override
//   void initState() {
//     super.initState();
//     initCamera();
//   }

//   Future<void> initCamera() async {
//     cameras = await availableCameras();
//     _controller = CameraController(cameras[0], ResolutionPreset.medium);
//     _controller.initialize().then((_) {
//       if (!mounted) {
//         return;
//       }
//       setState(() {
//         isInitialized = true;
//       });
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 255, 255, 254),
//       body: Stack(
//         children: [
//           isInitialized
//               ? SizedBox(
//                   width: MediaQuery.of(context).size.width, // 화면의 전체 너비를 사용합니다.
//                   height: MediaQuery.of(context).size.height *
//                       0.95, // 화면 높이의 75%를 사용합니다.
//                   child: CameraPreview(_controller),
//                 )
//               : const Center(child: CircularProgressIndicator()),

//           // Display captured image
//           capturedImage != null
//               ? SizedBox(
//                   width: MediaQuery.of(context).size.width, // 화면의 전체 너비를 사용합니다.
//                   height: MediaQuery.of(context).size.height *
//                       0.95, // 화면 높이의 95%를 사용합니다.
//                   child: Image.file(capturedImage!, fit: BoxFit.cover),
//                 )
//               : Container(),

//           capturedImage == null
//               ? Align(
//                   alignment: const Alignment(0, 3.0),
//                   child: Container(
//                     width: 600.0,
//                     height: 700.0,
//                     decoration: const BoxDecoration(
//                       image: DecorationImage(
//                         image: AssetImage('Assets/Image/guide.png'),
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                 )
//               : Container(),
//         ],
//       ),
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.fromLTRB(20, 2, 20, 2),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             capturedImage == null
//                 ? buildCaptureButton()
//                 : buildSaveAndRetakeButtons(),
//             const SizedBox(height: 10),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildCaptureButton() {
//     return SizedBox(
//       width: 400,
//       child: ElevatedButton(
//         onPressed: () async {
//           if (isInitialized) {
//             final image = await _controller.takePicture();
//             setState(() {
//               capturedImage = File(image.path);
//             });
//           }
//         },
//         style: ElevatedButton.styleFrom(
//           backgroundColor: const Color(0xFFF5BEB5),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(5.0),
//           ),
//         ),
//         child: const Text(
//           '사진찍기',
//           style: TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.w700,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildSaveAndRetakeButtons() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         ElevatedButton(
//           onPressed: () async {
//             setState(() {
//               capturedImage = null;
//             });

//             // if (isInitialized) {
//             //   final image = await _controller.takePicture();
//             //   setState(() {
//             //     capturedImage = File(image.path);
//             //   });
//             // }
//           },
//           style: ElevatedButton.styleFrom(
//             backgroundColor: const Color(0xFFF5BEB5),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(5.0),
//             ),
//           ),
//           child: const Text(
//             '다시찍기↺',
//             style: TextStyle(
//               color: Colors.white,
//               fontWeight: FontWeight.w700,
//             ),
//           ),
//         ),
//         ElevatedButton(
//           onPressed: () async {
//             if (capturedImage != null) {
//               Dio dio = Dio();
//               try {
//                 FormData formData = FormData.fromMap({
//                   "multipartFile":
//                       await MultipartFile.fromFile(capturedImage!.path),
//                 });
//                 print('FormData 준비 완료');
//                 final response = await dio.post(
//                   'http://k9c105.p.ssafy.io:8761/api/photo',
//                   data: formData,
//                 );
//                 print('디오요청완료');

//                 if (response.statusCode == 200) {
//                   final responseData = json.decode(response.data);
//                   // 'resultCode'를 체크합니다.
//                   if (responseData['result']['resultCode'] == 200) {
//                     print('파일 잘 업로드됨: ${responseData['body']}');
//                   } else {
//                     print(
//                         '파일 업로드는 성공했지만, 결과 코드에 문제가 있음: ${responseData['result']['resultMessage']}');
//                   }
//                 } else {
//                   print('사진파일 못보냄ㅜㅜㅜㅜㅜㅜㅜㅜㅜㅜㅜㅜㅜㅜㅜ: ${response.statusCode}');
//                 }
//               } catch (e) {
//                 print('오류 발생ㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠ: $e');
//               }
//             }
//           },
//           style: ElevatedButton.styleFrom(
//             backgroundColor: const Color(0xFFF5BEB5),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(5.0),
//             ),
//           ),
//           child: const Text(
//             '저장하기📁',
//             style: TextStyle(
//               color: Colors.white,
//               fontWeight: FontWeight.w700,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
