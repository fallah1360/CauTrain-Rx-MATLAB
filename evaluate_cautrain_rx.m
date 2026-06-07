function metrics = evaluate_cautrain_rx(recommendations, testData, cfg)
% evaluate_cautrain_rx
% Computes prediction and prescription-level metrics.
%
% Final implementation should compute:
%   MAE
%   RMSE
%   Safety F1
%   Brier score
%   estimated safety-constraint violation rate
%   average utility
%   fallback/review flag rate
%   recommendation stability across seeds

metrics = struct();

metrics.fatigueMAE = NaN;
metrics.readinessMAE = NaN;
metrics.safetyF1 = NaN;
metrics.brierScore = NaN;
metrics.violationRate = NaN;
metrics.averageUtility = NaN;
metrics.fallbackRate = NaN;
metrics.recommendationStability = NaN;

end
