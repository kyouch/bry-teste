resource "aws_security_group" "master" {
  name   = "${var.kubernetes_name}-sg-master"
  vpc_id = aws_vpc.vpc.id

  ingress {
    description = "SSH"
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "etcd server client API"
    protocol    = "tcp"
    from_port   = 2379
    to_port     = 2380
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Kubernetes API server"
    protocol    = "tcp"
    from_port   = 6443
    to_port     = 6443
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Weavenet TCP"
    protocol    = "tcp"
    from_port   = 6783
    to_port     = 6783
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Weavenet UDP"
    protocol    = "udp"
    from_port   = 6783
    to_port     = 6784
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP Generic"
    protocol    = "tcp"
    from_port   = 8080
    to_port     = 8080
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "ALB Controller"
    protocol    = "tcp"
    from_port   = 9443
    to_port     = 9443
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Kubelet API"
    protocol    = "tcp"
    from_port   = 10250
    to_port     = 10250
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "kube-controller-manager"
    protocol    = "tcp"
    from_port   = 10257
    to_port     = 10257
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "kube-scheduler"
    protocol    = "tcp"
    from_port   = 10259
    to_port     = 10259
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "NodePort Services"
    protocol    = "tcp"
    from_port   = 30000
    to_port     = 32767
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.kubernetes_name}-sg-master"
  }
}

resource "aws_security_group" "worker" {
  name   = "${var.kubernetes_name}-sg-worker"
  vpc_id = aws_vpc.vpc.id

  ingress {
    description = "SSH"
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Weavenet TCP"
    protocol    = "tcp"
    from_port   = 6783
    to_port     = 6783
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Weavenet UDP"
    protocol    = "udp"
    from_port   = 6783
    to_port     = 6784
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "ALB Controller"
    protocol    = "tcp"
    from_port   = 9443
    to_port     = 9443
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Kubelet API"
    protocol    = "tcp"
    from_port   = 10250
    to_port     = 10250
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "NodePort Services"
    protocol    = "tcp"
    from_port   = 30000
    to_port     = 32767
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.kubernetes_name}-sg-worker"
  }
}
