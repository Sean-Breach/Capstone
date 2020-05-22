pipeline {
  agent any
  stages {
	stage('Lint Application') {
		sh 'echo "Performing Make Lint to Check Python and HTML'
		sh 'make lint'
	}
	stage('Build Container') {
	
	}
	stage('Security Scan') {
		sh 'echo "Checking Security with Aqua MicroScanner..."'
        aquaMicroscanner(imageName: 'alpine:latest', notCompliesCmd: 'exit 1', onDisallowed: 'fail', outputFormat: 'html')
	}
	stage(Push Image') {
		sh 'echo "Get Login Token for Pushing Docker Image to Amazon ECR"'
		sh 'aws ecr get-login-password --region us-west-2 | docker login --username AWS --password-stdin 500258544193.dkr.ecr.us-west-2.amazonaws.com/capstone-ecr' to get login
        sh 'echo "Tag Docker Image Before Pushing to Amazon ECR"'
		sh 'docker tag imageId 500258544193.dkr.ecr.us-west-2.amazonaws.com/capstone-ecr'
        sh 'echo "Push Docker Image to Amazon ECR"'
		sh 'docker push 500258544193.dkr.ecr.us-west-2.amazonaws.com/capstone-ecr'
	}
	stage('set current kubectl context') {
	}
	stage('Deploy container') {
	}
  
  
  
  
    stage('Build') {
      steps {
        sh 'echo "This is the Build Stage!"'
        sh '''
                     echo "Multiline shell steps works too"
                     ls -lah
                 '''
      }
    }

    stage('Lint HTML') {
      steps {
        sh 'tidy -q -e *.html'
      }
    }

    stage('Security Scan') {
      steps {
        sh 'echo "Checking Security"'
        aquaMicroscanner(imageName: 'alpine:latest', notCompliesCmd: 'exit 1', onDisallowed: 'fail', outputFormat: 'html')
      }
    }

    stage('Upload to AWS') {
      steps {
        sh 'echo "Uploading content with AWS creds"'
      }
    }

  }
}
