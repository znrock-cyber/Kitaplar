import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'secret_screen.dart';

class BookHomeScreen extends StatefulWidget {
  @override
  _BookHomeScreenState createState() => _BookHomeScreenState();
}

class _BookHomeScreenState extends State<BookHomeScreen> {
  int _tapCount = 0;
  DateTime? _lastTap;
  String _secretCode = '';
  bool _showSecretInput = false;

  final List<Map<String, String>> books = [
    {
      'title': 'Suç ve Ceza',
      'author': 'Fyodor Dostoyevski',
      'description': 'Rus edebiyatının başyapıtlarından biri.',
      'rating': '4.8'
    },
    {
      'title': 'Simyacı',
      'author': 'Paulo Coelho',
      'description': 'Kişisel efsanenizi yaşama dair ilham verici bir hikaye.',
      'rating': '4.6'
    },
    {
      'title': '1984',
      'author': 'George Orwell',
      'description': 'Distopik gelecek hakkında düşündürücü bir roman.',
      'rating': '4.7'
    },
    {
      'title': 'Küçük Prens',
      'author': 'Antoine de Saint-Exupéry',
      'description': 'Çocuksu masumiyetin güzelliği.',
      'rating': '4.9'
    },
    {
      'title': 'Satranç',
      'author': 'Stefan Zweig',
      'description': 'İnsan psikolojisinin derinliklerine yolculuk.',
      'rating': '4.5'
    },
  ];

  void _onTitleTap() {
    final now = DateTime.now();
    if (_lastTap != null && now.difference(_lastTap!).inSeconds > 3) {
      _tapCount = 0;
    }
    _lastTap = now;
    _tapCount++;

    if (_tapCount >= 7) {
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
    // iOS için Cupertino tasarımı
    if (Platform.isIOS) {
      return CupertinoPageScaffold(
        backgroundColor: Color(0xFFF5F5DC),
        navigationBar: CupertinoNavigationBar(
          backgroundColor: CupertinoColors.systemBrown,
          middle: GestureDetector(
            onTap: () {
              HapticFeedback.lightImpact();
              _onTitleTap();
            },
            child: Text(
              'Kitap Önerileri',
              style: TextStyle(
                color: CupertinoColors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CupertinoButton(
                padding: EdgeInsets.zero,
                child: Icon(
                  CupertinoIcons.search,
                  color: CupertinoColors.white,
                ),
                onPressed: () {
                  HapticFeedback.lightImpact();
                },
              ),
              CupertinoButton(
                padding: EdgeInsets.zero,
                child: Icon(
                  CupertinoIcons.heart,
                  color: CupertinoColors.white,
                ),
                onPressed: () {
                  HapticFeedback.lightImpact();
                },
              ),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              if (_showSecretInput)
                Container(
                  padding: EdgeInsets.all(16),
                  color: CupertinoColors.systemGrey6,
                  child: Row(
                    children: [
                      Expanded(
                        child: CupertinoTextField(
                          onChanged: (value) => _secretCode = value,
                          obscureText: true,
                          placeholder: 'Gizli kod',
                          onSubmitted: (_) => _checkSecretCode(),
                        ),
                      ),
                      SizedBox(width: 10),
                      CupertinoButton.filled(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        onPressed: _checkSecretCode,
                        child: Text('Giriş'),
                      ),
                    ],
                  ),
                ),
              Container(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(
                      CupertinoIcons.chart_bar_alt_fill,
                      color: CupertinoColors.systemBrown,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Popüler Kitaplar',
                      style: CupertinoTheme.of(context).textTheme.navTitleTextStyle.copyWith(
                        color: CupertinoColors.systemBrown,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  itemCount: books.length,
                  itemBuilder: (context, index) {
                    final book = books[index];
                    return Container(
                      margin: EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: CupertinoColors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: CupertinoColors.systemGrey.withOpacity(0.2),
                            blurRadius: 8,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: CupertinoButton(
                        padding: EdgeInsets.all(16),
                        onPressed: () {
                          HapticFeedback.lightImpact();
                        },
                        child: Row(
                          children: [
                            Container(
                              width: 60,
                              height: 80,
                              decoration: BoxDecoration(
                                color: CupertinoColors.systemBrown,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                CupertinoIcons.book,
                                color: CupertinoColors.white,
                                size: 30,
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    book['title']!,
                                    style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: CupertinoColors.systemBrown,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    book['author']!,
                                    style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                                      fontSize: 14,
                                      color: CupertinoColors.systemGrey,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    book['description']!,
                                    style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                                      fontSize: 12,
                                      color: CupertinoColors.systemGrey2,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(
                                        CupertinoIcons.star_fill,
                                        color: CupertinoColors.systemYellow,
                                        size: 16,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        book['rating']!,
                                        style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: CupertinoColors.systemBrown,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              CupertinoIcons.chevron_right,
                              color: CupertinoColors.systemGrey,
                              size: 16,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    }
    
    // Android için Material Design
    return Scaffold(
      backgroundColor: Color(0xFFF5F5DC),
      appBar: AppBar(
        backgroundColor: Colors.brown[700],
        title: GestureDetector(
          onTap: _onTitleTap,
          child: Text(
            'Kitap Önerileri',
            style: TextStyle(color: Colors.white),
          ),
        ),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.favorite_border, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          if (_showSecretInput)
            Container(
              padding: EdgeInsets.all(16),
              color: Colors.brown[100],
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (value) => _secretCode = value,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Gizli kod',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      ),
                      onSubmitted: (_) => _checkSecretCode(),
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _checkSecretCode,
                    child: Text('Giriş'),
                  ),
                ],
              ),
            ),
          Container(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(Icons.trending_up, color: Colors.brown[700]),
                SizedBox(width: 8),
                Text(
                  'Popüler Kitaplar',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown[800],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemCount: books.length,
              itemBuilder: (context, index) {
                final book = books[index];
                return Card(
                  margin: EdgeInsets.only(bottom: 16),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Container(
                          width: 60,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.brown[300],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.menu_book,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                book['title']!,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.brown[800],
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                book['author']!,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.brown[600],
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                book['description']!,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[700],
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 16,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    book['rating']!,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.brown[700],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.brown[400],
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.brown[700],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.brown[300],
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Ana Sayfa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Kategoriler',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}