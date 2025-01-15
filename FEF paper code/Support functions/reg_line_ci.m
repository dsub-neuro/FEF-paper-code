function [line, negError, posError] = reg_line_ci(xVar, yVar, xNew)

%needs to be a column vector
if size(xNew, 1) < size(xNew, 2)
    xNew = xNew';
end

mdl = fitlm(xVar, yVar, 'RobustOpts', 'on');
[line, CI] = predict(mdl, xNew);

negError = line - CI(:, 1);
posError = CI(:, 2) - line;

end