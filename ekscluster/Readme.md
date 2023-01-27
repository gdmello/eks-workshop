# EKS Learning
Based on [EKS workshop](https://www.eksworkshop.com/beginner/).

## Setup AWS cli 

Ensure that the aws cli is [configured](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html) with the account access key ID and secret access key.

    $ aws --version
    aws-cli/2.9.4 Python/3.9.11 Linux/5.14.0-1042-oem exe/x86_64.ubuntu.22 prompt/off

## Create a Key

    ./key.sh

## Setup the Cluster 

    ./setup-cluster.sh
    
   this will take around 15 minutes to spin up the cluster.    

    2022-12-02 14:13:15 [!]  SSM is now enabled by default; `ssh.enableSSM` is deprecated and will be removed in a future release
    2022-12-02 14:13:16 [ℹ]  eksctl version 0.121.0
    2022-12-02 14:13:16 [ℹ]  using region us-east-1
    2022-12-02 14:13:17 [ℹ]  subnets for us-east-1a - public:192.168.0.0/19 private:192.168.96.0/19
    2022-12-02 14:13:17 [ℹ]  subnets for us-east-1b - public:192.168.32.0/19 private:192.168.128.0/19
    2022-12-02 14:13:17 [ℹ]  subnets for us-east-1c - public:192.168.64.0/19 private:192.168.160.0/19
    2022-12-02 14:13:17 [ℹ]  nodegroup "nodegroup" will use "" [AmazonLinux2/1.21]
    ...
    2022-12-02 14:28:32 [ℹ]  nodegroup "nodegroup" has 3 node(s)
    2022-12-02 14:28:32 [ℹ]  node "ip-192-168-4-220.ec2.internal" is ready
    2022-12-02 14:28:32 [ℹ]  node "ip-192-168-55-8.ec2.internal" is ready
    2022-12-02 14:28:32 [ℹ]  node "ip-192-168-83-82.ec2.internal" is ready
    2022-12-02 14:28:33 [ℹ]  kubectl command should work with "/home/gavin.dmello/.kube/rke-config-bee.yaml", try 'kubectl --kubeconfig=/home/gavin.dmello/.kube/rke-config-bee.yaml get nodes'
    2022-12-02 14:28:33 [✔]  EKS cluster "ekswork-eksctl" in "us-east-1" region is ready


    $ KUBECONFIG=~/.kube/eks-wrk-shop.yaml kubectl get nodes
    NAME                            STATUS   ROLES    AGE   VERSION
    ip-192-168-4-220.ec2.internal   Ready    <none>   18m   v1.21.14-eks-fb459a0
    ip-192-168-55-8.ec2.internal    Ready    <none>   18m   v1.21.14-eks-fb459a0
    ip-192-168-83-82.ec2.internal   Ready    <none>   18m   v1.21.14-eks-fb459a0

## Decode Authorization Messages
Decode any encoded messages with [this](https://docs.aws.amazon.com/cli/latest/reference/sts/decode-authorization-message.html) cli command-

    aws sts decode-authorization-message --encoded-message <ENCODED_MESSAGE>

