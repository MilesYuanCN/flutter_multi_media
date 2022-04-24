import 'package:flutter/material.dart';
import 'package:multi_media/audio_player.dart';
import 'package:multi_media/external_surface.dart';
import 'package:multi_media/video_player.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.blueAccent,
        scaffoldBackgroundColor: Colors.black,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        colorScheme: ColorScheme.dark()
      ),
      home: MyHomePage(title: 'multi_media'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  int pageIndex = 0;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: buildBottomNavigationBar(),
      body: buildPage()
    );
  }

  Widget buildBottomNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: Theme.of(context).primaryColor,
      currentIndex: pageIndex,
      items: [
        BottomNavigationBarItem(
          icon: Text('VideoPlayer'),
          label: 'Video'
          ),
        BottomNavigationBarItem(
          icon: Text('AudioPlayer'),
          label: 'Audio'
        ),
        BottomNavigationBarItem(
          icon: Text('ExternalTexture'),
          label: 'Texture'
          ),
      ],
      onTap: (int selectIndex) => setState(() =>{
        pageIndex = selectIndex 
      }),
    );
  }

  Widget buildPage() {
    switch(pageIndex) {
      case 0:
        return DemoVideoPlayer();
      case 1:
        return DemoAudioPlayer();
      case 2:
        return DemoExternalTexture();
      default:
        return Container();
    }
  }
}
