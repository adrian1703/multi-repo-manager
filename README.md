
# Git Multi-Repo Manager

Simple toolkit to manage multiple Git repositories from a single location.

## Requirements

- Bash
- Git
- yq (YAML parser)
- SSH access for Git repositories

## Setup

1. Configure repositories in `repos.yaml`:

```yaml
repos:
- name: repo-name    # Local directory name
  url: git@...       # Git repository URL
  branch: main      # Default branch (optional)
```

## Scripts

### clone.bash

Clones all repositories from `repos.yaml`:

```bash
./clone.bash
```

- Skips existing repositories
- Uses colored output for better visibility

### meta.bash

Executes commands in all repositories:

```bash
./meta.bash <command>
```

Common examples:
```bash
./meta.bash git status
./meta.bash git checkout main
./meta.bash git pull
```

## Common Operations

### Repository Setup
```bash
./clone.bash                          # Clone all repos
./meta.bash git checkout main         # Switch to main branch
```

### Sync Changes
```bash
./meta.bash git pull                  # Pull all repos
./meta.bash git push                  # Push all repos
```

### Status Check
```bash
./meta.bash git status                # Check all repos
./meta.bash "git branch --show-current"   # Show current branches
```

## Troubleshooting

- Ensure SSH keys are configured for Git
- Install yq if missing
- Run scripts from their directory
- Use quotes for complex commands