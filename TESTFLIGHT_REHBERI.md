# TestFlight Beta Test Rehberi

Bu rehber, Gizli Kitap uygulamanızı TestFlight üzerinden beta test için yayınlamanıza yardımcı olacaktır.

## Ön Gereksinimler

### 1. Apple Developer Hesabı
- Apple Developer Program üyeliği (yıllık $99)
- [Apple Developer](https://developer.apple.com) hesabınızla giriş yapın

### 2. Xcode Kurulumu
- Mac bilgisayar gereklidir
- App Store'dan Xcode'u indirin ve kurun
- Xcode Command Line Tools'u kurun: `xcode-select --install`

### 3. Certificates ve Provisioning Profiles

#### A. Development Certificate Oluşturma
1. Xcode'u açın
2. Preferences > Accounts > Apple ID'nizi ekleyin
3. "Manage Certificates" > "+" > "iOS Development"

#### B. App ID Oluşturma
1. [Apple Developer Console](https://developer.apple.com/account) > Certificates, Identifiers & Profiles
2. Identifiers > "+" > App IDs
3. Bundle ID: `com.gizlikitap.app`
4. Capabilities: WebView gerekli yetenekleri seçin

#### C. Provisioning Profile Oluşturma
1. Profiles > "+" > iOS App Development
2. App ID'nizi seçin
3. Certificate'ınızı seçin
4. Test cihazlarınızı ekleyin
5. Profile'ı indirin ve Xcode'a ekleyin

## iOS Build Süreci

### 1. Flutter iOS Build
```bash
# Proje dizinine gidin
cd "c:\Users\ozenk\OneDrive\Masaüstü\uygulama 3"

# iOS release build oluşturun
flutter build ios --release
```

### 2. Xcode ile Archive
1. Xcode'da iOS projesini açın:
   ```bash
   open ios/Runner.xcworkspace
   ```

2. Xcode'da:
   - Product > Scheme > Edit Scheme
   - Run > Build Configuration > Release
   - Product > Archive

3. Archive tamamlandığında "Distribute App" seçin

### 3. App Store Connect'e Upload
1. "App Store Connect" seçin
2. "Upload" seçin
3. Signing options'da "Automatically manage signing" seçin
4. "Upload" butonuna tıklayın

## App Store Connect Yapılandırması

### 1. App Store Connect'te Uygulama Oluşturma
1. [App Store Connect](https://appstoreconnect.apple.com) > My Apps
2. "+" > New App
3. Bilgileri doldurun:
   - Platform: iOS
   - Name: Gizli Kitap
   - Primary Language: Turkish
   - Bundle ID: com.gizlikitap.app
   - SKU: gizlikitap001

### 2. App Information
- **Name**: Gizli Kitap
- **Subtitle**: Kitap Önerileri ve Gizli İçerikler
- **Category**: Books
- **Content Rights**: Kendi içeriğiniz

### 3. Pricing and Availability
- **Price**: Free
- **Availability**: Sadece sizin için test amaçlı

## TestFlight Beta Test Kurulumu

### 1. Internal Testing
1. App Store Connect > TestFlight
2. "Internal Testing" sekmesi
3. "+" > Create New Group
4. Group Name: "Internal Test"
5. Kendinizi test kullanıcısı olarak ekleyin

### 2. Build'i Test Grubuna Atama
1. Upload ettiğiniz build'i seçin
2. "Add to Group" > "Internal Test"
3. Build review'dan geçmesini bekleyin (genellikle birkaç dakika)

### 3. TestFlight App ile Test
1. iPhone'unuza TestFlight uygulamasını indirin
2. Apple ID'nizle giriş yapın
3. "Gizli Kitap" uygulamasını görüp indirebilirsiniz

## Güvenlik ve Gizlilik

### Internal Testing Avantajları
- Sadece siz erişebilirsiniz
- App Store review süreci yoktur
- Anında test edebilirsiniz
- 100 internal tester limiti
- 90 gün boyunca geçerli

### Dikkat Edilecekler
- Bundle ID'yi değiştirmeyin: `com.gizlikitap.app`
- Test sırasında gerçek veriler kullanmayın
- Beta sürümü herkese açık değildir

## Sorun Giderme

### Build Hataları
```bash
# Pod'ları temizle ve yeniden kur
cd ios
rm -rf Pods Podfile.lock
pod install
cd ..
flutter clean
flutter pub get
```

### Signing Hataları
- Xcode > Preferences > Accounts > Apple ID'nizi kontrol edin
- Provisioning Profile'ların güncel olduğundan emin olun
- Bundle ID'nin doğru olduğunu kontrol edin

### Upload Hataları
- Internet bağlantınızı kontrol edin
- Xcode'un güncel olduğundan emin olun
- Apple Developer hesabınızın aktif olduğunu kontrol edin

## Sonraki Adımlar

1. **Test Süreci**: Uygulamayı kapsamlı test edin
2. **Bug Fixes**: Testte bulunan hataları düzeltin
3. **New Builds**: Güncellemeler için yeni build'ler yükleyin
4. **Production**: Test tamamlandığında App Store review'a gönderin

---

**Not**: Bu rehber test amaçlı internal beta için hazırlanmıştır. Uygulamanız sadece sizin erişiminizde olacak ve herkese açık olmayacaktır.