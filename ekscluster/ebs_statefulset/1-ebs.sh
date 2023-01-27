# Create an IAM OIDC provider for your cluster
eksctl utils associate-iam-oidc-provider \
  --region=${AWS_REGION} \
  --cluster=ekswork-eksctl \
  --approve

# Create a service account
eksctl create iamserviceaccount \
  --cluster ekswork-eksctl \
  --name ebs-csi-controller-irsa \
  --namespace kube-system \
  --attach-policy-arn ${EBS_CSI_POLICY_ARN} \
  --override-existing-serviceaccounts \
  --approve