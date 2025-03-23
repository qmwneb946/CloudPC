@echo off
chcp 65001 >nul
cd /d E:\workspace

echo 请选择操作:
echo 1. 从云端拉取
echo 2. 推送到云端
set /p choice="请输入选项 (1-2): "

if "%choice%"=="1" (
    git pull 2>nul
    if %errorlevel% neq 0 (
        echo 拉取失败，请检查网络
    ) else (
        echo 拉取成功
    )
) else if "%choice%"=="2" (
    git push -f 2>nul
    if %errorlevel% neq 0 (
        echo 推送失败，请检查权限
    ) else (
        echo 推送成功
    )
) else (
    echo 无效选项
)

pause