import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class PictureScreen extends StatefulWidget {

  final CameraDescription camera;

  const PictureScreen({Key? key, required this.camera}) : super(key: key);

  @override
  _PictureScreenState createState() => _PictureScreenState();

}
/*
class PreviewPictureScreen extends StatelessWidget {
  final String imagePath;
  const PreviewPictureScreen({super.key, required this.imagePath});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Vista previa')),
      body: Image.file(File(imagePath)),
      );
  }
}
*/
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
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menú',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.of(context).pop(); // Close the drawer
                Navigator.of(context).pushNamed('/'); // Navigate to home
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Camera: ${widget.camera.name}'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                try {
                  await _initializeControllerFuture;
                  final image = await _controller.takePicture();
                } catch (e) {
                  print(e);
                  }
              },
              child: Text('Tomar foto'),
            ),
          ],
        ),
      ),
    );
  }
}