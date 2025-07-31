#!/bin/bash
set -e

WORKFLOW_FILE=".github/workflows/deploy.yml"

if [ ! -f "$WORKFLOW_FILE" ]; then
  echo "❌ HATA: $WORKFLOW_FILE bulunamadı. Terraform apply çalıştı mı?"
  exit 1
fi

if git diff --quiet "$WORKFLOW_FILE"; then
  echo "✅ $WORKFLOW_FILE dosyasında değişiklik yok. Push gerekli değil."
  exit 0
fi

echo "🔄 GitHub Actions workflow değişti. Commit ve push ediliyor..."
git add "$WORKFLOW_FILE"
git commit -m "🔁 Update GitHub Actions workflow (auto from Terraform)"
git push origin "$(git rev-parse --abbrev-ref HEAD)"
echo "✅ Push işlemi tamamlandı."
