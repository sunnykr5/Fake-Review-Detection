# Contributing

Small, reviewable changes are welcome. Before opening a pull request:

1. `make test` passes (Python unit and integration tests, frontend logic tests).
2. If you touched the pipeline, run `make demo-quick` and confirm the app still loads.
3. If you touched the UI, run `make build && make dev` in one terminal and `make e2e` in another.
4. Do not commit datasets, trained models, databases or screenshots made from private data.
5. Never write a metric, citation or result by hand. Results come from `artifacts/results.json` via `make report`.

Design changes follow `docs/design-system.md`: tokens, not literals; risk is never colour alone.
