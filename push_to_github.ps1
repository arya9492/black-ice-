# Set PATH to include portable Git and GitHub CLI
$env:PATH = "C:\Users\ashis\bin\git\cmd;C:\Users\ashis\bin\gh\bin;" + $env:PATH

Write-Host "======================================================================" -ForegroundColor Cyan
Write-Host "BLACK ICE: GITHUB REPOSITORY CREATION & PUSH" -ForegroundColor Cyan
Write-Host "======================================================================" -ForegroundColor Cyan
Write-Host ""

# Check gh authentication
$authStatus = & gh auth status 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "[!] GitHub CLI is not yet logged in." -ForegroundColor Yellow
    Write-Host "[*] Launching GitHub web browser authentication..." -ForegroundColor Yellow
    Write-Host "    Follow the prompt to copy your one-time code and authorize in your browser." -ForegroundColor DarkGray
    Write-Host ""
    & gh auth login -h github.com -p https -w
    if ($LASTEXITCODE -ne 0) {
        Write-Host "[x] GitHub authentication cancelled." -ForegroundColor Red
        exit 1
    }
}

Write-Host "[v] GitHub CLI authenticated successfully!" -ForegroundColor Green
Write-Host ""
Write-Host "[*] Creating repository 'black-ice' on GitHub and pushing all files..." -ForegroundColor Cyan

& gh repo create "black-ice" --public --source=. --remote=origin --push

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "======================================================================" -ForegroundColor Green
    Write-Host "[SUCCESS] Repository created and pushed to GitHub!" -ForegroundColor Green
    Write-Host ""
    Write-Host "Next Steps for Netlify Deployment:" -ForegroundColor Cyan
    Write-Host "1. Open https://app.netlify.com/"
    Write-Host "2. Click 'Add new site' -> 'Import an existing project'"
    Write-Host "3. Choose 'GitHub' and select the 'black-ice' repository"
    Write-Host "4. Netlify will auto-detect netlify.toml (Base: frontend, Publish: dist)"
    Write-Host "5. Click 'Deploy black-ice'"
    Write-Host "======================================================================" -ForegroundColor Green
} else {
    Write-Host "[!] If the repository already exists on GitHub, attempting push..." -ForegroundColor Yellow
    & git push -u origin main
}
