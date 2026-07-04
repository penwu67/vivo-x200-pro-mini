@echo off
chcp 65001 > nul

set APPS=com.vivo.assistant com.vivo.favorite com.vivo.nightpearl com.vivo.doubleinstance com.vivo.audiofx com.vivo.numbermark com.android.vendors.bridge.softsim com.mediatek.gbaservice com.vivo.cota com.debug.loggerui com.vivo.devicereg com.vivo.floatingball com.vivo.findphone com.vivo.gamewatch com.vivo.globalanimation com.vivo.globalsearch com.vivo.setupwizard com.vivo.upslide com.vivo.iotserver com.vivo.magazine com.vivo.minscreen com.vivo.musicwidgetmix com.vivo.pushservice com.vivo.SmartKey com.vivo.quickpay com.vivo.upnpserver com.vivo.secime.service com.vivo.safecenter com.vivo.abe com.bbk.SuperPowerSave com.vivo.sps com.android.BBKCrontab com.vivo.vibrator4d com.vivo.videoeditor com.android.vivo.tws.vivotws com.bbk.cloud com.vivo.daemonService com.vivo.vms com.vivo.weather.provider com.vivo.voicewakeup com.bbk.appstore

for %%a in (%APPS%) do (
    echo ---------------------------------------
    echo Dang xu ly: %%a

    rem 1. Xoa cache + data
    adb shell pm clear %%a >nul 2>&1

    rem 2. Chan cac quyen runtime (loi "khong co quyen nay" la binh thuong, da an di cho gon)
    adb shell pm revoke %%a android.permission.ACCESS_FINE_LOCATION >nul 2>&1
    adb shell pm revoke %%a android.permission.ACCESS_COARSE_LOCATION >nul 2>&1
    adb shell pm revoke %%a android.permission.ACCESS_BACKGROUND_LOCATION >nul 2>&1
    adb shell pm revoke %%a android.permission.READ_CONTACTS >nul 2>&1
    adb shell pm revoke %%a android.permission.WRITE_CONTACTS >nul 2>&1
    adb shell pm revoke %%a android.permission.READ_PHONE_STATE >nul 2>&1
    adb shell pm revoke %%a android.permission.CALL_PHONE >nul 2>&1
    adb shell pm revoke %%a android.permission.READ_SMS >nul 2>&1
    adb shell pm revoke %%a android.permission.SEND_SMS >nul 2>&1
    adb shell pm revoke %%a android.permission.READ_CALENDAR >nul 2>&1
    adb shell pm revoke %%a android.permission.WRITE_CALENDAR >nul 2>&1
    adb shell pm revoke %%a android.permission.BLUETOOTH_CONNECT >nul 2>&1
    adb shell pm revoke %%a android.permission.BLUETOOTH_SCAN >nul 2>&1
    adb shell pm revoke %%a android.permission.ACTIVITY_RECOGNITION >nul 2>&1
    adb shell pm revoke %%a android.permission.READ_MEDIA_IMAGES >nul 2>&1
    adb shell pm revoke %%a android.permission.READ_MEDIA_VIDEO >nul 2>&1
    adb shell pm revoke %%a android.permission.READ_MEDIA_AUDIO >nul 2>&1
    adb shell pm revoke %%a android.permission.READ_EXTERNAL_STORAGE >nul 2>&1
    adb shell pm revoke %%a android.permission.WRITE_EXTERNAL_STORAGE >nul 2>&1
    adb shell pm revoke %%a android.permission.POST_NOTIFICATIONS >nul 2>&1

    rem 3. Chan cac quyen dac biet (khong revoke duoc bang pm, phai dung appops)
    adb shell cmd appops set %%a MANAGE_EXTERNAL_STORAGE deny >nul 2>&1
    adb shell cmd appops set %%a POST_NOTIFICATION ignore >nul 2>&1

    rem 4. Tat cong tac tong "Mo lien ket duoc ho tro" (App Links)
    rem    Luu y: lenh cu "set-app-links-user-selection ... false" thieu tham so domain
    rem    nen khong co tac dung. Lenh dung cho cong tac TONG la set-app-links-allowed.
    adb shell pm set-app-links-allowed --user 0 --package %%a false >nul 2>&1
)

echo ---------------------------------------
echo Hoan thanh.
echo.
echo Ghi chu: phan lon app trong danh sach tren la dich vu he thong,
echo khong khai bao lien ket http/https nao ca, nen voi cac app do
echo muc "Mo lien ket duoc ho tro" von khong xuat hien trong Settings
echo de tat - khong phai script chay sai.
echo Muon kiem tra app nao co domain rieng, dung lenh:
echo   adb shell pm get-app-links ^<package_name^>
pause