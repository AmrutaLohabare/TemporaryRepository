pipeline {
  agent {
    docker {
      image 'vl-pun-rie-hbr1.bmc.com/dsm/bwfa180500:RC3'
      args 'Bundle_Version'
    }
    
  }
  stages {
    stage('Greetings') {
      agent any
      steps {
        sh 'echo "Hello World!!!"'
        echo 'Hello World is printed'
      }
    }
  }
  environment {
    IS_SERVER = ''
  }
}