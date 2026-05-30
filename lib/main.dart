import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart'; 
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import 'package:pertemuan5/page/dashboard.dart';
import 'package:pertemuan5/auth/auth_page.dart';
import 'package:pertemuan5/page/profile.dart';
import 'package:pertemuan5/page/list_page.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Authentication', 
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const AuthPage(), 
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  final List<Widget> _pages = [
    DashboardPage(),
    ProfilePage(),
    ListPage(),
  ];

  int currentPage = 0; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(currentPage == 0 ? 'Dashboard' : currentPage == 1 ? 'Profile' : 'List'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut(); 
              if (context.mounted) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const AuthPage()),
                );
              }
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),

      body: _pages[currentPage],
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: currentPage,
        onTap: (i) => setState(() => currentPage = i),
        items: [
          SalomonBottomBarItem(
            icon: const Icon(Icons.home),
            title: const Text('Beranda'),
            selectedColor: Colors.blue,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.person),
            title: const Text('Profile'),
            selectedColor: Colors.blue,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.list),
            title: const Text("List"),
            selectedColor: Colors.blue,
          ),
        ],
      ),
    );
  }
}