# ElastiCache Redis Instanc
resource "aws_elasticache_cluster" "redis" {
  cluster_id           = "redis-instance"
  engine              = "redis"
  node_type           = "cache.t2.micro"
  num_cache_nodes     = 1
  engine_version      = "7.0"
  parameter_group_name = "default.redis7"
  port                = 6379
  subnet_group_name   = aws_elasticache_subnet_group.redis_subnet_group.name
  security_group_ids  = [aws_security_group.redis_sg.id]

  apply_immediately = true

  transit_encryption_enabled  = false

  tags = {
    Name = "Secured Redis Instance"
  }
}

output "redis_endpoint" {
  value = aws_elasticache_cluster.redis.cache_nodes[0].address
}
