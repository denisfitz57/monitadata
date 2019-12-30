emoDirTable = readtable('EmoTable.xlsx');
emotions = unique(emoDirTable.emotion)';
subjects = unique(emoDirTable.subjnum)';
sentences = unique(emoDirTable.sentencenum)';
sex = unique(emoDirTable.sex)';
numsubjects = length(subjects);
fn='emotsentplots';
flag=1;
for sentence = sentences(1:12)
    emotioncount = 1;
    hf=figure('units','normalized','outerposition',[0 0 .95 .95])
    for emotion = emotions
        subjcount = 1;
        maxmax = 0;
        subplot(3,2,emotioncount);
        ylim([0 numsubjects+1]);
        ylabel('Speaker Number');
        yticks(0:numsubjects+1);;
        xlabel('Time (sec)');
        yticklabels([{' '}; split(num2str(subjects)); {' '}])
        for subject = subjects
            curtarget = emoDirTable.sentencenum == sentence  & ...
                contains(emoDirTable.emotion,emotion)  & ...
                emoDirTable.subjnum == subject;
            if sum(curtarget) > 0
                cursoundfile = emoDirTable.wavfilename(curtarget);
                curtgfile = emoDirTable.tgfilename(curtarget);
                textgrid = tgRead(curtgfile{1});
                textgrid.tier(:,2)=[]; %remove phone tier
                
                labels = textgrid.tier{1}.Label;
                Xs = textgrid.tier{1}.T1;
                Xs2 = textgrid.tier{1}.T2;
                if isempty(labels{end})
                    Xs = Xs(1:end-1);
                    Xs2 = Xs2(1:end-1);
                    labels = labels(1:end-1);
                end
                for ii = 1:length(labels)
                    if isempty(labels{ii})
                        if ii == 1
                            Xs=Xs-Xs(2);
                            Xs2=Xs2-Xs2(2);
                            continue
                        else
                            lbl = '';
                        end
                    else
                        lbl=labels{ii};
                    end
                    text(Xs(ii),subjcount,lbl);
                end
                maxmax = max(maxmax,max(Xs(end)+.1));
                xlim([-.05 maxmax]);
            end
            subjcount = subjcount + 1;
        end
        title(['Emotion: ' emotion{1} '   Sentence: ' num2str(sentence) ])
        emotioncount =  emotioncount + 1;
    end
    if flag
        export_fig(hf,fn,'-pdf','-r300');
        flag = 0;
    else
        export_fig(hf,fn,'-pdf','-r300','-append');
    end
    close
end
                