import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:webview_flutter/webview_flutter.dart';
import 'book_home_screen.dart';

class SecretScreen extends StatefulWidget {
  @override
  _SecretScreenState createState() => _SecretScreenState();
}

class _SecretScreenState extends State<SecretScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  late WebViewController _instagramController;
  late WebViewController _whatsappController;
  bool _isInstagramLoading = true;
  bool _isWhatsappLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _initializeWebViews();
  }

  void _initializeWebViews() {
    // Instagram WebView - Incognito mode için özel ayarlar
    _instagramController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setUserAgent('Mozilla/5.0 (iPhone; CPU iPhone OS 15_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.0 Mobile/15E148 Safari/604.1')
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            if (progress == 100) {
              setState(() {
                _isInstagramLoading = false;
              });
            }
          },
          onPageStarted: (String url) {
            setState(() {
              _isInstagramLoading = true;
            });
            // Clear cookies for fresh session
            _clearWebViewData();
          },
          onPageFinished: (String url) {
            setState(() {
              _isInstagramLoading = false;
            });
            // Inject JavaScript to enhance privacy
            _injectPrivacyScript(_instagramController);
          },
          onWebResourceError: (WebResourceError error) {},
        ),
      )
      ..loadRequest(Uri.parse('https://www.instagram.com'));

    // WhatsApp WebView - Incognito mode için özel ayarlar
    _whatsappController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setUserAgent('Mozilla/5.0 (iPhone; CPU iPhone OS 15_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.0 Mobile/15E148 Safari/604.1')
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            if (progress == 100) {
              setState(() {
                _isWhatsappLoading = false;
              });
            }
          },
          onPageStarted: (String url) {
            setState(() {
              _isWhatsappLoading = true;
            });
            // Clear cookies for fresh session
            _clearWebViewData();
          },
          onPageFinished: (String url) {
            setState(() {
              _isWhatsappLoading = false;
            });
            // Inject JavaScript to enhance privacy
            _injectPrivacyScript(_whatsappController);
          },
          onWebResourceError: (WebResourceError error) {},
        ),
      )
      ..loadRequest(Uri.parse('https://web.whatsapp.com'));
  }

  // WebView verilerini temizle (incognito mode)
  void _clearWebViewData() async {
    await WebViewCookieManager().clearCookies();
  }

  // Gizlilik için JavaScript enjekte et
  void _injectPrivacyScript(WebViewController controller) {
    controller.runJavaScript('''
      // Local storage temizle
      localStorage.clear();
      sessionStorage.clear();
      
      // Cache temizle
      if ('caches' in window) {
        caches.keys().then(function(names) {
          names.forEach(function(name) {
            caches.delete(name);
          });
        });
      }
      
      // IndexedDB temizle
      if ('indexedDB' in window) {
        indexedDB.databases().then(databases => {
          databases.forEach(db => {
            indexedDB.deleteDatabase(db.name);
          });
        });
      }
      
      console.log('Privacy mode activated - all local data cleared');
    ''');
  }

  // Tüm verileri temizle ve çık
  void _clearAllDataAndExit() async {
    // Tüm WebView verilerini temizle
    await WebViewCookieManager().clearCookies();
    
    // Her iki WebView'i de yeniden yükle
    _instagramController.reload();
    _whatsappController.reload();
    
    // JavaScript ile tüm verileri temizle
    _injectPrivacyScript(_instagramController);
    _injectPrivacyScript(_whatsappController);
    
    if (Platform.isIOS) {
      HapticFeedback.mediumImpact();
      showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text('Veriler Temizlendi'),
            content: Text('Tüm oturum verileri temizlendi. Yeni hesaplarla giriş yapabilirsiniz.'),
            actions: [
              CupertinoDialogAction(
                child: Text('Tamam'),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushReplacement(
                    CupertinoPageRoute(builder: (context) => BookHomeScreen()),
                  );
                },
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Veriler Temizlendi'),
            content: Text('Tüm oturum verileri temizlendi. Yeni hesaplarla giriş yapabilirsiniz.'),
            actions: [
              TextButton(
                child: Text('Tamam'),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => BookHomeScreen()),
                  );
                },
              ),
            ],
          );
        },
      );
    }
  }

  void _exitSecretMode() {
    if (Platform.isIOS) {
      // iOS için Cupertino dialog
      showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text('Çıkış'),
            content: Text('Gizli moda çıkmak istediğinizden emin misiniz?'),
            actions: [
              CupertinoDialogAction(
                child: Text('İptal'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              CupertinoDialogAction(
                isDestructiveAction: true,
                child: Text('Çıkış'),
                onPressed: () {
                  HapticFeedback.mediumImpact();
                  Navigator.of(context).pop();
                  Navigator.of(context).pushReplacement(
                    CupertinoPageRoute(builder: (context) => BookHomeScreen()),
                  );
                },
              ),
            ],
          );
        },
      );
    } else {
      // Android için Material dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Çıkış'),
            content: Text('Gizli moda çıkmak istediğinizden emin misiniz?'),
            actions: [
              TextButton(
                child: Text('İptal'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('Çıkış'),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => BookHomeScreen()),
                  );
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // iOS için Cupertino tasarımı
    if (Platform.isIOS) {
      return CupertinoPageScaffold(
        backgroundColor: CupertinoColors.black,
        navigationBar: CupertinoNavigationBar(
          backgroundColor: CupertinoColors.systemGrey6.darkColor,
          middle: Text(
            'Gizli Mod',
            style: TextStyle(
              color: CupertinoColors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          leading: CupertinoButton(
            padding: EdgeInsets.zero,
            child: Icon(
              CupertinoIcons.back,
              color: CupertinoColors.white,
            ),
            onPressed: () {
              HapticFeedback.lightImpact();
              _exitSecretMode();
            },
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CupertinoButton(
                padding: EdgeInsets.zero,
                child: Icon(
                  CupertinoIcons.refresh,
                  color: CupertinoColors.white,
                ),
                onPressed: () {
                  HapticFeedback.lightImpact();
                  if (_tabController.index == 0) {
                    _instagramController.reload();
                  } else {
                    _whatsappController.reload();
                  }
                },
              ),
              CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: Icon(
                      CupertinoIcons.clear_circled,
                      color: CupertinoColors.systemRed,
                    ),
                    onPressed: () {
                      HapticFeedback.lightImpact();
                      _clearAllDataAndExit();
                    },
                  ),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: Icon(
                      CupertinoIcons.square_arrow_right,
                      color: CupertinoColors.white,
                    ),
                    onPressed: () {
                      HapticFeedback.lightImpact();
                      _exitSecretMode();
                    },
                  ),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // iOS için segmented control
              Container(
                padding: EdgeInsets.all(16),
                child: CupertinoSlidingSegmentedControl<int>(
                  backgroundColor: CupertinoColors.systemGrey6.darkColor,
                  thumbColor: CupertinoColors.systemGrey4,
                  groupValue: _tabController.index,
                  onValueChanged: (int? value) {
                    if (value != null) {
                      HapticFeedback.selectionClick();
                      _tabController.animateTo(value);
                    }
                  },
                  children: {
                    0: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            CupertinoIcons.camera,
                            color: CupertinoColors.white,
                            size: 16,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Instagram',
                            style: TextStyle(
                              color: CupertinoColors.white,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    1: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            CupertinoIcons.chat_bubble,
                            color: CupertinoColors.white,
                            size: 16,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'WhatsApp',
                            style: TextStyle(
                              color: CupertinoColors.white,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  },
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    // Instagram Tab
                    Stack(
                      children: [
                        WebViewWidget(controller: _instagramController),
                        if (_isInstagramLoading)
                          Container(
                            color: CupertinoColors.black,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CupertinoActivityIndicator(
                                    color: CupertinoColors.white,
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    'Instagram yükleniyor...',
                                    style: TextStyle(
                                      color: CupertinoColors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                    // WhatsApp Tab
                    Stack(
                      children: [
                        WebViewWidget(controller: _whatsappController),
                        if (_isWhatsappLoading)
                          Container(
                            color: CupertinoColors.black,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CupertinoActivityIndicator(
                                    color: CupertinoColors.white,
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    'WhatsApp yükleniyor...',
                                    style: TextStyle(
                                      color: CupertinoColors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
    
    // Android için Material Design
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: Text(
          'Gizli Mod',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: _exitSecretMode,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: Colors.white),
            onPressed: () {
              if (_tabController.index == 0) {
                _instagramController.reload();
              } else {
                _whatsappController.reload();
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.clear_all, color: Colors.red),
            onPressed: _clearAllDataAndExit,
          ),
          IconButton(
            icon: Icon(Icons.exit_to_app, color: Colors.white),
            onPressed: _exitSecretMode,
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey[400],
          tabs: [
            Tab(
              icon: Icon(Icons.camera_alt),
              text: 'Instagram',
            ),
            Tab(
              icon: Icon(Icons.chat),
              text: 'WhatsApp',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Instagram Tab
          Stack(
            children: [
              WebViewWidget(controller: _instagramController),
              if (_isInstagramLoading)
                Container(
                  color: Colors.black,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Instagram yükleniyor...',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
          // WhatsApp Tab
          Stack(
            children: [
              WebViewWidget(controller: _whatsappController),
              if (_isWhatsappLoading)
                Container(
                  color: Colors.black,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'WhatsApp yükleniyor...',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey[800],
        child: Icon(Icons.home, color: Colors.white),
        onPressed: () {
          if (_tabController.index == 0) {
            _instagramController.loadRequest(Uri.parse('https://www.instagram.com'));
          } else {
            _whatsappController.loadRequest(Uri.parse('https://web.whatsapp.com'));
          }
        },
      ),
    );
  }
}