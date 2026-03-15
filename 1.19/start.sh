#!/bin/bash
if [[ -v VERBOSE ]]; then
    echo "Starting kubectl container in verbose mode."
    echo Your container args are: "$@"
    echo "------------------------------------------"
fi

if [[ -v KUBECONFIG_BASE64 ]]; then
    if [[ -v VERBOSE ]]; then
        echo "\$KUBECONFIG_BASE64 is NOT empty"
        echo "Writing content into ${KUBECONFIG:-/root/.kube/config}"
        echo "########## DECODED KUBECONFIG ##########"
        echo $KUBECONFIG_BASE64 | base64 -d
        echo "########## END OF DECODED KUBECONFIG ##########"
    fi
    echo $KUBECONFIG_BASE64 | base64 -d >> ${KUBECONFIG:-/root/.kube/config}
else
    if [[ -v VERBOSE ]]; then
        echo "\$KUBECONFIG_BASE64 is empty"
    fi
fi

# AWS EKS Support
if [[ -v AWS_ACCESS_KEY_ID ]]; then
    if [[ -v VERBOSE ]]; then
        echo "Configuring AWS credentials"
    fi
    aws configure set aws_access_key_id "$AWS_ACCESS_KEY_ID"
    aws configure set aws_secret_access_key "$AWS_SECRET_ACCESS_KEY"
    aws configure set region "$AWS_REGION"
fi

if [[ "$@" == '' ]]; then
    kubectl --help
else
    if [[ "$1" == 'bash' || "$1" == 'sh' ]]; then
        "$@"
    else
        kubectl "$@"
    fi
fi
