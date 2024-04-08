variable "instance_name" {
        description = "Name of the instance to be created"
        type = string
}

variable "instance_type" {
        default = "t3.large"
        type = string
}

variable "subnet_id" {
        description = "The VPC subnet the instance(s) will be created in"
        type = string
#        default = "subnet-0234e994abe911cc1"
}

variable "ami_id" {
        description = "The AMI to use"
        type = string
#        default = "ami-04adeb9ef364bcb6a"
}

variable "number_of_instances" {
        description = "number of instances to be created"
        default = 1
}

variable "ami_key_pair_name" {
        default = "FortiFW"
        type = string
}

variable "volume_size" {
        default = "80"
        type = string
}
variable "region" {
        default = "us-west-2"
        type = string
}