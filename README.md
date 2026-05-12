# DevOps CI/CD Security Platform
![CI/CD Status](https://github.com/YOUR_GITHUB_USERNAME/Makeup-Exam/actions/workflows/pipeline.yaml/badge.svg)

## Branching Strategy
* **main**: Contains production-ready code.
* **staging**: Pre-production environment for testing.
* **development**: Active development branch where features are integrated.

---

## Execution History & Command Reference
*This section documents the step-by-step terminal commands used to construct this DevOps infrastructure, fulfilling the Linux administration, Git workflow, and security automation requirements.*

### Phase 1: Linux Administration & User Management
```bash
# 1. Created the required project directory structure
mkdir -p company-devops-platform/{configs,deployments,policies,reports/sonarqube,artifacts,backup}

# 2. Created designated groups for access control
sudo groupadd developers
sudo groupadd operations

# 3. Created users and assigned them to their respective primary groups
sudo useradd -m -g developers developer
sudo useradd -m -g developers tester
sudo useradd -m -g operations devopsadmin

# 4. Configured directory ownership and restrictive permissions
# Assigned to devopsadmin (owner) and developers (group)
sudo chown -R devopsadmin:developers .
# Gave full access to admin, read/write/execute to developers
sudo chmod -R 775 .
Phase 2: Configuration Management & Backup Simulation
# 1. Initialized empty configuration files
touch configs/deployment.yaml configs/pipeline.yaml configs/security.conf

# 2. Created time-stamped backups of configuration files
cp configs/deployment.yaml backup/deployment_$(date +%Y%m%d_%H%M%S).yaml
cp configs/pipeline.yaml backup/pipeline_$(date +%Y%m%d_%H%M%S).yaml
cp configs/security.conf backup/security_$(date +%Y%m%d_%H%M%S).conf

# 3. Demonstrated background process execution and termination
sleep 1000 &  # Start background process
kill $!       # Terminate using process ID
Phase 3: Version Control (Git & GitHub)
# 1. Initialized the local Git repository and set the main branch
git init
git checkout -b main

# 2. Created functional environments (branches)
git branch development
git branch staging
git branch production

# Note: Advanced Git operations performed during development:
# - Resolved merge conflicts manually in security.conf
# - Used 'git stash' and 'git stash pop' for context switching
# - Executed 'git cherry-pick' to move specific commits
# - Used 'git revert HEAD --no-edit' to safely undo changes
# - Recovered deleted files using 'git restore'
Phase 4: CI/CD & Security Integration
GitHub Actions: Configured .github/workflows/pipeline.yaml for automated build, test, and artifact generation.

SonarQube: Integrated code quality analysis steps into the pipeline.

Open Policy Agent (OPA): Created policies/deployment.rego to enforce non-root execution and prevent latest image tags. Validated against deployment files using conftest.
### Step 2: Delete the Unneeded File (Optional but Clean)
If you created the `commands.txt` file from my previous message, let's delete it so your repository stays clean:
```bash
rm commands.txt
Step 3: Push the Perfect README to GitHub
Now, let's commit this beautifully documented README.md and push it to your development branch (and subsequently, your main branch so it shows up on the front page of your repository).
# Add and commit the updated README
git add README.md
git commit -m "docs: completely overhauled README with detailed command history and comments"

# Push to development
git push origin development

# Merge the clean README into your main branch so the teacher sees it immediately
git checkout main
git merge development
git push origin main

# Switch back to development just in case you need to do more work
git checkout development
