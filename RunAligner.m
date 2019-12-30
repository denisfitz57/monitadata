username='denis';
spkrs= {'scr'}; %{'acr','ekl','ksh','law','mfo','mth','scr','sde'};
targetdir = 'AdultDirected';
dirlist=dir(targetdir);
dirlist={dirlist(3:end).name};
for curdir = dirlist
    cmd = ['C:\Users\fitden\Documents\montreal-forced-aligner\bin\mfa_align.exe -q H:\MonitaData\AdultDirected\' curdir{1} ' C:\Users\fitden\Documents\montreal-forced-aligner\bin\english.dict english  ..\output' curdir{1}];
    [status,cmdout] = system(cmd);
end