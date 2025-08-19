import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class BrowserScreen extends StatefulWidget {
  @override
  _BrowserScreenState createState() => _BrowserScreenState();
}

class _BrowserScreenState extends State<BrowserScreen> {
  late WebViewController _controller;
  final TextEditingController _urlController = TextEditingController();
  String _currentUrl = 'https://www.google.com';
  bool _isLoading = true;
  bool _canGoBack = false;
  bool _canGoForward = false;
  List<String> _history = [];
  List<Map<String, String>> _bookmarks = [];
  bool _showBookmarks = false;

  @override
  void initState() {
    super.initState();
    _urlController.text = _currentUrl;
    _loadBookmarks();
    _initializeWebView();
  }

  void _initializeWebView() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar
          },
          onPageStarted: (String url) {
            setState(() {
              _isLoading = true;
              _currentUrl = url;
              _urlController.text = url;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              _isLoading = false;
              _currentUrl = url;
              _urlController.text = url;
            });
            _updateNavigationButtons();
            _addToHistory(url);
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('Page resource error: ${error.description}');
          },
        ),
      )
      ..loadRequest(Uri.parse(_currentUrl));
  }

  void _updateNavigationButtons() async {
    final canGoBack = await _controller.canGoBack();
    final canGoForward = await _controller.canGoForward();
    setState(() {
      _canGoBack = canGoBack;
      _canGoForward = canGoForward;
    });
  }

  void _addToHistory(String url) {
    if (!_history.contains(url)) {
      _history.add(url);
      _saveHistory();
    }
  }

  void _saveHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('browser_history', _history);
  }



  void _saveBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    final bookmarksJson = _bookmarks.map((bookmark) => jsonEncode(bookmark)).toList();
    await prefs.setStringList('browser_bookmarks', bookmarksJson);
  }

  void _loadBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    final bookmarksJson = prefs.getStringList('browser_bookmarks') ?? [];
    setState(() {
      _bookmarks = bookmarksJson
          .map((json) => Map<String, String>.from(jsonDecode(json)))
          .toList();
    });
  }

  void _addBookmark() {
    showDialog(
      context: context,
      builder: (context) {
        final titleController = TextEditingController();
        return AlertDialog(
          backgroundColor: Colors.grey[900],
          title: Text('Yer İmi Ekle', style: TextStyle(color: Colors.white)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Başlık',
                  labelStyle: TextStyle(color: Colors.grey),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text(
                'URL: $_currentUrl',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('İptal', style: TextStyle(color: Colors.grey)),
            ),
            TextButton(
              onPressed: () {
                if (titleController.text.isNotEmpty) {
                  setState(() {
                    _bookmarks.add({
                      'title': titleController.text,
                      'url': _currentUrl,
                    });
                  });
                  _saveBookmarks();
                }
                Navigator.pop(context);
              },
              child: Text('Ekle', style: TextStyle(color: Colors.orange)),
            ),
          ],
        );
      },
    );
  }

  void _navigateToUrl(String url) {
    if (!url.startsWith('http://') && !url.startsWith('https://')) {
      url = 'https://' + url;
    }
    _controller.loadRequest(Uri.parse(url));
    setState(() {
      _showBookmarks = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: Text('Tarayıcı', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.bookmark_add, color: Colors.white),
            onPressed: _addBookmark,
          ),
          IconButton(
            icon: Icon(
              _showBookmarks ? Icons.web : Icons.bookmarks,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                _showBookmarks = !_showBookmarks;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // URL Bar
          Container(
            color: Colors.grey[900],
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: _canGoBack ? Colors.white : Colors.grey,
                  ),
                  onPressed: _canGoBack
                      ? () {
                          _controller.goBack();
                        }
                      : null,
                ),
                IconButton(
                  icon: Icon(
                    Icons.arrow_forward,
                    color: _canGoForward ? Colors.white : Colors.grey,
                  ),
                  onPressed: _canGoForward
                      ? () {
                          _controller.goForward();
                        }
                      : null,
                ),
                IconButton(
                  icon: Icon(Icons.refresh, color: Colors.white),
                  onPressed: () {
                    _controller.reload();
                  },
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                    ),
                    child: TextField(
                      controller: _urlController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'URL girin...',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                      onSubmitted: _navigateToUrl,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.search, color: Colors.white),
                  onPressed: () {
                    _navigateToUrl(_urlController.text);
                  },
                ),
              ],
            ),
          ),
          // Quick Access Buttons
          Container(
            color: Colors.grey[850],
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildQuickAccessButton(
                  'Instagram',
                  Icons.camera_alt,
                  Colors.purple,
                  'https://www.instagram.com',
                ),
                _buildQuickAccessButton(
                  'WhatsApp',
                  Icons.chat,
                  Colors.green,
                  'https://web.whatsapp.com',
                ),
              ],
            ),
          ),
          // Loading indicator
          if (_isLoading)
            LinearProgressIndicator(
              backgroundColor: Colors.grey[800],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
            ),
          // Content
          Expanded(
            child: _showBookmarks ? _buildBookmarksView() : _buildWebView(),
          ),
        ],
      ),
    );
  }

  Widget _buildWebView() {
    return WebViewWidget(controller: _controller);
  }

  Widget _buildBookmarksView() {
    return Container(
      color: Colors.black,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Yer İmleri',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: _bookmarks.isEmpty
                ? Center(
                    child: Text(
                      'Henüz yer imi eklenmemiş',
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    itemCount: _bookmarks.length,
                    itemBuilder: (context, index) {
                      final bookmark = _bookmarks[index];
                      return ListTile(
                        leading: Icon(Icons.bookmark, color: Colors.orange),
                        title: Text(
                          bookmark['title'] ?? '',
                          style: TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          bookmark['url'] ?? '',
                          style: TextStyle(color: Colors.grey),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            setState(() {
                              _bookmarks.removeAt(index);
                            });
                            _saveBookmarks();
                          },
                        ),
                        onTap: () {
                          _navigateToUrl(bookmark['url'] ?? '');
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAccessButton(
    String title,
    IconData icon,
    Color color,
    String url,
  ) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        child: ElevatedButton(
          onPressed: () {
            _navigateToUrl(url);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(icon, size: 18),
              const SizedBox(width: 6),
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }
}