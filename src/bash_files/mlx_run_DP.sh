
# for pc in 
# python src/run_model.py -d compas -n DP -pc 0.1 -fc 0.2 -pass -def -dm highacc

# pc_vec=( $(python -c "import numpy as np; print(' '.join(map(str, np.arange(0.02, 0.37, 0.02))))") )
pc_vec=( $(python -c "import numpy as np; print(' '.join(map(str, np.arange(0.1, 0.95, 0.8))))") )
dataset="compas"
CURRENTDATE=`date +"%m_%d_%Y"`
# Iterate through the list using a for loop
for pc in "${pc_vec[@]}"
do
    for fairnotion in "DP" "EO" "EOs"
    do
        expname="${CURRENTDATE}_${dataset}_${fairnotion}_pc_${pc}_fc_0.2_highacc"
        launch --cpu 24 --gpu 0 -- python src/run_model.py -d $dataset -n $expname -pc $pc -fc 0.2 -pass -def -dm highacc -fn $fairnotion &>> "./ad_hoc_logs/${fairnotion}_$(date +"%Y_%m_%d_%I_%M_%p").log"
    done
    # Do something with pc here
    # For example:
    # python my_script.py --pc $pc
done