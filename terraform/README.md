The backend for terraform can be managed locally or on a server.
I've decided to implement S3 as the backend server that will store the state of resources.
The backend.tf file contains only a S3 bucket that will do just that.
I just ran a simple:
terraform init
terraform plan # To check the plan
terraform plan -out=tfplan # To check the plan and save the output to the file 'tfplan'
terraform apply # This will also show a plan before typing yes to apply
terraform apply tfplan # This will apply the plan defined in tfplan file

If you want to capture the output of something like the ARN of a resource, you must define your want for it in the outputs file.

The value is usually the:
resource module name + resource name given + whatever parameter you need like ARN

