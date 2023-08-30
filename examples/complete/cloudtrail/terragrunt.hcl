include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../..//."
}

inputs = {
  enabled = true

  region      = "us-east-2"
  environment = "test"

  name = "dt-terraform-test"

  bucket_force_destroy = true

  tags = {
    "Company" = "DeveloperTown"
  }
}
