The backend for terraform can be managed locally or on a server.<br/>
I've decided to implement S3 as the backend server that will store the state of resources.<br/>
The ```backend.tf``` file contains only a S3 bucket that will do just that.<br/>
I ran:<br/>

```bash
terraform init
# To check the plan
terraform plan 
#To check the plan and save the output to the file 'tfplan'
terraform plan -out=tfplan
#This will also show a plan before typing yes to apply
terraform apply
# This will apply the plan defined in tfplan file
terraform apply tfplan
```

If you want to capture the output of something like the ARN of a resource, you must define your want for it in the outputs file.<br/>

The value is usually the:<br/>
resource module name + resource name given + whatever parameter you need like ARN<br/>

