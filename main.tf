resource "aws_instance" "iac_1_instance" {
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.ec2_1_public_subnet.id
  vpc_security_group_ids = [aws_security_group.iac-instance-sg.id]
  key_name               = var.key_name
  #user_data              = file("install_script.sh")
  tags = {
    Name = "AS-instance-1"
  }
  depends_on = [
    aws_db_instance.rds_wordpress,
  ]
}

#user_data              = file("install_script.sh")
resource "aws_instance" "iac_2_instance" {
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.ec2_2_public_subnet.id
  vpc_security_group_ids = [aws_security_group.iac-instance-sg.id]
  key_name               = var.key_name
  user_data              = file("scriptminikube.sh")
  tags = {
    Name = "AS-instance-2"
  }
}

resource "aws_db_subnet_group" "database_subnet" {
  name       = "db subnet"
  subnet_ids = [aws_subnet.database_private_subnet.id]
}

resource "aws_db_instance" "rds_wordpress" {
  identifier              = "rds-wordpress"
  allocated_storage       = 10
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class          = "db.t3.micro"
  db_name                 = var.db_name
  username                = var.db_user
  password                = var.db_password
  backup_retention_period = 7
  multi_az                = false
  availability_zone       = var.availability_zone[0]
  db_subnet_group_name    = aws_db_subnet_group.database_subnet.id
  skip_final_snapshot     = true
  vpc_security_group_ids  = [aws_security_group.iac-sg-database.id]
  storage_encrypted       = true
  tags = {
    Name = "AS-db-instance"
  }
}