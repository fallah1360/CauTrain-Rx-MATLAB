function panelOut = apply_preprocessing_params(panelIn, prepParams, cfg)
% apply_preprocessing_params
% Applies fixed preprocessing parameters to a panel.
%
% No validation or test statistics should be estimated inside this function.

panelOut = panelIn;

if isempty(panelIn)
    return;
end

% Placeholder implementation steps:
%   1. Create missingness indicators.
%   2. Forward-fill short gaps within athlete using past observations only.
%   3. Impute longer gaps using training-set values stored in prepParams.
%   4. Winsorize workload variables using prepParams bounds.
%   5. Standardize continuous variables using prepParams means and stds.

end
