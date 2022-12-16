source rds-sg.sh
source pod-sg.sh


source rds-auth-rule.sh
source rds-sg.sh
source rds-create.sh

# In the AWS console, the RDS instance is publicly accessible, 
# but the Security Group rule RDS_SG only permits inbound access from POD_SG
# Temporarily allow public inbound access to setup the DB
aws ec2 authorize-security-group-ingress \
    --group-id ${RDS_SG} \
    --protocol tcp \
    --port 5432 \
    --cidr 0.0.0.0/0

<!-- $ psql postgresql://eksworkshop:${RDS_PASSWORD}@${RDS_ENDPOINT}:5432/eksworkshop -f sg-per-pod/psql.sql 
CREATE TABLE
INSERT 0 1
INSERT 0 1
INSERT 0 1 -->

# Once the DB has been setup, remove this rule immediately
aws ec2 revoke-security-group-ingress \
    --group-id ${RDS_SG} \
    --protocol tcp \
    --port 5432 \
    --cidr 0.0.0.0/0