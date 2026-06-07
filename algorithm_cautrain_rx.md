# Algorithm: CauTrain-Rx Counterfactual Fatigue-Aware Training Prescription

## Input

- Longitudinal athlete-monitoring dataset `${\mathcal{D}}$`
- Look-back window `${W}$
- Prediction horizon `${\Delta}$
- Candidate action space `${\mathcal{A}^{0}=\{a^{rec},a^{red},a^{bal},a^{perf}\}}$
- Fatigue threshold `${\tau^{F}_{i,t}}$
- Safety-risk threshold `${\tau^{S}_{i,t}}$
- Utility weights `${\lambda_P,\lambda_R,\lambda_F,\lambda_S}$

## Output

- Safety-filtered action set `${\mathcal{A}^{safe}_{i,t}}$
- Ranked prescription list `${\mathcal{R}_{i,t}}$
- Recommended action `${a^{*}_{i,t}}$
- Coach-reviewable recommendation package
- Decision log

## Pseudocode

```text
Algorithm CauTrain-Rx

1.  Load raw athlete-monitoring files.
2.  Harmonize wellness, workload, session, injury, illness, and performance data.
3.  Construct a unified athlete-day panel.
4.  Sort records chronologically within each athlete.
5.  Split each athlete timeline into training, validation, and test partitions.
6.  Estimate preprocessing parameters from training data only.
7.  Apply leakage-free preprocessing to all partitions.
8.  Estimate athlete-specific workload thresholds from training data only.
9.  Construct workload-derived action labels:
        recovery-oriented
        reduced-load
        balanced-load
        performance-oriented
10. Construct temporal histories H_i,t^W for eligible decision points.
11. Train the temporal encoder g_phi and action-conditioned outcome head m_theta.
12. Optionally train an action-assignment model for propensity and overlap diagnostics.
13. For each test decision point (i,t):
        a. Retrieve athlete history H_i,t^W.
        b. Encode the history as h_i,t = g_phi(H_i,t^W).
        c. Determine feasible candidate actions A_i,t.
        d. For each feasible action a:
              Estimate fatigue, readiness, performance response, and safety risk.
              Compute prescription utility.
              Check fatigue and safety-risk constraints.
        e. Construct safety-filtered set A_i,t^safe.
        f. If A_i,t^safe is empty:
              Assign recovery-oriented fallback.
              Flag mandatory coach review.
           Else:
              Rank safe actions by utility.
              Select the highest-utility safe action.
        g. Generate coach-reviewable recommendation package.
        h. Store the decision log.
14. Evaluate prediction, safety, utility, fallback, and stability metrics.
```
