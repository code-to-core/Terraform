terraform {
    required_version = "> 0.11.0"
}

provider "aws" {
    region     = "${var.region}"
    version = "~> 1.6"
}


# Define the security Group
data "aws_security_group" "selected" {
    name = "default"
}


# Define the instance

resource "aws_instance" "ubuntu_instance" {
    # TODO, get the ami by selecting the lastest Ubuntu build
    ami             = "ami-bcdc16c6"

    # TODO, parameterize the instance type
    instance_type   = "t2.micro"

    key_name        = "${var.key_name}"

    provisioner "local-exec" {
        command = "echo ${aws_instance.ubuntu_instance.public_dns} > dns.txt"
    }

    # TODO, create a module with parameters for creating Chef managed instance
    provisioner "chef" {
        # TODO parameterize with a role
        run_list    = [ "chef-client::delete_validation" ]

        # TODO parameterize
        node_name   = "serious-callers-only"

        # TODO parameterize
        server_url  = "https://api.chef.io/organizations/codetocore"

        recreate_client = true

        user_name   = "pw1326"
        user_key    = "${file("~/chef/.chef/pw1326.pem")}"
        connection {
            type    =   "ssh"
            # TODO, combine with the resolution of the ami 
            user    =   "ubuntu"

            private_key = "${file("~/.aws/aws.pem")}"
            agent   =   "false"
        }
    }
}

# Should really create a new security group with appropriate permission
resource "aws_security_group_rule" "allow_ssh" {
    type            = "ingress"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = "${data.aws_security_group.selected.id}"
}

resource "aws_security_group_rule" "allow_http" {
    type            = "ingress"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = "${data.aws_security_group.selected.id}"
}
