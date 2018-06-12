#!/bin/bash
set -e

# exitstatus=0
#
# for file in *.Rmd
# do
#     Rscript -e "lintr::lint(\"$file\")"
#     outputbytes=`Rscript -e "lintr::lint(\"$file\")" | grep ^ | wc -c`
#     if [ $outputbytes -gt 0 ]
#     then
#         exitstatus=1
#     fi
# done
#
# exit $exitstatus

# do it all in one line
outputbytes=`find src -iname '*.R' -exec Rscript -e 'lintr::lint(filename="{}", linters=lintr:::read_settings(".lintr"))' \;`
if [ $outputbytes -gt 0 ]
then
    exit 1
else
    exit 0
fi
