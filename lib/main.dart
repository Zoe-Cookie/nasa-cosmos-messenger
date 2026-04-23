import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");
  
  runApp(const NasaCosmosMessenger());
}

class NasaCosmosMessenger extends StatelessWidget {
  const NasaCosmosMessenger({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NASA Cosmos Messenger',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.black)),
      home: NavigationApp(),
    );
  }
}

class NavigationApp extends StatefulWidget {
  const NavigationApp({super.key});

  @override
  State<NavigationApp> createState() => _NavigationAppState();
}

class _NavigationAppState extends State<NavigationApp> {
  int _currentIndex = 0;

  final List<String> _pageTitles = const ['Nova', '收藏'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_pageTitles[_currentIndex])),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Ionicons.planet_outline),
            activeIcon: Icon(Ionicons.planet),
            label: 'Nova',
          ),
          BottomNavigationBarItem(icon: Icon(Ionicons.star_outline), activeIcon: Icon(Ionicons.star), label: '收藏'),
        ],
      ),
      body: <Widget>[Text(""), Text("")][_currentIndex],
    );
  }
}
