# BLACK ICE — AI Agent Security Firewall

> **"The Security Layer for AI Agents."**  
> *Detect. Understand. Sanitize. Protect.*

---

## 1. Project Overview

**BLACK ICE** is an enterprise-grade AI-agent security firewall positioned between users/untrusted external content and autonomous AI agent execution layers. Its mission is to intercept, analyze, sanitize, and block adversarial threats before they reach downstream LLM execution boundaries.

### Core Threat Vectors Intercepted
- **Prompt Injection:** Malicious inputs designed to override system directives.
- **Jailbreak Exploits:** Persona manipulation (e.g. DAN) circumventing safety guardrails.
- **Instruction Hijacking:** Secondary directives embedded in external text/documents.
- **Sensitive Data Exposure:** Accidental leakage of SSNs, credentials, and API keys.
- **Malicious Documents:** Embedded adversarial triggers within uploaded PDF and TXT files.
- **Data Exfiltration:** Unauthorized external webhook egress and token harvesting.

---

## 2. Technical Architecture

Black Ice operates on an **8-Stage Zero-Trust Security Pipeline**:

```
[ USER / EXTERNAL CONTENT ]
          │
          ▼
 [ 1. BLACK ICE GATEWAY ] ──> JWT Auth Verification & Perimeter Rate Limiting
          │
          ▼
[ 2. INPUT NORMALIZATION ] ──> De-obfuscation (Base64/Hex) & Token Boundary Alignment
          │
          ▼
[ 3. THREAT DETECTION ENGINE ] ──> Deterministic Signature & Heuristic Scanner
          │
          ▼
[ 4. AI CLASSIFIER ] ──> Modular Semantic Vector & LLM Guardrail Layer (Phase 2 Interface)
          │
          ▼
   [ 5. RISK ENGINE ] ──> Unified 0-100 Risk Score & Severity Evaluation
          │
          ▼
[ 6. POLICY DECISION GATE ] ──> Zero-Trust Tri-Action Enforcement
          │
     ┌────┴────────────┐
     ▼                 ▼                 ▼
 [ ALLOW ]        [ SANITIZE ]        [ BLOCK ]
Forwarded          Redacted          Dropped at
Clean              Sensitive         Perimeter
     │                 │
     └────────┬────────┘
              │
              ▼
   [ 7. TARGET AI AGENT ]
Autonomous Execution within Verified Safe Boundaries
              │
              ▼
 [ 8. TELEMETRY & AUDIT LEDGER ]
Real-time logging to PostgreSQL/SQLite audit table
```

---

## 3. Technology Stack

### Frontend
- **Framework:** React 19 + TypeScript
- **Bundler:** Vite
- **Styling:** Tailwind CSS + Vanilla CSS Design Tokens (Custom Cyber-Frost Obsidian Theme)
- **Icons:** Lucide React
- **Visual Analytics:** Recharts

### Backend
- **Framework:** FastAPI (Python 3.10+)
- **ORM & Database:** SQLAlchemy 2.0 (PostgreSQL-compatible with zero-config SQLite local development fallback)
- **Data Validation:** Pydantic v2 & Pydantic-Settings
- **Authentication & Security:** Bcrypt password hashing, PyJWT bearer token management, Starlette hardening middleware
- **File Parsing:** PyPDF & safe buffer decoders (zero arbitrary code execution)

---

## 4. Application Routes

| Path | Description | Access |
|---|---|---|
| `/` | Brand landing page with visual security pipeline | Public |
| `/login` | Security console authentication (with 1-click Demo credentials) | Public |
| `/register` | Operator registration & tenant creation | Public |
| `/dashboard` | Security Command Center with live telemetry & Recharts | **Protected** |
| `/scanner` | Heuristic Threat Scanner with preset adversarial payloads | **Protected** |
| `/playground` | AI Agent Security Playground (Without vs With Black Ice simulation) | **Protected** |
| `/documents` | Safe PDF/TXT document context scanner & upload registry | **Protected** |
| `/threats` | Filterable & searchable threat audit ledger with modal inspector | **Protected** |
| `/analytics` | Deep forensic security metrics, trends, and category distribution | **Protected** |
| `/architecture` | Interactive 8-stage technical architecture flowchart & inspector | **Protected** |
| `/settings` | Operator profile, security policy toggles, and session termination | **Protected** |

---

## 5. API Overview

### Authentication
- `POST /api/auth/register` — Register new operator account & return JWT.
- `POST /api/auth/login` — Authenticate credentials & return JWT.
- `GET /api/auth/me` — Retrieve authenticated user profile.
- `POST /api/auth/logout` — Terminate session.

### Dashboard
- `GET /api/dashboard/summary` — Dynamically compute Total Scans, Threats Blocked, Critical Threats, and Live Security Score from database records.
- `GET /api/dashboard/recent-threats` — Stream the latest intercepted threats.

### Threat Scanner
- `POST /api/scans` — Ingest prompt/instruction, analyze risk, enforce action, and persist audit record.
- `GET /api/scans` — Retrieve scan history.
- `GET /api/scans/{id}` — Get single scan record details.

### Threat Ledger
- `GET /api/threats` — Filterable audit trail (`threat_type`, `severity`, `action`).
- `GET /api/threats/{id}` — Full threat detail with linked scan telemetry.

### Document Scanner
- `POST /api/documents/scan` — Upload and safely parse PDF/TXT documents.
- `GET /api/documents` — Ingested documents registry.

### Security Analytics
- `GET /api/analytics/all` — Consolidated overview, category distribution, severity breakdown, and 7-day activity timeline.
- `GET /api/analytics/overview` — High-level security posture summary.
- `GET /api/analytics/threat-distribution` — Categorical breakdown.
- `GET /api/analytics/activity` — Timeline data for charts.

### Playground Simulation
- `POST /api/playground/simulate` — Dual execution contract simulating vulnerability vs protected defense.

---

## 6. Getting Started

### Prerequisites
- Python 3.10+ (Tested up to Python 3.14)
- Node.js 18+ & npm

### Backend Setup & Startup

1. **Navigate to the backend directory:**
   ```bash
   cd backend
   ```

2. **Create and activate a virtual environment:**
   ```bash
   # Windows PowerShell
   python -m venv venv
   .\venv\Scripts\Activate.ps1

   # Linux / macOS
   python3 -m venv venv
   source venv/bin/activate
   ```

3. **Install dependencies:**
   ```bash
   pip install -r requirements.txt
   ```

4. **Configure environment variables:**
   Copy `.env.example` to `.env`:
   ```bash
   cp .env.example .env
   ```

5. **Start the FastAPI backend server:**
   ```bash
   uvicorn app.main:app --host 127.0.0.1 --port 8000 --reload
   ```
   *FastAPI Interactive API Documentation is available at: `http://127.0.0.1:8000/docs`*

### Frontend Setup & Startup

1. **Navigate to the frontend directory:**
   ```bash
   cd frontend
   ```

2. **Install frontend dependencies:**
   ```bash
   npm install
   ```

3. **Start the Vite development server:**
   ```bash
   npm run dev
   ```
   *The web console will be accessible at: `http://localhost:5173`*

---

## 7. Default Demo Analyst Credentials

On first run, if the database is empty, Black Ice automatically populates realistic initial development seed telemetry and creates a demonstration account:

- **Email:** `analyst@blackice.security`
- **Password:** `BlackIce2025!`
*(A 1-click button on `/login` automatically fills these credentials for convenience).*

---

## 8. Phase 2 & 3 Roadmap

- [x] **Phase 1 (Completed):** Production-quality foundation, full database schema, JWT auth, complete API endpoints, Recharts analytics, threat scanner UI, document uploader, responsive cyber-frost design system.
- [ ] **Phase 2 (Upcoming):** Multi-model neural guardrail integration (LlamaGuard, NeMo, semantic vector classifier) plugged seamlessly into `scanner_service.py`.
- [ ] **Phase 3 (Upcoming):** Live LLM agent execution sandbox in the AI Agent Playground with real-time tool calling tracing and automated canary token injection.
