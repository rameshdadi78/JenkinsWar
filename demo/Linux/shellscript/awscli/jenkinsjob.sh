echo "you have selected all the inputs"
echo "Now Instance is getting created "
aws ec2 run-instances \
        --region $region \
        --instance-type $instance_type \
        --image-id $ami \
        --key-name $keypair \
        --security-group-ids $sg \
        --subnet-id $subnetid \
        --output $output
        
if ( echo $? == 0 )
then 
   echo "Instance has been created successfully"
else
   echo "Instance is not created"
   
fi   
        
