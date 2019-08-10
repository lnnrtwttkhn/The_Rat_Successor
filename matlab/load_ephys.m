
function load_ephys 
% load and order data in timestamps.
% MIND summer school 2019.

load('/Users/Christoffer/Dropbox/PhD/Projects/the_rat_successor/The_Rat_Successor/DataFiles/AJF016/CD1/AJF016CD1SpksEvs.mat')


% cell array for events and timestamps.

events=cell(1,length(cinedata(1).events));
timestamps=cell(1,length(cinedata(1).events));

eventsTimestamps = table()
all_ts=[];
all_events = {};

for ievent = 2:length(cinedata(1).events)
events{ievent} = cinedata(1).events{ievent}.name;
timestamps{ievent} = cinedata(1).events{ievent}.timestamps;

all_ts = [all_ts;timestamps{ievent}];

multiEvent = repmat({cinedata(1).events{ievent}.name},[1 length(timestamps{ievent})]);

all_events = [all_events,multiEvent];

end 



eventsTimestamps = table(all_events',all_ts);

[a,b]=sort(all_ts);

all_events= all_events(b)'; 

eventsTimestamps = table(all_events',all_ts);





