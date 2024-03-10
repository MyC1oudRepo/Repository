#--------------------------------------------------------------
# Elastic Load Balancer Outputs
#--------------------------------------------------------------

output "lb_id" {
  description = "LB id"
  #value       = try(aws_lb.this[0].id, "")
  value       = try(aws_lb.this.id, "")
}

output "lb_arn" {
  description = "LB ARN"
  #value       = try(aws_lb.this[0].arn, "")
  value       = try(aws_lb.this.arn, "")
}

output "lb_tg_id" {
  description = "LB Target group id"
  #value       = try(aws_lb_target_group.this[0].id, "")
  value       = try(aws_lb_target_group.this.id, "")
}

output "lb_tg_arn" {
  description = "LB Target group ARN"
  #value       = try(aws_lb_target_group.this[0].arn, "")
  value       = try(aws_lb_target_group.this.arn, "")
}

output "data_aws_instance_id" {
  value       = concat(data.aws_instances.this.*.id, [""])[0]
  description = "data_aws_instance_id"
}

output "data_aws_instance_ids" {
  value       = concat(data.aws_instances.this.*.ids, [""])[0]
  description = "data_aws_instance_ids"
}
