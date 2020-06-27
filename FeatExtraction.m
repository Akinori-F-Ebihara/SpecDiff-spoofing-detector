function face_loc = FeatExtraction(face_cen, targimg, tag)

    face_loc = load(strcat('./face_loc/', tag, '.mat'));
    face_loc = face_loc.face_loc;
end

