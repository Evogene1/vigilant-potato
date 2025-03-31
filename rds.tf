# RDS Instance
resource "aws_db_instance" "mysql" {
  allocated_storage = 10         # Storage for instance in gigabytes
  identifier = "mydb"  # The name of the RDS instance
  storage_type = "gp2"           # See storage comparision <https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_Storage.html#storage-comparison>
  engine = "mysql"               # Specific Relational Database Software <https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Welcome.html#Welcome.Concepts.DBInstance>
  
  # InvalidParameterCombination: RDS does not support creating a DB instance with the following combination: DBInstanceClass=db.t4g.micro, Engine=mysql, EngineVersion=5.7.41,
  # <https://aws.amazon.com/about-aws/whats-new/2021/09/amazon-rds-t4g-mysql-mariadb-postgresql/>
  engine_version = "8.0.32"
  instance_class = "db.t3.micro" # See instance pricing <https://aws.amazon.com/rds/mysql/pricing/?pg=pr&loc=2>
  multi_az = true

  # mysql -u dbadmin -h <ENDPOINT> -P 3306 -D sample -p
  db_name  = var.db_name           # name is deprecated, use db_name instead
  username = var.rds_user
  password = var.rds_passwd

  db_subnet_group_name = aws_db_subnet_group.private_db_subnet.name  # Name of DB subnet group. DB instance will be created in the VPC associated with the DB subnet group.
  # Error: final_snapshot_identifier is required when skip_final_snapshot is false
  skip_final_snapshot = true

  vpc_security_group_ids = [
    aws_security_group.rds_sg.id
  ]
}