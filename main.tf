provider "tfe" {
  token = var.token
}

data "tfe_workspace" "template" {
  name         = var.template
  organization = var.organization
}

data "tfe_oauth_client" "client" {
  organization     = var.organization
  service_provider = "github"
}

data "tfe_variable_set" "test" {
  name         = var.variableSet
  organization = var.organization
}

data "tfe_policy_set" "test" {
  name         = var.policySet
  organization = var.organization
}

resource "tfe_workspace" "new" {
  depends_on = [
    data.tfe_workspace.template
  ]
  name              = "${var.squad}-${var.resource}-${var.project}-${var.environment}"
  organization      = data.tfe_workspace.template.organization
  working_directory = data.tfe_workspace.template.working_directory
  trigger_patterns  = ["/${upper(var.resource)}/${upper(var.project)}/*"]
  vcs_repo {
    branch             = data.tfe_workspace.template.vcs_repo[0].branch
    identifier         = var.git
    ingress_submodules = data.tfe_workspace.template.vcs_repo[0].ingress_submodules
    oauth_token_id     = data.tfe_oauth_client.client.id
  }
  tag_names = [var.environment, var.project, var.resource, var.squad]
}

resource "tfe_workspace_variable_set" "test" {
  depends_on = [
    tfe_workspace.new,
    data.tfe_variable_set.test
  ]
  variable_set_id = data.tfe_variable_set.test.id
  workspace_id    = tfe_workspace.new.id
}

resource "tfe_policy_set" "test" {
  depends_on = [
    tfe_workspace.new,
    data.tfe_policy_set.test
  ]
  name          = var.policySet
  organization  = var.organization
  description   = data.tfe_policy_set.test.description
  workspace_ids = setunion(data.tfe_policy_set.test.workspace_ids, [tfe_workspace.new.id])
  vcs_repo {
    identifier         = data.tfe_policy_set.test.vcs_repo[0].identifier
    ingress_submodules = data.tfe_policy_set.test.vcs_repo[0].ingress_submodules
    oauth_token_id     = data.tfe_oauth_client.client.id
  }
}

