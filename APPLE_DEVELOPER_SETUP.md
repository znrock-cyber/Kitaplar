# Apple Developer Hesabı Kurulumu ve App Store Yayınlama Rehberi

## 1. Apple Developer Hesabı Oluşturma

### Gerekli Bilgiler
- Apple ID (iCloud hesabı)
- Kredi kartı veya banka kartı
- Yıllık ücret: $99 USD (yaklaşık ₺2,800)
- Kimlik doğrulama belgeleri

### Adım Adım Kurulum

#### 1.1 Apple Developer Portal'a Kayıt
```
1. https://developer.apple.com adresine gidin
2. "Account" butonuna tıklayın
3. Apple ID ile giriş yapın
4. "Join the Apple Developer Program" seçeneğini seçin
5. "Enroll" butonuna tıklayın
```

#### 1.2 Hesap Türü Seçimi
```
• Individual (Bireysel): Kişisel geliştirici hesabı
• Organization (Kurumsal): Şirket hesabı (D-U-N-S numarası gerekli)

Önerilen: Individual (daha hızlı onay)
```

#### 1.3 Kimlik Doğrulama
```
1. Kişisel bilgilerinizi girin
2. Telefon numaranızı doğrulayın
3. Kimlik belgesi yükleyin (ehliyet, pasaport)
4. Ödeme bilgilerini girin
5. Sözleşmeleri kabul edin
```

#### 1.4 Onay Süreci
```
• Onay süresi: 24-48 saat
• Bazen 1 hafta kadar sürebilir
• E-posta ile bildirim gelir
• Hesap aktif olduktan sonra geliştirmeye başlayabilirsiniz
```

## 2. Xcode ve Geliştirme Ortamı Kurulumu

### 2.1 Xcode İndirme
```
1. Mac App Store'dan Xcode'u indirin (ücretsiz)
2. Alternatif: developer.apple.com'dan beta sürümler
3. Minimum macOS gereksinimi: macOS 12.5+
4. Önerilen: En son macOS sürümü
```

### 2.2 Command Line Tools
```bash
# Terminal'de çalıştırın
xcode-select --install
```

### 2.3 Flutter iOS Kurulumu
```bash
# Flutter doctor ile kontrol edin
flutter doctor

# iOS simulator kurulumu
open -a Simulator

# CocoaPods kurulumu (gerekirse)
sudo gem install cocoapods
```

## 3. Sertifika ve Provisioning Profile Oluşturma

### 3.1 Development Certificate
```
1. Xcode > Preferences > Accounts
2. Apple ID'nizi ekleyin
3. "Manage Certificates" tıklayın
4. "+" butonuna basın
5. "iOS Development" seçin
6. Sertifika otomatik oluşturulur
```

### 3.2 Distribution Certificate
```
1. developer.apple.com > Certificates, Identifiers & Profiles
2. Certificates > "+" butonuna tıklayın
3. "iOS Distribution" seçin
4. Certificate Signing Request (CSR) yükleyin
5. Sertifikayı indirin ve Keychain'e ekleyin
```

### 3.3 App ID Oluşturma
```
1. Identifiers > App IDs > "+" butonuna tıklayın
2. "App" seçin
3. Description: "Gizli Kitap App"
4. Bundle ID: com.gizlikitap.app
5. Capabilities seçin (gerekirse)
6. "Continue" ve "Register"
```

### 3.4 Provisioning Profile
```
1. Profiles > "+" butonuna tıklayın
2. "App Store" seçin (distribution için)
3. App ID'yi seçin
4. Distribution certificate'ı seçin
5. Profile adı: "Gizli Kitap Distribution"
6. "Generate" ve indirin
```

## 4. App Store Connect Kurulumu

### 4.1 App Store Connect'e Giriş
```
1. https://appstoreconnect.apple.com adresine gidin
2. Apple Developer hesabınızla giriş yapın
3. "My Apps" sekmesine gidin
4. "+" butonuna tıklayın
5. "New App" seçin
```

### 4.2 Uygulama Bilgileri
```
• Platform: iOS
• Name: Gizli Kitap
• Primary Language: Turkish
• Bundle ID: com.gizlikitap.app
• SKU: GIZLIKITAP001
```

### 4.3 App Information
```
• Subtitle: Kitap Önerileri ve Gizli İçerikler
• Category: Books
• Secondary Category: Education
• Content Rights: Evet (kendi içeriğiniz)
• Age Rating: 4+ (Everyone)
```

### 4.4 Pricing and Availability
```
• Price: Free (Ücretsiz)
• Availability: All Countries
• App Store Distribution: Evet
```

## 5. Uygulama Metadata'sı Ekleme

### 5.1 App Store Listing
```
1. App Information > App Store Listing
2. APP_STORE_METADATA.md dosyasındaki bilgileri kullanın:
   - App Name: Gizli Kitap
   - Subtitle: Kitap Önerileri ve Gizli İçerikler
   - Description: Detaylı açıklamayı kopyalayın
   - Keywords: Anahtar kelimeleri ekleyin
   - Support URL: https://gizlikitap.com/support
   - Marketing URL: https://gizlikitap.com
```

### 5.2 Ekran Görüntüleri
```
Gerekli boyutlar:
• iPhone 6.7": 1290 x 2796 px (5 adet)
• iPhone 6.5": 1242 x 2688 px (5 adet)
• iPhone 5.5": 1242 x 2208 px (5 adet)
• iPad Pro 12.9": 2048 x 2732 px (5 adet)

İpucu: Simulator'da ekran görüntüsü alın
Device > Screenshot (Cmd+S)
```

### 5.3 App Icon
```
• Boyut: 1024 x 1024 px
• Format: PNG (alpha kanalı olmadan)
• Tasarım önerisi: Kitap simgesi, mor/kahverengi tema
```

## 6. Build Oluşturma ve Yükleme

### 6.1 Release Build Hazırlama
```bash
# Proje dizininde
cd "c:\Users\ozenk\OneDrive\Belgeler\gizli uygulama"

# iOS dependencies
cd ios
pod install
cd ..

# Release build
flutter build ios --release
```

### 6.2 Xcode ile Archive
```
1. ios/Runner.xcworkspace dosyasını Xcode ile açın
2. Product > Scheme > Edit Scheme
3. Run > Build Configuration > Release
4. Product > Archive
5. Archive tamamlandıktan sonra "Distribute App"
6. "App Store Connect" seçin
7. "Upload" seçin
8. Sertifika ve provisioning profile seçin
9. "Upload" butonuna tıklayın
```

### 6.3 TestFlight (Beta Test)
```
1. App Store Connect > TestFlight
2. Yüklenen build'i seçin
3. "Beta App Review Information" doldurun
4. Test kullanıcıları ekleyin
5. "Start Testing" butonuna tıklayın
```

## 7. App Store Review Süreci

### 7.1 Review Öncesi Kontrol
```
✅ Uygulama çökmüyor
✅ Tüm özellikler çalışıyor
✅ Gizlilik politikası eklendi
✅ Metadata eksiksiz
✅ Ekran görüntüleri güncel
✅ App icon doğru boyutta
✅ Test kullanıcı hesabı (gerekirse)
```

### 7.2 Review Gönderimi
```
1. App Store Connect > App Store
2. "+ Version or Platform" tıklayın
3. Version: 1.0.0
4. "What's New in This Version" doldurun
5. Build seçin
6. "Submit for Review" tıklayın
```

### 7.3 Review Süresi
```
• Ortalama süre: 24-48 saat
• Bazen 7 güne kadar çıkabilir
• Red durumunda düzeltme yapıp tekrar gönderin
• Onaylandıktan sonra "Release This Version" tıklayın
```

## 8. Yaygın Sorunlar ve Çözümler

### 8.1 Code Signing Hataları
```
Hata: "No matching provisioning profiles found"
Çözüm:
1. Xcode > Preferences > Accounts
2. "Download Manual Profiles" tıklayın
3. Project > Signing & Capabilities
4. "Automatically manage signing" işaretleyin
```

### 8.2 Build Hataları
```
Hata: "CocoaPods not installed"
Çözüm:
sudo gem install cocoapods
cd ios && pod install

Hata: "Flutter not found"
Çözüm:
export PATH="$PATH:`pwd`/flutter/bin"
```

### 8.3 App Store Red Sebepleri
```
• Eksik gizlilik politikası
• Çökme veya bug'lar
• Metadata uyumsuzluğu
• Telif hakkı ihlali
• Apple'ın kurallarına aykırılık
```

## 9. Yayın Sonrası

### 9.1 App Store Optimization (ASO)
```
• Anahtar kelime optimizasyonu
• Ekran görüntülerini güncelleme
• Kullanıcı yorumlarına yanıt verme
• Düzenli güncellemeler
```

### 9.2 Analytics ve Takip
```
• App Store Connect Analytics
• Firebase Analytics (opsiyonel)
• Kullanıcı geri bildirimleri
• Crash raporları
```

### 9.3 Güncellemeler
```
• Yeni özellikler ekleyin
• Bug'ları düzeltin
• iOS güncellemelerine uyum sağlayın
• Düzenli olarak yeni sürümler çıkarın
```

## 10. Maliyet Hesabı

### 10.1 Zorunlu Maliyetler
```
• Apple Developer Program: $99/yıl (~₺2,800)
• Mac bilgisayar (gerekirse): ₺25,000-₺100,000
• Toplam minimum: ~₺2,800/yıl
```

### 10.2 Opsiyonel Maliyetler
```
• App Store Optimization araçları: $50-200/ay
• Analytics araçları: $0-100/ay
• Marketing: Değişken
• Tasarım hizmetleri: ₺1,000-₺10,000
```

---

## 🚀 Hızlı Başlangıç Checklist

```
□ Apple Developer hesabı oluştur ($99)
□ Xcode'u indir ve kur
□ Flutter iOS kurulumunu tamamla
□ Sertifika ve provisioning profile oluştur
□ App Store Connect'te uygulama kaydı yap
□ Metadata ve ekran görüntülerini hazırla
□ Release build oluştur
□ Xcode ile archive ve upload yap
□ TestFlight ile beta test yap
□ App Store review'a gönder
□ Onay bekle ve yayınla
```

**Not:** Bu süreç ilk kez 1-2 hafta sürebilir. Deneyim kazandıkça daha hızlı olacaktır.