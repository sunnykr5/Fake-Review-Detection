PY ?= python3
.PHONY: finish setup demo demo-quick real ott test test-py test-ui api dev build e2e report clean

setup:                ## install Python and frontend dependencies
	$(PY) -m pip install -r requirements.txt
	cd frontend && npm install

demo-quick:           ## about a minute: small simulated corpus, quick settings (for trying the app)
	$(PY) -m ml.pipeline synthetic --n 3000 --quick

demo:                 ## about 8 minutes: the full simulation study on 8,000 simulated reviews
	$(PY) -m ml.pipeline synthetic --n 8000

real:                 ## full pipeline on a real corpus: make real DATA=data/raw/yelpchi NAME=yelpchi
	$(PY) -m ml.pipeline run --data $(DATA) --format yelp --name $(NAME)

finish:               ## everything that needs network + the dataset, in order, stopping at the first failure: make finish DATA=data/raw/yelpchi
	DATA=$(or $(DATA),data/raw/yelpchi) bash scripts/finish.sh

ott:                  ## text-only reference experiment: make ott DATA=data/raw/op_spam_v1.4
	$(PY) -m ml.pipeline ott --path $(DATA)

test: test-py test-ui ## all tests
test-py:
	$(PY) -m unittest discover -s tests -t . -v
test-ui:
	cd frontend && npm test

api:                  ## FastAPI on :8000 (needs requirements.txt)
	$(PY) -m uvicorn backend.app.main:app --port 8000
dev:                  ## zero-dependency API + built frontend on :8000
	$(PY) -m backend.app.devserver --port 8000
build:                ## production frontend build
	cd frontend && npm run build
e2e:                  ## browser journeys against a running server (also saves screenshots)
	cd frontend && node e2e/journeys.mjs

report:               ## render results, findings and discussion into docs/report.md and docs/results.md
	$(PY) -m ml.report.build_docs

clean:
	rm -rf artifacts models/*.joblib frontend/dist
