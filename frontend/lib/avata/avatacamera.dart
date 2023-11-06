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

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import '../avata/wearcloth.dart';

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
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 254),
      body: Stack(
        children: [
          isInitialized
              ? SizedBox(
                  width: MediaQuery.of(context).size.width, // 화면의 전체 너비를 사용합니다.
                  height: MediaQuery.of(context).size.height *
                      0.95, // 화면 높이의 75%를 사용합니다.
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
                  width: MediaQuery.of(context).size.width, // 화면의 전체 너비를 사용합니다.
                  height: MediaQuery.of(context).size.height *
                      0.95, // 화면 높이의 95%를 사용합니다.
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
              capturedImage = File(image.path); // Set captured image path
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
            '다시찍기↺',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {},
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
