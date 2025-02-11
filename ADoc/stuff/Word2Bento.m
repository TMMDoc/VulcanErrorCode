% C:\Users\wadehnwo\AppData\Local\Pandoc\pandoc RA.docx -f docx -t asciidoc --wrap=none --markdown-headings=atx --extract-media=extracted-media -o output.adoc

% == is sub folder level
% === is file level
%
clc
fid_rootcont=fopen('contents.txt','w');
fidout=fopen(['x.adoc'],'w');
fid_cont=fopen('x.txt','w');
fid=fopen('output.adoc','r');
while ~feof(fid);
    ilin=fgetl(fid);
    if length(ilin)>5
        
        if findstr(ilin(1:3),'== ');  %open folder
            foldnam=strrep(ilin(3:end),' ','');
            mkdir(foldnam)
            mkdir([foldnam,'\img'])
            fprintf(fid_rootcont,'[%s]\n',foldnam);
            ii=1;
            fclose(fidout);
            fidout=fopen(['.\',foldnam,'\index.adoc'],'w');
            fprintf(fidout,'%s\n\n',ilin(2:end));
            fclose(fid_cont);
            fid_cont=fopen(['.\',foldnam,'\contents.txt'],'w'); %fprintf('fopen fidcont %s\n',['.\',foldnam,'\contents.txt']);%content file in this sub folder
        elseif findstr(ilin(1:4),'=== ');%open doc in folder
                filenam=strrep(ilin(4:end),' ','');
                filenam=strrep(filenam,'/','_');
                fprintf(fid_cont,'%s\n',filenam);
                fclose(fidout);
                fidout=fopen(['.\',foldnam,'\',filenam,'.adoc'],'w'); %fprintf('fopen fidout %s\n',['.\',foldnam,'\',filenam,'.adoc']);
                fprintf(fidout,'\n%s\n\n',ilin(3:end));
        elseif findstr(ilin(1:5),'==== ');%open subheadline
                fprintf(fidout,'\n%s\n\n',ilin(3:end));
        elseif findstr(ilin,'Planning information');
            for ii=1:25 ilin=fgetl(fid); end;
            
        elseif findstr(ilin,'image:');   %image
            n=length(findstr(ilin,'image:')); %several images in one line
            if n>1
                n
            end
            for jj=1:n  %copy muliple files
                a=findstr(ilin,'/'); b=findstr(ilin,'.');c=findstr(ilin,'[');
                d=(jj-1)*4+2;
                try copyfile(['extracted-media/media/',ilin(a(d)+1:c(jj)-1)],[foldnam,'\img\']);
                   % fprintf(['extracted-media/media/',ilin(a((ii*4)+2)+1:c-1),' ',foldnam,'\img\']);
                catch
                    fprintf(['copy extracted-media/media/',ilin(a(d)+1:c(jj)-1),' ',foldnam,'\\img\\']);
                end;
            end
            ilin=strrep(ilin,'extracted-media/media','img');
            fprintf(fidout,'%s\n\n',ilin);
        else
            fprintf(fidout,'%s\n',ilin);
        end

   end;
end

fclose(fid);
fclose(fid_cont);fclose(fid_rootcont);
fclose(fidout);

a=dir;
for ii=[3:length(a)];
    if a(ii).isdir==1;
        if exist([a(ii).folder,'\',a(ii).name,'\index.adoc'])
        fid=fopen([a(ii).folder,'\',a(ii).name,'\index.adoc'],'r');
        ilin=fgetl(fid);
        fclose(fid);
        fid=fopen([a(ii).folder,'\',a(ii).name,'\index.adoc'],'w');
        fprintf(fid,'%s\n\n',ilin);
        fprintf(fid,'Note: this is a online snapshot of the version 01/2024 for internal use only. Please get the latest version via your service department. In only contains reference material snippets for repairs.\n');
        fclose(fid);
        end
    end
end
        fid=fopen([a(ii).folder,'\contents.txt'],'r');
        fclose(fid);

%Files = searchDocumentsInSubfolders(startingFolder,'.html');

