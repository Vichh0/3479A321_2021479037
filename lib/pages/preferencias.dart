import 'package:flutter/material.dart';
import 'package:flutter_application_laboratorio/pages/About.dart';
import 'package:flutter_application_laboratorio/pages/Home.dart';
import 'package:flutter_application_laboratorio/pages/lista.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencePage extends StatefulWidget {
  const PreferencePage({super.key, required this.title});
  final String title;
  @override
  State<PreferencePage> createState(){
    return _PreferencePageState();
  }
}

class _PreferencePageState extends State<PreferencePage> {

  bool Ischecked = false;

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
      setState(() {
        Ischecked = prefs.getBool('Ischecked') ?? false;
        });
  }
  Future<void> _savePreferences() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('Ischecked', Ischecked);
  }
  @override
  void initState() {
  super.initState();
  _loadPreferences();
  }

  @override
  void dispose(){
    super.dispose();
    _savePreferences();
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
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MyHomePage(title: 'Home')),
                );
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
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const PreferencePage(title: 'Preferencias')),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Text('checkbox'),
            Checkbox(value: Ischecked , onChanged: (bool? value){
              setState(() {
                Ischecked = value!;
              });
            })
          ],
        )
      ),
    );
  }
}
