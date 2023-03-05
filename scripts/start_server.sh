#!/bin/bash
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/app/rust/RustDedicated_Data/Plugins/x86_64
/app/rust/RustDedicated \
    -batchmode \
    -load \
    -nographics