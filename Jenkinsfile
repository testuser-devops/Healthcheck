pipeline{
    agent any
    stages{
        stage("dfghjk"){
            steps{
                sh '''
                    cd
                    ls
                    git clone https://github.com/testuser-devops/Healthcheck.git
                   '''
            }
        }
        stage("cloning git repository"){
            steps{
                git branch: 'main', credentialsId: 'gmail', url: 'https://github.com/testuser-devops/Healthcheck.git'
            }
            
        }
        stage(" checking server status"){
        steps{
            sh '''
              chmod +x script.sh
              ./script.sh
            '''
        }
        }
    }    
}
