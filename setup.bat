@echo off
chcp 65001 >nul
echo ========================================
echo    Gizli Kitap Uygulamasi Kurulum
echo ========================================
echo.

echo [1/6] Flutter SDK kontrol ediliyor...
flutter --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ HATA: Flutter SDK bulunamadi!
    echo.
    echo Flutter kurulum adimlari:
    echo 1. https://flutter.dev/docs/get-started/install adresine gidin
    echo 2. Windows icin Flutter SDK indirin
    echo 3. C:\flutter klasorune cikarin
    echo 4. PATH degiskenine C:\flutter\bin ekleyin
    echo 5. Bilgisayari yeniden baslatın
    echo.
    pause
    exit /b 1
)
echo ✅ Flutter SDK bulundu

echo.
echo [2/6] Flutter Doctor kontrol ediliyor...
flutter doctor

echo.
echo [3/6] Proje bagimliliklari yukleniyor...
flutter pub get
if %errorlevel% neq 0 (
    echo ❌ HATA: Bagimliliklar yuklenemedi!
    pause
    exit /b 1
)
echo ✅ Bagimliliklar yuklendi

echo.
echo [4/6] Android cihazlar kontrol ediliyor...
flutter devices

echo.
echo [5/6] Uygulama derleniyor (Release mode)...
flutter build apk --release
if %errorlevel% neq 0 (
    echo ❌ HATA: APK derlenemedi!
    echo Lutfen Flutter Doctor ciktisini kontrol edin.
    pause
    exit /b 1
)
echo ✅ APK basariyla derlendi

echo.
echo [6/6] APK dosyasi hazir! 🎉
echo 📍 Konum: build\app\outputs\flutter-apk\app-release.apk
echo 📱 Dosya boyutu:
dir "build\app\outputs\flutter-apk\app-release.apk" | find "app-release.apk"
echo.
echo 📋 Kurulum adimlari:
echo 1. APK dosyasini Android telefonunuza kopyalayin
echo 2. Telefonunuzda "Bilinmeyen kaynaklardan kurulum"u acin
echo 3. APK dosyasina dokunarak kurun
echo 4. Uygulamayi acin ve kitap listesini gorun
echo 5. Gizli moda erismek icin basligi 7 kez tiklayin
echo 6. Gizli kod: 1234
echo.
echo ✅ Kurulum tamamlandi!
echo 🔒 Uygulama mevcut WhatsApp/Instagram hesaplarinizi etkilemez
echo 🆕 Yeni hesaplarla giris yapabilirsiniz
echo.
pause