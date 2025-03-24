@echo off
setlocal enabledelayedexpansion

:start
:: 设置UTF-8编码
chcp 65001 >nul

:: 切换到工作目录
cd /d E:\workspace

:: 清空屏幕
cls

:: 显示菜单
echo 请选择操作:
echo 1. 从云端拉取（覆盖本地）
echo 2. 推送到云端（覆盖云端）
echo 3. 查看Git状态
echo 4. 退出
set /p choice="请输入选项 (1-4): "

:: 处理用户输入
if "%choice%"=="1" (
    call :pull_from_cloud
) else if "%choice%"=="2" (
    call :push_to_cloud
) else if "%choice%"=="3" (
    call :git_status
) else if "%choice%"=="4" (
    exit /b
) else (
    echo 无效选项，请重新输入。
)

:: 暂停并返回菜单
pause
goto start

:: 从云端拉取函数
:pull_from_cloud
echo 正在从云端拉取代码...
git pull 2>&1
if %errorlevel% equ 0 (
    echo 拉取成功！
) else (
    echo 拉取失败，请检查网络连接或Git配置。
)
exit /b

:: 推送到云端函数
:push_to_cloud
echo 正在推送到云端...
git add . >nul 2>&1
git commit -m "手动推送" >nul 2>&1
git push -f 2>&1 | findstr /v "Everything up-to-date"
if %errorlevel% equ 0 (
    echo 推送成功！
) else (
    echo 推送失败，请检查网络连接或Git权限。
)
exit /b

:: 查看Git状态函数
:git_status
echo 当前Git仓库状态：
git status -s
exit /b