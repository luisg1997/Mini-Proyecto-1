 a = arduino();
figure
h = animatedline;
ax = gca;
ax.YGrid = 'on';
ax.YLim = [-1 6];

stop = false;
startTime = datetime('now');
while ~stop
    % Leemos el valor actual
    v = readVoltage(a,'A1');    
    % Obtenemos el tiempo actual
    t =  datetime('now') - startTime;
    % a164adimos los puntos
    addpoints(h,datenum(t),v)
    % Actualizamos los ejes
    ax.XLim = datenum([t-seconds(5) t]);
    datetick('x','keeplimits')
    drawnow
end