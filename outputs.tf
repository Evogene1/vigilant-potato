#outputs.tf

output "wordpress_public_ip" {
  value = aws_instance.go_api.public_ip
}

output "rds_host" {
  value = split(":", aws_db_instance.mysql.endpoint)[0]
}

output "redis_host" {
  value = aws_elasticache_cluster.redis.cache_nodes[0].address
}

output "redis_port" {
  value = 6379
}

output "db_user" {
  value = var.rds_user
}

output "db_password" {
  value = var.rds_passwd
}