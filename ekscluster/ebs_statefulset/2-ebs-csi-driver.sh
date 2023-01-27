# add the aws-ebs-csi-driver as a helm repo
helm repo add aws-ebs-csi-driver https://kubernetes-sigs.github.io/aws-ebs-csi-driver

# search for the driver
helm search  repo aws-ebs-csi-driver

helm upgrade --install aws-ebs-csi-driver \
  --version=2.16.0 \
  --namespace kube-system \
  --set controller.serviceAccount.create=false \
  --set enableVolumeScheduling=true \
  --set enableVolumeResizing=true \
  --set enableVolumeSnapshot=true \
  --set controller.serviceAccount.name=ebs-csi-controller-irsa \
  aws-ebs-csi-driver/aws-ebs-csi-driver

  kubectl -n kube-system rollout status deployment ebs-csi-controller