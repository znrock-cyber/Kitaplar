# Sideloadly İçin iOS Kurulum Rehberi

## 📱 Sideloadly Nedir?

Sideloadly, iOS uygulamalarını App Store olmadan doğrudan cihazınıza yüklemenizi sağlayan ücretsiz bir araçtır. Bu rehber, GitHub Actions ile oluşturulan IPA dosyasını Sideloadly ile nasıl yükleyeceğinizi açıklar.

## 🔧 Gereksinimler

### 1. Apple Developer Account
- **ÜCRETSİZ** Apple ID yeterlidir (ücretli hesap gerekmez)
- 7 günlük sınırlama vardır (her 7 günde bir yeniden yükleme gerekir)

### 2. Gerekli Yazılımlar
- [Sideloadly](https://sideloadly.io/) - İndirin ve kurun
- iTunes (Windows için) veya Finder (macOS için)
- USB kablosu (cihaz bağlantısı için)

## 🛠️ GitHub Secrets Kurulumu

### Gerekli Secrets (Sideloadly için basitleştirilmiş)

```
TEAM_ID                           # Apple Developer Team ID
BUILD_CERTIFICATE_BASE64          # iOS Development Certificate (Base64)
P12_PASSWORD                      # Certificate şifresi
BUILD_PROVISION_PROFILE_BASE64    # Development Provisioning Profile (Base64)
KEYCHAIN_PASSWORD                 # Keychain şifresi (güvenli bir şifre)
```

**Not:** App Store Connect API anahtarları Sideloadly için gerekli değildir.

## 📋 Adım Adım Kurulum

### 1. Apple Developer Portal'da Sertifika Oluşturma

#### a) Certificate Signing Request (CSR) Oluşturma
```bash
# macOS/Linux için:
openssl req -new -newkey rsa:2048 -nodes -keyout ios_development.key -out ios_development.csr

# Windows için PowerShell:
# OpenSSL kurulu değilse, Keychain Access (macOS) kullanın
```

#### b) iOS Development Certificate Oluşturma
1. [Apple Developer Portal](https://developer.apple.com/account/resources/certificates/list) → Certificates
2. "+" butonuna tıklayın
3. **iOS Development** seçin
4. CSR dosyasını yükleyin
5. Certificate'ı indirin (.cer dosyası)

#### c) P12 Dosyası Oluşturma
```bash
# Certificate'ı PEM formatına çevirin
openssl x509 -in ios_development.cer -inform DER -out ios_development.pem

# P12 dosyası oluşturun
openssl pkcs12 -export -out ios_development.p12 -inkey ios_development.key -in ios_development.pem

# Base64'e çevirin
base64 -i ios_development.p12 -o ios_development_base64.txt
```

### 2. Development Provisioning Profile Oluşturma

1. [Apple Developer Portal](https://developer.apple.com/account/resources/profiles/list) → Profiles
2. "+" butonuna tıklayın
3. **iOS App Development** seçin
4. App ID: `com.gizlikitap.app` seçin
5. Certificate'ınızı seçin
6. Test cihazlarınızı seçin (UDID gerekli)
7. Profile adı: `Gizli Kitap Development`
8. Profile'ı indirin (.mobileprovision dosyası)

```bash
# Provisioning profile'ı Base64'e çevirin
base64 -i GizliKitapDevelopment.mobileprovision -o provisioning_profile_base64.txt
```

### 3. Team ID Bulma

1. [Apple Developer Portal](https://developer.apple.com/account/) → Membership
2. **Team ID** değerini kopyalayın (10 karakterlik kod)

### 4. GitHub Secrets Ekleme

1. GitHub repository → Settings → Secrets and variables → Actions
2. **New repository secret** ile aşağıdaki secrets'ları ekleyin:

```
TEAM_ID: [10 karakterlik Team ID]
BUILD_CERTIFICATE_BASE64: [P12 dosyasının Base64 içeriği]
P12_PASSWORD: [P12 dosyası için belirlediğiniz şifre]
BUILD_PROVISION_PROFILE_BASE64: [Provisioning profile'ın Base64 içeriği]
KEYCHAIN_PASSWORD: [Güvenli bir şifre belirleyin]
```

## 🚀 IPA Dosyası Oluşturma

### GitHub Actions ile Build

1. Kodu `main` branch'e push edin
2. GitHub Actions otomatik olarak çalışacak
3. Build tamamlandığında **Artifacts** bölümünden IPA dosyasını indirin

### Manuel Tetikleme

1. GitHub repository → Actions
2. **iOS Build** workflow'unu seçin
3. **Run workflow** butonuna tıklayın

## 📱 Sideloadly ile Yükleme

### 1. Sideloadly Kurulumu

1. [Sideloadly.io](https://sideloadly.io/) adresinden indirin
2. Kurulumu tamamlayın
3. Uygulamayı açın

### 2. Cihaz Hazırlığı

1. iOS cihazınızı USB ile bilgisayara bağlayın
2. Cihazda **"Bu bilgisayara güven"** seçin
3. **Geliştirici Modu**nu etkinleştirin:
   - Ayarlar → Gizlilik ve Güvenlik → Geliştirici Modu

### 3. IPA Yükleme

1. Sideloadly'yi açın
2. **IPA dosyasını** sürükleyip bırakın
3. **Apple ID** ve **şifrenizi** girin
4. **Cihazınızı** seçin
5. **Start** butonuna tıklayın

### 4. Uygulama Güvenilirliği

1. Yükleme tamamlandıktan sonra:
   - Ayarlar → Genel → VPN ve Cihaz Yönetimi
   - Apple ID'nizi seçin
   - **"Güven"** butonuna tıklayın

## ⚠️ Önemli Notlar

### Sınırlamalar
- **7 günlük sınır**: Ücretsiz Apple ID ile yüklenen uygulamalar 7 gün sonra çalışmaz
- **3 uygulama sınırı**: Aynı anda en fazla 3 uygulama yüklenebilir
- **Cihaz sınırı**: Her Apple ID ile en fazla 3 cihaza yükleme yapılabilir

### Güvenlik
- Apple ID şifrenizi kimseyle paylaşmayın
- İki faktörlü kimlik doğrulama kullanın
- Uygulama şifresi oluşturmayı tercih edin

### Sorun Giderme

#### "Untrusted Developer" Hatası
- Ayarlar → Genel → VPN ve Cihaz Yönetimi → Geliştiriciyi güvenilir yap

#### "Unable to Install" Hatası
- Cihazın UDID'sinin provisioning profile'a eklendiğinden emin olun
- Bundle identifier'ın doğru olduğunu kontrol edin

#### "Revoked Certificate" Hatası
- 7 günlük süre dolmuş, uygulamayı yeniden yükleyin

## 🔄 Otomatik Yenileme

### AltStore (Alternatif)
- [AltStore](https://altstore.io/) kullanarak otomatik yenileme yapabilirsiniz
- WiFi üzerinden 7 günde bir otomatik yeniler

### Shortcuts (iOS)
- iOS Shortcuts uygulaması ile otomatik yenileme scripti oluşturabilirsiniz

## 📞 Destek

Sorun yaşarsanız:
1. GitHub Issues bölümünde sorun bildirin
2. Build loglarını kontrol edin
3. Sideloadly loglarını inceleyin

---

**Not**: Bu yöntem tamamen yasal ve Apple'ın izin verdiği bir yöntemdir. Sadece kişisel kullanım içindir.