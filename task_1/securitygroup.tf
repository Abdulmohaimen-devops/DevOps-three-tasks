resource "aws_security_group" "myinstance" {
  vpc_id = aws_vpc.main.id
  name = "myinstance"
  description = "security group for my instance"
  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  } 

  ingress {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      security_groups = [aws_security_group.elb-securitygroup.id]
  }

  tags = {
    Name = "SG_EC2"
  }
}

resource "aws_security_group" "allow-mariadb" {
  vpc_id = aws_vpc.main.id
  name = "allow-mariadb"
  description = "allow-mariadb"
  ingress {
      from_port = 3306
      to_port = 3306
      protocol = "tcp"
      security_groups = [aws_security_group.myinstance.id]              # allowing access from our example instance
  }
  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
      self = true
  }
  tags = {
    Name = "SG_RDS"
  }
}

resource "aws_security_group" "elb-securitygroup" {
  vpc_id = aws_vpc.main.id
  name = "elb"
  description = "security group for load balancer"
  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  } 
  tags = {
    Name = "SG_LB"
  }
}
