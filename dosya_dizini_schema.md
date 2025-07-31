aws-terraform-project/
├── modules/
│   ├── shared-secret/          # Secrets Manager modülü (multi-region)
│   ├── dynamodb_table/         # DynamoDB tablosu modülü
│   └── eks_cluster/            # EKS cluster ve node grupları modülü (varsa)
├── k8s/                       # Kubernetes deployment, service, ingress manifestleri
├── lambda/                    # Lambda fonksiyon kaynak kodları ve paketleri
│   ├── geo-redirect-src/
│   ├── geo-redirect.zip
│   ├── whatsapp-alert-src/
│   └── whatsapp-alert.zip
├── scripts/                   # Otomasyon ve paketleme scriptleri
│   ├── package-lambda.sh
│   └── git-auto-push.sh
├── .github/
│   └── workflows/             # GitHub Actions CI/CD pipeline tanımları
│       └── deploy.yml
├── main.tf                   # Ana terraform konfigürasyonu (kaynaklar, modül çağrıları)
├── variables.tf              # Değişken tanımları
├── outputs.tf                # Çıktılar
├── provider.tf               # AWS provider konfigürasyonu
├── dev.tfvars                # Development ortamı için değişken değerleri
├── test.tfvars               # Test ortamı için değişken değerleri
├── prod.tfvars               # Prod ortamı için değişken değerleri
└── README.md                 # Proje genel bilgileri ve kullanım kılavuzu
