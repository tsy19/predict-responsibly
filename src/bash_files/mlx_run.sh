
# for pc in 
# python src/run_model.py -d compas -n DP -pc 0.1 -fc 0.2 -pass -def -dm highacc

pc_vec=( $(python -c "import numpy as np; print(' '.join(map(str, np.arange(0.01, 0.37, 0.01))))") )
# pc_vec=( $(python -c "import numpy as np; print(' '.join(map(str, np.arange(0.1, 0.85, 0.8))))") )
# dataset="compas"
dataset="law"
CURRENTDATE=`date +"%m_%d_%Y"`
DM="highbias"
# Iterate through the list using a for loop

# rm /mnt/bn/confrank2/predict-responsibly/ad_hoc_logs/*
mkdir ./res_${dataset}
mkdir ./res_${dataset}/05_13_2023

rm -r ./res_${dataset}/05_13_2023/*

for pc in "${pc_vec[@]}"
do
    for fairnotion in "EO" "DP" "EOs" 
    do
        expname="${CURRENTDATE}_${dataset}_${fairnotion}_pc_${pc}_fc_0.2_${DM}"
        launch --cpu 24 --gpu 0 -- python src/run_model.py -d $dataset -n $expname -pc $pc -fc 0.2 -pass -def -dm $DM -dirs "./conf/dirs/${dataset}.json" -fn $fairnotion &>> "./ad_hoc_logs/${dataset}_${fairnotion}_$(date +"%Y_%m_%d_%I_%M_%p").log"
    done
    # Do something with pc here
    # For example:
    # python my_script.py --pc $pc
done