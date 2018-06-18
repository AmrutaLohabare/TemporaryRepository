pipeline {
  agent any
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