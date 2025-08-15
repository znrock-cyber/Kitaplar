# iPhone 13 Pro Max Kurulum Rehberi

## Seçenek 1: GitHub Actions ile Online Build (Önerilen)

### Adımlar:
1. Bu projeyi GitHub'a yükleyin
2. GitHub Actions otomatik olarak iOS uygulamasını derleyecek
3. Actions sekmesinden derlenmiş IPA dosyasını indirin
4. iPhone'unuza kurmak için aşağıdaki yöntemlerden birini kullanın:

### iPhone'a Kurulum Yöntemleri:

#### A) TestFlight ile (Apple Developer hesabı gerekli - $99/yıl)
- Apple Developer hesabı açın
- App Store Connect'te uygulama oluşturun
- IPA'yı TestFlight'a yükleyin
- TestFlight uygulaması ile iPhone'unuza kurun

#### B) AltStore ile (Ücretsiz - 7 günde bir yenileme gerekli)
1. Bilgisayarınıza AltServer'ı kurun: https://altstore.io/
2. iPhone'unuza AltStore uygulamasını kurun
3. IPA dosyasını AltStore ile iPhone'unuza yükleyin
4. Her 7 günde bir uygulamayı yenilemeniz gerekir

#### C) Sideloadly ile (Ücretsiz - 7 günde bir yenileme)
1. Sideloadly'yi indirin: https://sideloadly.io/
2. Apple ID'nizi kullanarak IPA'yı iPhone'unuza yükleyin
3. iPhone Ayarlar > Genel > VPN ve Cihaz Yönetimi'nden uygulamaya güvenin

#### D) Xcode ile (macOS gerekli)
1. macOS bilgisayarda Xcode'u açın
2. Projeyi Xcode'da açın
3. iPhone'unuzu USB ile bağlayın
4. "Run" butonuna basarak doğrudan kurun

## Seçenek 2: Codemagic ile Online Build

1. https://codemagic.io/ sitesine gidin
2. GitHub hesabınızla giriş yapın
3. Bu projeyi seçin
4. iOS build ayarlarını yapın
5. Build'i başlatın ve IPA'yı indirin

## Test Etme

### iOS Simülatörde Test:
- GitHub Actions'dan simulator zip dosyasını indirin
- macOS'ta Xcode Simulator'da çalıştırın

### Gerçek Cihazda Test:
- Yukarıdaki kurulum yöntemlerinden birini kullanın
- Uygulamayı açın ve gizli kodu test edin: **2580**

## Önemli Notlar:

⚠️ **Güvenlik**: Bu uygulama gizli içerik barındırdığı için:
- Uygulamayı başkalarıyla paylaşmayın
- Güvenlik kodunu kimseyle paylaşmayın
- Gerektiğinde "Verileri Temizle" özelliğini kullanın

📱 **iOS Özellikleri**:
- Face ID/Touch ID desteği
- iOS 12.0+ uyumlu
- iPhone ve iPad desteği
- Karanlık mod desteği

🔒 **Gizlilik**:
- Uygulama simgesi kitap görünümünde
- Gizli kod ile erişim: 2580
- İncognito mod WebView
- Otomatik veri temizleme

## Sorun Giderme:

**"Güvenilmeyen Geliştirici" Hatası:**
- Ayarlar > Genel > VPN ve Cihaz Yönetimi
- Geliştirici profilinizi bulun ve güvenin

**Uygulama Açılmıyor:**
- iPhone'u yeniden başlatın
- Uygulamayı silip tekrar kurun
- iOS sürümünüzün 12.0+ olduğundan emin olun

**Build Hatası:**
- GitHub Actions loglarını kontrol edin
- pubspec.yaml dosyasındaki bağımlılıkları kontrol edin