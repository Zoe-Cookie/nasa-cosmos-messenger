import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nasa_cosmos_messenger/ui/screens/nova_chat_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [const NovaChatScreen(), const Center(child: Text("開發中"))];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(splashColor: Colors.transparent, highlightColor: Colors.transparent),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
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
      ),
    );
  }
}
