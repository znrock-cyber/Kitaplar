# Kitap Önerileri Uygulaması

Bu uygulama, dış görünümde kitap önerileri gösteren ancak gizli bir bölümde Instagram ve WhatsApp web versiyonlarına erişim sağlayan bir Flutter uygulamasıdır.

## Özellikler

- **Kitap Uygulaması Görünümü**: Normal kullanıcılar için kitap önerileri listesi
- **Gizli Erişim**: Özel kod ile Instagram ve WhatsApp'a erişim
- **WebView Entegrasyonu**: Instagram ve WhatsApp web versiyonları
- **Güvenli Giriş**: 1234 kodu ile gizli moda erişim

## Gizli Moda Erişim

### Yöntem 1: Ana Ekrandan
1. Uygulamayı açın
2. Ana ekrandaki kitap ikonuna 5 kez hızlıca dokunun
3. Açılan kod girişine "1234" yazın
4. Giriş butonuna basın

### Yöntem 2: Kitap Listesi Ekranından
1. Kitap listesi ekranında "Kitap Önerileri" başlığına 7 kez hızlıca dokunun
2. Açılan kod girişine "1234" yazın
3. Giriş butonuna basın

## Kurulum

### Gereksinimler
- Flutter SDK (3.0.0 veya üzeri)
- Android Studio veya VS Code
- Android cihaz veya emülatör

### Kurulum Adımları

1. **Flutter bağımlılıklarını yükleyin:**
   ```bash
   flutter pub get
   ```

2. **Uygulamayı çalıştırın:**
   ```bash
   flutter run
   ```

3. **APK oluşturmak için:**
   ```bash
   flutter build apk --release
   ```

## Kullanım

### Normal Mod
- Uygulama açıldığında kitap önerileri listesi görünür
- Alt menüden farklı bölümlere geçiş yapabilirsiniz
- Arama ve favori özellikleri mevcuttur

### Gizli Mod
- Gizli koda erişim sağladıktan sonra Instagram ve WhatsApp sekmelerine geçiş yapabilirsiniz
- Her sekme kendi WebView'ında çalışır
- Yenileme butonu ile sayfaları yenileyebilirsiniz
- Çıkış butonu ile normal moda dönebilirsiniz

## Güvenlik

- Gizli kod: **1234**
- Kod yanlış girildiğinde giriş ekranı kapanır
- Gizli moddan çıkış için onay penceresi gösterilir
- Uygulama kapatıldığında otomatik olarak normal moda döner

## Teknik Detaylar

### Kullanılan Paketler
- `webview_flutter`: Web sayfalarını göstermek için
- `shared_preferences`: Kullanıcı tercihlerini saklamak için
- `cupertino_icons`: iOS tarzı ikonlar için

### Dosya Yapısı
```
lib/
├── main.dart                 # Ana uygulama dosyası
├── screens/
│   ├── book_home_screen.dart # Kitap listesi ekranı
│   └── secret_screen.dart    # Gizli mod ekranı
```

## Sorun Giderme

### WebView Yüklenmiyorsa
- İnternet bağlantınızı kontrol edin
- Uygulamayı yeniden başlatın
- Yenileme butonunu kullanın

### Gizli Kod Çalışmıyorsa
- Dokunuşları hızlı ve ardışık yapın
- 3 saniye içinde gerekli sayıda dokunuş yapın
- Kodu doğru girdiğinizden emin olun (1234)

## Notlar

- Bu uygulama sadece kişisel kullanım içindir
- Instagram ve WhatsApp hesaplarınıza web üzerinden giriş yapmanız gerekir
- Bildirimler sadece uygulama içinde görünür
- Uygulama kapalıyken bildirim gelmez