function varargout = derive_action_labels(panelIn, cfg, mode, actionParams)
% derive_action_labels
% Fits or applies workload-derived action labels.
%
% mode = "fit":
%   Estimate athlete-specific Q25, Q50, Q75 from training data only.
%
% mode = "apply":
%   Apply fixed thresholds to any partition.

arguments
    panelIn
    cfg
    mode string
    actionParams = struct()
end

if mode == "fit"

    actionParams = struct();

    if isempty(panelIn)
        warning("Training panel is empty. Returning placeholder action parameters.");
        varargout{1} = actionParams;
        return;
    end

    athletes = unique(panelIn.athlete_id);

    for k = 1:numel(athletes)
        athlete = athletes(k);

        idx = panelIn.athlete_id == athlete;

        % Replace load_score with final workload score variable.
        L = panelIn.load_score(idx);
        L = L(L > 0);

        actionParams(k).athlete_id = athlete;
        actionParams(k).q25 = prctile(L,25);
        actionParams(k).q50 = prctile(L,50);
        actionParams(k).q75 = prctile(L,75);
    end

    varargout{1} = actionParams;
    return;
end

if mode == "apply"

    panelOut = panelIn;

    if isempty(panelIn)
        varargout{1} = panelOut;
        return;
    end

    panelOut.action_label = strings(height(panelOut),1);

    for r = 1:height(panelOut)

        athlete = panelOut.athlete_id(r);
        pIdx = find([actionParams.athlete_id] == athlete, 1);

        if isempty(pIdx)
            panelOut.action_label(r) = "recovery";
            continue;
        end

        L = panelOut.load_score(r);
        q25 = actionParams(pIdx).q25;
        q50 = actionParams(pIdx).q50;
        q75 = actionParams(pIdx).q75;

        if L == 0 || L <= q25
            panelOut.action_label(r) = "recovery";
        elseif L <= q50
            panelOut.action_label(r) = "reduced_load";
        elseif L <= q75
            panelOut.action_label(r) = "balanced_load";
        else
            panelOut.action_label(r) = "performance";
        end
    end

    varargout{1} = panelOut;
    return;
end

error("Unknown mode. Use 'fit' or 'apply'.");
end
