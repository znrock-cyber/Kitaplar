import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Gizlilik Politikası',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.deepPurple, Colors.purple],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 8,
            color: Colors.grey[900],
            shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(Radius.circular(15)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Icon(
                      Icons.privacy_tip,
                      size: 60,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Center(
                    child: Text(
                      'Gizlilik Politikası',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Center(
                    child: Text(
                      'Son Güncelleme: 16 Ocak 2025',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  _buildSection(
                    'Giriş',
                    'Bu gizlilik politikası, "Kitap Önerileri" mobil uygulamasının kullanıcılarının kişisel verilerinin nasıl toplandığı, kullanıldığı ve korunduğu hakkında bilgi vermektedir.',
                  ),
                  _buildSection(
                    'Toplanan Bilgiler',
                    '• Cihaz bilgileri (model, işletim sistemi)\n• Uygulama kullanım istatistikleri\n• Çökme raporları ve hata günlükleri\n• Kullanıcı ayarları ve tercihleri',
                  ),
                  _buildSection(
                    'Bilgilerin Kullanımı',
                    'Toplanan bilgiler uygulamanın performansını iyileştirmek, teknik sorunları çözmek, kullanıcı deneyimini geliştirmek ve güvenlik açıklarını tespit etmek için kullanılır.',
                  ),
                  _buildSection(
                    'Veri Güvenliği',
                    'Kişisel verilerinizi korumak için şifreleme teknolojileri, güvenli veri depolama, düzenli güvenlik denetimleri ve erişim kontrolü önlemlerini alıyoruz.',
                  ),
                  _buildSection(
                    'Kullanıcı Hakları',
                    '• Kişisel verilerine erişim hakkı\n• Verilerin düzeltilmesi hakkı\n• Verilerin silinmesi hakkı\n• Veri işlemeye itiraz etme hakkı',
                  ),
                  _buildSection(
                    'Çocukların Gizliliği',
                    'Uygulamamız 13 yaş altındaki çocuklardan bilerek kişisel bilgi toplamaz.',
                  ),
                  _buildSection(
                    'İletişim',
                    'Gizlilik politikası hakkında sorularınız için:\nE-posta: privacy@kitaponerileri.com',
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        HapticFeedback.lightImpact();
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      label: const Text(
                        'Geri Dön',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 15,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: const BorderRadius.all(Radius.circular(25)),
                        ),
                        elevation: 5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white70,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}