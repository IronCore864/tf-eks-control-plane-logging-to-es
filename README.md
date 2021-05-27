# EKS Control Plane Logging to ElasticSearch

This is a terraform module which creates a CloudWatch log group subscription filter with ElasticSearch as the destination.

Under the hood, the subscription filter sends logs to a Lambda function, then the Lambda function in turn sends the logs to ES.

## Example Usage

```
module "cloudwatch_log_to_elasticsearch" {
  source = "./path/to/this/modules"

  eks_cluster_name         = "cluster_name""
  eks_region               = "eu-central-1"
  log_group_name           = "/aws/eks/test/cluster"
  log_group_arn            = "arn:aws:logs:eu-central-1:ACCOUNT_ID:log-group:/aws/eks/test/cluster:*"
  elasticsearch_domain_arn = "arn:aws:es:eu-central-1:ACCOUNT_ID:domain/test"
}
```

## Notes

In Kibana - Security - Roles - all_access - Mapped users, the Lambda ARN needs to be mapped as a backend role so that the Lambda function can writes to ElasticSearch.

The Lambda ARN is in the output of this module.

More details see [here](https://docs.aws.amazon.com/elasticsearch-service/latest/developerguide/fgac.html#fgac-mapping).
