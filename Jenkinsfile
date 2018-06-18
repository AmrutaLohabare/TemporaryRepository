pipeline {
  agent any
  stages {
    stage('Greetings') {
      parallel {
        stage('Greetings') {
          agent any
          steps {
            sh 'echo "Hello World!!!"'
            echo 'Hello World is printed'
          }
        }
        stage('Copy the script') {
          steps {
            sh '''echo "Copy the Script..."

sshpass -p $ROOT_PASSWORD scp -r replaceLib.sh root@$STACK_NAME:/root/.'''
            input(message: 'Stack Name', id: '12345', ok: 'Password')
          }
        }
      }
    }
  }
}