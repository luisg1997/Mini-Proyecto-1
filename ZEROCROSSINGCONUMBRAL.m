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
contador = 0;
banderaneg = 0;
banderapos = 0;
banderaentre = 0;
banderaentre2 = 0;
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
    %CAMBIO DE NEGATIVO A POSITIVO
    if (b < 2) && (banderaentre == 1)
        banderaentre = 0;
        banderaneg =0;
    end
    if(b>2) && (b<4)
        banderaentre = 1;
    end
    if(banderaentre==1) && (b>4)
        banderaneg = 1;
        banderaentre = 0;
    end
    if(banderaneg ==1)
        contador = contador+1;
        banderaneg = 0;
    end
   
   %CAMBIO DE POSITIVO A NEGATIVO
    if (b > 4) && (banderaentre2 == 1)
        banderaentre2 = 0;
        banderapos =0;
    end
    if(b>2) && (b<4)
        banderaentre2 = 1;
    end
    if(banderaentre2==1) && (b<2)
        banderapos = 1;
        banderaentre2 = 0;
    end
    if(banderapos ==1)
        contador = contador+1;
        banderapos = 0;
    end
end