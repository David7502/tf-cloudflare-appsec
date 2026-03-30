# Lab AppSec - Terraform + Ansible

Infrastructure de lab AppSec (Application Security) sur Google Cloud Platform avec déploiement automatisé via Terraform et Ansible.

## Architecture

Une VM Docker en **europe-west1** hébergeant plusieurs applications vulnérables pour tests de sécurité :

| Application | Port | Description |
|-------------|------|-------------|
| **httpbin** | 8080 | API de test HTTP |
| **Site web** | 80 | Dashboard avec liens vers les apps |
| **Juice Shop** | 3000 | App vulnérable OWASP (e-commerce) |
| **DVWA** | 4280 | Damn Vulnerable Web App |
| **WebGoat** | 8081, 9090 | Plateforme d'apprentissage sécurité OWASP |
| **json-server** | 3001 | Fake REST API |

## Prérequis

- [Terraform](https://www.terraform.io/downloads.html) >= 1.0
- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html) >= 2.9
- Compte Google Cloud Platform (GCP)
- Clé SSH configurée

## Déploiement

### 1. Configuration Terraform

```bash
# Cloner le repo
git clone https://github.com/David7502/tf-cloudflare-appsec.git
cd tf-cloudflare-appsec

# Configurer les credentials GCP
export GOOGLE_APPLICATION_CREDENTIALS="/chemin/vers/service-account.json"

# Créer le fichier de variables
cp terraform.tfvars.example terraform.tfvars
```

Éditer `terraform.tfvars` :

```hcl
project_id     = "votre-projet-gcp"
ssh_public_key = "ssh-ed25519 AAAA... user@host"
```

```bash
# Déployer l'infrastructure
terraform init
terraform plan
terraform apply
```

### 2. Configuration Ansible

```bash
cd ansible

# Mettre à jour l'inventaire avec l'IP de la VM
# Remplacer IP_DE_VM par l'IP externe de la VM créée
nano inventory.ini
```

```bash
# Déployer les containers Docker
ansible-playbook -i inventory.ini playbook.yml
```

## Structure du projet

```
.
├── main.tf              # Infrastructure GCP (VPC, firewall, VM)
├── variables.tf         # Variables Terraform
├── provider.tf          # Provider Google Cloud
├── outputs.tf           # Outputs Terraform
├── terraform.tfvars     # Valeurs des variables (non commité)
└── ansible/
    ├── inventory.ini    # Inventaire des hôtes
    ├── playbook.yml     # Playbook Docker + containers
    └── files/
        └── db.json      # Données pour json-server
```

## Sécurité

**Fichiers sensibles** (non commités) :

- `terraform.tfvars` - Variables Terraform
- `ansible/vars.local.yml` - Variables Ansible sensibles
- `*.tfstate` - État Terraform
- `*.json` - Clés de service GCP

## Commandes utiles

```bash
# Terraform
terraform plan          # Prévisualiser les changements
terraform apply         # Appliquer les changements
terraform destroy       # Supprimer l'infrastructure
terraform output        # Afficher les outputs

# Ansible
ansible-playbook -i ansible/inventory.ini ansible/playbook.yml
```

## Accès aux applications

Une fois déployé, les applications sont accessibles via l'IP externe de la VM :

- `http://<IP>:80` - Dashboard (page d'accueil)
- `http://<IP>:3000` - Juice Shop
- `http://<IP>:4280` - DVWA
- `http://<IP>:8080` - httpbin
- `http://<IP>:8081` - WebGoat
- `http://<IP>:3001` - json-server

## Dépannage

### Erreur SSH "REMOTE HOST IDENTIFICATION HAS CHANGED"

Si vous recréez la VM avec la même IP, SSH refusera la connexion car la clé de l'hôte a changé :

```
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@    WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!     @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
```

**Solution** : Supprimer l'ancienne entrée du fichier `known_hosts` :

```bash
ssh-keygen -f ~/.ssh/known_hosts -R "<IP_DE_LA_VM>"
```

Puis relancez le playbook Ansible.
