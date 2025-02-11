% C:\Users\wadehnwo\AppData\Local\Pandoc\pandoc RA.docx -f docx -t asciidoc --wrap=none --markdown-headings=atx --extract-media=extracted-media -o output.adoc

% == is sub folder level
% === is file level
% 

fid=fopen('index.adoc','r');
fid2=fopen('contents.txt','w');
ii=0;
fid3=fopen(['doc',num2str(ii),'.adoc'],'w');

while ~feof(fid);
    ilin=fgetl(fid);
    if length(ilin)>3
        if findstr(ilin(1:3),'== ');
            fprintf(fid2,'doc%d\n',ii);
            fclose(fid3);
            fid3=fopen(['doc',num2str(ii),'.adoc'],'w');
            fprintf(fid3,'%s\n\n',ilin(2:end));
            fprintf(fid3,'%s\n\n',ilin(1:end));
            ii=ii+1;
        else
            fprintf(fid3,'%s\n',ilin);
        end
    else
        fprintf(fid3,'%s\n',ilin);
    end
    
end

fclose(fid);
fclose(fid2);
fclose(fid3);