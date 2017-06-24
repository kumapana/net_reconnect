@echo off

rem ゲートウェイIP設定
set gateway_ip 10.203.10.1

rem ネットワークチップのデバイスIDの設定
set device_id "device id"

rem ログファイルのパスの設定
set log_path C:\Users\Linuxclub\Desktop\net_test.log


rem デフォルトゲートウェイにPINGを実行し疎通試験。

ping gateway_ip -n 5
if errorlevel 0 GOTO OK
if errorlevel 1 GOTO NG

rem 疎通検査合格の場合
:OK
echo %date% %time% OK>> log_path
GOTO END

rem 疏通試験失敗の場合
:NG 
echo %date% %time% NG >> log_path
rem ネットワークチップの無効化
devcon disable "device_id"
ping 127.0.0.1 -n 15

rem ネットワークチップの有効化
devcon enable "device_id"
ping 127.0.0.1 -n 15

rem 再度疎通試験
GOTO TEST

:END
exit /b
