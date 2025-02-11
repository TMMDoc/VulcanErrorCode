fid=fopen('indx.txt','r');
fid2=fopen('indx2.txt','w');
ii=1;
while ~feof(fid);
    fprintf(fid2,'xref:.//img/Schematics-%d.pdf[%s]\n\n',ii+1,fgetl(fid));
    ii=ii+1;
end
fclose(fid); fclose(fid2); 