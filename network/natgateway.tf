# resource "aws_eip" "dev" {
#   vpc   = true
#   count = 2

#   tags = {
#     Name = "${var.service}-${var.dev.env}"
#   }
# }

# resource "aws_nat_gateway" "dev" {
#   count         = 2
#   allocation_id = aws_eip.dev[count.index].id
#   subnet_id     = element(aws_subnet.dev_public.*.id, count.index)

#   tags = {
#     Name = "${var.service}-${var.dev.env}"
#   }
# }
