INSTANCE_IDS=`aws autoscaling describe-auto-scaling-instances --query 'AutoScalingInstances' | jq -r .[].InstanceId`

#echo "instances: " $INSTANCE_IDS

for instance in `echo $INSTANCE_IDS`; 
do
	aws ec2 describe-instances --instance-id $instance --query 'Reservations[*].Instances[*].NetworkInterfaces[*].PrivateIpAddress' | jq -r .[].[].[]
done
