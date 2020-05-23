# Capstone Project 

## Project Overview

In this project, I have applied the skills acquired in [Udacity's Cloud DevOps Engineer Program](https://www.udacity.com/course/cloud-dev-ops-nanodegree--nd9991) for the _Capstone_ Final Project. 

Taking a home-brewed Hello World Flask application (Written in Python), I've containerized with Docker, piped it with Jenkins, and deployed it to Amazon's Elastic Kubernetes Services (EKS).

### Project Tasks 

Step 1: Server Setup via CloudFormation
  1) Deploy a Jenkins Master Box
      * Include Blue Ocean and AWS Plugins
  2) Deploy an EC2 Ubuntu Server to Deploy Code
      * Clone GitHub Capstone Repo
      * Build Docker Image and Test Python Flask Locally
  3) Deploy Amazon EKS Service and Cluster

Step 2: Build Out Jenkins Pipeline
  1) Construct pipeline in GitHub Capstone Repo
  2) Ensure pipeline does the following:
      * Lints Python and Dockerfile
      * Scans Docker Image for Security
      * Deploys Docker Image to Amazon ECR
      * Sets Up / Exposes Kubernetes Pod to Port 8080
      * Creates / Updates Pod with Rolling Builds

You can find a detailed [project rubric, here](https://review.udacity.com/#!/rubrics/2577/view).

**The Final Implementation of this Capstone Project will Showcase Your Abilities to Perform DevOps in the Cloud.**

---

## Seting up the Environment

* Run the CloudFormation
* Build out the Jenkins Server
    * Add Blue Ocean and AWS Plugins
    * In Blue Ocean, Connect to GitHub Repo
    * Add AWS Credentials for CLI Access
    * Install PIP, PyLint, AWS CLI, and Kubectl Under Jenkins Account
* Build out the Dev Server
    * Install AWS CLI
    * Clone GitHub Repo
    * Build Virtual Environment
    * Validate / Test Code

### Running Flask Application `app.py`

1. Standalone:  `python web.py`
2. Run in Docker:  `./run_docker.sh`
3. Run in Kubernetes:  `./run_kubernetes.sh`

### Kubernetes Steps

* Setup and Configure Docker locally
  * [Docker Desktop](https://www.docker.com/products/docker-desktop)
  * Use Native Bash or [Git Bash](https://www.techoism.com/how-to-install-git-bash-on-windows/) for Windows to work with * * Let Jenkinsfile do the heavy lifting (As it will maintain the Kubernetes Cluster as you Build)

---

### Repo File Documentation

* **CloudFormation** - Folder for the CloudFormation template that builds out the EKS, Jenkins and Dev environments
* **Screenshots** - Folder with screenshots of a successful deployment, failing deployment and rolling deployment
* **Shell** - Folder for shell scripts to manually run setups
* **templates** - Folder for web.py's Flask webpage template
* **.gitignore** - Tells Git to Ignore Specific Files/Folders for Python
* **Dockerfile** - Used to Setup/Build Docker Image
* **Jenkinsfile** - Jenkins Pipeline file that performs CI/CD from check-ins on GitHub to Amazon ECR and EKS
* **LICENSE** - License file for the Project
* **Makefile** - A series of directives for Build Automation of the Dockerfile Image
* **README.md** - Your Helpful Guide to this Crazy Project's Purpose
* **requirements.txt** - List of Libraries to Install via _Dockerfile_ and _Makefile_
* **web.py** - Flask Application that renders a webpage template, passing in a message to be displayed

