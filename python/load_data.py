import scipy.io
import path
import pandas as pd

def get_mat_file(animal="AJF016", trial="CD3", basefolder="The_Rat_Successor"):
    #Using the path library makes this works on both Windows and
    #mac / linux
    data_path = path.Path(basefolder) / "DataFiles"
    data_path /= animal
    data_path /= trial
    data_path /= (animal+trial+"SpksEvs.mat")
    return scipy.io.loadmat(data_path)

def load_events(matfile=get_mat_file()):
    '''
    Function for loading the events into a pandas DataFrame.
    
    Example usage (filter out the frame marker events):
    >>> events = load_events()
    >>> events.query("event_type != 'Frame Marker'")
    '''
    all_dfs = []
    for event_type in matfile["cinedata"][0]["events"][0]:
        event_object = event_type[0][0,0]
        event_name = event_object[0][0]
        event_timestamps = event_object[2]
        df = pd.Series(event_timestamps.flatten(), name="timestamp").to_frame()
        df["event_type"] = event_name
        all_dfs.append(df)
    return pd.concat(all_dfs).sort_values("timestamp") 

def load_spike_data(matfile=get_mat_file()):
    unit_ts=matfile["unitdata"][0]["units"][0]["ts"]
    num_neurons = unit_ts.shape[1]
    all_dfs = []
    for i in range(num_neurons):
        spike_times = unit_ts[0, i]
        df = pd.Series(spike_times.flatten(), name="spike_time").to_frame()
        df["neuron"] = i
        all_dfs.append(df)
    return pd.concat(all_dfs)

def load_position(matfile=get_mat_file()):
    position=matfile["unitdata"]["rawLEDs"][0,0]
    cols = ["timestamp", "x1", "y1", "x2", "y2"]
    return pd.DataFrame(position, columns=cols).set_index("timestamp")
