package main

# Prevent root user execution
deny[msg] {
  input.kind == "Deployment"
  not input.spec.template.spec.securityContext.runAsNonRoot
  msg = "Containers must not run as root"
}

# Enforce image version tagging (prevent 'latest')
deny[msg] {
  input.kind == "Deployment"
  image := input.spec.template.spec.containers[_].image
  endswith(image, ":latest")
  msg = "Deployments must not use the 'latest' image tag"
}

# Prevent privileged container execution
deny[msg] {
  input.kind == "Deployment"
  input.spec.template.spec.containers[_].securityContext.privileged == true
  msg = "Privileged containers are not allowed"
}