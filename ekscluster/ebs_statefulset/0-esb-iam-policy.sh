export EBS_CSI_POLICY_NAME="Amazon_EBS_CSI_Driver"
export AWS_REGION="us-east-1"

[ -d "$(pwd)/ebs_statefulset" ] || mkdir $(pwd)/ebs_statefulset
cd $(pwd)/ebs_statefulset

# download the IAM policy document
curl -sSL -o ebs-csi-policy.json https://raw.githubusercontent.com/kubernetes-sigs/aws-ebs-csi-driver/master/docs/example-iam-policy.json

# Create the IAM policy
aws iam create-policy \
  --region ${AWS_REGION} \
  --policy-name ${EBS_CSI_POLICY_NAME} \
  --policy-document file://$(pwd)/ebs-csi-policy.json

# export the policy ARN as a variable
export EBS_CSI_POLICY_ARN=$(aws --region ${AWS_REGION} iam list-policies --query 'Policies[?PolicyName==`'$EBS_CSI_POLICY_NAME'`].Arn' --output text)