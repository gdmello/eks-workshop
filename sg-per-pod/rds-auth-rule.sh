# # Cloud9 IP
# export C9_IP=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)

# # allow Cloud9 to connect to RDS
# aws ec2 authorize-security-group-ingress \
#     --group-id ${RDS_SG} \
#     --protocol tcp \
#     --port 5432 \
#     --cidr ${C9_IP}/32

# Allow POD_SG to connect to the RDS
aws ec2 authorize-security-group-ingress \
    --group-id ${RDS_SG} \
    --protocol tcp \
    --port 5432 \
    --source-group ${POD_SG}

