# 📱 Gizli Kitap Uygulaması - Kurulum Rehberi

## 🚀 Hızlı Başlangıç

### 1️⃣ Sistem Kontrolü
```bash
# Windows'ta çift tıklayın:
check_requirements.bat
```

### 2️⃣ Android Kurulumu
```bash
# Windows'ta çift tıklayın:
setup.bat
```

### 3️⃣ iOS Kurulumu (macOS gerekli)
```bash
# Terminal'de çalıştırın:
chmod +x setup_ios.sh
./setup_ios.sh
```

## 📋 Gereksinimler

### 🔧 Temel Gereksinimler
- **Flutter SDK** (3.0.0+)
- **Dart SDK** (Flutter ile birlikte gelir)
- **Git** (Flutter kurulumu için)

### 📱 Android için
- **Android Studio** veya **VS Code**
- **Android SDK** (API 21+)
- **Java JDK** (8 veya üzeri)
- **Android Emulator** veya fiziksel cihaz

### 🍎 iOS için
- **macOS** (zorunlu)
- **Xcode** (App Store'dan ücretsiz)
- **CocoaPods** (`sudo gem install cocoapods`)
- **iOS Simulator** veya fiziksel iPhone/iPad
- **Apple Developer hesabı** (fiziksel cihaz için)

## 📥 Flutter SDK Kurulumu

### Windows
1. [Flutter resmi sitesi](https://flutter.dev/docs/get-started/install/windows) ziyaret edin
2. Flutter SDK zip dosyasını indirin
3. `C:\flutter` klasörüne çıkarın
4. PATH değişkenine `C:\flutter\bin` ekleyin
5. Bilgisayarı yeniden başlatın
6. `flutter doctor` komutunu çalıştırın

### macOS
```bash
# Homebrew ile
brew install flutter

# Veya manuel kurulum
# 1. Flutter SDK indirin
# 2. ~/development klasörüne çıkarın
# 3. PATH'e ekleyin: export PATH="$PATH:`pwd`/flutter/bin"
```

## 🔧 Kurulum Adımları

### Adım 1: Proje Klonlama
```bash
# Proje zaten mevcut:
cd "c:\Users\ozenk\OneDrive\Belgeler\gizli uygulama"
```

### Adım 2: Bağımlılıkları Yükleme
```bash
flutter pub get
```

### Adım 3: Cihaz Kontrolü
```bash
flutter devices
```

### Adım 4: Uygulamayı Çalıştırma
```bash
# Geliştirme modu
flutter run

# Release modu (Android)
flutter run --release
```

## 📦 APK/IPA Oluşturma

### Android APK
```bash
# Release APK
flutter build apk --release

# APK konumu:
# build/app/outputs/flutter-apk/app-release.apk
```

### iOS IPA (macOS gerekli)
```bash
# iOS pods yükleme
cd ios
pod install
cd ..

# iOS build
flutter build ios --release

# Xcode'da imzalama
open ios/Runner.xcworkspace
```

## 📱 Fiziksel Cihaza Kurulum

### Android
1. **Geliştirici Seçenekleri**'ni açın
2. **USB Hata Ayıklama**'yı etkinleştirin
3. Cihazı USB ile bağlayın
4. `flutter run` komutunu çalıştırın

### iOS
1. **Xcode**'da `ios/Runner.xcworkspace` açın
2. **Bundle Identifier** ayarlayın
3. **Development Team** seçin
4. Cihazı bağlayın ve **güven** ayarları yapın
5. **Run** butonuna basın

## 🎯 Uygulama Kullanımı

### Normal Mod
- Kitap önerileri görüntüleme
- Kitap detayları inceleme
- Kitap arama ve filtreleme

### Gizli Mod
1. Ana ekranda **başlığa 7 kez** dokunun
2. **Gizli kod girişi** görünür
3. **"1234"** kodunu girin
4. **Instagram** ve **WhatsApp** web erişimi

## 🔒 Güvenlik Özellikleri

- ✅ Uygulama arka plana geçtiğinde ekran bulanıklaştırma
- ✅ Gizli kod koruması (varsayılan: "1234")
- ✅ Güvenli çıkış onayları
- ✅ iOS haptic feedback
- ✅ Platform özel tasarım (iOS/Android)

## 🛠️ Sorun Giderme

### Flutter Doctor Sorunları
```bash
flutter doctor
flutter doctor --android-licenses
```

### Android SDK Sorunları
```bash
flutter config --android-sdk /path/to/android/sdk
```

### iOS Sorunları
```bash
cd ios
pod repo update
pod install
```

### Bağımlılık Sorunları
```bash
flutter clean
flutter pub get
```

## 📞 Destek

Sorun yaşarsanız:
1. `flutter doctor` çıktısını kontrol edin
2. Hata mesajlarını kaydedin
3. Flutter resmi dokümantasyonunu inceleyin

## 🎉 Başarılı Kurulum

Kurulum başarılı olduğunda:
- ✅ Uygulama cihazınızda çalışır
- ✅ Kitap önerileri görüntülenir
- ✅ Gizli mod erişimi çalışır
- ✅ Instagram/WhatsApp web erişimi aktif

**Uygulamanız kullanıma hazır! 🎊**