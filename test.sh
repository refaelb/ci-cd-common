echo Write your commands here
pwd
echo Hello world

ls -l

while read i; do echo "$p" ;  helm template common ./common -f $i-values.yaml --output-dir ./template/$i-common ; done <fitcher.txt