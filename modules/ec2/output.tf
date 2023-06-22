output "private_instance_id"{
    value = aws_instance.pri-instance.*.id
}

output "public_instance_id"{
    value = aws_instance.basti-instance.id
}

