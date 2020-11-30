resource "aws_security_group" "netpalm" {
    name = "netpalm"
    description = "Security group for netpalm"
    vpc_id = aws_vpc.this.id

    ingress {
        description = "SSH from Everywhere"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "icmp from Everywhere"
        from_port = -1
        to_port = -1
        protocol = "icmp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

data "aws_ami" "netpalm" {
    most_recent = true

    filter {
        name = "tag:Name"
        values = [
            "netpalm-public"
        ]
    }
    filter {
        name = "virtualization-type"
        values = [
            "hvm"
        ]
    }

    owners = ["100784628684"]
}

resource "aws_instance" "netpalm" {
    ami = data.aws_ami.netpalm.id
    instance_type = "t3.micro"
    subnet_id = aws_subnet.this_public.id
    associate_public_ip_address = true

    vpc_security_group_ids = [
        aws_security_group.netpalm.id
    ]

    root_block_device {
        volume_type = "gp2"
        volume_size = 80
    }

    key_name = "wgkp"

    tags = var.common_tags
}