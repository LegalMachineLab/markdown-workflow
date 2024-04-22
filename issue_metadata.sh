ROOT="$(realpath $(dirname $0))"
workingDir="$PWD"

if ! [ -f "$workingDir/issue.yaml" ]; then
echo "missing file in $workingDir/issue.yaml"
echo "insert year, volume, issue, separated by a blank space (e.g., 2024 1 2)"
read year volume issue
echo "
---
# Issue Level Customizations
volume: \"$volume\"
issue: \"$issue\"
year: \"$year\"
#issuetitle: # placeholder
#issuedescription: # placeholder
issuedisplay: \"Vol. $volume n. $issue ($year)\" # how you are going to show in PDF & HTML the issue reference
---
" > "$workingDir/issue.yaml"
else
echo "Reading issue metadata from file"
volume=$(grep volume "$workingDir/issue.yaml" | cut -d'"' -f2)
issue=$(grep issue: "$workingDir/issue.yaml" | cut -d'"' -f2)
year=$(grep year "$workingDir/issue.yaml" | cut -d'"' -f2)
echo "Volume data: Vol. $volume n. $issue ($year)."
echo ""
echo "Is the information correct? [Yn]"
read yn
case $yn in 
	[yY] ) echo ok, we will proceed;
		;;
	[nN] ) echo exiting...;
		exit;;
	* ) echo invalid response;;
esac
fi