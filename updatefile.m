function void = updatefile(filename, filename_copy)
fid = fopen(filename);
fgetl(fid);
fgetl(fid);
fgetl(fid);
fgetl(fid);
fgetl(fid);
fgetl(fid);
fgetl(fid);
fgetl(fid);
fgetl(fid);
fgetl(fid);
fgetl(fid);
fgetl(fid);
buffer = fread(fid, Inf) ;                    % Read rest of the file.
fclose(fid);
fid = fopen(filename_copy, 'w')  ;   % Open destination file.
fwrite(fid, buffer) ;                         % Save to file.
fclose(fid) ;