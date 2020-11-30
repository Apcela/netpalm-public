variable "common_tags" {
    type = map(string)
    default = {
        "applictaion": "netpalm",
        "Name": "netpalm"
    }
}

resource "aws_vpc" "this" {
    cidr_block = "10.0.0.0/16"

    tags = var.common_tags
}
