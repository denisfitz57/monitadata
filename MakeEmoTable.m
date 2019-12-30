targetdir = [pwd filesep 'AdultDirected'];
dirlist=dir(targetdir);
dirlist={dirlist(3:end).name};
tglist = dirlist(cellfun(@(x) contains(x,'output'),dirlist));
wavlist = dirlist(cellfun(@(x) ~contains(x,'output'),dirlist));
emoDirTable = table();
for wavDir=wavlist
    wavDir=wavDir{1};
    wavfiles = dir([targetdir filesep wavDir filesep '*.wav']);
    wavfiles={wavfiles.name};
    for wav=wavfiles
        wav = wav{1};
        tmp = strsplit(wav,'_');
        subjnum= str2num(tmp{1});
        sentencenum = str2num(tmp{2});
        emotion = {tmp{3}};
        sex = {tmp{4}(1)};
        wavfilename = {[targetdir filesep wavDir filesep wav]};
        tgDir = ['output' wavDir filesep wavDir]; %mfa_align output path convention
        tgfilename = {[targetdir filesep tgDir filesep wav(1:end-4) '.TextGrid']};
        emoDirTable = [emoDirTable;table(subjnum,sentencenum,emotion,sex,wavfilename,tgfilename)];
    end
end
writetable(emoDirTable,'EmoTable.xlsx');
