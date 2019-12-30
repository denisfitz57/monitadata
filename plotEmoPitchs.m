
cmdstr=[ 'praat &']; %open PRAAT and detach from Matlb
system(cmdstr);
emoDirTable = readtable('EmoTable.xlsx');
emotions = unique(emoDirTable.emotion)';
subjects = unique(emoDirTable.subjnum)';
sentences = unique(emoDirTable.sentencenum)';
sex = unique(emoDirTable.sex)';
numsubjects = length(subjects);
objnum = 1;
for sentence = sentences
    emotioncount = 1;
%     figure('units','normalized','outerposition',[0 0 .95 .95])
    for emotion = emotions
        subjcount = 1;
        maxmax = 0;
        for subject = subjects
            curtarget = emoDirTable.sentencenum == sentence  & ...
                contains(emoDirTable.emotion,emotion)  & ...
                emoDirTable.subjnum == subject;
            if sum(curtarget) > 0
                cursoundfile = emoDirTable.wavfilename(curtarget);
                cmdstr=[ 'sendpraat praat "s1 = Read from file... ' cursoundfile{1} '"'];
                system(cmdstr);
                cmdstr=[ 'sendpraat praat "To Pitch: 0, 75, 600"'];
                system(cmdstr);
                cmdstr=[ 'sendpraat praat "Down to PitchTier"'];
                system(cmdstr);
                cmdstr=[ 'sendpraat praat "Save as text file... ' [cursoundfile{1}(1:end-4) '.PitchTier'] '"'];
                system(cmdstr);
                pt=ptRead([cursoundfile{1}(1:end-4) '.PitchTier']);
                ptPlot(pt);
                cmdstr=[ 'sendpraat praat "plusObject: ' num2str(objnum)];
                system(cmdstr);
                cmdstr=[ 'sendpraat praat "plusObject: ' num2str(objnum+1)];
                system(cmdstr);
                cmdstr=[ 'sendpraat praat "Remove"'];
                system(cmdstr);
                objnum = objnum + 3;
            end
            subjcount = subjcount + 1;
        end
        title([emotion ])
        emotioncount =  emotioncount + 1;
    end
end
                