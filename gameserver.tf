provider "aws" {
  region = "ap-southeast-2" # Specify the region
}

resource "aws_instance" "zerotier_instance" {
  ami           = "ami-0d9fa9def05704a02"
  instance_type = "g4dn.2xlarge"
  key_name      = "Hurren"
  subnet_id     = "subnet-0f287a6780b92e68d"
  vpc_security_group_ids = ["sg-0bdbdd4fe6994f0cf"]

  root_block_device {
    volume_size           = 100
    volume_type           = "gp2"
    delete_on_termination = true
  }

  tags = {
    Name = "ZerotierInstance"
  }

  user_data = <<-EOT
#!/bin/bash
# Install ZeroTier
curl -s https://install.zerotier.com | bash
# Join ZeroTier network
zerotier-cli join 60ee7c034a8fdc46
EOT
}

output "instance_id" {
  value = aws_instance.zerotier_instance.id
}

output "public_ip" {
  value = aws_instance.zerotier_instance.public_ip
}

output "private_ip" {
  value = aws_instance.zerotier_instance.private_ip
}
