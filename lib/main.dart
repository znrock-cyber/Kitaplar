import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/book_home_screen.dart';
import 'screens/secret_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // iOS için özel tasarım
    if (Platform.isIOS) {
      return CupertinoApp(
        title: 'Kitap Önerileri',
        theme: CupertinoThemeData(
          primaryColor: CupertinoColors.systemBrown,
          scaffoldBackgroundColor: Color(0xFFF5F5DC),
          textTheme: CupertinoTextThemeData(
            primaryColor: CupertinoColors.systemBrown,
          ),
        ),
        home: SplashScreen(),
        debugShowCheckedModeBanner: false,
      );
    }
    
    // Android için Material Design
    return MaterialApp(
      title: 'Kitap Önerileri',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        fontFamily: 'Roboto',
      ),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String _secretCode = '';
  bool _showSecretInput = false;
  int _tapCount = 0;
  DateTime? _lastTap;

  @override
  void initState() {
    super.initState();
    _loadApp();
  }

  void _loadApp() async {
    await Future.delayed(Duration(seconds: 2));
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => BookHomeScreen()),
    );
  }

  void _onLogoTap() {
    final now = DateTime.now();
    if (_lastTap != null && now.difference(_lastTap!).inSeconds > 2) {
      _tapCount = 0;
    }
    _lastTap = now;
    _tapCount++;

    if (_tapCount >= 5) {
      setState(() {
        _showSecretInput = true;
      });
    }
  }

  void _checkSecretCode() {
    if (_secretCode == '1234') {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => SecretScreen()),
      );
    } else {
      setState(() {
        _secretCode = '';
        _showSecretInput = false;
        _tapCount = 0;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Yanlış kod!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // iOS için haptic feedback
    if (Platform.isIOS) {
      return CupertinoPageScaffold(
        backgroundColor: Color(0xFFF5F5DC),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    HapticFeedback.lightImpact(); // iOS haptic feedback
                    _onLogoTap();
                  },
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: CupertinoColors.systemBrown,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: CupertinoColors.systemGrey.withOpacity(0.3),
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Icon(
                      CupertinoIcons.book,
                      size: 60,
                      color: CupertinoColors.white,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Kitap Önerileri',
                  style: CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle.copyWith(
                    color: CupertinoColors.systemBrown,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'En iyi kitapları keşfedin',
                  style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                    color: CupertinoColors.systemGrey,
                  ),
                ),
                if (_showSecretInput) ...[
                  SizedBox(height: 40),
                  Container(
                    width: 200,
                    child: CupertinoTextField(
                      onChanged: (value) => _secretCode = value,
                      obscureText: true,
                      textAlign: TextAlign.center,
                      placeholder: 'Gizli kod',
                      onSubmitted: (_) => _checkSecretCode(),
                    ),
                  ),
                  SizedBox(height: 10),
                  CupertinoButton.filled(
                    onPressed: _checkSecretCode,
                    child: Text('Giriş'),
                  ),
                ],
              ],
            ),
          ),
        ),
      );
    }
    
    // Android için Material Design
    return Scaffold(
      backgroundColor: Color(0xFFF5F5DC),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: _onLogoTap,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.brown[700],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(
                  Icons.menu_book,
                  size: 60,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Kitap Önerileri',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.brown[800],
              ),
            ),
            SizedBox(height: 10),
            Text(
              'En iyi kitapları keşfedin',
              style: TextStyle(
                fontSize: 16,
                color: Colors.brown[600],
              ),
            ),
            if (_showSecretInput) ...[
              SizedBox(height: 40),
              Container(
                width: 200,
                child: TextField(
                  onChanged: (value) => _secretCode = value,
                  obscureText: true,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: 'Gizli kod',
                    border: OutlineInputBorder(),
                  ),
                  onSubmitted: (_) => _checkSecretCode(),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: _checkSecretCode,
                child: Text('Giriş'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}