clc
global a ;
if ~isempty(instrfind)
fclose(instrfind);
delete(instrfind);
end
a = arduino();
interval = 100;
init_time = 1;
x = 0;
while(init_time <interval)
    b = readVoltage(a, 'A1');
    x = [x,b];
    plot(x);
    grid ON
    init_time = init_time + 0.5 ;
   % if init_time == 100
    %    init_time = 0;
    %    x = [0,b];
   % end 
    drawnow;
end