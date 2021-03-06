#!/usr/bin/bash

# Declare variables
if [[ ! -z "$1" ]]; then
  VERSION=".${1}"
else
  VERSION=''
fi
DATE="$(date +"%Y%m")${VERSION}" # create date with version
CODEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd -P)/.."
BASEDIR="//tierra.cnic.es/SC/U_Proteomica/UNIDAD/iSanXoT_DBs"
OUTDIR="${BASEDIR}/${DATE}" # with date folder
WSDIR="${BASEDIR}/current_release"
LOGDIR="${CODEDIR}/logs/${DATE}"

TYPE_LIST=("pro-sw" "pro-sw-tr" "uni-sw" "uni-sw-tr")
SPECIES_LIST=(human mouse rat pig rabbit zebrafish ecoli)

# Function that executes the input command
run_cmd () {
  echo "-- $1"
  echo ""
  eval $1
}

# prepare workspaces
mkdir "${LOGDIR}"

# CREATE FASTA files --------

# for the following databases and species...
for TYPE in "${TYPE_LIST[@]}"
do
  for SPECIES in "${SPECIES_LIST[@]}"
  do
    # get local variables
    OUTNAME="${SPECIES}_${DATE}_${TYPE}"
    OUTFILE="${OUTDIR}/${OUTNAME}.fasta"
    LOGFILE="${LOGDIR}/create_fasta.${OUTNAME}.log"

    OUTFILE_dc="${OUTDIR}/${OUTNAME}.decoy.fasta"
    OUTFILE_tg="${OUTDIR}/${OUTNAME}.target.fasta"
    OUTFILE_dc_tg="${OUTDIR}/${OUTNAME}.target-decoy.fasta"
    LOGFILE_dc_tg="${LOGDIR}/decoyPYrat.${OUTNAME}.log"

    # execute commands
    CMD1="python '${CODEDIR}/src/create_fasta.py' -s ${SPECIES} -f ${TYPE} -o '${OUTFILE}' -vv  &> '${LOGFILE}' "
    CMD2="python '${CODEDIR}/src/decoyPYrat.v2.py' --output_fasta '${OUTFILE_dc}' --decoy_prefix=DECOY -t '${OUTFILE}.tmp' '${OUTFILE}' &> '${LOGFILE_dc_tg}' ; cat ${OUTFILE_tg} ${OUTFILE_dc} > ${OUTFILE_dc_tg} "
    run_cmd "${CMD1} ; ${CMD2}" &
  done
done


# CREATE SYSTEM BIOLOGY files --------

# for the following species...
for SPECIES in "${SPECIES_LIST[@]}"
do
  # get local variables
  OUTNAME="${SPECIES}_${DATE}"
  OUTFILE="${OUTDIR}/${OUTNAME}.categories.tsv"
  LOGFILE="${LOGDIR}/create_sb.${OUTNAME}.log"

  OUTFILE_cr="${OUTDIR}/${OUTNAME}.cat.tsv"
  LOGFILE_cr="${LOGDIR}/createRels.${OUTNAME}.log"

  # execute commands
  CMD1="python '${CODEDIR}/src/create_sb.py' -s ${SPECIES} -o '${OUTFILE}' -vv  &> '${LOGFILE}' "
  CMD2="python '${CODEDIR}/src/createRels.v0211.py' -vv  -ii '${OUTFILE}' -o '${OUTFILE_cr}' -i 'Comment_Line' -j 'cat_*' &> '${LOGFILE_cr}'"
  run_cmd "${CMD1} ; ${CMD2}" &
done
