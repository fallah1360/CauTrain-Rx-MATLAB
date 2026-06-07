function candidateOutcomes = predict_candidate_outcomes(model, decisionPoint, cfg)
% predict_candidate_outcomes
% Estimates action-conditioned outcomes for all feasible actions.

feasibleActions = determine_feasible_actions(decisionPoint, cfg);

candidateOutcomes = struct([]);

for a = 1:numel(feasibleActions)

    action = feasibleActions{a};

    % Placeholder predictions.
    % Replace with model.temporalEncoder and model.outcomeHead inference.
    predFatigue     = NaN;
    predReadiness   = NaN;
    predPerformance = NaN;
    predSafetyRisk  = NaN;

    candidateOutcomes(a).action = action;
    candidateOutcomes(a).fatigue = predFatigue;
    candidateOutcomes(a).readiness = predReadiness;
    candidateOutcomes(a).performance = predPerformance;
    candidateOutcomes(a).safetyRisk = predSafetyRisk;
end
end

function feasibleActions = determine_feasible_actions(decisionPoint, cfg)
% Default feasibility before safety filtering.
feasibleActions = cfg.actions;
end
