import 'package:flutter/material.dart';
import 'package:flutter_application_laboratorio/pages/Home.dart';
import 'package:flutter_application_laboratorio/pages/lista.dart';
import 'package:flutter_application_laboratorio/pages/preferencias.dart';
import 'package:flutter_svg/svg.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key, required this.title});

  final String title;

  @override

  State<AboutPage> createState(){
    return _AboutPageState();
  }
}

class _AboutPageState extends State<AboutPage> {
  int _counter = 0;

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
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
               Navigator.of(context).pop();
               Navigator.pop(context);
              },
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
              leading: Icon(Icons.precision_manufacturing),
              title: Text('Preferencias'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const PreferencePage(title: 'Preferencias')),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
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
      TextButton(onPressed: _resetCounter, child: Icon(Icons.restore)),
    ];
  }
}
