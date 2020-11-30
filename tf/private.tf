# Probably we'll never need this.  Too complicated for a small use case like this

# resource "aws_eip" "this_ngw" {
#     vpc = true 

#     depends_on = [ aws_internet_gateway.this ]
# }

# resource "aws_nat_gateway" "this" {
#     allocation_id = aws_eip.this_ngw.id
#     subnet_id = aws_subnet.this_public.id 
    
#     depends_on = [ aws_internet_gateway.this ]
#     tags = var.common_tags
# }

# resource "aws_subnet" "this_private" {
#     vpc_id = aws_vpc.this.id
#     cidr_block = "10.0.2.0/24"

#     tags = var.common_tags
# }

# resource "aws_route_table" "this_private" {
#     vpc_id = aws_vpc.this.id

#     route {
#         cidr_block = "0.0.0.0/0"
#         nat_gateway_id = aws_nat_gateway.this.id
#     }
    
#     tags = var.common_tags
# }
