# convert faulty GE 7T dicoms

#singularity pull docker://nipy/heudiconv:unstable
#singularity shell --bind /data:/data /data/backed_up/shared/ThalHi_MRI/Raw/heudiconv-unstable.simg

# mkdir /data/backed_up/shared/MRRF_Seq_Test/20190709_7T/
# mkdir /data/backed_up/shared/MRRF_Seq_Test/20190709_7T/1
# cd /data/backed_up/shared/ThalHi_MRI/Raw/20190709/20190709a/SCANS/300/DICOM
# for f in $(ls *.dcm); do
# 	dcmconv $f /data/backed_up/shared/MRRF_Seq_Test/20190709_7T/1/$f
# done

# mkdir /data/backed_up/shared/MRRF_Seq_Test/20190709_7T/2
# cd /data/backed_up/shared/ThalHi_MRI/Raw/20190709/20190709mb/SCANS/500/DICOM/
# for f in $(ls *.dcm); do
# 	dcmconv $f /data/backed_up/shared/MRRF_Seq_Test/20190709_7T/2/$f
# done

# mkdir /data/backed_up/shared/MRRF_Seq_Test/20190709_7T/3
# cd /data/backed_up/shared/ThalHi_MRI/Raw/20190709/20190709mbrun2/SCANS/600/DICOM/
# for f in $(ls *.dcm); do
# 	dcmconv $f /data/backed_up/shared/MRRF_Seq_Test/20190709_7T/3/$f
# done

# mkdir /data/backed_up/shared/MRRF_Seq_Test/20190709_7T/4
# cd /data/backed_up/shared/ThalHi_MRI/Raw/20190709/20190709mbrun3/SCANS/700/DICOM/
# for f in $(ls *.dcm); do
# 	dcmconv $f /data/backed_up/shared/MRRF_Seq_Test/20190709_7T/4/$f
# done

# mkdir /data/backed_up/shared/MRRF_Seq_Test/20190709_7T/5
# cd /data/backed_up/shared/ThalHi_MRI/Raw/20190709/20190709mbrun4/SCANS/800/DICOM/
# for f in $(ls *.dcm); do
# 	dcmconv $f /data/backed_up/shared/MRRF_Seq_Test/20190709_7T/5/$f
# done



## Heudiconv # failed
heudiconv -d /data/backed_up/shared/MRRF_Seq_Test/{subject}/*/*dcm -s 20190709_7T -b -c none -o /data/backed_up/shared/MRRF_Seq_Test/BIDS/ -f /home/kahwang/bin/heudiconv/heudiconv/heuristics/convertall.py


## MRIQC
singularity exec -B /data/:/data /opt/mriqc/mriqc.simg mriqc \
/data/backed_up/shared/MRRF_Seq_Test/BIDS/ \
/data/backed_up/shared/MRRF_Seq_Test/MRIQC/ \
participant --participant_label 7T --n_procs 4 --ants-nthreads 4 -w ﻿/data/not_backed_up/shared/tmp


##fmriprep
http_proxy=http://proxy.divms.uiowa.edu:8888
https_proxy=http://proxy.divms.uiowa.edu:8888
singularity run --cleanenv -B /data:/data /opt/fmriprep/fmriprep.simg \
/data/backed_up/shared/MRRF_Seq_Test/BIDS/ \
/data/backed_up/shared/MRRF_Seq_Test/fMRIprep participant \
--skip_bids_validation --ignore slicetiming --participant_label 7T --nthreads 6 --omp-nthreads 6 -w ﻿/data/not_backed_up/shared/tmp

