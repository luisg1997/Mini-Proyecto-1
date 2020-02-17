 a = arduino();
figure
h = animatedline;
ax = gca;
ax.YGrid = 'on';
ax.YLim = [-1 6];
t = 0;
dt = 0.01;
stop = false;
while ~stop
    % Leemos el valor actual
    v = readVoltage(a,'A1');    
    % Obtenemos el tiempo actual
    t =  t + dt;
    % a164adimos los puntos
    addpoints(h,t,v)
    % Actualizamos los ejes
    ax.XLim = datenum([t-seconds(20) t]);
    datetick('x','keeplimits')
    drawnow
end