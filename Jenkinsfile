pipeline {
  agent { label 'built-in' }
  tools { nodejs "Node_v18" }

  environment {
    APP_NAME   = 'toformtask-app'
    ARTVERSION = "${env.BUILD_ID}"
  }

  stages {

    stage('Approve Production Deployment') {
      when {
        expression {
          return env.BRANCH_NAME ==~ /^v\d+\.\d+\.\d+$/
        }
      }
      steps {
        script {
          def userInput = input(
            id: 'ProdApproval',
            message: 'Deploy to production?',
            ok: 'Deploy',
            submitter: 'raja'
          )
          echo "Approval received from: ${userInput}"
        }
      }
    }

    stage('Deploy to Production') {
  when {
    expression {
      return env.BRANCH_NAME ==~ /^v\d+\.\d+\.\d+$/
    }
  }
 steps {
        bat """
  pm2 delete "%APP_NAME%" --silent
  pm2 save --force
  pm2 list
  call npm install --unsafe-perm
  pm2 start app.js --name "%APP_NAME%"
  pm2 save
  pm2 list
"""
      }
}

    stage('Skip Deploy (Not a Tag)') {
      when {
        not {
          expression { return env.BRANCH_NAME ==~ /^v\d+\.\d+\.\d+(-[a-zA-Z0-9]+)?$/ }
        }
      }
      steps {
        echo "Not deploying — no valid release tag detected."
      }
    }
  }

  post {
    always {
      echo "Pipeline completed for: ${env.BRANCH_NAME}"
    }
    success {
      echo "✅ Build succeeded"
    }
    failure {
      echo "❌ Build failed"
    } 
  }
}
