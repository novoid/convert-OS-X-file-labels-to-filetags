#!/bin/sh

## see id:2014-09-07-OSX-colour-labels-to-tags
echo
echo "This file searches for files within filelist as command line parameter"
echo "and extracts OS X file labels and adds them as filetags"
echo

FILETAGS_PARAM="-s"
FILETAGS_PARAM=""

handle_file()
{
    echo "================ [${1}] ============================"
    label=`xattr -lp com.apple.FinderInfo "${1}" 2>/dev/null|grep "0000"|cut -d " " -f 13`
    #echo "label: ${label}"
    if [ ! -f "${1}" ]; then
            echo "no regular file" 
        return
    elif [ "x${label}" == "x" ]; then
        echo "no label" 
        return
    elif [ "${label}" == "02" ]; then
        echo "gray!"
        filetags -t "label-gray" ${FILETAGS_PARAM} "${1}"
    elif [ "${label}" == "04" ]; then
        echo "green!"
        filetags -t "label-green" ${FILETAGS_PARAM} "${1}"
    elif [ "${label}" == "0C" ]; then
        echo "red!"
        filetags -t "label-red" ${FILETAGS_PARAM} "${1}"
    elif [ "${label}" == "0A" ]; then
        echo "yellow!"
        filetags -t "label-yellow" ${FILETAGS_PARAM} "${1}"
    elif [ "${label}" == "0E" ]; then
        echo "orange!"
        filetags -t "label-orange" ${FILETAGS_PARAM} "${1}"
    elif [ "${label}" == "08" ]; then
        echo "blue!"
        filetags -t "label-blue" ${FILETAGS_PARAM} "${1}"
    elif [ "${label}" == "06" ]; then
        echo "purple!"
        filetags -t "label-purple" ${FILETAGS_PARAM} "${1}"
    else
            echo "ERROR unrecognized colour [${label}] for file [${1}]"
    fi
}

#find ./converting\ files -exec handle_file "{}" \;
for file in "${@}"; do
    handle_file "${file}"
done


#end
