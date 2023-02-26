pipeline{
    agent any
    stages{
        stage("clone git repo"){
            steps{
                git branch: 'main', credentialsId: 'gmail', url: 'https://github.com/testuser-devops/Healthcheck.git'
            }
            
        }
        stage("server status"){
        steps{
            sh '''
                ls
                cd Healthcheck
                .script.sh
            '''
        }
        }
    }    
}
