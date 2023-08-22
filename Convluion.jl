using StatsModels, MixedModels, DataFrames
import DSP.conv
using Unfold
using UnfoldMakie,CairoMakie
using DataFrames
using PyMNE

#loading data
pathtodata = "/Users/anikait/Desktop/builds/EEG mat to julia/Data/raw_EM_RtrFixCnd_clean_opticat_ICA_FiltAvRefIntp.set"
eeglabdata = PyMNE.io.read_raw_eeglab(pathtodata)
eeglabdata


#converting to dataframe
data = eeglabdata.get_data()
df = eeglabdata.to_data_frame()
print(df)


# deteling usless data
# Load row numbers from the text file
row_numbers = vec(readdlm("Data/5_winrej_Rtr.txt", Int))
# Convert the row numbers to 1-based indices
row_indices = row_numbers .+ 1
# Delete rows with the specified indices
delete!(df, row_indices)
println(df)







# all_events, all_event_id = PyMNE.events_from_annotations(eeglabdata)



# function convert_pandas(df_pd)
#       df= DataFrame()
#     for col in df_pd.columns
#         df[!, col] = getproperty(df_pd, col).values
#     end
#     return df
# end



# # metadata for each epoch shall include events from the range: [0.0, 1.5] s,
# # i.e. starting with stimulus onset and expanding beyond the end of the epoch
# metadata_tmin, metadata_tmax = -0.2, 0.4

# # auto-create metadata
# # this also returns a new events array and an event_id dictionary. we'll see
# # later why this is important
# metadata, events, event_id = PyMNE.epochs.make_metadata(
#     events=all_events,
#     event_id=all_event_id,
#     tmin=metadata_tmin,
#     tmax=metadata_tmax,
#     sfreq=eeglabdata.info["sfreq"],
# )

# # let's look at what we got!
# metadata


# metadata.head(5)


# include(joinpath(dirname(pathof(Unfold)), "../test/test_utilities.jl") )

# data, evts = loadtestdata("eeglab_current/eeglab2023.0/data.csv");
