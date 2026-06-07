function rec = recommend_cautrain_rx(candidateOutcomes, decisionPoint, cfg)
% recommend_cautrain_rx
% Applies fatigue-aware safety filtering and utility-based ranking.

n = numel(candidateOutcomes);

utilities = nan(n,1);
isSafe    = false(n,1);

for k = 1:n

    F = candidateOutcomes(k).fatigue;
    R = candidateOutcomes(k).readiness;
    P = candidateOutcomes(k).performance;
    S = candidateOutcomes(k).safetyRisk;

    utilities(k) = cfg.lambdaP*P + cfg.lambdaR*R - cfg.lambdaF*F - cfg.lambdaS*S;

    fatigueThreshold = cfg.defaultFatigueThreshold;
    safetyThreshold  = cfg.defaultSafetyThreshold;

    isSafe(k) = (F <= fatigueThreshold) && (S <= safetyThreshold);

    candidateOutcomes(k).utility = utilities(k);
    candidateOutcomes(k).isSafe = isSafe(k);
end

safeIdx = find(isSafe);

rec = struct();
rec.athlete_id = decisionPoint.athlete_id;
rec.decision_time = decisionPoint.decision_time;
rec.allCandidateOutcomes = candidateOutcomes;

if isempty(safeIdx)

    rec.recommendedAction = "recovery";
    rec.rankedSafeActions = [];
    rec.fallbackRequired = true;
    rec.mandatoryCoachReview = true;
    return;
end

[~, orderLocal] = sort(utilities(safeIdx), "descend");
rankedIdx = safeIdx(orderLocal);

rec.recommendedAction = string(candidateOutcomes(rankedIdx(1)).action);
rec.rankedSafeActions = candidateOutcomes(rankedIdx);
rec.fallbackRequired = false;
rec.mandatoryCoachReview = false;
end
