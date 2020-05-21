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
  3) Deploy Amazon EKS Service
      * Note: Cluster will be Manually Initialized

Step 2: Build Out Jenkins Pipeline
  1) Construct pipeline in GitHub Capstone Repo
  2) Ensure pipeline does the following:
      * Lints Python and Dockerfile
      * Deploys Docker Image to Amazon EKS

You can find a detailed [project rubric, here](https://review.udacity.com/#!/rubrics/2577/view).

**The Final Implementation of this Capstone Project will Showcase Your Abilities to Perform DevOps in the Cloud.**

---

## Seting up the Environment

* Create the virtualenv `python3 -m venv /.devops` and activate it `source ~/.devops/bin/activate`  
* Run `make install` to install the necessary dependencies into the venv

### Running Flask Application `app.py`

1. Standalone:  `python app.py`
2. Run in Docker:  `./run_docker.sh`
3. Run in Kubernetes:  `./run_kubernetes.sh`

### Kubernetes Steps

* Setup and Configure Docker locally
  * [Docker Desktop](https://www.docker.com/products/docker-desktop)
  * Use Native Bash or [Git Bash](https://www.techoism.com/how-to-install-git-bash-on-windows/) for Windows to work with Docker CLI
* Setup and Configure Kubernetes locally
* Create Flask app in Container
* Run via kubectl

---

### Repo File Documentation

* **.circleci** - Folder for the CircleCI **config.yml** for Continuously Integratation with Each Build
* **model_data** - Folder for the modeling data (_housing.csv_) and library for the predictor (_boston_housing_prediction.joblib_)
* **output_txt_files** - Folder for the Docker (_docker_out.txt_) and Kubernetes (_kubernetes_out.txt_) log outputs
* **.gitignore** - Tells Git to Ignore Specific Files/Folders for Python
* **Dockerfile** - Used to Setup/Build Docker Image
  * Setting _app_ as Working Directory
  * Copying _app.py_ to Working Directory
  * Install/Upgrade PIP and Other Requirements Into Image
  * Expose Port 80 and Launch _app.py_ Flask Application
* **LICENSE** - License file for the Project
* **Makefile** - A series of directives for Build Automation of the Dockerfile Image
  * Creating Python3 Virtual Environment
  * Install/Upgrade PIP and Other Requirements
  * Linting Python (pylint) and Dockerfile (hadolint)
* **README.md** - Your Helpful Guide to this Crazy Project's Purpose
* **app.py** - Flask Application to Predict Home Pricing
* **make_prediction.sh** - Shell to Call Flask Application and Get Prediction
* **requirements.txt** - List of Libraries to Install via _Dockerfile_ and _Makefile_
* **run_docker.sh** - Shell to Run Docker Image and Assign Host Port 8000 to Container's Port 80
* **run_kubernetes.sh** - Shell to Run Docker Hub Container with Kubernetes and Show Log Details
* **upload_docker.sh** - Shell to Upload Docker Local Image to Docker Hub
  * Note: It asks you to authenticate with my username. This will need to be changed to your Docker Hub account

