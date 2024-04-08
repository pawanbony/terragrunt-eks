#provider "aws" {
#    access_key = "ASIAV7YAT5M55INZPVJF"
#    secret_key = "9doCwvO8HI6mUG47ZMa2YN/8lLP1O0u+fd0yotke"
#    token="IQoJb3JpZ2luX2VjENb//////////wEaCWV1LXdlc3QtMSJIMEYCIQCTw9o+s7ebsh6jQOHncGbV/VJjITbXur+NujsyMAYKTgIhANHPAN+ESoQJpDW3BQPRFLQXElnP2zEFl0SWFYY7Kd15Kp8DCN///////////wEQABoMNDExNzgxMjk0OTA3IgwGQ8AOFG2//Nu8sYAq8wIZHC+7wpGzwqLxeKo2mP3+mEqnIi6TNFnd7os8C6Fa1AJxw2cPxnCNJqeXYSkziqzyULqYLQrggRDpgLq5gCzyEEZYz/sPz4mWHKlI/z8EcNx0OIpaPdEDO4BUEo4EuRuy+vqyZBikaGd19RGTf6wHZhDs8yViE/yAgJsGQpy0LCRsXkuayD1H/nKF7bZqYv6t/0JCpU6lFv58y5o1jKf3JYZP4IwsrixYxJpfbaNrG3UoiLHADua13CzCe8cHO/PE8n9MIyXjlkg9hF7HWcgdlxDfKCib1o1s9do1Rr5RSHSWdAQlfqzcl+f+eyBC0kxsoFY3ucZuYT3VOJcapSTxBgREzi3L8SI0sp7tVG2DvMlLwd56X1tsU8J5b1swOa4gQz8KBaWuUkz6tbFLJbdGeUYDsNrZHO3z8H2aSbuBM1eTB5Hbrn6MRpDNYhhiYTHQN4WmRn57mckTbhk2shoSPfJUVKg6w53WUAcmzyJvHVaTGzD/rcuiBjqlATD1Fh4ovm/HXPHhh0dFjrobWcL5HXHJ//+69CxsheMkWhx1CmU91bCUPvzterqbjqb+UZSMYz+da8zGeE1VYy5v4aoEc64RCpBymhaoz15Hf4BeoMCw4tSSss7vXwhtW8XnjMkLrR6w9xggeVslOVLqYCcCXW20ctYM/UILt4BG2qEHtJvuKjI+mj5qanD1OWXWnuoiApyKYnvUBQMiusyTkHdy0Q=="
#    region = var.region
#}

resource "aws_instance" "ec2_instance" {
#    name = "Test"
    ami = "${var.ami_id}"
    count = "${var.number_of_instances}"
    subnet_id = "${var.subnet_id}"
    instance_type = "${var.instance_type}"
    key_name = "${var.ami_key_pair_name}"
    tags = {
    Name = var.instance_name
    }
    root_block_device {
     volume_size = var.volume_size # in GB <<----- I increased this!
     volume_type = "gp3"
     encrypted   = true
#     kms_key_id  = data.aws_kms_key.customer_master_key.arn
  }
} 