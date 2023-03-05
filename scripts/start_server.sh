#!/bin/bash
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/steamcmd/rust/RustDedicated_Data/Plugins/x86_64
/app/rust/RustDedicated \
    -batchmode \
    -load \
    -nographics