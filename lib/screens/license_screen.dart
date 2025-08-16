import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LicenseScreen extends StatelessWidget {
  const LicenseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lisans Bilgileri',
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
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Icon(
                      Icons.gavel,
                      size: 60,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Center(
                    child: Text(
                      'Lisans ve Patent Bilgileri',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Center(
                    child: Text(
                      'Copyright © 2025 Gizli Kitap Uygulaması',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  _buildSection(
                    'Lisans Türü',
                    'MIT License with Patent Protection',
                    Icons.verified_user,
                  ),
                  _buildSection(
                    'Patent Koruması',
                    'Bu yazılım ve temel algoritmaları, kullanıcı arayüzü tasarımları ve yenilikçi özellikleri bekleyen ve verilmiş patentlerle korunmaktadır.',
                    Icons.security,
                  ),
                  _buildSection(
                    'Korunan Alanlar',
                    '• Kullanıcı arayüzü tasarım desenleri\n• Veri şifreleme ve güvenlik algoritmaları\n• İçerik organizasyonu ve görüntüleme yöntemleri\n• Kullanıcı kimlik doğrulama mekanizmaları',
                    Icons.shield,
                  ),
                  _buildSection(
                    'Ticari Kullanım',
                    'Bu yazılımın ticari kullanımı ayrı bir ticari lisans gerektirir. Ticari lisanslama koşulları için telif hakkı sahibi ile iletişime geçin.',
                    Icons.business,
                  ),
                  _buildSection(
                    'Marka Tescili',
                    '"Gizli Kitap" tescilli bir markadır. Bu markanın kullanımı marka sahibinden açık izin gerektirir.',
                    Icons.copyright,
                  ),
                  _buildSection(
                    'Yasal Uyarı',
                    'Bu yazılım "OLDUĞU GİBİ" sağlanır, açık veya zımni hiçbir garanti verilmez. Yazarlar veya telif hakkı sahipleri hiçbir durumda herhangi bir talep, zarar veya diğer yükümlülüklerden sorumlu tutulamaz.',
                    Icons.warning,
                  ),
                  _buildSection(
                    'İletişim',
                    'Lisanslama sorguları, patent bilgileri veya ticari kullanım izinleri için:\nE-posta: legal@gizlikitap.com',
                    Icons.contact_mail,
                  ),
                  const SizedBox(height: 30),
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.amber.withOpacity(0.1),
                      border: Border.all(color: Colors.amber),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.info, color: Colors.amber),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Bu uygulamanın kullanımı, yukarıdaki lisans koşullarının kabul edildiği anlamına gelir.',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
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
                          borderRadius: BorderRadius.circular(25),
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

  Widget _buildSection(String title, String content, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.white, size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 28),
            child: Text(
              content,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white70,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}