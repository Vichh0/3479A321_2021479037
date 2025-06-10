import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class PictureScreen extends StatefulWidget {

  final CameraDescription camera;

  const PictureScreen({Key? key, required this.camera}) : super(key: key);

  @override
  _PictureScreenState createState() => _PictureScreenState();

}

class _PictureScreenState extends State<PictureScreen> {

  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller.initialize();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Picture Screen'),
      ),
      body: Center(
        child: Text('Camera: ${widget.camera.name}'),
      ),
    );
  }
}