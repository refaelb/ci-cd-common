pwd
ls -l
count=0
while read i
do 
    echo "$p" 
    helm template common ./common -f $i-values.yaml --output-dir ./$i-common 
    kubectl apply --dry-run=server -f ./$i-common/common/templates/deployment.yaml 
    if (($? == 0)) ;then echo "work"; count=$((count+1)) ;else echo "bad"; fi
done <fitcher.txt
len=`wc -l < fitcher.txt`
if [ "$count" == "$len" ] 
then 
    echo "good" 
    helm package ./common/
else  
    echo "nott"
fi