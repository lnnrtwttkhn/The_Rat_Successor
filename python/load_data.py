import scipy.io
import path
import pandas as pd

def load_events(animal="AJF016", trial="CD3", basefolder="The_Rat_Successor"):
    '''
    Function for loading the events into a pandas DataFrame.
    
    Example usage (filter out the frame marker events):
    >>> events = load_events()
    >>> events.query("event_type != 'Frame Marker'")
    '''
    #Using the path library makes this works on both Windows and
    #mac / linux
    data_path = path.Path(basefolder) / "DataFiles"
    data_path /= animal
    data_path /= trial
    data_path /= (animal+trial+"SpksEvs.mat")
    data = scipy.io.loadmat(data_path)
    all_dfs = []
    for event_type in data["cinedata"][0]["events"][0]:
        event_object = event_type[0][0,0]
        event_name = event_object[0][0]
        event_timestamps = event_object[2]
        df = pd.Series(event_timestamps.flatten(), name="timestamp").to_frame()
        df["event_type"] = event_name
        all_dfs.append(df)
    return pd.concat(all_dfs).sort_values("timestamp") 