# Windows'ta iOS Build Rehberi

Windows bilgisayarınızda iOS uygulaması build etmek için cloud build servislerini kullanmanız gerekiyor.

## Seçenek 1: Codemagic (Önerilen)

### Avantajları
- Ücretsiz plan mevcut (500 build dakikası/ay)
- Flutter'a özel optimize edilmiş
- Kolay kurulum
- TestFlight'a otomatik upload

### Kurulum Adımları

#### 1. Codemagic Hesabı Oluşturma
1. [Codemagic.io](https://codemagic.io) sitesine gidin
2. GitHub hesabınızla giriş yapın
3. "Add application" > "Flutter App"

#### 2. Repository Bağlama
1. GitHub'da projenizi public repository olarak yükleyin
2. Codemagic'te repository'nizi seçin
3. "Start your first build" tıklayın

#### 3. iOS Build Yapılandırması
1. Codemagic dashboard > App settings
2. "iOS code signing" sekmesi
3. Apple Developer hesap bilgilerinizi ekleyin:
   - Apple ID
   - App-specific password
   - Team ID

#### 4. Certificates Upload
1. Mac'te oluşturduğunuz certificates'ları (.p12 format) upload edin
2. Provisioning profile'ları upload edin
3. Bundle ID'yi kontrol edin: `com.gizlikitap.app`

#### 5. Build Başlatma
```yaml
# codemagic.yaml dosyası oluşturun
workflows:
  ios-workflow:
    name: iOS Workflow
    max_build_duration: 120
    environment:
      flutter: stable
      xcode: latest
    scripts:
      - name: Set up code signing settings on Xcode project
        script: xcode-project use-profiles
      - name: Get Flutter packages
        script: flutter packages pub get
      - name: Build ipa for distribution
        script: flutter build ipa --release
    artifacts:
      - build/ios/ipa/*.ipa
    publishing:
      app_store_connect:
        api_key: $APP_STORE_CONNECT_PRIVATE_KEY
        key_id: $APP_STORE_CONNECT_KEY_IDENTIFIER
        issuer_id: $APP_STORE_CONNECT_ISSUER_ID
```

## Seçenek 2: GitHub Actions

### Avantajları
- GitHub ile entegre
- Ücretsiz (public repo için)
- Tam kontrol

### Kurulum

#### 1. GitHub Repository
1. Projenizi GitHub'a public olarak yükleyin
2. `.github/workflows/ios.yml` dosyası oluşturun:

```yaml
name: iOS Build

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  build:
    runs-on: macos-latest
    
    steps:
    - uses: actions/checkout@v3
    
    - name: Setup Flutter
      uses: subosito/flutter-action@v2
      with:
        flutter-version: '3.16.0'
        
    - name: Install dependencies
      run: flutter pub get
      
    - name: Build iOS
      run: flutter build ios --release --no-codesign
      
    - name: Upload artifacts
      uses: actions/upload-artifact@v3
      with:
        name: ios-build
        path: build/ios/iphoneos/Runner.app
```

#### 2. Secrets Ekleme
1. GitHub repository > Settings > Secrets
2. Apple Developer bilgilerinizi ekleyin:
   - `APPLE_ID`
   - `APPLE_PASSWORD`
   - `TEAM_ID`
   - `CERTIFICATE_P12` (base64 encoded)
   - `CERTIFICATE_PASSWORD`

## Seçenek 3: Yerel Mac Erişimi

### MacinCloud
- Saatlik Mac rental servisi
- [MacinCloud.com](https://macincloud.com)
- Uzaktan Mac'e erişim
- Xcode pre-installed

### AWS EC2 Mac Instances
- Amazon'un Mac sunucuları
- Daha pahalı ama güçlü
- Tam kontrol

## Önerilen Workflow

### 1. Geliştirme (Windows)
```bash
# Windows'ta geliştirme ve test
flutter run -d chrome  # Web test
flutter run -d windows # Windows test
```

### 2. iOS Build (Cloud)
1. Kodu GitHub'a push edin
2. Codemagic otomatik build başlatır
3. Build tamamlandığında TestFlight'a otomatik upload

### 3. Test (iPhone)
1. TestFlight uygulamasını açın
2. Yeni build'i indirin
3. Test edin

## Maliyet Analizi

### Codemagic (Ücretsiz Plan)
- 500 build dakikası/ay
- iOS build ~10-15 dakika
- Yaklaşık 30-50 build/ay
- **Maliyet: $0**

### Codemagic (Pro Plan)
- Unlimited builds
- Faster machines
- **Maliyet: $28/ay**

### MacinCloud
- $1/saat
- Build başına ~1 saat
- **Maliyet: Build başına $1**

## Hızlı Başlangıç

### 1. Şimdi Yapılacaklar
```bash
# 1. GitHub repository oluşturun
git init
git add .
git commit -m "Initial commit"
git remote add origin https://github.com/KULLANICI_ADI/gizli-kitap.git
git push -u origin main

# 2. Codemagic.io'ya gidin
# 3. GitHub ile giriş yapın
# 4. Repository'nizi bağlayın
```

### 2. Apple Developer Hesabı
1. [developer.apple.com](https://developer.apple.com) > Enroll
2. $99/yıl ödeme yapın
3. Hesap onayını bekleyin (1-2 gün)

### 3. İlk Build
1. Codemagic'te "Start new build" tıklayın
2. iOS workflow seçin
3. Build'in tamamlanmasını bekleyin
4. TestFlight'ta uygulamanızı görün

## Sorun Giderme

### Build Hataları
- Codemagic logs'ları kontrol edin
- Bundle ID'nin doğru olduğundan emin olun
- Certificates'ların geçerli olduğunu kontrol edin

### TestFlight'ta Görünmüyor
- App Store Connect'te build'in "Processing" durumunu kontrol edin
- Internal testing grubuna eklendiğinden emin olun
- Apple ID'nizin doğru olduğunu kontrol edin

---

**Sonuç**: Windows'ta iOS development için Codemagic en pratik çözümdür. Ücretsiz planla başlayıp ihtiyaca göre upgrade edebilirsiniz.