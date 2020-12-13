resource "aws_security_group" "elb" {
    name = "netpalm-elb"
    description = "Security group for netpalm elb"
    vpc_id = aws_vpc.this.id

    ingress {
        description = "HTTP from Everywhere"
        from_port = 80
        to_port = 80
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

resource "aws_lb_target_group" "netpalm" {
    name = "netpalm-lb-tg"
    vpc_id = aws_vpc.this.id
    
    port = 9000
    # target_type = "ip"
    protocol = "HTTP"
    
    tags = var.common_tags
    deregistration_delay = 15
}

resource "aws_lb" "netpalm" {
    name = "netpalm-lb"
    load_balancer_type = "application"

    subnets = [
        aws_subnet.this_public.id,
        aws_subnet.this_public2.id
    ]
    security_groups = [
        aws_security_group.elb.id
    ]
    internal = false
}

resource "aws_lb_listener" "netpalm" {
    load_balancer_arn = aws_lb.netpalm.arn 

    port = 80
    protocol = "HTTP"

    default_action {
        type = "fixed-response"
        fixed_response {
            content_type = "text/plain"
            status_code = 403
            message_body = "NOPE"
        }
    }
}

resource "aws_lb_listener_rule" "netpalm" {
    listener_arn = aws_lb_listener.netpalm.arn
    
    action {
        type = "forward"
        target_group_arn = aws_lb_target_group.netpalm.arn
    }

    condition {
        path_pattern {
            values = [
                "/",
                "/static/*",
                "/swaggerfile"
            ]
        }
    }
}

resource "aws_lb_target_group_attachment" "netpalm" {
    target_group_arn = aws_lb_target_group.netpalm.arn
    target_id = aws_instance.netpalm.id
    port = 9000
}

resource "aws_route53_record" "netpalm" {
    zone_id = data.aws_route53_zone.netpalm.zone_id
    name = "public.${data.aws_route53_zone.netpalm.name}"
    type = "A"

    alias {
        name = aws_lb.netpalm.dns_name
        zone_id = aws_lb.netpalm.zone_id
        evaluate_target_health = false 
    }
}