terraform {
  cloud {
    organization = "VortexLab"

    workspaces {
      name = "TF_Doki_tfe"
    }
  }
  required_providers {

    tfe = {
      source  = "hashicorp/tfe"
      version = "0.39.0"
    }
  }
}
