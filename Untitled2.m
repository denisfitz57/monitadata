cmdstr=[ 'praat &']; %open PRAAT and detach from Matlb
system(cmdstr);

targetdir = [pwd filesep 'AdultDirected'];
dirlist=dir(targetdir);
dirlist={dirlist(3:end).name};
tglist = dirlist(cellfun(@(x) contains(x,'output'),dirlist));
wavlist = dirlist(cellfun(@(x) ~contains(x,'output'),dirlist));
objnum=1;
for wavDir=wavlist
    wavDir=wavDir{1};
    wavfiles = dir([targetdir filesep wavDir filesep '*.wav']);
    wavfiles={wavfiles(3:end).name};
    for wav=wavfiles
        wav = wav{1};
        wavfilename = [targetdir filesep wavDir filesep wav];
        tgDir = ['output' wavDir filesep wavDir]; %mfa_align output path convention
        tgfilename = [targetdir filesep tgDir filesep wav(1:end-4) '.TextGrid'];
        cmdstr=[ 'sendpraat praat "sound = Read from file... ' wavfilename '"'];
        system(cmdstr);
        cmdstr=[ 'sendpraat praat "tg = Read from file... ' tgfilename '"'];
        system(cmdstr);
        cmdstr=[ 'sendpraat praat "plusObject: ' num2str(objnum) '"'];
        system(cmdstr);
        cmdstr=[ 'sendpraat praat "View & Edit"'];
        system(cmdstr);
        cmdstr=[ 'sendpraat praat "selectObject: ' num2str(objnum)  '"'];
        system(cmdstr);
        cmdstr=[ 'sendpraat praat "Play"'];
        system(cmdstr);
        cmdstr=[ 'sendpraat praat "plusObject: ' num2str(objnum+1)   '"'];
        system(cmdstr);
        cmdstr=[ 'sendpraat praat "Remove"'];
        system(cmdstr);
        objnum = objnum + 2;
    end
end
