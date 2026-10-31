Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "   BLACK ICE — AI AGENT SECURITY FIREWALL" -ForegroundColor White
Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "Starting Unified Application on http://127.0.0.1:8000 ..." -ForegroundColor Yellow
Write-Host "Live Demo URL: http://127.0.0.1:8000/demo" -ForegroundColor Green
Set-Location -Path "$PSScriptRoot\backend"
& ".\venv\Scripts\python.exe" -m uvicorn app.main:app --host 127.0.0.1 --port 8000
