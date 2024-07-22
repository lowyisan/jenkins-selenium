pipeline {
    agent none
    stages {
        stage('Deploy and Test') {
            parallel {
                stage('Deploy') {
                    agent any
                    steps {
                        sh './jenkins/scripts/deploy.sh'
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
        stage('User Confirmation') {
            agent any
            steps {
                input message: 'Finished using the web site? (Click "Proceed" to continue)'
            }
        }
        stage('Kill Process') {
            agent any
            steps {
                sh './jenkins/scripts/kill.sh'
            }
        }
    }
}
