function score_pool = run_RBF_SVM(feature_vector, params)
    % home-made SVM classifieer with RBF kernel.
    %
    % input:
    %       feature_vector: SpecDiff descriptor with 13200 dim.
    %       workingdir: main directory contains a subdirectory parameters.
    %
    % output:
    %       decision_value: SVM result.
    %
    %
    % SVM parameters to be loaded:
    %       params.coef ... Support vector coefficients. vector with length same as totalSV.
    %       params.SV ... Support vectors. matrix of size totalSV x feature length.
    %       params.gamma ... RBF parameter, gamma = 1/(2*sigma^2)
    %       params.rho ... bias term.
    %
    %   Akinori F. Ebihara, July 5th, 2017

    Nsv = length(params.coef);
    list_length = length(feature_vector');
    score_pool = zeros(1, list_length);
    
    for j = 1:list_length
        decision_value = 0;

        % calculate the decision value 
        for i = 1:Nsv
            decision_value = decision_value + params.coef(i) * ...
                    RBFkernel(params.SV(i,:), feature_vector{j}, params.gamma);
        end
        score_pool(j) = decision_value - params.rho;

    end

    function val = RBFkernel(vec1, vec2, gamma)
        val = exp(-gamma * (dot(vec1, vec1) + ...
                           dot(vec2, vec2) - ...
                           2 * dot(vec1, vec2)));
    end

end

