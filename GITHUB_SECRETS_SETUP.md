# GitHub Secrets Kurulum Rehberi - Code Signing

## Genel Bakış

App Store'a otomatik yükleme için GitHub Actions'da aşağıdaki secrets'ları yapılandırmanız gerekir:

## 1. Gerekli Secrets Listesi

### Code Signing Secrets
```
1. BUILD_CERTIFICATE_BASE64     - iOS Distribution Certificate (Base64)
2. P12_PASSWORD                 - Certificate şifresi
3. BUILD_PROVISION_PROFILE_BASE64 - Provisioning Profile (Base64)
4. KEYCHAIN_PASSWORD            - Geçici keychain şifresi
5. TEAM_ID                      - Apple Developer Team ID
```

### App Store Connect API Secrets
```
6. APP_STORE_CONNECT_API_KEY_ID      - API Key ID
7. APP_STORE_CONNECT_ISSUER_ID       - Issuer ID
8. APP_STORE_CONNECT_API_KEY_BASE64  - API Key dosyası (Base64)
```

## 2. Apple Developer Sertifikaları

### 2.1 iOS Distribution Certificate Oluşturma

#### Adım 1: Certificate Signing Request (CSR) Oluşturma
```bash
# Terminal'de çalıştırın (macOS)
openssl req -new -newkey rsa:2048 -nodes -keyout gizlikitap.key -out gizlikitap.csr

# Bilgileri doldurun:
# Country Name: TR
# State: Istanbul
# City: Istanbul
# Organization: Gizli Kitap
# Organizational Unit: Development
# Common Name: Gizli Kitap iOS Distribution
# Email: developer@gizlikitap.com
```

#### Adım 2: Apple Developer Portal'da Certificate Oluşturma
```
1. https://developer.apple.com/account/resources/certificates/list adresine gidin
2. "+" butonuna tıklayın
3. "iOS Distribution (App Store and Ad Hoc)" seçin
4. "Continue" tıklayın
5. CSR dosyasını yükleyin
6. "Continue" tıklayın
7. Certificate'ı indirin (.cer dosyası)
```

#### Adım 3: P12 Dosyası Oluşturma
```bash
# Certificate'ı keychain'e ekleyin
security import ios_distribution.cer -k ~/Library/Keychains/login.keychain

# P12 dosyası export edin
security export -k ~/Library/Keychains/login.keychain -t identities -f pkcs12 -o gizlikitap.p12

# Şifre belirleyin (P12_PASSWORD olarak kullanılacak)
```

#### Adım 4: Base64 Encoding
```bash
# P12 dosyasını Base64'e çevirin
base64 -i gizlikitap.p12 -o gizlikitap_base64.txt

# İçeriği kopyalayın
cat gizlikitap_base64.txt
```

### 2.2 Provisioning Profile Oluşturma

#### Adım 1: App ID Kontrolü
```
1. https://developer.apple.com/account/resources/identifiers/list adresine gidin
2. "com.gizlikitap.app" App ID'sinin olduğunu kontrol edin
3. Yoksa oluşturun:
   - "+" butonuna tıklayın
   - "App IDs" seçin
   - "App" seçin
   - Description: "Gizli Kitap App"
   - Bundle ID: "com.gizlikitap.app"
   - "Register" tıklayın
```

#### Adım 2: Provisioning Profile Oluşturma
```
1. https://developer.apple.com/account/resources/profiles/list adresine gidin
2. "+" butonuna tıklayın
3. "App Store" seçin
4. "com.gizlikitap.app" App ID'sini seçin
5. iOS Distribution certificate'ı seçin
6. Profile Name: "Gizli Kitap Distribution"
7. "Generate" tıklayın
8. Profile'ı indirin (.mobileprovision dosyası)
```

#### Adım 3: Base64 Encoding
```bash
# Provisioning profile'ı Base64'e çevirin
base64 -i Gizli_Kitap_Distribution.mobileprovision -o provision_base64.txt

# İçeriği kopyalayın
cat provision_base64.txt
```

### 2.3 Team ID Bulma
```
1. https://developer.apple.com/account/#/membership adresine gidin
2. "Team ID" değerini kopyalayın (10 karakterlik kod)
```

## 3. App Store Connect API Key

### 3.1 API Key Oluşturma
```
1. https://appstoreconnect.apple.com/access/api adresine gidin
2. "Keys" sekmesine tıklayın
3. "+" butonuna tıklayın
4. Key Name: "Gizli Kitap CI/CD"
5. Access: "Developer" seçin
6. "Generate" tıklayın
7. API Key'i indirin (.p8 dosyası)
8. Key ID'yi kopyalayın
9. Issuer ID'yi kopyalayın (sayfanın üstünde)
```

### 3.2 API Key Base64 Encoding
```bash
# API Key dosyasını Base64'e çevirin
base64 -i AuthKey_XXXXXXXXXX.p8 -o apikey_base64.txt

# İçeriği kopyalayın
cat apikey_base64.txt
```

## 4. GitHub Secrets Ekleme

### 4.1 Repository Settings
```
1. GitHub repository'nize gidin
2. "Settings" sekmesine tıklayın
3. Sol menüden "Secrets and variables" > "Actions" seçin
4. "New repository secret" butonuna tıklayın
```

### 4.2 Secrets Ekleme

#### BUILD_CERTIFICATE_BASE64
```
Name: BUILD_CERTIFICATE_BASE64
Secret: [gizlikitap_base64.txt dosyasının içeriği]
```

#### P12_PASSWORD
```
Name: P12_PASSWORD
Secret: [P12 dosyası oluştururken belirlediğiniz şifre]
```

#### BUILD_PROVISION_PROFILE_BASE64
```
Name: BUILD_PROVISION_PROFILE_BASE64
Secret: [provision_base64.txt dosyasının içeriği]
```

#### KEYCHAIN_PASSWORD
```
Name: KEYCHAIN_PASSWORD
Secret: [Güçlü bir şifre belirleyin, örn: GizliKitap2024!]
```

#### TEAM_ID
```
Name: TEAM_ID
Secret: [Apple Developer Team ID, örn: ABC123DEFG]
```

#### APP_STORE_CONNECT_API_KEY_ID
```
Name: APP_STORE_CONNECT_API_KEY_ID
Secret: [API Key ID, örn: XXXXXXXXXX]
```

#### APP_STORE_CONNECT_ISSUER_ID
```
Name: APP_STORE_CONNECT_ISSUER_ID
Secret: [Issuer ID, örn: xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx]
```

#### APP_STORE_CONNECT_API_KEY_BASE64
```
Name: APP_STORE_CONNECT_API_KEY_BASE64
Secret: [apikey_base64.txt dosyasının içeriği]
```

## 5. Secrets Doğrulama

### 5.1 Kontrol Listesi
```
✅ BUILD_CERTIFICATE_BASE64 - P12 certificate Base64
✅ P12_PASSWORD - Certificate şifresi
✅ BUILD_PROVISION_PROFILE_BASE64 - Provisioning profile Base64
✅ KEYCHAIN_PASSWORD - Keychain şifresi
✅ TEAM_ID - Apple Developer Team ID
✅ APP_STORE_CONNECT_API_KEY_ID - API Key ID
✅ APP_STORE_CONNECT_ISSUER_ID - Issuer ID
✅ APP_STORE_CONNECT_API_KEY_BASE64 - API Key Base64
```

### 5.2 Test Workflow
```
1. GitHub repository'de "Actions" sekmesine gidin
2. "Build iOS App" workflow'unu seçin
3. "Run workflow" butonuna tıklayın
4. "main" branch'i seçin
5. "Run workflow" tıklayın
6. Workflow'un başarıyla çalıştığını kontrol edin
```

## 6. Güvenlik Önerileri

### 6.1 Sertifika Güvenliği
```
• P12 şifrelerini güçlü tutun
• Sertifikaları düzenli olarak yenileyin
• API Key'leri sadece gerekli izinlerle oluşturun
• Secrets'ları asla kod içinde paylaşmayın
```

### 6.2 Access Control
```
• Repository'ye erişimi sınırlayın
• Secrets'ları sadece gerekli workflow'larda kullanın
• API Key'leri düzenli olarak rotate edin
• Team üyelerinin erişimlerini kontrol edin
```

## 7. Sorun Giderme

### 7.1 Yaygın Hatalar

#### "Code signing error"
```
Çözüm:
1. Certificate'ın doğru olduğunu kontrol edin
2. Provisioning profile'ın App ID'si ile eşleştiğini kontrol edin
3. Team ID'nin doğru olduğunu kontrol edin
4. Certificate'ın süresinin dolmadığını kontrol edin
```

#### "Invalid API Key"
```
Çözüm:
1. API Key ID'nin doğru olduğunu kontrol edin
2. Issuer ID'nin doğru olduğunu kontrol edin
3. API Key dosyasının doğru encode edildiğini kontrol edin
4. API Key'in "Developer" yetkisine sahip olduğunu kontrol edin
```

#### "Bundle identifier mismatch"
```
Çözüm:
1. Provisioning profile'ın bundle ID'si ile eşleştiğini kontrol edin
2. App Store Connect'te app'in bundle ID'sini kontrol edin
3. Xcode project settings'te bundle ID'yi kontrol edin
```

### 7.2 Debug Adımları
```
1. GitHub Actions logs'unu inceleyin
2. Certificate'ları Keychain Access ile kontrol edin
3. Provisioning profile'ları Xcode'da kontrol edin
4. App Store Connect'te app durumunu kontrol edin
```

## 8. Workflow Kullanımı

### 8.1 Test Build (Unsigned)
```
# Normal push/PR'larda otomatik çalışır
git push origin main

# Unsigned IPA oluşturulur
# AltStore/Sideloadly ile test edilebilir
```

### 8.2 Production Build (Signed)
```
# Manuel olarak tetiklenir
1. GitHub > Actions > Build iOS App
2. "Run workflow" tıklayın
3. "main" branch seçin
4. "Run workflow" tıklayın

# Signed IPA oluşturulur ve App Store'a yüklenir
```

### 8.3 Build Artifacts
```
Test Build:
• gizli-kitap-ios-unsigned.ipa
• gizli-kitap-ios-simulator.zip

Production Build:
• gizli-kitap-ios-appstore.ipa
• Otomatik App Store Connect upload
```

---

## 🚀 Hızlı Kurulum Checklist

```
□ Apple Developer hesabı aktif ($99/yıl)
□ iOS Distribution Certificate oluşturuldu
□ P12 dosyası export edildi
□ Provisioning Profile oluşturuldu
□ App Store Connect API Key oluşturuldu
□ Tüm dosyalar Base64'e çevrildi
□ 8 GitHub Secret eklendi
□ ExportOptions.plist yapılandırıldı
□ Bundle ID güncellendi (com.gizlikitap.app)
□ Test workflow çalıştırıldı
□ Production workflow test edildi
```

**Önemli:** Tüm sertifikalar ve API key'ler güvenli bir şekilde saklanmalı ve düzenli olarak yenilenmelidir.