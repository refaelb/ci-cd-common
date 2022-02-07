pwd
ls -l
count=0
list=0
for a in "$search_dir"./*yaml; do   echo "$entry"
    echo $a
    helm template common ./common -f $a --output-dir ./$a-common 
    kubectl apply --dry-run=server -f ./$a-common/common/templates/deployment.yaml
    if (($? == 0)) ;then echo "work"; count=$((count+1)) ;else echo "bad"; fi
    list=$((list+1))
done
if [ "$count" == "$list" ] 
then 
    echo "good" 
    helm package ./common/
else  
    echo "you ave a err"
fi