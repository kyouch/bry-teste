data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

resource "aws_key_pair" "ssh_public_key" {
  key_name   = var.key_name
  public_key = var.key_public
}

resource "aws_instance" "master" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type["master"]
  key_name                    = aws_key_pair.ssh_public_key.key_name
  subnet_id                   = aws_subnet.public_subnet[0].id
  vpc_security_group_ids      = [aws_security_group.master.id]
  iam_instance_profile        = aws_iam_instance_profile.master_profile.name
  associate_public_ip_address = true

  root_block_device {
    volume_type = "gp3"
    volume_size = 14
  }

  tags = {
    Name = "master-${var.kubernetes_name}"
  }
}

resource "aws_instance" "worker" {
  count                       = var.worker_count
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type["worker"]
  key_name                    = aws_key_pair.ssh_public_key.key_name
  subnet_id                   = aws_subnet.public_subnet[count.index].id
  vpc_security_group_ids      = [aws_security_group.worker.id]
  iam_instance_profile        = aws_iam_instance_profile.worker_profile.name
  associate_public_ip_address = true

  root_block_device {
    volume_type = "gp3"
    volume_size = 8

  }

  tags = {
    Name = "worker-${count.index}-${var.kubernetes_name}"
  }
}

resource "ansible_host" "master" {
  depends_on = [aws_instance.master]
  name       = "master"
  groups     = ["masters"]
  variables = {
    ansible_user                 = "ubuntu"
    ansible_host                 = aws_instance.master.public_ip
    instance_hostname            = "master"
    ansible_ssh_private_key_file = "id_ed25519"
  }
}

resource "ansible_host" "worker" {
  depends_on = [aws_instance.worker]
  count      = 2
  name       = "worker-${count.index}"
  groups     = ["workers"]
  variables = {
    ansible_user                 = "ubuntu"
    ansible_host                 = aws_instance.worker[count.index].public_ip
    instance_hostname            = "worker-${count.index}"
    ansible_ssh_private_key_file = "id_ed25519"
  }
}
