function prepParams = fit_preprocessing_params(trainPanel, cfg)
% fit_preprocessing_params
% Estimates preprocessing parameters using training data only.
%
% Includes:
%   missingness rules
%   imputation values
%   normalization means and standard deviations
%   winsorization percentile limits
%   athlete-specific baselines

prepParams = struct();

if isempty(trainPanel)
    warning("Training panel is empty. Returning placeholder preprocessing parameters.");
    prepParams.featureMeans = [];
    prepParams.featureStds  = [];
    prepParams.winsorLow    = [];
    prepParams.winsorHigh   = [];
    return;
end

% Placeholder:
% featureVars = {...};
% prepParams.featureMeans = varfun(@mean, trainPanel(:,featureVars));
% prepParams.featureStds  = varfun(@std,  trainPanel(:,featureVars));
% prepParams.winsorLow    = prctile(trainPanel{:,featureVars}, 1);
% prepParams.winsorHigh   = prctile(trainPanel{:,featureVars}, 99);

end
