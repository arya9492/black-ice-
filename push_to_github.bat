@echo off
setlocal
set "PATH=C:\Users\ashis\bin\git\cmd;C:\Users\ashis\bin\gh\bin;%PATH%"

echo ======================================================================
echo BLACK ICE: GITHUB REPO CREATION AND PUSH
echo ======================================================================
echo.

:: 1. Check gh authentication
gh auth status >nul 2>&1
if %errorlevel% neq 0 (
    echo [!] GitHub CLI is not yet logged in.
    echo [*] Starting interactive login. Please choose GitHub.com ^> HTTPS ^> Web Browser...
    echo.
    gh auth login -h github.com -p https -w
    if %errorlevel% neq 0 (
        echo [x] GitHub login was not completed. Exiting.
        pause
        exit /b 1
    )
)

echo [v] GitHub CLI authenticated successfully!
echo.
echo [*] Creating GitHub repository 'black-ice' and pushing code...
gh repo create "black-ice" --public --source=. --remote=origin --push

if %errorlevel% equ 0 (
    echo.
    echo ======================================================================
    echo [SUCCESS] Black Ice repository created and pushed to GitHub!
    echo.
    echo Next Steps for Netlify Deployment:
    echo 1. Open https://app.netlify.com/
    echo 2. Click 'Add new site' -> 'Import an existing project'
    echo 3. Select 'GitHub' and choose 'black-ice'
    echo 4. Netlify will auto-detect netlify.toml (Base: frontend, Publish: dist)
    echo 5. Click 'Deploy black-ice'
    echo ======================================================================
) else (
    echo.
    echo [!] Note: If the repository already exists on GitHub, pushing directly:
    git push -u origin main
)

pause
