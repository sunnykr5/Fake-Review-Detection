"""One-command launcher: builds demo data if needed, starts the app and opens your browser.

    python run_demo.py            # uses the prebuilt simulation run if present, else builds a quick one (about a minute)
    python run_demo.py --port 8010
Needs only: pip install numpy pandas scipy scikit-learn networkx joblib   (no Node.js, no FastAPI)."""
from __future__ import annotations

import argparse
import subprocess
import sys
import threading
import webbrowser
from pathlib import Path

ROOT = Path(__file__).resolve().parent


def main() -> None:
    ap = argparse.ArgumentParser()
    ap.add_argument("--port", type=int, default=8000)
    ap.add_argument("--no-browser", action="store_true")
    a = ap.parse_args()
    if not (ROOT / "artifacts" / "reviewguard.db").exists():
        print("No prebuilt data found. Building a quick simulated corpus (about a minute)...")
        subprocess.check_call([sys.executable, "-m", "ml.pipeline", "synthetic", "--n", "3000", "--quick"], cwd=ROOT)
    if not (ROOT / "frontend" / "dist" / "index.html").exists():
        sys.exit("frontend/dist is missing. Install Node.js and run:  cd frontend && npm install && npm run build")
    url = f"http://127.0.0.1:{a.port}"
    if not a.no_browser:
        threading.Timer(1.5, lambda: webbrowser.open(url)).start()
    print(f"ReviewGuard is running at {url}   (press Ctrl+C to stop)")
    subprocess.call([sys.executable, "-m", "backend.app.devserver", "--port", str(a.port)], cwd=ROOT)


if __name__ == "__main__":
    main()
