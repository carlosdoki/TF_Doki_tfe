variable "token" {
  type        = string
  sensitive   = true
  description = "TFE Token"
}
variable "organization" {
  type        = string
  description = "Organization"
}
variable "project" {
  type        = string
  description = "Porject Name"
}
variable "environemt" {
  type        = string
  description = "Environment"
}
variable "squad" {
  type        = string
  description = "Squad"
}
variable "resource" {
  type        = string
  description = "Resource"
}
variable "git" {
  type        = string
  description = "GIT"
}
variable "template" {
  type        = string
  description = "Workspace Template"
}
variable "variableSet" {
  type        = string
  description = "Global Variable"
}
variable "policySet" {
  type        = string
  description = "Policy Set"
}
