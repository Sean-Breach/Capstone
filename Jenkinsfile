// Global Variable for Retaining a Constant Build ID
def buildID = ""
def ecrURI = ""
def ecrRepoName = "capstone-ecr"
def eksService = ""
def podHash = ""
def podName = ""

pipeline {
  agent any
  stages {
	stage('Setup Global Parameters'){
		steps {
			sh "echo 'Getting Timestamp'"
			script {
				buildID = sh 'echo date +%Y-%m-%dT%H.%M.%S'
			}
			sh "echo 'Build ID: $buildID'"
			//ecrURI = "aws ecr describe-repositories --output json | jq -r '.repositories[] | select(.repositoryName == \"$ecrRepoName\").repositoryUri'"
		}
	}
/*
	stage('Lint Application') {
		steps {
			sh "echo 'Performing Make Lint to Check Python and HTML'"
			sh "make lint"
		}
	}
	stage('Build Container') {
		steps {
			sh "echo 'Build Docker Image'"
			sh "docker build --tag=python_website ."
		}
	}
	stage('Security Scan') {
		steps {
			sh "echo 'Checking Security with Aqua MicroScanner'"
			aquaMicroscanner(imageName: "alpine:latest", notCompliesCmd: "exit 1", onDisallowed: "fail", outputFormat: "html")
		}
	}
	stage('Push Image') {
		steps {
			sh "echo 'Get Login Token for Pushing Docker Image to Amazon ECR'"
			sh "aws ecr get-login-password --region us-west-2 | docker login --username AWS --password-stdin $ecrID"
			sh "echo 'Get Docker Image ID'"
			sh "imageID=`docker images -q python_website`"
			sh "echo 'Tag Docker Image Before Pushing to Amazon ECR (Build ID: $buildID'"
			sh "docker tag `echo \$imageID` $ecrURI:$buildID"
			sh "echo 'Push Docker Image to Amazon ECR'"
			sh "docker push $ecrURI"
		}
	}
	stage('Setup EKS') {
		steps {
			sh "echo 'Get EKS kubeconfig'"
			sh "aws eks --region us-west-2 update-kubeconfig --name capstone-ekscluster"
			sh "echo 'EKS is Setup'"
		}
	}
	stage('Deploy container') {
		steps {
			sh "echo 'Check if Pod has Previously been Deployed'"
			podName = sh "kubectl get pods --output=json | jq -r '.items[] | select(.metadata.labels.run == \"$ecrRepoName\").metadata.labels.\"pod-template-hash\"'"
			script {
				if (podName.isEmpty()) {
					sh "echo 'No Pod Deployed. Deploying Now'"
					sh "kubectl run $ecrRepoName --image=$ecrURL:$buildID --replicas=1 --port=8080"
					podName = sh "kubectl get pods --output=json | jq -r '.items[] | select(.metadata.labels.run == \"$ecrRepoName\").metadata.labels.\"pod-template-hash\"'"
					podHash = sh "kubectl get pods --output=json | jq -r '.items[] | select(.metadata.labels.run == \"$ecrRepoName\").metadata.labels.\"pod-template-hash\"'"
				} else {
					sh "echo 'Previous Pod Deployment Found'"
					sh "echo 'Set New Image to Deployed Pod'"
					sh "kubectl set image deployment/$ecrRepoName $ecrRepoName=$ecrURL:$buildID"
					sh "echo 'Restart Pod to Update Image'"
					sh "kubectl rollout restart deployment/$ecrRepoName"
					sh "echo 'Get Pod's New Name and Hash'"
					podName = sh "kubectl get pods --output=json | jq -r '.items[] | select(.metadata.labels.run == \"$ecrRepoName\").metadata.labels.\"pod-template-hash\"'"
					podHash = sh "kubectl get pods --output=json | jq -r '.items[] | select(.metadata.labels.run == \"$ecrRepoName\").metadata.labels.\"pod-template-hash\"'"
				}
			}
			sh "ech 'Check if Pod Service has Previously been Deployed'"
			eksService = sh "kubectl get services --output=json | jq -r '.items[] | select(.metadata.name == \"capstone-server\").metadata.name'"
			script {
				if (ekService.isEmpty() && !podName.isEmpty()) {
					sh "echo 'Pod Service not Found. Setting up Service for Pod'"
					sh "kubectl expose pod $podName --port=8080 --target-port=80 --type="LoadBalancer" --name=capstone-server"
					eksService = sh "kubectl get services --output=json | jq -r '.items[] | select(.metadata.name == \"capstone-server\").metadata.name'"
				} else {
					sh "echo 'Pod Service Found. Patching with New Pod Hash'"
					sh "kubectl patch svc capstone-server -p '{\"metadata\": {\"labels\": {\"pod-template-hash\": \"$podHash\"}},\"spec\": {\"selector\": {\"pod-template-hash\": \"$podHash\"}}}'"
				}
			}
			sh "echo 'Deployment Complete'"
		}
	}
*/
  }
}
