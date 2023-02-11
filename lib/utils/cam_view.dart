import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CamView extends StatefulWidget {
  final CameraDescription? firstCamera;
  final CameraDescription? secondCamera;
  final Function(Uint8List, dynamic) onTakePictureCallback;

  CamView(this.firstCamera, this.secondCamera, this.onTakePictureCallback) {}

  @override
  State<StatefulWidget> createState() {
    return CamViewState(firstCamera, secondCamera, onTakePictureCallback);
  }
}

class CamViewState extends State {
  final Function(Uint8List, dynamic) onTakePictureCallback;

  CamViewState(
      this.firstCamera, this.secondCamera, this.onTakePictureCallback) {}

  final CameraDescription? firstCamera;
  final CameraDescription? secondCamera;
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  bool processingImage = false;

  Widget withFullScreenSize(Widget innerWidget, {int bottomMargin = 0}) {
    final scale = (1 /
        (_controller.value.aspectRatio *
            MediaQuery.of(context).size.aspectRatio));

    return Transform.scale(
        scale: scale, alignment: Alignment.topCenter, child: innerWidget);
  }

  late bool frontalCamera = true;

  @override
  void initState() {
    _initCamera(this.frontalCamera
        ? (this.secondCamera ?? this.firstCamera)
        : (this.firstCamera ?? this.secondCamera));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    if (this.firstCamera != null || this.secondCamera != null) {
      return Scaffold(
        body: FutureBuilder<void>(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: withFullScreenSize(
                      Stack(
                        children: [
                          CameraPreview(_controller),
                          Positioned(
                            top: 0,
                            bottom: 0,
                            // left: MediaQuery.of(context).size.width * 0.25,
                            child: Image.asset(
                              'assets/images/overlay_mask_camera.png',
                              width: MediaQuery.of(context).size.width,
                            ),
                          ),
                          Positioned(
                            top: 0,
                            left: 0,
                            bottom: 0,
                            child: Container(
                                height: MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width,
                                child: this.processingImage
                                    ? Center( child: CircularProgressIndicator() )
                                    : Center()),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.black,
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        MaterialButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 2.0),
                            child: Image.asset(
                              "assets/images/close.png",
                              color: Color(0xFFfbfbfb),
                              width: 34,
                            ),
                          ),
                        ),
                        MaterialButton(
                          // child: Text("OK", style: Styles.ButtonLabelStyle),
                          // style: Styles.CommonButtonStyle,
                          child: Image.asset("assets/images/click.png"),
                          onPressed: () async {
                            if (!this.processingImage) {
                              this.setState(() {
                                this.processingImage = true;
                              });
                            } else {
                              return;
                            }

                            Uint8List image =
                            await (await this._controller.takePicture())
                                .readAsBytes();

                            var shouldReturn = await this
                                .onTakePictureCallback(image, this.context);

                            if (shouldReturn) {
                              Navigator.of(context).pop();
                            } else {
                              this.setState(() {
                                this.processingImage = false;
                              });
                            }
                          },
                        ),
                        MaterialButton(
                          onPressed: () {
                            this.setState(() {
                              this.frontalCamera = !this.frontalCamera;
                              _initCamera(this.frontalCamera
                                  ? (this.secondCamera ?? this.firstCamera)
                                  : (this.firstCamera ?? this.secondCamera));
                            });
                          },
                          child: Image.asset("assets/images/rotate_cam.png"),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return Container();
            }
          },
        ),
      );
    }

    return Scaffold(
      body: Text("Não há câmeras disponíveis"),
    );
  }

  Future<void> _initCamera(CameraDescription? description) async {
    if (description == null) {
      return;
    }

    _controller = CameraController(description, ResolutionPreset.low,enableAudio: false);
    _initializeControllerFuture = _controller.initialize();
  }
}