@echo off
echo ========================================
echo    Sistem Gereksinimleri Kontrolu
echo ========================================
echo.

echo [1/4] Flutter SDK kontrol ediliyor...
flutter --version
if %errorlevel% neq 0 (
    echo HATA: Flutter SDK bulunamadi!
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
echo ✓ Flutter SDK bulundu
echo.

echo [2/4] Flutter Doctor calistiriliyor...
flutter doctor
echo.

echo [3/4] Bagli cihazlar kontrol ediliyor...
flutter devices
echo.

echo [4/4] Android SDK kontrol ediliyor...
flutter doctor --android-licenses
echo.

echo ========================================
echo Kontrol tamamlandi!
echo.
echo Eger tum kontroller basarili ise:
echo - Android icin: setup.bat calistirin
echo - iOS icin: setup_ios.sh calistirin (macOS gerekli)
echo ========================================
pause