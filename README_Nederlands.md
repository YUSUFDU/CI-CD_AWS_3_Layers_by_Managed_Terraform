# AWS EKS Secure Multi-Region Terraform Project

## Overzicht

Dit project implementeert een veilige, schaalbare en geo-bewuste 3-tier architectuur op AWS met de volgende services:

- Amazon EKS (Kubernetes Cluster)  
- Amazon ECR (Docker Container Registry)  
- Amazon DynamoDB (NoSQL Database)  
- AWS Secrets Manager (Multi-region secrets)  
- Amazon CloudFront + ACM + Route53 (CDN, HTTPS, Geo DNS)  
- AWS Lambda@Edge (Geo-gebaseerde redirect en beveiliging)  
- AWS WAF (Web Application Firewall)  
- Amazon CloudWatch + SNS (Monitoring en alerts)  
- GitHub Actions (CI/CD Pipeline)

---

## Mappenstructuur

- `modules/`: Herbruikbare Terraform modules (Secrets Manager, DynamoDB, etc.)  
- `.github/workflows/`: GitHub Actions workflow definities  
- `k8s/`: Kubernetes manifests (één YAML bestand met Deployment, Service, HPA en Ingress)  
- `lambda/`: Broncode en verpakte Lambda functies  
- `scripts/`: Hulpscripts voor automatisering  
- Kern Terraform bestanden (`main.tf`, `variables.tf`, `outputs.tf`, `provider.tf`)

---

## Kubernetes Manifests

Alle Kubernetes resources, inclusief Deployment, Service, Horizontal Pod Autoscaler (HPA) en Ingress, zijn gedefinieerd in een **enkel bestand** genaamd `k8s/deployment.yaml`. Dit vereenvoudigt deployment en beheer voor kleine tot middelgrote projecten.  

Voor grotere projecten wordt aanbevolen deze resources op te splitsen in losse bestanden (bijv. `deployment.yaml`, `service.yaml`, `ingress.yaml`, `hpa.yaml`) om onderhoudbaarheid te verbeteren.

---

## Aan de slag

1. **Vereisten**  
   - Installeer AWS CLI en configureer credentials  
   - Installeer Terraform (v1.0 of hoger)  
   - Maak vereiste GitHub repository secrets aan:  
     - `AWS_ROLE_ARN`  
     - `ECR_REPO`  
     - `AWS_REGION`  
     - `SLACK_WEBHOOK_URL`  
     - `TWILIO_ACCOUNT_SID`  
     - `TWILIO_AUTH_TOKEN`  
     - en andere indien nodig  

2. **Terraform Deployment**  
   - Initialiseer Terraform:  
     ```bash
     terraform init
     ```  
   - Voer Terraform uit voor de gewenste omgeving (dev/test/prod):  
     ```bash
     terraform apply -var-file="dev.tfvars"
     ```  
   - Dit zal alle AWS resources provisionen en de infrastructuur uitrollen.

3. **CI/CD Pipeline**  
   - Bij pushes naar GitHub branches (`dev`, `test`, `main`), zal GitHub Actions:  
     - Docker images bouwen en pushen naar ECR  
     - Geüpdatete manifests uitrollen naar EKS  
     - Rollback uitvoeren bij falen  

4. **Secrets Management**  
   - Secrets (zoals Twilio tokens, Slack webhook URLs, etc.) worden centraal beheerd via AWS Secrets Manager in meerdere regio's.

5. **DNS en Geo-routing**  
   - Route53 met Geo DNS en Lambda@Edge zorgen voor regio-specifieke routing.

6. **Monitoring & Alerts**  
   - CloudWatch monitort belangrijke metrics en factureringsdrempels.  
   - SNS topics sturen alerts via e-mail, Slack en WhatsApp (via Lambda).

---

## Beveiligingsoverwegingen

- **Least privilege IAM-rollen** worden overal gebruikt.  
- **VPC Endpoints** beperken netwerktoegang tot DynamoDB.  
- **WAF** blokkeert veelvoorkomende webaanvallen zoals SQL-injectie.  
- **IP-whitelisting en tijdschema-beperkingen** beperken toegang buiten werktijden.

---

## Mapoverzicht

- **modules/**: Bevat herbruikbare Terraform modules voor secret management en DynamoDB tabel creatie.  
- **lambda/**: Bevat broncode en verpakte Lambda functies voor geo-redirect en WhatsApp alerts.  
- **k8s/**: Kubernetes deployment manifests (één YAML-bestand met gecombineerde resources).  
- **.github/workflows/**: GitHub Actions CI/CD workflow definities.  
- **scripts/**: Hulpscripts voor het automatiseren van git push van workflowbestanden.  

---

## Terraform Backend Configuratie en State Management

Om meerdere omgevingen met geïsoleerd state management te ondersteunen, zijn er **backend configuratiebestanden** toegevoegd aan het project:

- `backend-dev.tfvars`  
- `backend-test.tfvars`  
- `backend-prod.tfvars`

Deze bestanden configureren remote Terraform state opslag met **AWS S3 buckets** voor de state bestanden en **DynamoDB tabellen** voor state locking en consistentie.

## Terraform Deployment

Initialiseer Terraform met backend configuratie voor de gewenste omgeving:

```bash
terraform init -backend-config=backend-dev.tfvars
```

## Voer Terraform uit voor de gewenste omgeving (dev/test/prod):

In dit project worden dev en test omgevingen automatisch uitgerold. Alleen de prod omgeving moet handmatig uitgerold worden.
```bash
terraform apply -var-file="prod.tfvars"
```
Dit zal alle AWS resources provisionen en de infrastructuur uitrollen.

## Contact

Voor vragen of ondersteuning, neem contact op met: y.duymac@gmail.com
