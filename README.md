# CauTrain-Rx MATLAB Pseudocode

This repository contains a MATLAB-style pseudocode skeleton for **CauTrain-Rx**, a coach-reviewable counterfactual decision-support framework for fatigue-aware training prescription in elite soccer.

The code is intentionally written as a clear implementation template rather than a dataset-specific executable package. Dataset loading, exact variable names, and final model architectures should be adapted to the processed SoccerMon panel used in the manuscript.

## Files

| File | Description |
|---|---|
| `README.md` | Repository overview |
| `algorithm_cautrain_rx.md` | Journal-style pseudocode |
| `run_cautrain_rx_demo.m` | Main MATLAB-style workflow script |
| `build_athlete_day_panel.m` | Data harmonization placeholder |
| `fit_preprocessing_params.m` | Training-only preprocessing parameter estimation |
| `apply_preprocessing_params.m` | Leakage-free preprocessing application |
| `derive_action_labels.m` | Workload-derived action construction |
| `construct_temporal_histories.m` | Look-back history construction |
| `train_cautrain_rx_model.m` | Model training placeholder |
| `predict_candidate_outcomes.m` | Action-conditioned prediction placeholder |
| `recommend_cautrain_rx.m` | Safety filtering and utility ranking |
| `evaluate_cautrain_rx.m` | Metric evaluation placeholder |

## Main workflow

1. Harmonize SoccerMon subjective files into an athlete-day panel.
2. Split the data chronologically by athlete.
3. Fit preprocessing parameters using training data only.
4. Apply the same preprocessing parameters to validation and test data.
5. Derive workload-based action labels using training-only thresholds.
6. Construct temporal athlete histories.
7. Train the CauTrain-Rx action-conditioned estimator.
8. Estimate candidate outcomes for feasible prescriptions.
9. Apply fatigue-aware safety filtering.
10. Rank safe prescriptions by utility.
11. Generate coach-reviewable outputs.
12. Evaluate prediction and prescription-level metrics.

## Notes

- This package does not include the SoccerMon dataset.
- All preprocessing and threshold estimation must be fitted on the training partition only.
- The coach-review step is represented as a deployment-oriented design component.
- The code should be treated as pseudocode until dataset-specific loaders and model definitions are implemented.

## Citation placeholder

```bibtex
@article{cautrainrx,
  title   = {CauTrain-Rx: A Coach-Reviewable Counterfactual Decision-Support Framework for Fatigue-Aware Training Prescription in Elite Soccer},
  author  = {To be updated},
  journal = {To be updated},
  year    = {To be updated}
}
```
