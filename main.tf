provider "aws" {
  region = "ap-southeast-1"
}

# Generate SSH key pair
resource "tls_private_key" "tf-rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "tf-keys" {
  key_name   = "tf-keys"
  public_key = tls_private_key.tf-rsa.public_key_openssh
}

resource "local_file" "ssh_key" {
  filename = "ssh_private_key.pem"
  content  = tls_private_key.tf-rsa.private_key_pem
}

# Define a security group with inbound SSH open to all
resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow SSH from any IP address
  }
}

resource "aws_instance" "Docker_Terraform" {
  ami                         = "ami-06c4be2792f419b7b"
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  key_name                    = aws_key_pair.tf-keys.key_name
  security_groups             = [aws_security_group.allow_ssh.name]  # Attach the security group
  tags = {
    "Name" = "my-project-tf"
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = tls_private_key.tf-rsa.private_key_pem
    host        = self.public_ip  # Dynamically set the host to the public IP address of the instance
    timeout     = "5m"
  }

  provisioner "file" {
    source      = "install.sh"
    destination = "/tmp/install.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/install.sh",
      "sudo bash /tmp/install.sh"
    ]
  }
}

output "public_ip" {
  value = aws_instance.Docker_Terraform.public_ip
}
