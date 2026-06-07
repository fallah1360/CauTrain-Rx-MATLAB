function [trainPanel, valPanel, testPanel] = chronological_split_by_athlete(panel, cfg)
% chronological_split_by_athlete
% Splits each athlete timeline into train, validation, and test partitions.
%
% Required columns in final implementation:
%   athlete_id
%   date or time_index

if isempty(panel)
    trainPanel = table();
    valPanel   = table();
    testPanel  = table();
    warning("Panel is empty. This is expected in pseudocode mode.");
    return;
end

athletes = unique(panel.athlete_id);

trainPanel = table();
valPanel   = table();
testPanel  = table();

for k = 1:numel(athletes)

    idx = panel.athlete_id == athletes(k);
    p = panel(idx,:);
    p = sortrows(p, "date");

    n = height(p);

    nTrain = floor(cfg.trainRatio*n);
    nVal   = floor(cfg.valRatio*n);

    trainPanel = [trainPanel; p(1:nTrain,:)];
    valPanel   = [valPanel;   p(nTrain+1:nTrain+nVal,:)];
    testPanel  = [testPanel;  p(nTrain+nVal+1:end,:)];

end
end
