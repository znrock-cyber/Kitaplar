# Gizli Kitap Uygulamasi Kurulum Scripti
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "    Gizli Kitap Uygulamasi Kurulum" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "[1/6] Flutter SDK kontrol ediliyor..." -ForegroundColor Yellow
$flutterCheck = Get-Command flutter -ErrorAction SilentlyContinue
if ($flutterCheck) {
    Write-Host "Flutter SDK bulundu" -ForegroundColor Green
} else {
    Write-Host "HATA: Flutter SDK bulunamadi!" -ForegroundColor Red
    Write-Host ""
    Write-Host "Flutter kurulum adimlari:" -ForegroundColor Yellow
    Write-Host "1. https://flutter.dev/docs/get-started/install adresine gidin"
    Write-Host "2. Windows icin Flutter SDK indirin"
    Write-Host "3. C:\flutter klasorune cikarin"
    Write-Host "4. PATH degiskenine C:\flutter\bin ekleyin"
    Write-Host "5. Bilgisayari yeniden baslatin"
    Write-Host ""
    Read-Host "Devam etmek icin Enter'a basin"
    exit 1
}

Write-Host ""
Write-Host "[2/6] Flutter Doctor kontrol ediliyor..." -ForegroundColor Yellow
flutter doctor

Write-Host ""
Write-Host "[3/6] Proje bagimliliklari yukleniyor..." -ForegroundColor Yellow
flutter pub get
if ($LASTEXITCODE -ne 0) {
    Write-Host "HATA: Bagimliliklar yuklenemedi!" -ForegroundColor Red
    Read-Host "Devam etmek icin Enter'a basin"
    exit 1
}
Write-Host "Bagimliliklar yuklendi" -ForegroundColor Green

Write-Host ""
Write-Host "[4/6] Android cihazlar kontrol ediliyor..." -ForegroundColor Yellow
flutter devices

Write-Host ""
Write-Host "[5/6] Uygulama derleniyor..." -ForegroundColor Yellow
flutter build apk --release
if ($LASTEXITCODE -ne 0) {
    Write-Host "HATA: APK derlenemedi!" -ForegroundColor Red
    Write-Host "Lutfen Flutter Doctor ciktisini kontrol edin." -ForegroundColor Yellow
    Read-Host "Devam etmek icin Enter'a basin"
    exit 1
}
Write-Host "APK basariyla derlendi" -ForegroundColor Green

Write-Host ""
Write-Host "[6/6] APK dosyasi hazir!" -ForegroundColor Green
Write-Host "Konum: build\app\outputs\flutter-apk\app-release.apk" -ForegroundColor Cyan

$apkPath = "build\app\outputs\flutter-apk\app-release.apk"
if (Test-Path $apkPath) {
    $fileSize = (Get-Item $apkPath).Length
    $fileSizeMB = [math]::Round($fileSize / 1MB, 2)
    Write-Host "Dosya boyutu: $fileSizeMB MB" -ForegroundColor Cyan
}

Write-Host ""
Write-Host "Kurulum adimlari:" -ForegroundColor Yellow
Write-Host "1. APK dosyasini Android telefonunuza kopyalayin"
Write-Host "2. Telefonunuzda Bilinmeyen kaynaklardan kurulum acin"
Write-Host "3. APK dosyasina dokunarak kurun"
Write-Host "4. Uygulamayi acin ve kitap listesini gorun"
Write-Host "5. Gizli moda erismek icin basligi 7 kez tiklayin"
Write-Host "6. Gizli kod: 1234"
Write-Host ""
Write-Host "Kurulum tamamlandi!" -ForegroundColor Green
Write-Host "Uygulama mevcut WhatsApp/Instagram hesaplarinizi etkilemez" -ForegroundColor Cyan
Write-Host "Yeni hesaplarla giris yapabilirsiniz" -ForegroundColor Cyan
Write-Host ""
Read-Host "Cikis icin Enter'a basin"