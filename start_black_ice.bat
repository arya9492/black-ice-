@echo off
title BLACK ICE — AI Agent Security Firewall
echo ==========================================================
echo    BLACK ICE -- AI AGENT SECURITY FIREWALL
echo ==========================================================
echo Starting Unified Application on http://127.0.0.1:8000 ...
echo Live Demo URL: http://127.0.0.1:8000/demo
echo.
cd /d "%~dp0backend"
venv\Scripts\python.exe -m uvicorn app.main:app --host 127.0.0.1 --port 8000
pause
