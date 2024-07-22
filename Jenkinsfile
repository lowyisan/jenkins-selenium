pipeline {
    agent none
    stages {
        stage('Integration UI Test') {
            parallel {
                stage('Deploy') {
                    agent any
                    steps {
                        sh 'which dos2unix || (sudo apt-get update && sudo apt-get install -y dos2unix)'
                        sh 'dos2unix ./jenkins/scripts/deploy.sh'
                        sh 'chmod +x ./jenkins/scripts/deploy.sh'
                        sh './jenkins/scripts/deploy.sh'
                        input message: 'Finished using the web site? (Click "Proceed" to continue)'
                        sh 'dos2unix ./jenkins/scripts/kill.sh'
                        sh './jenkins/scripts/kill.sh'
                    }
                }
                stage('Headless Browser Test') {
                    agent {
                        docker {
                            image 'maven'
                            args '--platform linux/amd64 -u root'
                        }
                    }
                    steps {
                        sh 'dos2unix ./jenkins/scripts/deploy.sh' // Ensure this script is also converted if used here
                        sh 'mvn -B -DskipTests clean package'
                        sh 'mvn test'
                    }
                    post {
                        always {
                            junit 'target/surefire-reports/*.xml'
                        }
                    }
                }
            }
        }
    }
}
