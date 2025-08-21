@echo off
echo Flutter Otomatik Hata Takip Sistemi
echo =====================================
echo.
echo Bu sistem Flutter kodunuzdaki hatalari otomatik olarak takip eder.
echo Her 5 dakikada bir analiz yapar ve sonuclari raporlar.
echo.
echo Durdurmak icin Ctrl+C basin.
echo.
pause

:loop
echo.
echo [%date% %time%] Hata analizi baslatiliyor...
powershell -ExecutionPolicy Bypass -File .\scripts\auto_track_errors.ps1
echo.
echo Sonraki analiz 5 dakika sonra...
timeout /t 300 /nobreak
goto loop