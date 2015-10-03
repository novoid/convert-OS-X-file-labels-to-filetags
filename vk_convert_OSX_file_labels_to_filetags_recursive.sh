#!/bin/bash

startdir=`pwd` 

## Note: vk_convert_OSX_file_labels_to_filetags.sh has to be found in $PATH or do add its path

find . -maxdepth 10 -type d -print0 | \
    while IFS= read -rd '' dir; \
    do cd "$startdir/$dir"; \
       pwd ; \
       vk_convert_OSX_file_labels_to_filetags.sh * ;\
    done

cd "$startdir" 

#end
