import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'book_home_screen.dart';

class SecretScreen extends StatefulWidget {
  @override
  _SecretScreenState createState() => _SecretScreenState();
}

class _SecretScreenState extends State<SecretScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _openInstagram() {
    // Instagram açma işlemi - platform bağımsız
    print('Instagram açılıyor...');
  }

  void _openWhatsApp() {
    // WhatsApp açma işlemi - platform bağımsız
    print('WhatsApp açılıyor...');
  }

  Widget _buildInstagramIframe() {
    return Container(
      color: Colors.black,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.camera_alt,
              size: 80,
              color: Colors.pink,
            ),
            const SizedBox(height: 20),
            const Text(
              'Instagram',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _openInstagram();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                ),
              ),
              child: const Text(
                'Instagram\'ı Aç',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }





  Widget _buildInstagramTab() {
    return Container(
      color: Colors.black,
      child: Column(
        children: [
          // Instagram başlık çubuğu
          Container(
            padding: const EdgeInsets.all(16),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Instagram',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

              ],
            ),
          ),
          // Instagram iframe
          Expanded(
            child: _buildInstagramIframe(),
          ),
        ],
      ),
    );
  }

  Widget _buildWhatsAppIframe() {
    return Container(
      color: Colors.black,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.chat,
              size: 80,
              color: Colors.green,
            ),
            const SizedBox(height: 20),
            const Text(
              'WhatsApp',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _openWhatsApp();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                ),
              ),
              child: const Text(
                'WhatsApp\'ı Aç',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }



  Widget _buildWhatsAppTab() {
    return Container(
      color: Colors.black,
      child: Column(
        children: [
          // WhatsApp başlık çubuğu
          Container(
            padding: const EdgeInsets.all(16),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'WhatsApp',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

              ],
            ),
          ),
          // WhatsApp iframe
          Expanded(
            child: _buildWhatsAppIframe(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: Colors.black,
        middle: const Text(
          'Özel Bölüm',
          style: TextStyle(color: Colors.white),
        ),
        leading: CupertinoButton(
          padding: const EdgeInsets.all(0),
          child: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => BookHomeScreen()),
            );
          },
        ),
      ),
      child: Column(
        children: [
          // Modern Tab Bar with Icons
          Container(
            color: Colors.black,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: const BorderRadius.all(Radius.circular(25)),
                border: Border.all(color: Colors.grey.shade700, width: 1),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        _tabController.animateTo(0);
                        setState(() {});
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: _tabController.index == 0 
                              ? Colors.purple.shade600 
                              : Colors.transparent,
                          borderRadius: const BorderRadius.all(Radius.circular(25)),
                          gradient: _tabController.index == 0 
                              ? LinearGradient(
                                  colors: [Colors.purple.shade600, Colors.pink.shade500],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                )
                              : null,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.camera_alt,
                              color: _tabController.index == 0 ? Colors.white : Colors.grey.shade400,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Instagram',
                              style: TextStyle(
                                color: _tabController.index == 0 ? Colors.white : Colors.grey.shade400,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        _tabController.animateTo(1);
                        setState(() {});
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: _tabController.index == 1 
                              ? Colors.green.shade600 
                              : Colors.transparent,
                          borderRadius: const BorderRadius.all(Radius.circular(25)),
                          gradient: _tabController.index == 1 
                              ? LinearGradient(
                                  colors: [Colors.green.shade600, Colors.green.shade500],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                )
                              : null,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.chat,
                              color: _tabController.index == 1 ? Colors.white : Colors.grey.shade400,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'WhatsApp',
                              style: TextStyle(
                                color: _tabController.index == 1 ? Colors.white : Colors.grey.shade400,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Tab Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildInstagramTab(),
                _buildWhatsAppTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}