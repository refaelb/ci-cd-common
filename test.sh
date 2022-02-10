pwd
ls -l
count=0
list=0
for a in "$search_dir"./*yaml; do   echo "$entry"
    echo $a
    helm template common ./common -f $a --output-dir ./$a-common
    if (($? == 0)) ;then echo "helm templated successfuly"; helm_count=$((helm_count+1)) ;else echo "helm template failed"; fi
    kubectl apply --dry-run=server -f ./$a-common/common/templates/deployment.yaml
    if (($? == 0)) ;then echo "k8s manifests successfully passed dry run deployment "; ks_count=$((ks_count+1)) ;else echo "k8s manifests failed during dry-run deployment"; fi
done
echo $ks_count
echo $helm_count
if [ "$ks_count" == "$helm_count" ] 
then 
    echo "good" 
    helm package ./common/
else  
    echo "you ave a err"
    (exit 1)
    echo hi
fi

