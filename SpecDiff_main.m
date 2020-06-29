% An example implementation of the SpecDiff descriptor.
%
% inputs: Pair of facial images, one with flash and another without flash
% (i.e., under background light)
%
% outputs: SVM classification scores (positive: live, negative: spoof)
% and the calculated SpecDiff plotted on a figure.
% For the SVM, Radial basis function kernel-SVM is used with pretrained weights 
% to classify the SpecDiff descriptor.
%
% June 18th, 2020. Akinori F. Ebihara.

clear 
close all
fclose('all');


%================USER EDITABLE PARAMETERS START===================
[workingdir, name, ext] = fileparts(which(mfilename));
params = load(strcat(workingdir, '\parameters\parameters.mat'));
params.Gaussian_sigma = [2,5]; % Gaussian sigma parameters for iris and face region, respectively.
Label = {sprintf('correct_%d_%d',params.Gaussian_sigma(1),params.Gaussian_sigma(2)),sprintf('fake_%d_%d',params.Gaussian_sigma(1),params.Gaussian_sigma(2))};
params.Rel = 0.5; % Rel = 0.5; %d10 param: reliability
params.NumFace = 1; % NumFace = 1; %d10 param: #face / image
params.EyeDistMIN = 50; % EyeDistMIN = 20; %d10 param: minimum eye distance (pixels)
params.EyeDistMAX = 1000; % EyeDistMAX = 1000; %d10 param: maximum eye distance (pixels)
% params.rightEyePos = [28, 30, 29, 31, 32]; %left, right, up, down, center
% params.leftEyePos = [35, 33, 34, 36, 37]; %left, right, up, down, center
params.offset = 20; % offset from detected eye regions
params.IrisSize = [40,40]; % size of cut Iris images
params.Face3Dsize = [100,100];
%================USER EDITABLE PARAMETERS END===================

currdir = pwd;
cd(workingdir);


% load example imagelists
[live_flash, live_background, spoof_flash, spoof_background] = ...
    load_facial_images(workingdir);


% preprocessing
[live_iris_flash_left, live_iris_flash_right, live_face_flash] = ...
    preprocessing(live_flash, 'live_flash', params);

[live_iris_background_left, live_iris_background_right, live_face_background] = ...
    preprocessing(live_background, 'live_background', params);

[spoof_iris_flash_left, spoof_iris_flash_right, spoof_face_flash] = ...
    preprocessing(spoof_flash, 'spoof_flash', params);

[spoof_iris_background_left, spoof_iris_background_right, spoof_face_background] = ...
    preprocessing(spoof_background, 'spoof_background', params);


% calculate feature vectors
SpecDiff_live = ...
    calc_SpecDiff(...
    live_iris_flash_left, live_iris_flash_right, ...
    live_iris_background_left, live_iris_background_right, ...
    live_face_flash, live_face_background);

SpecDiff_spoof = ...
    calc_SpecDiff(...
    spoof_iris_flash_left, spoof_iris_flash_right, ...
    spoof_iris_background_left, spoof_iris_background_right,...
    spoof_face_flash, spoof_face_background);


% classify with the pretrained SVM
score_live = run_RBF_SVM(SpecDiff_live, params);
score_spoof = run_RBF_SVM(SpecDiff_spoof, params);


% visualize the result
figure('Position', [10, 10, 1628, 1010]);
hold on;
id = 1;
plot(SpecDiff_live{id}, 'linewidth', 2);
plot(SpecDiff_spoof{id}, 'linewidth', 2);
legend(sprintf('live, score:%d', score_live(id)),...
    sprintf('spoof, score:%d', score_spoof(id)));
set(gca, 'tickdir', 'out', 'fontsize', 20);
cd(pwd);
