function [iris_left, iris_right, face] = preprocessing(img_list, tag, params)
    %UNTITLED4 Summary of this function goes here
    
    % Note that the functions FaceDetection and FeatExtraction cannot be
    % disclosed because they are a part of proprietary software. Instead we
    % provide mock codes that return pre-calculated values.
    % The argument 'tag' is only used to associate the input image with 
    % pre-calculated face and featurepoint locations. A user may safely 
    % replace the face detection and face featurepoint extraction function 
    % to delete the tag argument.

    list_length = length(img_list');

    iris_left = cell(1, length(list_length));
    iris_right = cell(1, length(list_length));
    face = cell(1, length(list_length));

    
    for i = 1:list_length
        
        % load the image
        targimg = imread(img_list{i});
        
        % preprocessing #1: rotation (if needed)
        imsize = size(targimg);
        if imsize(1) < imsize(2)
            targimg = imrotate(targimg, -90);
        end
        
        % preprocessing #2: grayscale conversion
        targimg = rgb2gray(targimg);
        
        % preprocessing #3: face detection
        face_cen = FaceDetection(targimg, strcat(tag, '_', int2str(i)));
        
        % preprocessing #3: facial feature extraction
        face_loc = FeatExtraction(face_cen, targimg, strcat(tag, '_', int2str(i)));
        
        % crop the region of interests
        [iris_pre_left, iris_pre_right, face_pre] = FaceCrop(targimg, face_loc);
        
        % apply Gaussian Filters
        iris_pre_left = GaussFilter(iris_pre_left, params.Gaussian_sigma(1));
        iris_pre_right = GaussFilter(iris_pre_right, params.Gaussian_sigma(1));
        face_pre = GaussFilter(face_pre, params.Gaussian_sigma(2));
        
        % resize
        iris_left{i} = imresize(iris_pre_left, [params.IrisSize(1), params.IrisSize(2)]);
        iris_right{i} = imresize(iris_pre_right, [params.IrisSize(1), params.IrisSize(2)]);
        face{i}  = double(imresize(face_pre, [params.Face3Dsize(1), params.Face3Dsize(2)]));
    
    end
    
end
