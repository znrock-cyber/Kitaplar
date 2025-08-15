#!/bin/bash

echo "========================================"
echo "    Gizli Kitap Uygulamasi iOS Kurulum"
echo "========================================"
echo

echo "[1/6] Flutter SDK kontrol ediliyor..."
if ! command -v flutter &> /dev/null; then
    echo "HATA: Flutter SDK bulunamadi!"
    echo "Lutfen Flutter'i resmi sitesinden indirin: https://flutter.dev/docs/get-started/install"
    exit 1
fi
echo "✓ Flutter SDK bulundu"

echo
echo "[2/6] Xcode kontrol ediliyor..."
if ! command -v xcodebuild &> /dev/null; then
    echo "HATA: Xcode bulunamadi!"
    echo "Lutfen Xcode'u App Store'dan indirin"
    exit 1
fi
echo "✓ Xcode bulundu"

echo
echo "[3/6] Proje bagimliliklari yukleniyor..."
flutter pub get
if [ $? -ne 0 ]; then
    echo "HATA: Bagimliliklar yuklenemedi!"
    exit 1
fi
echo "✓ Bagimliliklar yuklendi"

echo
echo "[4/6] iOS pods yukleniyor..."
cd ios
pod install
if [ $? -ne 0 ]; then
    echo "HATA: Pods yuklenemedi!"
    exit 1
fi
cd ..
echo "✓ iOS pods yuklendi"

echo
echo "[5/6] iOS cihazlar kontrol ediliyor..."
flutter devices

echo
echo "[6/6] iOS uygulamasi derleniyor..."
flutter build ios --release
if [ $? -ne 0 ]; then
    echo "HATA: iOS uygulamasi derlenemedi!"
    exit 1
fi
echo "✓ iOS uygulamasi basariyla derlendi"

echo
echo "Kurulum tamamlandi!"
echo "Xcode'da ios/Runner.xcworkspace dosyasini acarak uygulamayi cihaziniza yukleyebilirsiniz."
echo