output "netpalm-mgmt" {
    value = aws_route53_record.netpalm-mgmt.name
}

output "netpalm" {
    value = aws_route53_record.netpalm.name
}