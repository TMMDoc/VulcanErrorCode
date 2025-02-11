clear
for fff=1:4;
field={'HMI_error','NC_error','NC_error2','PLC_error'};
[t,t,raw]=xlsread('20230914_Errormessages_SIS.xlsx',field{fff});
fidc=fopen(['.\',field{fff},'\contents.txt'],'w');
for ff=2:length(raw);
    if  length(raw{ff,1})>1
    %if ~isnan(raw{ff,3}) %only the errors with additional description
    fprintf(fidc,'%s\n',['',raw{ff,1}]); fprintf('%s\n',['E',raw{ff,1}]);
    fid=fopen(['.\',field{fff},'\',raw{ff,1},'.adoc'],'w');
    if length(raw{ff,2})<15 
        fprintf(fid,'= %s\n:imagesdir: img\n\n',[raw{ff,1},' ',raw{ff,2}]);
    else
        fprintf(fid,'= %s\n:imagesdir: img\n\n',[raw{ff,1},' ',raw{ff,2}]);
    end
    for ii=2:5; 
        if isnan(raw{ff,ii}); raw{ff,ii}=' '; end;
        raw{ff,ii}=strrep(raw{ff,ii},'•',10);
        raw{ff,ii}=strrep(raw{ff,ii},'°','');
    end;
    fprintf(fid,'== Description\n%s\n\n',raw{ff,2});
    fprintf(fid,'== Cause\n%s\n\n',raw{ff,3});
    fprintf(fid,'== Action\n%s\n\n',raw{ff,4});
    fprintf(fid,'== Effect\n%s\n\n',raw{ff,5});
    fclose(fid);
    end;
end
fclose(fidc);
end;    