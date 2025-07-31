# AWS EKS Güvenli Çok Bölge Terraform Projesi

## Genel Bakış

Bu proje, AWS üzerinde güvenli, ölçeklenebilir ve coğrafi farkındalıklı 3 katmanlı mimariyi aşağıdaki servisleri kullanarak dağıtır:

- Amazon EKS (Kubernetes Kümesi)  
- Amazon ECR (Docker Container Registry)  
- Amazon DynamoDB (NoSQL Veri Tabanı)  
- AWS Secrets Manager (Çoklu bölge gizli yönetimi)  
- Amazon CloudFront + ACM + Route53 (CDN, HTTPS, Geo DNS)  
- AWS Lambda@Edge (Coğrafi tabanlı yönlendirme ve güvenlik)  
- AWS WAF (Web Uygulama Güvenlik Duvarı)  
- Amazon CloudWatch + SNS (İzleme ve uyarılar)  
- GitHub Actions (CI/CD Süreci)

---

## Dizin Yapısı

- `modules/`: Yeniden kullanılabilir Terraform modülleri (Secrets Manager, DynamoDB vb.)  
- `.github/workflows/`: GitHub Actions workflow tanımları  
- `k8s/`: Kubernetes manifestleri (Deployment, Service, HPA ve Ingress içeren tek YAML dosyası)  
- `lambda/`: Lambda fonksiyon kaynak kodları ve paketleri  
- `scripts/`: Otomasyon için yardımcı scriptler  
- Temel Terraform dosyaları (`main.tf`, `variables.tf`, `outputs.tf`, `provider.tf`)

---

## Kubernetes Manifestleri

Deployment, Service, Horizontal Pod Autoscaler (HPA) ve Ingress dahil tüm Kubernetes kaynakları, `k8s/deployment.yaml` dosyasında **tek bir dosya** halinde tanımlanmıştır. Bu, küçük ve orta ölçekli projeler için dağıtımı ve yönetimi basitleştirir.  

Daha büyük projelerde, bu kaynakları ayrı dosyalara bölmek (örneğin `deployment.yaml`, `service.yaml`, `ingress.yaml`, `hpa.yaml`) bakımı kolaylaştırır.

---

## Başlarken

1. **Gereksinimler**  
   - AWS CLI kurulu ve yapılandırılmış olmalı  
   - Terraform (v1.0 veya üzeri) kurulu olmalı  
   - Gerekli GitHub repository secret’ları oluşturulmalı:  
     - `AWS_ROLE_ARN`  
     - `ECR_REPO`  
     - `AWS_REGION`  
     - `SLACK_WEBHOOK_URL`  
     - `TWILIO_ACCOUNT_SID`  
     - `TWILIO_AUTH_TOKEN`  
     - ve gerektiği kadar diğerleri  

2. **Terraform Dağıtımı**  
   - Terraform’u başlatın:  
     ```bash
     terraform init
     ```  
   - Hedef ortam için Terraform’u uygulayın (dev/test/prod):  
     ```bash
     terraform apply -var-file="dev.tfvars"
     ```  
   - Bu, tüm AWS kaynaklarını oluşturacak ve altyapıyı dağıtacaktır.

3. **CI/CD Süreci**  
   - GitHub üzerinde `dev`, `test` ve `main` branch’lerine push yapıldığında GitHub Actions şunları yapar:  
     - Docker imajlarını ECR’ye derleyip gönderir  
     - Güncellenen manifestleri EKS’e dağıtır  
     - Hata durumunda rollback yapar  

4. **Gizli Bilgi Yönetimi**  
   - Twilio tokenları, Slack webhook URL’leri gibi gizli bilgiler AWS Secrets Manager üzerinden çoklu bölgede merkezi olarak yönetilir.

5. **DNS ve Coğrafi Yönlendirme**  
   - Route53 Geo DNS ve Lambda@Edge ile bölge bazlı trafik yönlendirmesi sağlanır.

6. **İzleme ve Uyarılar**  
   - CloudWatch kritik metrikleri ve faturalandırma eşiklerini izler.  
   - SNS ile e-posta, Slack ve WhatsApp (Lambda üzerinden) bildirimleri gönderilir.

---

## Güvenlik Hususları

- **Minimum yetki prensibine uygun IAM roller** kullanılır.  
- **VPC Endpoint’leri** DynamoDB’ye erişimi sınırlar.  
- **WAF** SQL Injection gibi yaygın web saldırılarını engeller.  
- **IP beyaz listesi ve zaman kısıtlamaları** ile çalışma saatleri dışındaki erişim kısıtlanır.

---

## Klasör Özeti

- **modules/**: Gizli bilgi yönetimi ve DynamoDB tablosu oluşturma modülleri  
- **lambda/**: Geo yönlendirme ve WhatsApp uyarı Lambda fonksiyonları  
- **k8s/**: Kubernetes deployment manifestleri (tek YAML dosyası)  
- **.github/workflows/**: GitHub Actions CI/CD workflow dosyaları  
- **scripts/**: Otomasyon için yardımcı scriptler  

---

## Terraform Backend Yapılandırması ve State Yönetimi

Çoklu ortamları izole state yönetimi ile desteklemek için proje içine **backend konfigürasyon dosyaları** eklenmiştir:

- `backend-dev.tfvars`  
- `backend-test.tfvars`  
- `backend-prod.tfvars`

Bu dosyalar, Terraform state dosyalarının uzak AWS S3 bucket’larda saklanmasını ve DynamoDB tabloları ile state kilitlemeyi sağlar.

## Terraform Dağıtımı

Hedef ortam için backend konfigürasyon dosyasını belirterek Terraform’u başlatın:

```bash
terraform init -backend-config=backend-dev.tfvars
```
## Hedef ortam için Terraform’u uygulayın (dev/test/prod):

Bu projede dev ve test ortamları otomatik olarak dağıtılır. Yalnızca prod ortam manuel uygulanmalıdır.

```bash
terraform apply -var-file="prod.tfvars"
```
Bu işlem tüm AWS kaynaklarını oluşturacak ve altyapıyı kuracaktır.

## İletişim

Sorularınız veya destek için lütfen iletişime geçin: y.duymac@gmail.com