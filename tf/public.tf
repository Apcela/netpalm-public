
resource "aws_internet_gateway" "this" {
    vpc_id = aws_vpc.this.id
    
    tags = var.common_tags
}

resource "aws_subnet" "this_public" {
    vpc_id = aws_vpc.this.id
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = true

    tags = var.common_tags
}

resource "aws_route_table" "this_public" {
    vpc_id = aws_vpc.this.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.this.id
    }
    
    tags = var.common_tags
}

resource "aws_route_table_association" "this_public" {
    route_table_id = aws_route_table.this_public.id 
    subnet_id = aws_subnet.this_public.id
}
