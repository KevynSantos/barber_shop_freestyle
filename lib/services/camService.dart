import 'package:camera/camera.dart';

class CamService
{
  late CameraDescription? firstCamera;

  late CameraDescription? secondCamera;

  Future<void> init()
  async {
    var cameras = await availableCameras();

    int cameraIndex = 0;
    int lastCameraIndex = cameras.length - 1;

    this.firstCamera = lastCameraIndex >= cameraIndex ? cameras[cameraIndex++] : null;
    this.secondCamera = lastCameraIndex >= cameraIndex ? cameras[cameraIndex++] : null;
  }

  close()
  {
    this.firstCamera = null;
    this.secondCamera = null;
  }

  getFirstCamera()
  {
    return this.firstCamera;
  }

  getSecondCamera()
  {
    return this.secondCamera;
  }
}