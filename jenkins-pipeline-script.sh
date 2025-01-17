pipeline {
    agent any

    stages {
        stage('Pull Dockerfile') {
            steps {
                echo 'Pulling Dockerfile from the repository...'
                git branch: 'main', url: '<REPO URL>'
            }
        }
        stage('Docker Lint Syntax Check') {
            steps {
                echo 'Running Dockerfile lint checks...'
                script {
                    catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                        sh '''
                        cd /opt/import
                        docker run --rm -i hadolint/hadolint < DOCKERFILE
                        '''
                    }
                    echo 'Lint check completed. Ignoring failure to continue the pipeline.'
                }
            }
        }
        stage('Build Docker Image') {
            steps {
                echo 'Building Docker image...'
                sh '''
                cd /opt/import
                echo "Delete docker Image"
                docker image inspect test >/dev/null 2>&1 && docker image rm test || echo "test image not found"
                echo "Create new docker Image"
                docker image build -t test .
                '''
            }
        }
        stage('Dependency Check') {
            steps {
                echo 'Checking dependencies in Docker image...'
                script {
                    sh '''
                    // The below command is to disable secret scanning
                    trivy image <docker image> --scanners vuln --debug --timeout 30m
                    // The command to run all the modules
                    trivy image <docker image> --debug --timeout 30m
                    '''
                }
            }
        }
    }
}
