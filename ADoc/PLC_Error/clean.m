Files = searchInSubfolders('.','.adoc');
fid=fopen('contents.txt','w');

 for ii=1:length(Files)
     ifile = fileread(Files{ii});
     c(ii)=length(strfind(ifile,10));
     if c(ii)>17
          fprintf(fid,'%s\n',Files{ii}(3:end-5));
     end
 end
 fclose(fid);
     plot(c)