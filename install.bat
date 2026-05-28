@echo off
REM 获取当前批处理文件所在的目录
set "CURRENT_DIR=%~dp0"
REM 去掉末尾的反斜杠
set "CURRENT_DIR=%CURRENT_DIR:~0,-1%"

REM 拼接 GNU-tools-for-STM32\bin 目录
set "TOOL_PATH=%CURRENT_DIR%\GNU-tools-for-STM32\bin"

REM 检查路径是否已存在于用户Path中
for /f "tokens=2*" %%A in ('reg query "HKCU\Environment" /v Path 2^>nul') do set "OLD_PATH=%%B"


echo %OLD_PATH% | find /i "%TOOL_PATH%" >nul
if %errorlevel%==0 (
    echo "%TOOL_PATH%"已存在于Path中，无需修改。
) else (
    echo 将 %TOOL_PATH% 添加到用户Path中...
    setx Path "%OLD_PATH%;%TOOL_PATH%" >nul
    echo 已成功添加，CLion等软件需重启才能正常读取。
)

pause
