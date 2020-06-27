function [left_iris, right_iris, face] = FaceCrop(targimg, face_loc)

rightEyePos = [28, 30, 29, 31, 32]; %left, right, up, down, center
leftEyePos = [35, 33, 34, 36, 37]; %left, right, up, down, center
offsets = [0, 0, 0, 0, 0, 0];

left_iris = double(cut_iris(targimg, face_loc, leftEyePos, offsets, 0));
right_iris = double(cut_iris(targimg, face_loc, rightEyePos, offsets, 0));

face = cut_face(targimg, face_loc, 0); % use zero offset

end

