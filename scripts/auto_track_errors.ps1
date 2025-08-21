# Otomatik Hata Takip Scripti
# Bu script Flutter analyze hatalarını takip eder ve raporlar

Write-Host "Flutter Hata Takip Sistemi Başlatılıyor..." -ForegroundColor Green

# Mevcut tarih ve saat
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
Write-Host "Tarih: $timestamp" -ForegroundColor Yellow

# Flutter analyze çalıştır
Write-Host "\nFlutter analyze çalıştırılıyor..." -ForegroundColor Cyan
$analyzeResult = flutter analyze 2>&1
$exitCode = $LASTEXITCODE

# Sonuçları analiz et
if ($exitCode -eq 0) {
    Write-Host "✅ Hiç hata bulunamadı!" -ForegroundColor Green
    $logEntry = "[$timestamp] ✅ Hiç hata yok"
} else {
    # Hata sayısını çıkar
    $errorLine = $analyzeResult | Select-String "issues found"
    if ($errorLine) {
        $errorCount = ($errorLine -split " ")[0]
        Write-Host "⚠️  $errorCount hata bulundu" -ForegroundColor Red
        $logEntry = "[$timestamp] ⚠️  $errorCount hata bulundu"
        
        # En kritik hataları göster
        Write-Host "\nEn kritik hatalar:" -ForegroundColor Yellow
        $analyzeResult | Select-String "error -" | Select-Object -First 5 | ForEach-Object {
            Write-Host "  - $_" -ForegroundColor Red
        }
    } else {
        Write-Host "❌ Analiz hatası" -ForegroundColor Red
        $logEntry = "[$timestamp] ❌ Analiz hatası"
    }
}

# Log dosyasına kaydet
$logFile = "error_tracking_log.txt"
$logEntry | Add-Content -Path $logFile

# Özet rapor
Write-Host "\n" + "="*50 -ForegroundColor Blue
Write-Host "ÖZET RAPOR" -ForegroundColor Blue
Write-Host "="*50 -ForegroundColor Blue
Write-Host "Tarih: $timestamp"
Write-Host "Durum: $(if ($exitCode -eq 0) { '✅ Temiz' } else { '⚠️  Hatalar var' })"
if ($exitCode -ne 0 -and $errorCount) {
    Write-Host "Hata Sayısı: $errorCount"
}
Write-Host "Log: $logFile dosyasına kaydedildi"
Write-Host "="*50 -ForegroundColor Blue

# Son 5 log girişini göster
Write-Host "\nSon 5 takip kaydı:" -ForegroundColor Cyan
if (Test-Path $logFile) {
    Get-Content $logFile | Select-Object -Last 5 | ForEach-Object {
        Write-Host "  $_" -ForegroundColor Gray
    }
}

Write-Host "\nHata takip tamamlandı." -ForegroundColor Green