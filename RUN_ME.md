# Run ReviewGuard on your computer

You need **Python 3.11 or newer**. You do not need Node.js, an account, or an internet connection after the install.

## 1. Install (once)
Open a terminal in this folder and run:

    python -m pip install numpy pandas scipy scikit-learn networkx joblib

(Windows: if `python` is not found, try `py -m pip install ...` and `py run_demo.py`.)
If a newer library version gives an error, use the exact versions we tested: `python -m pip install -r requirements-tested.txt`.

## 2. Start the app

    python run_demo.py

Your browser opens at http://127.0.0.1:8000. Press Ctrl+C in the terminal to stop.

The folder ships with a prebuilt simulation run (`artifacts/`, `models/`) and the built interface (`frontend/dist/`), so it starts at once.
If `artifacts/` is missing, `run_demo.py` builds a small run first (about a minute).

## 3. Re-run the whole experiment yourself (optional, about 8 minutes)

    python -m ml.pipeline synthetic --n 8000
    python -m ml.robustness
    python -m ml.report.build_docs      # rewrites docs/report.md and docs/results.md from the new results

## 4. Run the tests (optional)

    python -m unittest discover -s tests -t .

## What you are looking at
The reviews are **simulated**: the generator plants spam rings, bursts and templated text, so the study shows how well the method recovers known patterns. Present it as a simulation study. See `docs/simulation.md` for what it can and cannot show, and `docs/demo-guide.md` for a 5 to 10 minute demo script.

## Rebuilding the interface (only if you change the frontend)
Install Node.js 20+, then: `cd frontend && npm install && npm run build`.
