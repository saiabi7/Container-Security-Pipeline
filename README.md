
# Container Image Vulnerability Scanning

This repository implements a robust Container Security Pipeline that automates the security validation of Docker images. As containers become an almost ubiquitous method of packaging and deploying applications, the instances of malware have increased. Securing containers is now a top priority for DevOps engineers. Fortunately, a number of open source programs are available that scan containers and container images.Built using Jenkins, this project ensures a seamless integration of DevSecOps principles into the container lifecycle, enhancing security and reliability across deployments.

## What can Container Security Scanning do?

- Detect insecure containers
- Detect outdated libraries
- Detect incorrectly configured containers
- Detect outdated operating system
- Detect compliance validations
- Suggest best 

## Trivy

Trivy is an open-source vulnerability scanner specifically designed for containers. It is a lightweight and easy-to-use tool that helps identify vulnerabilities in container images and filesystems. Trivy focuses on scanning container images for known vulnerabilities in the installed packages and libraries.

To install Trivy, follow these steps based on your operating system:

```http
  curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | sudo sh -s -- -b /usr/local/bin
```

Move the extracted trivy binary to a directory in your system's $PATH:

```http
  sudo mv trivy_1.9.2/trivy /usr/local/bin/
```

OR 
```http
  snap install trivy
```

If trivy has to grant permission to access the user's specific directory eg. home

```http
  snap connect trivy:home
```

Test the installation by running:

```http
  trivy version
```

## Hadolint
To install Hadolint, Please pull its official docker image:

```http
  docker pull hadolint/hadolint:latest
```

## Jenkins Pipeline Integration
The pipeline script is saved in the file jenkins-pipeline-script.sh. This script defines the steps for building and securing Docker images. It outputs detailed logs for each stage, providing insights into the security checks and their results.
