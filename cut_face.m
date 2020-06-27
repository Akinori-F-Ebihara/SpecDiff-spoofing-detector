function cutout = cut_face( Img, pos_f12, offset)
% cut out face region based on the f12 positions. compare 4 eyebrow feature
% points to find the maximum size of a face
% axis ... left, right, up, down, (center)

% Nov. 30, 2016 Akinori F. Ebihara

axes  = [1, 15, 8]; % left, right, (up), down
brow = [17, 18, 23, 24]; % 4 eyebrow positions

% Xpos_brow = brow.*2 - 1;
Ypos_brow = brow.*2;
[~, minind] = min(pos_f12(Ypos_brow));
axes = [axes(1:2),brow(minind),axes(end)];

Xpos = axes.*2 - 1;
Ypos = axes.*2;

if pos_f12(Ypos(3))-offset < 1
    pos_f12(Ypos(3)) = 1+offset;
elseif pos_f12(Ypos(4))+offset > size(Img,1)
    pos_f12(Ypos(4)) = 1+offset;
elseif pos_f12(Xpos(1))-offset < 1
    pos_f12(Xpos(1)) = 1+offset;
elseif pos_f12(Xpos(2))+offset > size(Img,2)
    pos_f12(Xpos(2)) = 1+offset;
end

cutout = Img(...
    round(pos_f12(Ypos(3))-offset):round(pos_f12(Ypos(4))+offset),...
    round(pos_f12(Xpos(1))-offset):round(pos_f12(Xpos(2))+offset)...
    );

end

