// Global Variable for Retaining a Constant Build ID
def buildID = ""
def dockerImageID = ""
def ecrURI = ""
def ecrRepoName = "capstone-ecr"
def eksService = ""
def podHash = ""
def podName = ""
def serviceAddress = ""

pipeline {
  agent any
  stages {
	stage('Setup Global Parameters'){
		steps {
			sh "echo 'Getting Timestamp'"
			script {
				buildID = sh(script: 'echo `date +%Y-%m-%dT%H.%M.%S`', returnStdout: true).trim()
				ecrURI = sh(script: "aws ecr describe-repositories --output json | jq -r '.repositories[] | select(.repositoryName == \"$ecrRepoName\").repositoryUri'", returnStdout: true).trim()
			}
			sh "echo 'Build ID: $buildID, ECR URI: $ecrURI'"					
		}
	}
	stage('Lint Repo') {
		steps {
			sh "echo 'Performing Hadolint on Dockerfile'"
			sh "hadolint Dockerfile"
			sh "echo 'Performing Python Lint on web.py'"
			sh "pylint --disable=R,C,W1203 ./web.py"
		}
	}
	stage('Build Image') {
		steps {
			sh "echo 'Build Docker Image'"
			sh "docker build --tag=python_website ."
		}
	}

	stage('Image Security Scan') {
		steps {
			sh "echo 'Checking Security with Aqua MicroScanner'"
			aquaMicroscanner(imageName: "alpine:latest", notCompliesCmd: "exit 1", onDisallowed: "fail", outputFormat: "html")
		}
	}
	stage('Push Image to Amazon ECR') {
		steps {
			sh "echo 'Get Login Token for Pushing Docker Image to Amazon ECR'"
			sh "aws ecr get-login-password --region us-west-2 | docker login --username AWS --password-stdin $ecrURI"
			sh "echo 'Get Docker Image ID'"
			script {
				dockerImageID = sh(script: 'echo `docker images -q python_website`', returnStdout: true).trim()
			}
			sh "echo 'Tag Docker Image Before Pushing to Amazon ECR (Build ID: $buildID, Image ID: $dockerImageID)'"
			sh "docker tag `echo $dockerImageID` `echo $ecrURI`:`echo $buildID`"
			sh "echo 'Push Docker Image to Amazon ECR'"
			sh "docker push $ecrURI"
		}
	}

	stage('Setup EKS Cluster Connection') {
		steps {
			sh "echo 'Get EKS kubeconfig'"
			sh "aws eks --region us-west-2 update-kubeconfig --name capstone-ekscluster"
			sh "echo 'EKS is Setup'"
		}
	}
	stage('Deploy Amazon ECR to Kubernetes Cluster') {
		steps {
			script {
				sh "echo 'Check if Pod has Previously been Deployed'"
				script {
					podName = sh(script: "~/bin/kubectl get pods --output=json | jq -r '.items[0] | select(.metadata.labels.run == \"$ecrRepoName\").metadata.name'", returnStdout: true).trim()
				}
				if (podName.isEmpty()) {
					sh "echo 'No Pod Found, Deploying Now'"
					sh "~/bin/kubectl run `echo $ecrRepoName` --image=`echo $ecrURI`:`echo $buildID` --replicas=1 --port=8080"
					script {
						sh "echo 'Getting Pod Name and Hash'"
						podName = sh(script: "~/bin/kubectl get pods --output=json | jq -r '.items[0] | select(.metadata.labels.run == \"$ecrRepoName\").metadata.name'", returnStdout: true).trim()
						podHash = sh(script: "~/bin/kubectl get pods --output=json | jq -r '.items[0] | select(.metadata.labels.run == \"$ecrRepoName\").metadata.labels.\"pod-template-hash\"'", returnStdout: true).trim()
					}
				} else {
					sh "echo 'Pod Already Deployed, Updating Image'"
					sh "~/bin/kubectl set image deployment/`echo $ecrRepoName` `echo $ecrRepoName`=`echo $ecrURI`:`echo $buildID`"
					sh "echo 'Restart Pod to Clear Cache'"
					sh "~/bin/kubectl rollout restart deployment/$ecrRepoName"
					sh "echo 'Retrieving New Pod Name and Hash'"
					script {
						podName = sh(script: "~/bin/kubectl get pods --output=json | jq '[.items[] | select(.status.phase != \"Terminating\") ] | max_by(.metadata.creationTimestamp).metadata.name'", returnStdout: true).trim()
						podHash = sh(script: "~/bin/kubectl get pods --output=json | jq '[.items[] | select(.status.phase != \"Terminating\") ] | max_by(.metadata.creationTimestamp).metadata.labels.\"pod-template-hash\"'", returnStdout: true).trim()
					}
				} 
				sh "echo 'Check if Pod Service has Previously been Deployed'"
				script {
					eksService = sh(script: "~/bin/kubectl get services --output=json | jq -r '.items[0] | select(.metadata.name == \"capstone-server\").metadata.name'", returnStdout: true).trim()
				}
				if (eksService.isEmpty() && !podName.isEmpty()) {
					sh "echo 'No Pod Service Found, Deploying Now'"
					sh "~/bin/kubectl expose pod $podName --port=8080 --target-port=80 --type=LoadBalancer --name=capstone-server"
					//script {
					//	eksService = sh(script: "~/bin/kubectl get services --output=json | jq -r '.items[0] | select(.metadata.name == \"$podName\").metadata.name'", returnStdout: true).trim()
					//}
				} else {
					sh "echo 'Pod Service Found. Patching with New Pod Hash'"
					sh "~/bin/kubectl patch svc capstone-server -p '{\"metadata\": {\"labels\": {\"pod-template-hash\": $podHash}},\"spec\": {\"selector\": {\"pod-template-hash\": $podHash}}}'"
				}
				script {
					serviceAddress = sh(script: "~/bin/kubectl get services --output=json | jq -r '.items[0] | .status.loadBalancer.ingress[0].hostname'", returnStdout: true).trim()
				}
				sh "echo 'Deployment Complete!'"
				sh "echo 'View Page Here (Please Allow a Minute for Services to Refresh): http://$serviceAddress:8080'"
			}
		}
	}
  }
}
