@echo off 
chcp 65001 >nul 
color 0f 
 
:main 
cd /d E:\workspace || (echo 路径错误 && exit)
cls 
 
echo ESC[33m=== Git 智能同步系统 ===ESC[0m 
echo [1] 安全拉取（自动合并）
echo [2] 差异推送（交互确认）
echo [3] 退出系统 
set /p choice=请选择：
 
if "%choice%"=="1" call :safe_pull 
if "%choice%"=="2" call :smart_push 
if "%choice%"=="3" exit 
goto main 
 
:safe_pull 
git fetch 
git diff --name-status origin/$(git branch --show-current) || (
    echo ESC[91m存在未提交变更ESC[0m & exit /b 
)
git pull --rebase 
if %errorlevel%==0 echo ESC[92m同步成功ESC[0m & pause 
exit /b 
 
:smart_push 
git add . || (echo ESC[91m添加文件失败ESC[0m & pause & exit /b)
git diff --cached --quiet && (echo 无变更可提交 & pause & exit /b)
git difftool --cached 
set /p confirm=确认提交这些变更？(y/n) 
if /i "%confirm%"=="y" (
    git commit -m "手动提交：%date% %time%"
    git push --force-with-lease 
)
pause 
exit /b 