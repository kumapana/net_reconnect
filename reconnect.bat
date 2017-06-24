@echo off
setlocal enabledelayedexpansion

rem ゲートウェイIP設定
set gateway_ip 10.203.10.1

rem ネットワークチップのデバイスIDの設定
set device_id "device id"

rem ログファイルのパスの設定
set log_path C:\Users\Linuxclub\Desktop\net_test_log.csv

rem 実行回数を保存する変数宣言
set /a count=0

rem デフォルトゲートウェイにPINGを実行し疎通試験。
:TEST
ping gateway_ip -n 5
if errorlevel 0 GOTO OK
if errorlevel 1 GOTO NG

rem 疎通試験合格の場合ログを吐いて終了
:OK
echo %date%,%time%,!count!,OK>> log_path
GOTO END

rem 疏通試験失敗の場合
:NG
rem 試行回数が5回未満の時はリセット実行
if count lss 5 GOTO RESET

rem 試行回数が5の時は終了
if count equ 5 GOTO END

:RESET
echo %date%,%time%,!count!,NG >> log_path
rem ネットワークチップの無効化
devcon disable "device_id"
ping 127.0.0.1 -n 15

rem ネットワークチップの有効化
devcon enable device_id
ping 127.0.0.1 -n 15

rem チップリセット回数の記録
set /a count=count+1

rem 再度疎通試験
GOTO TEST

:END
exit /b
