import 'package:demo_app/camerapage.dart';
import 'package:demo_app/qr_code_page.dart';
import 'package:demo_app/statepage.dart';
import 'package:demo_app/apipage.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';

List<CameraDescription> cameras = [];

main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter("boxDirectory");
  var box = await Hive.openBox('testBox');

  box.put('name', 'Sean');

  print('Name: ${box.get('name')}');

  try {
    cameras = await availableCameras();
    var firstCamera = cameras.first;
    runApp(MyApp(
      camera: firstCamera,
    ));
  } on CameraException catch (e) {
    print(e.description);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.camera,
  });

  final CameraDescription camera;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      routes: {
        '/page1': (context) => TakePictureScreen(camera: camera),
        '/page2': (context) => StatePage(),
        '/page3': (context) => APIPage(title: 'API page',),
        '/page4': (context) => QRCodePage(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demo App'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Demo Pages',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Camera Page'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/page1');
              },
            ),
            ListTile(
              title: Text('State Page'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/page2');
              },
            ),
            ListTile(
              title: Text('API Page'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/page3');
              },
            ),
            ListTile(
              title: Text('QR Scanner Page'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/page4');
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Text(
          'Home Page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

class DemoPage extends StatelessWidget {
  final String pageTitle;

  DemoPage(this.pageTitle);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pageTitle),
      ),
      body: Center(
        child: Text(
          pageTitle,
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
