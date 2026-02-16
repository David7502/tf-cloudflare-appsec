# Terraform AppSec - Google Cloud

Configuration Terraform pour déployer une infrastructure AppSec (Application Security) sur Google Cloud Platform.

## 📋 Prérequis

- [Terraform](https://www.terraform.io/downloads.html) >= 1.0
- Compte Google Cloud Platform (GCP)
- Clé de service GCP configurée
- [Google Cloud CLI](https://cloud.google.com/sdk/docs/install) (optionnel mais recommandé)

## 🔧 Installation

### 1. Cloner le repository

```bash
git clone <your-repo-url>
cd terraform-appsec
```

### 2. Configurer les credentials Google Cloud

```bash
# Exporter la clé de service
export GOOGLE_APPLICATION_CREDENTIALS="/chemin/vers/your-service-account-key.json"
```

Ou créez un fichier `terraform.tfvars` en réutilisant le template :

```bash
cp terraform.tfvars.example terraform.tfvars
```

Éditez `terraform.tfvars` avec vos valeurs :

```hcl
project_id = "your-gcp-project-id"
region     = "europe-west1"
# Ajouter d'autres variables selon votre configuration
```

### 3. Initialiser Terraform

```bash
terraform init
```

## 📖 Utilisation

### Valider la configuration

```bash
terraform validate
```

### Afficher le plan d'exécution

```bash
terraform plan
```

### Appliquer la configuration

```bash
terraform apply
```

### Destructurer l'infrastructure

```bash
terraform destroy
```

## 📁 Structure du projet

- `main.tf` - Configuration principale des ressources
- `variables.tf` - Déclaration des variables
- `terraform.tfvars` - Valeurs des variables (à créer localement)
- `terraform.tfvars.example` - Template des variables
- `outputs.tf` - Valeurs en sortie
- `provider.tf` - Configuration du provider Google Cloud

## 🔐 Sécurité

**Important** : Ne jamais commiter les fichiers sensibles suivants :

- `terraform.tfvars` (contient vos secrets)
- Clés de service GCP (`*.json`)
- État Terraform (`*.tfstate`)

Consultez `.gitignore` pour la liste complète.

## 🚀 Déploiement

1. Vérifiez votre plan : `terraform plan`
2. Appliquez les changements : `terraform apply`
3. Consultez les outputs : `terraform output`

## 📊 Outputs

Les ressources créées sont disponibles via :

```bash
terraform output
```

Consultez `outputs.tf` pour les valeurs exportées.

## 🤝 Contribution

Les modifications doivent être testées en local avant le commit.

## 📝 License

À définir

## 📧 Support

Pour toute question, veuillez ouvrir une issue.
