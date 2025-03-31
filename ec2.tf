resource "aws_instance" "go_api" {
  ami                         = var.AMIS[var.REGION]
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.public_subnet_a.id
  associate_public_ip_address = true
  key_name                    = var.PUB_KEY

  vpc_security_group_ids = [aws_security_group.default.id]

  tags = {
    Name = "go-api-mysql"
    OS   = "ubuntu"
  }

  user_data = <<-EOF
    #!/bin/bash
    apt-get update
    apt-get install -y docker.io docker-compose git jq awscli
    git clone https://github.com/Evogene1/automatic-octo-tribble.git /opt/containers/wordpress
  EOF

provisioner "remote-exec" {
  inline = [
    "while [ ! -d /opt/containers/wordpress ]; do sleep 5; done",
    "sudo chown -R ubuntu. /opt/containers",
    "echo 'DB_HOST=${aws_db_instance.mysql.endpoint}' > /opt/containers/wordpress/.env",
    "echo 'DB_USER=${var.rds_user}' >> /opt/containers/wordpress/.env",
    "echo 'DB_PASSWORD=${var.rds_passwd}' >> /opt/containers/wordpress/.env",
    "echo 'REDIS_HOST=${aws_elasticache_cluster.redis.cache_nodes[0].address}' >> /opt/containers/wordpress/.env",
    "echo 'REDIS_PORT=6379' >> /opt/containers/wordpress/.env",
    "echo 'IP=${self.public_ip}' >> /opt/containers/wordpress/.env",
    "cd /opt/containers/wordpress && sudo docker-compose --env-file .env up -d"
  ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("your_key")
      host        = self.public_ip
    }
  }

  depends_on = [
    aws_security_group.default,
    aws_db_instance.mysql,
    aws_elasticache_cluster.redis
  ]
}