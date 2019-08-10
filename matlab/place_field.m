function place_field 

dataDir = uigetdir();

load(fullfile(dataDir,DataFiles,AJF016,CD3,AJF016CD3SpksEvs.mat))

x1 = unitdata.rawLEDs(:,2);
y1 = unitdata.rawLEDs(:,3);
x2 = unitdata.rawLEDs(:,4);
y2 = unitdata.rawLEDs(:,5);

led_ts=unitdata.rawLEDs(:,1);

% Match time stamps of the ephys. 
eventsTimestamps=load_ephys(); 

eventsTimestamps.all_ts(1:10)

spike_ts = unitdata.units(1).ts;


spike_ts(1:10)
led_ts(1:10)

spkx = interp1(led_ts,[x1 y1],spike_ts,'nearest');

% norm by occupancy
% 




for ispike=1:spike_ts
if spike_ts(ispike)<led_ts (spike_ts(ispike)<X) && (X<1)
    
end
end 

plot(x1,y1)

plot(unitdata.units(1).ts)
