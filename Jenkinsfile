pipeline{
    agent any
    stages{
        stage("cloning git repository"){
            steps{
                git branch: 'main', credentialsId: 'gmail', url: 'https://github.com/testuser-devops/Healthcheck.git'
            }
        }
        stage("servers health check"){
            steps{
                sh '''
                    chmod +x serverhealth.ps1
                    ./serverhealth.ps1
                    cat report
                '''
            }
        }
        stage('Update GIT') {
            steps {
                script {
                    catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                        withCredentials([usernamePassword(credentialsId: 'gmail', passwordVariable: 'GIT_PASSWORD', usernameVariable: 'GIT_USERNAME')]) {
                        def encodedPassword = URLEncoder.encode("$GIT_PASSWORD",'UTF-8')
                            sh "git config user.email test.tester9676@gmail.com"
                            sh "git config user.name testuser-devops"
                            sh "git add ."
                            sh "git commit -m 'Triggered Build: ${env.BUILD_NUMBER}'"
                            sh "git push https://${GIT_USERNAME}:${encodedPassword}@github.com/${GIT_USERNAME}/Healthcheck.git"
                        }
                    }
                }
            }
        }
    }    
}
