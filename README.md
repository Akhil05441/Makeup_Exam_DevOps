# DevOps CI/CD Security Platform
![CI/CD Status](https://github.com/Akhil05441/Makeup_Exam_DevOps/actions/workflows/pipeline.yaml/badge.svg)

## Branching Strategy
* **main**: Contains production-ready code.
* **staging**: Pre-production environment for testing.
* **development**: Active development branch where features are integrated.

DevOps CI/CD Security & Version Control System
Complete Execution Documentation
Akhil (GitHub: Akhil05441)
May 12, 2026
This document outlines the step-by-step execution history for the development of a secure
DevOps CI/CD infrastructure. It covers Linux administration, configuration management, Gitbased version control, and an automated GitHub Actions pipeline featuring SonarQube code
quality mock-validation and Open Policy Agent (OPA) security enforcement.
1 Phase 1: Linux Administration & User Management
This phase establishes the foundational directory structures, creates system users and groups,
and enforces the principle of least privilege using Linux file permissions.
# 1. Created the required project directory structure
mkdir -p company -devops -platform /{ configs ,deployments ,policies ,reports/sonarqube ,
artifacts ,backup}
cd company -devops -platform
# 2. Created designated groups for access control
sudo groupadd developers
sudo groupadd operations
# 3. Created users and assigned them to primary groups
sudo useradd -m -g developers developer
sudo useradd -m -g developers tester
sudo useradd -m -g operations devopsadmin
# 4. Configured directory ownership and restrictive permissions
# Ownership assigned to devopsadmin (user) and developers (group)
sudo chown -R devopsadmin : developers .
# Permissions: rwx for owner/group , rx for others
sudo chmod -R 775 .
2 Phase 2: Configuration Management & Backups
In this phase, configuration files were initialized, and a simulated automated backup mechanism was demonstrated using timestamped archives. Background process management was
also demonstrated.
# 1. Initialized empty configuration files
touch configs/ deployment .yaml configs/pipeline.yaml configs/security.conf
# 2. Created time -stamped backups of configuration files
cp configs/ deployment .yaml backup/ deployment_$ (date +%Y%m%d_%H%M%S).yaml
cp configs/pipeline.yaml backup/ pipeline_$ (date +%Y%m%d_%H%M%S).yaml
cp configs/security.conf backup/ security_$ (date +%Y%m%d_%H%M%S).conf
# 3. Demonstrated background process execution and termination
sleep 1000 & # Start background process
kill $! # Terminate using the Process ID
3 Phase 3: Version Control (Git & GitHub)
Git was initialized to track changes. A comprehensive branching strategy was implemented,
and advanced Git operations were utilized during the development lifecycle.
# 1. Initialized the local Git repository and set the main branch
git init
git checkout -b main
# 2. Created functional environments (branches)
git branch development
git branch staging
git branch production
# 3. Advanced Git operations performed during development:
# - Resolved merge conflicts manually in configs/security.conf
# - git stash / git stash pop (Context switching)
# - git cherry -pick <hash > (Migrating specific commits)
# - git revert HEAD --no-edit (Safe history rollback)
# - git restore <file > (Recovering deleted configuration files)
4 Phase 4: CI/CD Pipeline & Security Integration
An automated GitHub Actions pipeline was configured to trigger on pushes to the development
and production branches. The pipeline includes source checkout, simulated builds, security
validation, and artifact management.
4.1 Pipeline Architecture (GitHub Actions)
The pipeline relies on actions/checkout@v4 and actions/upload-artifact@v4 to prevent deprecation errors. It features a mocked SonarQube validation step and live execution of Open Policy
Agent (OPA) tests using Conftest.
# Open Policy Agent (OPA) integration within the pipeline:
wget https :// github.com/open -policy -agent/conftest/ releases/ download/v0 .45.0/ conftest_0
.45.0 _Linux_x86_64 .tar.gz
tar xzf conftest_0 .45.0 _Linux_x86_64 .tar.gz
sudo mv conftest /usr/local/bin
# Validating the deployment file against custom Rego policies:
conftest test deployments /app -deploy.yaml -p policies/ deployment .rego
4.2 OPA Rego Policy Example
Custom ‘.rego‘ policies were authored to restrict insecure container setups.
package main
# Prevent root user execution
deny[msg] {
input.kind == " Deployment "
not input.spec.template.spec. securityContext . runAsNonRoot
msg = " Containers must not run as root"
}
# Enforce image version tagging
deny[msg] {
input.kind == " Deployment "
image := input.spec.template.spec. containers [_]. image
endswith(image , ": latest ")
msg = " Deployments must not use the 'latest ' image tag"
}
