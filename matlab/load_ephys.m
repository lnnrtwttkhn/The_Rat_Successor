
function eventsTimestamps=load_ephys(~) 
% load and order data in timestamps.
% MIND summer school 2019.

load('AJF016/CD3/AJF016CD3SpksEvs.mat')


% cell array for events and timestamps.

events=cell(1,length(cinedata(1).events));
timestamps=cell(1,length(cinedata(1).events));

all_ts=[];
all_events = {};

for ievent = 2:length(cinedata(1).events)
events{ievent} = cinedata(1).events{ievent}.name;
timestamps{ievent} = cinedata(1).events{ievent}.timestamps;

all_ts = [all_ts;timestamps{ievent}];

multiEvent = repmat({cinedata(1).events{ievent}.name},[1 length(timestamps{ievent})]);

all_events = [all_events,multiEvent];

end 

[all_ts,indx]=sort(all_ts);
all_events= all_events(indx);


eventsTimestamps = table(all_events',all_ts);














