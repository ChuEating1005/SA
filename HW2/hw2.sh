#!/bin/sh
# shellcheck disable=SC2046,SC3037,SC2086,SC2004,SC2027

helpFunction()
{
    echo "hw2.sh -i INPUT -o OUTPUT [-c csv|tsv] [-j]" >&2;
	echo "" >&2;
	echo "Available Options:" >&2;				        
	echo "" >&2;					    
   	echo "-i: Input file to be decoded" >&2;	       
	echo "-o: Output directory" >&2;	        
	echo "-c csv|tsv: Output files.[ct]sv" >&2;			        
	echo "-j: Output info.json" >&2;								        
	exit 2									
}
outputInfoJson=false
outputFileType=""
while getopts ':i:o:c:j' opt
do
	case "$opt" in
		i ) inputFile="$OPTARG";;
		o ) outputDir="$OPTARG";;
		c ) outputFileType="$OPTARG";;
		j ) outputInfoJson=true;;
		? ) helpFunction;;
	esac
done
if [ ${inputFile##*.} != "hw2" ] || [ -z "$inputFile" ] || [ -z "$outputDir" ] ; then
	helpFunction
fi

if [ "${outputFileType}" = "csv" ] ; then
	del=','
fi

if [ "${outputFileType}" = "tsv" ] ; then
	del='\t'
fi

mkdir -p "${outputDir}"

invaildCnt=0

name=$(yq -r .name ${inputFile})
author=$(yq -r .author ${inputFile})
date=$(date -j -f "%s" $(yq .date ${inputFile}) "+%Y-%m-%dT%H:%M:%S")+"08:00"

if "$outputInfoJson"; then
	{
		echo  '{'
		echo -e "\t\"name\": \"${name}\","
		echo -e "\t\"author\": \"${author}\","
		echo -e "\t\"date\": \"${date}\""
		echo  '}'
	} >> "${outputDir}"/info.json
fi

if [ "${outputFileType}" = "csv" ] || [ "${outputFileType}" = "tsv" ]; then
	echo -e "filename${del}size${del}md5${del}sha1" >> "${outputDir}"/files."${outputFileType}"
fi

fileCount=$(grep -c -e '- name:' "${inputFile}")
fileCount_1=$(( $fileCount - 1 ))
for idx in $(seq 0 "${fileCount_1}"); do
	dataName="$(yq -r .files[${idx}].name "${inputFile}")"
	dataType="$(yq -r .files[${idx}].type "${inputFile}")"
	data="$(yq -r .files[${idx}].data "${inputFile}" | base64 -d )"
	size=${#data}
	size=$(( $size + 1))
	mkdir -p "${outputDir}"/"${dataName}"
	rmdir "${outputDir}"/"${dataName}"
	echo "${data}" >> "${outputDir}"/"${dataName}"
	md5="$(yq -r ".files["${idx}"].hash.md5" "${inputFile}")"	
	sha1="$(yq -r ".files["${idx}"].hash.\"sha-1\"" "${inputFile}")"

	tmd5="$(md5sum -q "${outputDir}"/"${dataName}")"
	tsha1="$(sha1sum -q "${outputDir}"/"${dataName}")"

	echo ${size}

	if [ "${outputFileType}" = "csv" ] || [ "${outputFileType}" = "tsv" ]; then
		echo -e "${dataName}${del}${size}${del}${md5}${del}${sha1}" >> "${outputDir}"/files."${outputFileType}"
	fi

	if [ "${md5}" != "${tmd5}" ] || [ "${sha1}" != "${tsha1}" ]; then
		invaildCnt=$(( $invaildCnt + 1 ))
	fi

	if [ "${dataType}" = "hw2" ]; then
		~/hw2.sh -i "${outputDir}"/"${dataName}" -o "${outputDir}"
	fi
done

exit $invaildCnt
