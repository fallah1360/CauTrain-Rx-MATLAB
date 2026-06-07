%% run_cautrain_rx_demo.m
% CauTrain-Rx MATLAB-style pseudocode workflow
% This script is a reproducible implementation skeleton.
% Replace placeholder loaders and model routines with final dataset-specific code.

clear; clc; close all;

%% -------------------- Configuration --------------------

cfg = struct();

cfg.randomSeeds      = [1 2 3 4 5];
cfg.lookBackWindow   = 21;      % W
cfg.predHorizon      = 1;       % Delta, next available monitoring point
cfg.trainRatio       = 0.70;
cfg.valRatio         = 0.15;
cfg.testRatio        = 0.15;

cfg.actions = {'recovery','reduced_load','balanced_load','performance'};

% Utility weights: U = lambdaP*P + lambdaR*R - lambdaF*F - lambdaS*S
cfg.lambdaP = 0.25;
cfg.lambdaR = 0.25;
cfg.lambdaF = 0.25;
cfg.lambdaS = 0.25;

% Safety thresholds can be athlete-specific in the final implementation.
cfg.defaultFatigueThreshold = 7.0;
cfg.defaultSafetyThreshold  = 0.30;

% Propensity clipping threshold for optional inverse-propensity weighting.
cfg.eMin = 0.05;

%% -------------------- Load and harmonize data --------------------

rawData = struct();
% rawData = load_soccer_mon_subjective_files(dataFolder);
% Implement dataset-specific file loading before calling build_athlete_day_panel.

panel = build_athlete_day_panel(rawData);

%% -------------------- Chronological athlete-aware split --------------------

[trainPanel, valPanel, testPanel] = chronological_split_by_athlete(panel, cfg);

%% -------------------- Leakage-free preprocessing --------------------

prepParams = fit_preprocessing_params(trainPanel, cfg);

trainPanel = apply_preprocessing_params(trainPanel, prepParams, cfg);
valPanel   = apply_preprocessing_params(valPanel, prepParams, cfg);
testPanel  = apply_preprocessing_params(testPanel, prepParams, cfg);

%% -------------------- Workload-derived action labels --------------------

actionParams = derive_action_labels(trainPanel, cfg, "fit");

trainPanel = derive_action_labels(trainPanel, cfg, "apply", actionParams);
valPanel   = derive_action_labels(valPanel, cfg, "apply", actionParams);
testPanel  = derive_action_labels(testPanel, cfg, "apply", actionParams);

%% -------------------- Temporal history construction --------------------

trainData = construct_temporal_histories(trainPanel, cfg);
valData   = construct_temporal_histories(valPanel, cfg);
testData  = construct_temporal_histories(testPanel, cfg);

%% -------------------- Repeated-run model training and evaluation --------------------

allResults = cell(numel(cfg.randomSeeds),1);

for s = 1:numel(cfg.randomSeeds)

    rng(cfg.randomSeeds(s), "twister");

    fprintf("\nRunning CauTrain-Rx seed %d/%d...\n", s, numel(cfg.randomSeeds));

    model = train_cautrain_rx_model(trainData, valData, cfg);

    recommendations = cell(numel(testData),1);

    for j = 1:numel(testData)

        decisionPoint = testData(j);

        candidateOutcomes = predict_candidate_outcomes(model, decisionPoint, cfg);

        recommendations{j} = recommend_cautrain_rx(candidateOutcomes, decisionPoint, cfg);

    end

    metrics = evaluate_cautrain_rx(recommendations, testData, cfg);

    allResults{s} = struct( ...
        "seed", cfg.randomSeeds(s), ...
        "model", model, ...
        "recommendations", {recommendations}, ...
        "metrics", metrics);

end

%% -------------------- Summarize repeated-run results --------------------

summaryTable = summarize_repeated_runs(allResults);

disp("CauTrain-Rx repeated-run summary:");
disp(summaryTable);
