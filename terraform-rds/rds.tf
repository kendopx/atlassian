#create a RDS Database Instance
resource "aws_db_instance" "myinstance" {
  storage_type           = "gp2"
  engine                 = "mysql"
  identifier             = "jiradb"
  allocated_storage      = 20
  engine_version         = "8.0"
  instance_class         = "db.t4g.small"
  username               = "jirauser"
  password               = "jira123!"
  parameter_group_name   = "default.mysql8.0"
  vpc_security_group_ids = ["${aws_security_group.rds_sg.id}"]
  skip_final_snapshot    = true
  publicly_accessible    = true
}