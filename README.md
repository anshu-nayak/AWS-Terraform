# AWS S3 Static Website with Terraform & Jenkins CI/CD

## 📌 Overview
This project sets up:
- An **S3 static website** hosted on AWS.
- Terraform code to manage infrastructure.
- Jenkins CI/CD pipeline to deploy website code automatically.

---

## 📂 Repository Structure
- **AWS-Terraform/** → Infrastructure as Code (Terraform)
- **AWS-S3-Web_app/** → Website source code + Jenkinsfile

---

## ⚙️ Environment Setup on Amazon Linux 2023 (AL2)

### 1️⃣ Install System Packages
```bash
sudo dnf update -y
sudo dnf install git wget unzip -y
```

### 2️⃣ Install AWS CLI
```bash
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
aws --version
```

### 3️⃣ Configure AWS CLI
```bash
aws configure
# Provide AWS Access Key, Secret Key, Region (ap-south-1)
```

### 4️⃣ Install Terraform
```bash
TERRAFORM_VERSION="1.9.5"
wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip
sudo mv terraform /usr/local/bin/
terraform -version
```

### 5️⃣ Install OpenJDK (for Jenkins)
```bash
sudo dnf install java-17-amazon-corretto -y
java -version
```

### 6️⃣ Install Jenkins
```bash
sudo wget -O /etc/yum.repos.d/jenkins.repo     https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
sudo dnf install jenkins -y
sudo systemctl enable jenkins
sudo systemctl start jenkins
sudo systemctl status jenkins
```

### 7️⃣ Access Jenkins
- Open your browser → `http://<EC2-Public-IP>:8080`
- Get initial admin password:
```bash
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```

- Install suggested plugins, set up an admin user.

---

## ⚙️ Infrastructure Setup (Terraform)

### In `AWS-Terraform/`
1. Clone the repo:
   ```bash
   git clone https://github.com/anshu-nayak/AWS-Terraform.git
   cd AWS-Terraform
   ```

2. Initialize Terraform:
   ```bash
   terraform init
   terraform plan -out=tfplan
   terraform apply -auto-approve tfplan
   ```

3. Note the website endpoint output.

---

## ⚙️ Website + Pipeline Setup

### In `AWS-S3-Web_app/`
1. Clone the repo:
   ```bash
   git clone https://github.com/anshu-nayak/AWS-S3-Web_app.git
   cd AWS-S3-Web_app
   ```

2. Jenkins will use the `Jenkinsfile` to:
   - Pull website repo & Terraform repo
   - Run `terraform apply`
   - Sync website code to S3 bucket

---

## 🌍 Access the Website
After pipeline runs, the site will be available at:
```
http://aws-project-website-code-bucket.s3-website-ap-south-1.amazonaws.com
```

---

## 🚀 CI/CD Flow
1. Developer pushes code → GitHub (`AWS-S3-Web_app`)
2. Jenkins job triggers
3. Terraform provisions infrastructure
4. Website files deployed to S3
5. Static site available via S3 endpoint

---

✅ Complete automated deployment with Terraform + Jenkins + AWS S3!
