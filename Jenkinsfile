pipeline {
  agent any
  parameters{
  choice(name:'door_choice',
        choices: 'one\ntwo\nthree\nfour\n',
        description:'what door you choose ?')
    
  }
  stages {
    stage('Example') {
      steps {
        sh 'echo "Hello World!!!"'
        echo 'Hello World is printed'
        echo 'You choose the door : params.door_choice'
      }
    }
  }
}
