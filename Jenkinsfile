pipeline {
  agent any
  stages {
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
