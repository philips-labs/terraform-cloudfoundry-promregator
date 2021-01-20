# Copyright Koninklijke Philips N.V. 2020
terraform {
  required_version = ">= 0.13.0"

  required_providers {
    cloudfoundry = {
      source  = "philips-labs/cloudfoundry"
      version = ">= 0.1206.0"
    }
  }
}
