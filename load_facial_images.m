function [live_flash, live_background,...
          spoof_flash, spoof_background] = load_facial_images(workingdir)

    [live_flash, ~] = Extract_PATHs(strcat(workingdir, '\live_flash'), true);
    [live_background, ~] = Extract_PATHs(strcat(workingdir, '\live_background'), true);
    [spoof_flash, ~] = Extract_PATHs(strcat(workingdir, '\spoof_flash'), true);
    [spoof_background, ~] = Extract_PATHs(strcat(workingdir, '\spoof_background'), true);
    
    if length(live_flash) ~= length(live_background) || ...
            length(spoof_flash) ~= length(spoof_background)
        error('length of the imagelists does not match!')
    end
end

