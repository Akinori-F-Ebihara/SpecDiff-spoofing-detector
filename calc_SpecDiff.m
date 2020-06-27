function SpecDiff = calc_SpecDiff(...
    iris_flash_left, iris_flash_right, ...
    iris_background_left, iris_background_right, ...
    face_flash, face_background)
    
    list_length = length(iris_flash_left');
    SpecDiff = cell(1, list_length);
    
    for i =1:list_length
        targ_face_flash = face_flash{i};
        targ_face_background = face_background{i};
        targ_iris_flash_left = iris_flash_left{i};
        targ_iris_flash_right = iris_flash_right{i};
        targ_iris_background_left = iris_background_left{i};
        targ_iris_background_right = iris_background_right{i};
        
        % calculate Ddiff:  
        Ddiff = calc_feat(targ_face_flash, targ_face_background);

        % calculate Dspec:
        Dspec_left = calc_feat(targ_iris_flash_left, targ_iris_background_left);
        Dspec_right = calc_feat(targ_iris_flash_right, targ_iris_background_right);
        Dspec = [sort(Dspec_left), sort(Dspec_right)];

        SpecDiff{i} = [Dspec, Ddiff];
        
    end
    
    function feat_vec = calc_feat(flash, background)
       feat = (flash - background) ./ (flash + background); 
       feat_vec = reshape(feat, 1, numel(feat));
       feat_vec(isnan(feat_vec)) = 0;
    end

end

