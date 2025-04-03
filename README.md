
# 🚀 AWS DevOps & GitOps Projesi

## 👨‍💻 Hakkımda

Ben Orhan Yardım. Bu proje, AWS üzerinde modern bir DevOps altyapısı kurmak ve GitOps yaklaşımı ile uygulama dağıtımı gerçekleştirmek amacıyla bireysel olarak yürüttüğüm bir çalışmadır. Proje boyunca sıfırdan öğrenerek adım adım ilerledim, altyapıyı Terraform ile kodladım ve AWS üzerinde EKS, RDS, Secrets Manager gibi servislerle entegre etmeyi hedefledim.

---

## 🎯 Proje Amacı

- AWS üzerinde **tamamen kodla tanımlanmış** bir Kubernetes altyapısı kurmak
- ArgoCD kullanarak **GitOps tabanlı uygulama dağıtımı** yapmak
- RDS ve Secrets Manager entegrasyonu ile **güvenli ve sürdürülebilir veri yönetimi** sağlamak
- HPA ve CloudWatch ile **ölçeklenebilirlik** ve **izlenebilirlik** mekanizmaları kurmak

---

## 🔧 Kullanılan Teknolojiler

| Araç | Açıklama |
|------|----------|
| Terraform | AWS altyapısını kodla oluşturmak için |
| AWS EKS | Kubernetes ortamı sağlamak için |
| ArgoCD | GitOps continuous delivery için |
| AWS RDS | Veritabanı çözümü olarak |
| AWS Secrets Manager | Güvenli şifre/anahtar yönetimi için |
| HPA | Otomatik yatay pod ölçekleme için |
| CloudWatch | İzleme ve log toplama için |
| GitHub | Kod ve konfigürasyon yönetimi için |
| kubectl & Helm | Kubernetes yönetimi ve ArgoCD kurulumu için |

---

## 📂 Proje Dosya Yapısı

```bash
aws-devops/
├── main.tf                 # VPC, EKS, subnet ve nodegroup tanımları
├── eks-node-group.tf       # Worker node role ve node group
├── variables.tf            # Terraform değişkenleri
├── outputs.tf              # Çıktılar
├── rds.tf                  # RDS veritabanı tanımı (oluşturulmadı)
├── secret.tf               # AWS Secrets Manager tanımı (oluşturulmadı)
├── aws-auth.yaml           # Node erişimi için ConfigMap
├── app.yaml                # ArgoCD Application CRD (guestbook)
├── README.md               # Bu dökümantasyon
```

---

## 🚧 Yapılanlar ve Durum

### ✅ 1. AWS Altyapı Kurulumu (Terraform ile)

- [x] `main.tf` içerisinde:
  - VPC oluşturuldu
  - 2 adet private subnet tanımlandı (farklı AZ'lerde)
- [x] `eks-node-group.tf` içerisinde:
  - IAM rol ve policy eklendi
  - Worker node grubu başarıyla oluşturuldu
- [x] `terraform apply` başarıyla tamamlandı
- [x] `kubectl get nodes` ile bağlantı kuruldu, worker node'lar eklendi

### ✅ 2. ArgoCD Kurulumu

- [x] `helm` yüklendi
- [x] `kubectl create namespace argocd` ile namespace oluşturuldu
- [x] `helm install` komutu ile ArgoCD başarıyla kuruldu
- [x] `kubectl port-forward` ile GUI erişimi sağlandı
- [x] Admin şifresi `argocd-secret` ile alındı

### 🟡 3. ArgoCD Üzerinden Uygulama Deploy

- [x] `app.yaml` dosyası yazıldı (guestbook app)
- [ ] ArgoCD GUI üzerinden senkronizasyon tamamlanamadı
- [ ] `kubectl get applications` ile uygulama başarıyla izlenemedi
- ⚠️ Uygulama pod'ları çalışmadığı için `kubectl get nodes` sonrası yük testleri yapılamadı

### 🟡 4. RDS (Amazon Relational Database Service)

- [x] `rds.tf` dosyası Terraform ile yazıldı
- [ ] `terraform apply` uygulanamadı (zaman kısıtlaması)
- [ ] Veritabanı bağlantı ayarları yapılandırılmadı
- ➕ Gelecekte uygulama ile bağlantısı Secrets Manager üzerinden yapılabilir

### 🟡 5. AWS Secrets Manager

- [x] `secret.tf` dosyası oluşturuldu
- [ ] `terraform apply` çalıştırılmadı
- ➕ RDS veritabanı şifresi gibi bilgileri güvenli saklamak için yapı planlandı

### 🔲 6. Horizontal Pod Autoscaler (HPA)

- [ ] `kubectl autoscale` ile HPA tanımı yapılamadı (uygulama pod'ları eksik)
- ➕ Uygulama deploy edildikten sonra `guestbook-ui` gibi servislere kolayca eklenebilir

### 🔲 7. AWS CloudWatch

- [ ] EKS cluster log’ları veya uygulama metrikleri CloudWatch’a gönderilmedi
- ➕ Kubernetes loglarını izlemek için container loglarını `stdout/stderr` üzerinden forward etmek planlanabilir

---

## ⚠️ Karşılaşılan Sorunlar ve Çözümler

| Sorun | Çözüm |
|-------|-------|
| NodeGroup EC2 instance'ları cluster’a bağlanmadı | `aws-auth.yaml` ile manuel role binding yapıldı |
| Helm tanınmadı | Chocolatey ile Helm yüklendi |
| RDS için subnet hatası alındı | VPC private subnet'leri eksiksiz tanımlandı |
| Guestbook app senkronize olmadı | ArgoCD `Application` tanımı kontrol edildi ama uygulama pod'ları oluşmadı |

---

## 🔍 Nasıl Kullanılır?

```bash
# Terraform komutları
terraform init
terraform apply -auto-approve

# ArgoCD erişimi
kubectl port-forward svc/argocd-server -n argocd 8080:443

# Erişim
https://localhost:8080
Kullanıcı: admin
Şifre: (kubectl ile alınır)
```

---

## 📸 Teslimat İçeriği

- `kubectl get nodes` çıktısı (worker node'lar bağlı)
- `kubectl get pods -n argocd` (ArgoCD pod’ları running)
- `app.yaml` içeriği (guestbook app)
- `terraform` kodları (EKS, VPC, IAM, nodegroup, subnet)
- `README.md` (detaylı dokümantasyon)

---

## 🧩 Devam Planı (Zaman kısıtı nedeniyle eklenemeyenler)

- [ ] `terraform apply` ile RDS ve Secrets Manager'ı canlıya almak
- [ ] Uygulamanın eksiksiz deploy edilmesini sağlamak
- [ ] HPA ile autoscaler yapılandırmak
- [ ] CloudWatch ile loglama ve alarm sistemi kurmak
- [ ] CI/CD pipeline ile uygulama güncellemelerini otomatikleştirmek

---

## 👋 Kapanış

Bu proje sürecinde AWS altyapısını tanıdım, Terraform ile tam kontrol sağladım ve GitOps yaklaşımıyla sürekli dağıtım mantığını uygulamaya geçirmeye başladım. Bazı adımlar tamamlanamadıysa da tüm yapı tasarlanmış ve belgelenmiştir. Bu süreç, DevOps yolculuğumun önemli bir adımı oldu.

**Orhan Yardım**  
📁 GitHub: [https://github.com/orhanyardim/aws-devops](https://github.com/orhanyardim/aws-devops)
