function cutout = cut_iris(Img, face_loc, axes, offsets, submean)
% Calculate eye center (=around Iris) position based on the feature
% points. 
% EyePos ... [left, right, up, down, center]
% offsets ... [left, right, up, down, centerX, centerY] ... offset to expand/shift the window 
% submean ... subtract mean or not

%  Nov. 29, 2016  Akinori F. Ebihara

%------------------USER EDITABLE PARAMETERS----------------
Irisrange = 1/3; % ... of entire eye length
%----------------USER EDITABLE PARAMETERS END----------------

Xpos = axes.*2 - 1;
Ypos = axes.*2;

% be aware of the x / y axis distinction...

centerX = face_loc(Xpos(5))-offsets(5);
centerY = face_loc(Ypos(5))-offsets(6);

widthIris = Irisrange*(face_loc(Xpos(2))-face_loc(Xpos(1)));
radIris = widthIris/2;

Xrange = round(centerX-(radIris+offsets(1))):round(centerX+(radIris+offsets(2)));
Yrange = round(centerY-(radIris+offsets(3))):round(centerY+(radIris+offsets(4)));

cutout = Img(Yrange,Xrange);

if submean
    cutout = cutout - mean(cutout(:));
end
end

