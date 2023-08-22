import mne

import pandas

path = "/Users/anikait/Desktop/builds/EEG mat to julia/Data/raw_EM_RtrFixCnd_clean_opticat_ICA_FiltAvRefIntp.set"
raw = mne.io.read_raw_eeglab(path , preload=True)

data = raw.get_data()


df = raw.to_data_frame()

print(df)

row_numbers = readdlm("row_numbers.txt", Int)







# from pathlib import Path
# import matplotlib.pyplot as plt
# import mne
#
# # raw.plot(start=0)
#
# # extract events
# all_events, all_event_id = mne.events_from_annotations(raw)
#
# metadata_tmin, metadata_tmax = -0.2, 0.4
#
# # auto-create metadata
# # this also returns a new events array and an event_id dictionary. we'll see
# # later why this is important
# # metadata, events, event_id = mne.epochs.make_metadata(
# #     events=all_events,
# #     event_id=all_event_id,
# #     tmin=metadata_tmin,
# #     tmax=metadata_tmax,
# #     sfreq=raw.info["sfreq"],
# # )
#
# print("Events: ", all_events)
# print("Events id: ", all_event_id)
#
# print(metadata)

