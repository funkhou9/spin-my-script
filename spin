echo '#!/bin/bash -login' > base.sh
echo '#PBS -l nodes=1:ppn=1:'$2',walltime='$3',mem='$4'Gb' >> base.sh
echo '#PBS -N' `echo $1 | cut -f1 -d.` >> base.sh
echo '#PBS -j oe' >> base.sh
echo '#PBS -m abe' >> base.sh
echo '#PBS -o '`echo $1 | cut -f1 -d.`'_literate/'`echo $1 | cut -f1 -d.`'.out' >> base.sh

echo 'cd '`pwd` >> base.sh

echo 'knitr_spin.R' $1 >> base.sh

echo 'if [ -d '`echo $1 | cut -f1 -d.`'_literate/ ]' >> base.sh
echo '  then' >> base.sh
echo '	  rm -rf' `echo $1 | cut -f1 -d.`'_literate/' >> base.sh
echo 'fi' >> base.sh

echo 'mkdir' `echo $1 | cut -f1 -d.`'_literate/' >> base.sh

echo 'if [ -d figure/ ]' >> base.sh
echo '  then' >> base.sh
echo '	  mv figure/ '`echo $1 | cut -f1 -d.`'_literate/' >> base.sh
echo 'fi' >> base.sh

echo 'mv '`echo $1 | cut -f1 -d.`'.md' `echo $1 | cut -f1 -d.`'_literate/' >> base.sh

echo 'rm '`echo $1 | cut -f1 -d.`'.html' >> base.sh

echo 'qstat -f ${PBS_JOBID}' >> base.sh

qsub base.sh

rm base.sh