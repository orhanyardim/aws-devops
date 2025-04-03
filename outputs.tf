output "eks_cluster_id" {
  description = "The ID of the EKS Cluster"
  value       = aws_eks_cluster.eks.id
}

output "vpc_id" {
  description = "The VPC ID"
  value       = aws_vpc.main.id
}
