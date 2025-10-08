# Instana Migration Ansible Collection

A reusable Ansible collection for migrating Instana agents from on-premises to SaaS using a safe dual-server approach.

## Collection Name

`instana_migration.collection`

## Features

- **Multi-Platform Support**: Windows and Linux Instana agents
- **Safe Migration**: Dual-server approach with rollback capability
- **Configuration Preservation**: Maintains all agent customizations
- **Comprehensive Backup**: Full configuration backup before changes
- **Verification Steps**: Agent status verification at each stage

## Installation

### From GitHub

```bash
ansible-galaxy collection install git+https://github.com/your-org/instana-migration-collection.git
```

### From Local Build

```bash
# Build the collection
ansible-galaxy collection build

# Install the collection
ansible-galaxy collection install instana_migration-collection-1.0.0.tar.gz
```

### Using Requirements File

Add to `requirements.yml`:

```yaml
collections:
  - name: https://github.com/your-org/instana-migration-collection.git
    type: git
    version: main
```

Then install:

```bash
ansible-galaxy collection install -r requirements.yml
```

## Usage

### 1. Create Inventory

Create an inventory file with your Instana agents:

```ini
[instana_agents]
server1.example.com
server2.example.com

[instana_agents:vars]
ansible_user=admin
ansible_become=yes
```

### 2. Create Variables File

Create `vars/instana-vars.yml`:

```yaml
---
instana_saas_endpoint: "saas-instana.example.com"
instana_saas_port: 443
instana_saas_key: "your-saas-agent-key"
instana_zone: "your-zone-name"
```

### 3. Run Migration Playbooks

```bash
# Backup current configuration
ansible-playbook -i inventory playbooks/backup-instana-config.yml

# Configure dual-server setup
ansible-playbook -i inventory playbooks/dual-server-migration.yml

# Final migration to SaaS-only
ansible-playbook -i inventory playbooks/saas-only-migration.yml
```

## Playbook Details

### Backup Playbook

- Creates backup of all Instana configuration files
- Captures agent version information
- Creates backup manifest with file list
- Supports both Linux and Windows paths

### Dual-Server Migration Playbook

- Preserves all existing agent customizations
- Updates only endpoint, port, and agent key for SaaS
- Maintains on-prem configuration for rollback
- Uses proper Instana dual-server file naming conventions

### SaaS-Only Migration Playbook

- Removes on-prem configuration files
- Verifies SaaS configuration is active
- Restarts agent for SaaS-only operation
- Provides comprehensive status verification

## Project Structure

```
instana-migration-collection/
├── galaxy.yml
├── meta/
│   └── runtime.yml
├── roles/
│   ├── instana_common/          # Shared functionality
│   ├── instana_backup/          # Backup operations
│   ├── instana_dual_config/     # Dual-server migration
│   └── instana_saas_only/       # SaaS-only migration
├── playbooks/                    # Ready-to-use playbooks
├── plugins/                      # Custom modules
├── docs/                         # Documentation
└── tests/                        # Test files
```

## Supported Platforms

- **Linux**: RHEL, CentOS, Ubuntu, Debian
- **Windows**: Server 2012+ , Windows 10+
- **Instana Agent**: Version 1.0.x and above

## Variables Reference

| Variable | Description | Default |
|----------|-------------|---------|
| `instana_saas_endpoint` | SaaS Instana endpoint | Required |
| `instana_saas_port` | SaaS Instana port | `443` |
| `instana_saas_key` | SaaS agent key | Required |
| `instana_zone` | Agent zone name | Optional |
| `instana_backup_dir` | Backup directory | OS-specific |

## License

MIT

## Support

For issues and questions, please create an issue in the GitHub repository.
