clc
files={'2.10.7403'};
fold='PLC_Error';
msg='asd'%image:../img/Cabinet1.jpg[]';

for ii=1:length(files)
    fid=fopen(['.\',fold,'\',files{ii},'.adoc'],'r');
    while ~feof(fid)
        ilin=fgetl(fid);
        if findstr(ilin,'== Action');
        fprintf('%s\n\n%s\n',ilin,msg);
        else
        fprintf('x%s\n',ilin);    
        end
    end
end

    