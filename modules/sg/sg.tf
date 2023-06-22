locals {
  source_cidrs_list = concat(var.source_bastion_cidrs, var.source_web_cidrs, var.source_was_cidrs)
}


resource "aws_security_group" "sg"{
    vpc_id = var.vpc_id
    name = "sg_song"
}


/*
locals {
  source_cidrs_list = concat(var.source_bastion_cidrs, var.source_web_cidrs, var.source_was_cidrs)
}
*/

resource "aws_security_group_rule" "ingress" {
  for_each = { for index, value in local.source_cidrs_list : index => value }
  
  security_group_id = aws_security_group.sg.id

  type        = "ingress"
  from_port   = each.value.from
  to_port     = each.value.to
  protocol    = each.value.protocol
  cidr_blocks = each.value.cidrs
}