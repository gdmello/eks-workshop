export ACCOUNT_ID=$(aws sts get-caller-identity --output text --query Account)
export AWS_REGION=us-east-1
export AZS=($(aws ec2 describe-availability-zones --query 'AvailabilityZones[].ZoneName' --output text --region $AWS_REGION))
export MASTER_ARN=$(aws kms describe-key --key-id alias/ekswork --query KeyMetadata.Arn --output text)
export CLUSTER_NAME=ekswork-eksctl

arraylength=${#AZS[@]}
for (( i=0; i<${arraylength}; i++ ));
do
  export AZS_$i=${AZS[$i]}
done

echo "export MASTER_ARN=${MASTER_ARN}" | tee -a ~/.bash_profile
test -n "$AWS_REGION" && echo AWS_REGION is "$AWS_REGION" || echo AWS_REGION is not set

envsubst < eksworks.yaml > eksworks-1.yaml

eksctl create cluster -f eksworks-1.yaml

# Create kubeconfig file
touch ~/.kube/eks-works.yaml
aws eks update-kubeconfig  --name ${CLUSTER_NAME} --region $AWS_REGION --kubeconfig eks-works
export KUBE_CONFIG=~/.kube/eks-works.yaml

# Export Worker Role Name
STACK_NAME=$(eksctl get nodegroup --cluster ${CLUSTER_NAME} -o json | jq -r '.[].StackName')
ROLE_NAME=$(aws cloudformation describe-stack-resources --stack-name $STACK_NAME | jq -r '.StackResources[] | select(.ResourceType=="AWS::IAM::Role") | .PhysicalResourceId')
echo "export ROLE_NAME=${ROLE_NAME}" | tee -a ~/.bash_profile