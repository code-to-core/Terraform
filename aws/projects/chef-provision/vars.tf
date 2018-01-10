# Define the variables here, provide any values in the terraform.tfvars
# file. Anything  with no default will be prompted for when 
# terraform runs

variable "region" {
    description = "The region on which this terraform will (e.g. us-east-1)."
    default = "us-east-1"
}


variable "key_name" {
    description = "The name of the Key Pair that can be used to SSh to each EC2 instance"
    default = ""
}
