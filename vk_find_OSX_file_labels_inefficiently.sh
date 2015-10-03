#!/bin/sh

## see id:2014-09-07-OSX-colour-labels-to-tags
echo
echo "This script traverses current folder and subfolders and logs files"
echo "that have OS X colour labels set to a log file."
echo

BASENAME=`basename "${0}"`
export FIND_COLOURS_LOGFILE="${HOME}/data/log/${BASENAME}.log"

echo "using FIND_COLOURS_LOGFILE: [${FIND_COLOURS_LOGFILE}]"
touch "${FIND_COLOURS_LOGFILE}" || echo "ERROR writing/creating FIND_COLOURS_LOGFILE"
echo "===================================================================" >> "${FIND_COLOURS_LOGFILE}"
echo "=== "`date` >> "${FIND_COLOURS_LOGFILE}"
echo "===================================================================" >> "${FIND_COLOURS_LOGFILE}"

handle_file()
{
    #echo "================ [${1}] ============================"
    label=`xattr -lp com.apple.FinderInfo "${1}" 2>/dev/null|grep "0000"|cut -d " " -f 13`
    #echo "label: ${label}"
    if [ ! -f "${1}" ]; then
        #echo "no regular file"
        return
    elif [ "x${label}" == "x" ]; then
        #echo "no label"
        return
    else
        #echo "label found in file ${1}"
        #echo "basename: "`basename "${1}"`
        #echo "dirname: "`dirname "${1}"`
        dirname "${1}" >> "${FIND_COLOURS_LOGFILE}"
    fi

}

export -f handle_file

find . -type f -exec bash -c 'handle_file "{}"' \;

echo "=== "`date` >> "${FIND_COLOURS_LOGFILE}"
echo "write to LOGFILE: [${FIND_COLOURS_LOGFILE}]"

#end
