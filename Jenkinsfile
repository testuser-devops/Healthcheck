pipeline{
    agent any
    stages{
        stage("cloning git repository"){
            steps{
                git branch: 'main', credentialsId: 'gmail', url: 'https://github.com/testuser-devops/Healthcheck.git'
            }
            
        }
        stage(" checking server status"){
        steps{
            sh '''
              chmod +x serverhealth.ps1
              ./serverhealth.ps1
            '''
        }
        }
    }    
}
