output network_interface {
    value = aws_instance.ec2_instance[0].primary_network_interface_id
}