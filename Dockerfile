# ==============================================================================
# BLACK ICE — Unified Production Dockerfile (Render / Cloud Deployment)
# Multi-stage build: compiles Vite + React SPA & runs FastAPI ASGI service
# ==============================================================================

# ------------------------------------------------------------------------------
# Stage 1: Build the React + TypeScript frontend
# ------------------------------------------------------------------------------
FROM node:20-slim AS frontend-builder

WORKDIR /app/frontend

# Leverage Docker cache for npm dependencies
COPY frontend/package.json frontend/package-lock.json ./
RUN npm ci

# Copy full frontend source code
COPY frontend/ ./

# Compile production bundle into /app/frontend/dist
RUN npm run build

# ------------------------------------------------------------------------------
# Stage 2: Production Python FastAPI runner
# ------------------------------------------------------------------------------
FROM python:3.11-slim AS production

# Security & runtime environment configuration
ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PORT=8000 \
    HOST=0.0.0.0 \
    PYTHONPATH=/app/backend \
    FRONTEND_DIST_DIR=/app/frontend/dist

# Install essential system runtime libraries (curl for healthchecks, libpq5 for PostgreSQL)
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    libpq5 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Install backend dependencies
COPY backend/requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir -r /app/requirements.txt

# Copy backend application source
COPY backend/ /app/backend/

# Copy compiled frontend SPA bundle from builder stage
COPY --from=frontend-builder /app/frontend/dist /app/frontend/dist

# Create persistent storage mount directory (for Render Persistent Disk or SQLite)
RUN mkdir -p /var/data && chmod 777 /var/data && mkdir -p /data && chmod 777 /data

WORKDIR /app/backend

# Default internal port (Render injects $PORT at runtime)
EXPOSE 8000

# Container healthcheck against FastAPI health endpoint
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
    CMD curl -f http://127.0.0.1:${PORT:-8000}/api/health || exit 1

# Launch FastAPI ASGI server bound to 0.0.0.0 on Render's dynamic $PORT
CMD ["sh", "-c", "exec python -m uvicorn app.main:app --host 0.0.0.0 --port ${PORT:-8000}"]
