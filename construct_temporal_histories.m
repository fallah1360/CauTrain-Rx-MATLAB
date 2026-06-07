function data = construct_temporal_histories(panel, cfg)
% construct_temporal_histories
% Builds look-back histories H_i,t^W for eligible decision points.

data = struct([]);

if isempty(panel)
    warning("Panel is empty. Returning empty temporal history structure.");
    return;
end

athletes = unique(panel.athlete_id);
count = 0;

for k = 1:numel(athletes)

    idx = panel.athlete_id == athletes(k);
    p = sortrows(panel(idx,:), "date");

    for t = cfg.lookBackWindow:height(p)

        count = count + 1;

        historyRows = (t-cfg.lookBackWindow+1):t;

        data(count).athlete_id = athletes(k);
        data(count).decision_time = p.date(t);
        data(count).history = p(historyRows,:);
        data(count).observed_action = p.action_label(t);

        % Add final outcome targets in dataset-specific implementation.
        data(count).target = struct();

    end
end
end
