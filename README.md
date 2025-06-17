   
# 🚀 DevSecOps CI/CD Pipeline Project

This project demonstrates a practical implementation of a DevSecOps pipeline with end-to-end automation, security integration, and GitOps deployment, based on tools like **Jenkins**, **SonarQube**, **Docker**, **EC2**, and **ArgoCD**.

---

## 📌 Project Architecture (Based on Implementation)
![diagram-export-6-16-2025-5_05_08-PM](https://github.com/user-attachments/assets/e208754d-8ed9-4f40-929d-8661eb041a1e)

---

## 🛠 Tools Used

| Tool        | Purpose                                 |
|-------------|------------------------------------------|
| **GitHub**  | Stores source code & triggers Jenkins    |
| **Jenkins** | Automates build, analysis & deployment   |
| **SonarQube** | Performs static code analysis           |
| **Docker**  | Containerizes the application            |
| **Github**     | Code Repository                       |
| **ArgoCD**  | GitOps-based K8s deployment              |
| **Terraform**| Creation of EC2 instance                |
---

## 📷 Screenshots Summary

1. **Jenkins Pipeline View**  
   Shows multiple pipeline stages: `Checkout`, `Build`, `SonarQube Analysis`, `Docker Build`, `Push`, `ArgoCD Trigger`.

2. **Dockerfile**  
   Contains steps to containerize the app, e.g., using `node:alpine`, copying source code, installing dependencies, and exposing ports.

3. **SonarQube Integration**  
   Jenkins triggers static code analysis, and a **SonarQube webhook** notifies Jenkins once analysis is complete.

4. **EC2 Instance**  
   AWS EC2 Ubuntu instance is used to host Jenkins, Docker, and SonarQube—all configured and running.

5. **ArgoCD GUI**  
   ArgoCD pulls the latest changes from the GitOps repo and deploys the Docker image to the Kubernetes cluster.

---

## ⚙️ Jenkins Pipeline Flow

### 📄 `Jenkinsfile` (based on pipeline shown in screenshots)

```groovy
pipeline {
    agent any

    stages {
        stage('Checkout Code') {
            steps {
                git 'https://github.com/your-username/your-repo.git'
            }
        }

        stage('Build') {
            steps {
                sh 'npm install'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('My SonarQube') {
                    sh 'sonar-scanner'
                }
            }
        }

        stage('Docker Build') {
            steps {
                sh 'docker build -t your-image-name .'
            }
        }

        stage('Docker Push') {
            steps {
                withCredentials([string(credentialsId: 'dockerhub-pass', variable: 'PASS')]) {
                    sh 'echo $PASS | docker login -u your-user --password-stdin'
                    sh 'docker push your-image-name'
                }
            }
        }

        stage('Deploy to Kubernetes via ArgoCD') {
            steps {
                sh 'kubectl apply -f deployment.yaml'
            }
        }
    }
}
```

---

## 📦 Dockerfile (from screenshot)

```dockerfile
FROM node:alpine

WORKDIR /app

COPY . .

RUN npm install

EXPOSE 3000

CMD ["npm", "start"]
```

---

## 🧪 Static Code Analysis (SonarQube)

- **Scanner Configured in Jenkins**
- **Webhook setup in SonarQube** to notify Jenkins after analysis
- Shows code smells, bugs, duplications, and maintains code quality gate

---

## 🚀 Deployment (via ArgoCD)

- **ArgoCD GUI** confirms successful deployment
- It continuously syncs with the GitOps repository
- Pulls latest image version from DockerHub
- Updates application on Kubernetes cluster

---

## ✅ Output

- Fully automated build-test-analyze-deploy pipeline
- Integrated static security scanning
- GitOps-driven Kubernetes deployment
- Hosted entirely on EC2 instance with open-source DevSecOps tools

---

## 📁 Directory Structure

```bash
.
├── Dockerfile
├── Jenkinsfile
├── deployment/
│   ├── deployment.yaml
│   └── service.yaml
├── sonar-project.properties
└── src/
```

---

## 📌 Notes

- Use **ngrok or webhook.site** to test SonarQube → Jenkins webhooks
- Ensure EC2 has proper security group rules for port 8080 (Jenkins), 9000 (SonarQube), etc.
- Docker & Kubernetes must be properly configured on EC2 or use EKS for production-level setup

---

## ✍️ Author

Lovish Barber

---
