resource "awscc_ec2_ipam" "main" {
  operating_regions = [
    {
      region_name = "us-east-1"
    },
    {
      region_name = "us-east-2"
    }
  ]
  tags = [{
    key   = "Name"
    value = "global-ipam"
  }]
}

resource "awscc_ec2_ipam_pool" "root" {
  address_family = "ipv4"
  ipam_scope_id  = awscc_ec2_ipam.main.private_default_scope_id
  auto_import    = false

  provisioned_cidrs = [
    {
      cidr = "10.0.0.0/16"
    }
  ]

  tags = [{
    key   = "Name"
    value = "top-level-pool"
  }]
}

resource "awscc_ec2_ipam_pool" "useast1" {
  address_family      = "ipv4"
  auto_import         = false
  ipam_scope_id       = awscc_ec2_ipam.main.private_default_scope_id
  locale              = "us-east-1"
  source_ipam_pool_id = awscc_ec2_ipam_pool.root.ipam_pool_id

  provisioned_cidrs = [
    {
      cidr = "10.0.0.0/17"
    }
  ]

  tags = [{
    key   = "Name"
    value = "regional-pool-us-east-1"
  }]
}

resource "awscc_ec2_ipam_pool" "useast2" {
  address_family      = "ipv4"
  auto_import         = false
  ipam_scope_id       = awscc_ec2_ipam.main.private_default_scope_id
  locale              = "us-east-2"
  source_ipam_pool_id = awscc_ec2_ipam_pool.root.ipam_pool_id

  provisioned_cidrs = [
    {
      cidr = "10.0.128.0/17"
    }
  ]

  tags = [{
    key   = "Name"
    value = "regional-pool-us-east-2"
  }]
}
