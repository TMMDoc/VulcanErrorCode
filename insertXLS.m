

if 0
    [f.file,f.path] = uigetfile('*.xlsx','Error file');
    if f.file~=0 [NUM,TXT,RAW]=xlsread([f.path,f.file]); end
    f.dir = uigetdir('folder of the PLC Adocs');
end

for ii=2:length(RAW)
    
    if ~isnan(RAW{ii,3})
        
        clc;
        fprintf('**xls line %d **',ii);
        ifile = fileread([f.dir,'\',RAW{ii,1},'.adoc']);
        
        disp(ifile);
        
        if 1 %first check if all files are readable then execute writing
            if ~isnan(RAW{ii,4}) fprintf('*********\n Cause\n%s\nAction\n%s\n',RAW{ii,3},RAW{ii,4});
            else fprintf('*********\n Cause\n%s\n',RAW{ii,3}); end;
            
            reply = input('Add to message? [y]:','s');
            if reply == 'y';
                ifile=strrep(ifile,'Cause',['Cause',13,RAW{ii,3}]);
                if ~isnan(RAW{ii,4}) ifile=strrep(ifile,'Action',['Action',13,RAW{ii,4}]); end
                fid=fopen([f.dir,'\',RAW{ii,1},'.adoc'],'w');
                fprintf(fid,'%s\n',ifile);
                fclose(fid);
            else
                fid=fopen('reject.txt','a');
                fprintf(fid,'%s\n',RAW{ii,1});
                fclose(fid);
            end;
        end
        
    end
end;

