function varargout = loadWrapper(varargin)

p = inputParser;
p.addParameter('dataType', 'behavior');
p.addParameter('animal', 'AJF016');
p.addParameter('session', 'CD1');
p.addParameter('root', nan);
p.parse(varargin{:});


switch p.Results.dataType
    case 'behavior'

        load([p.Results.root p.Results.animal '/' p.Results.session '/' p.Results.animal p.Results.session 'SpksEvs.mat'])


        % cell array for events and timestamps.

        events=cell(1,length(cinedata(1).events));
        timestamps=cell(1,length(cinedata(1).events));

        %eventsTimestamps = table();
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
        varargout{1} = eventsTimestamps;
        
    case 'ephys'
        varargout{1} = nan;
   
    
end



