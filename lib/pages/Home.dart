import 'package:flutter/material.dart';
import 'package:flutter_application_laboratorio/pages/About.dart';
import 'package:flutter_application_laboratorio/pages/lista.dart';
import 'package:flutter_application_laboratorio/pages/pagina_actividades.dart';
import 'package:flutter_application_laboratorio/pages/preferencias.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override

  State<MyHomePage> createState(){
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {

  
  int _counter = 0;
  bool _Ischecked = false;
  String imageUrl = ' '; 
  
  void _getNewImage() {
    setState(() {
      imageUrl = 'https://picsum.photos/250?image=${17 + _counter}';
    });
  }

  Future<void> _loadPreferences() async {
    
    final prefs = await SharedPreferences.getInstance();
      setState(() {
        _Ischecked = prefs.getBool('Ischecked') ?? false;
        });
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decreaseCounter() {
    setState(() {
      _counter--;
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
              child: const Text(
                'Menú de navegación',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('Lista'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ListaPage(title: 'Lista')),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('About'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AboutPage(title: 'About')),
                 );
              },
            ),
            ListTile(
              leading: Icon(Icons.precision_manufacturing),
              title: Text('Preferencias'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(context, MaterialPageRoute(builder: (context) => PreferencePage(title: 'Preferencias',))).then((_) {
                  _loadPreferences();
                  }
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.precision_manufacturing),
              title: Text('Actividades'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(context, MaterialPageRoute(builder: (context) => PaginaActividades()));
               },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.network('https://picsum.photos/250?image=17',
            width: 250,
            height: 250,
            fit: BoxFit.cover,
            ),
            SvgPicture.asset(
              'Assets/Icons/8666725_globe_icon.svg',
              semanticsLabel: 'Dart Logo',
            ),
            const Text(
              'Has pulsado el botón:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      persistentFooterButtons: botonesbasicos,
    );
  }

  List<Widget> get botonesbasicos {
    return [
      TextButton(onPressed: _incrementCounter, child: Icon(Icons.add)),
      TextButton(onPressed: _decreaseCounter, child: Icon(Icons.remove)),
      TextButton(onPressed: _Ischecked ? _resetCounter : null, child: Icon(Icons.restore), ),
|
    ];
  }
  
}
