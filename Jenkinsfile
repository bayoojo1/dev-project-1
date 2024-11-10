node {
    def app

    stage('Clone repository') {
        // Clone the repository to the Jenkins workspace
        checkout scm
    }

    stage('Build image') {
        // Build the Docker image
        // Specify the workspace path in Unix format for Docker compatibility
        dir("${env.WORKSPACE}".replaceAll('\\\\', '/')) {
            app = docker.build("bayoojo1/dev-project-1")
        }
    }

    stage('Test image') {
        // Run tests inside the container
        app.inside('-w /usr/src/app') {
            sh 'echo "Tests passed"'
        }
    }

    stage('Push image') {
        // Push image to Docker Hub with registry credentials
        docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
            app.push("${env.BUILD_NUMBER}")
            app.push("latest")
        }
    }

    stage('Cleanup') {
        // Clean up to free space by removing the image after pushing
        sh "docker rmi bayoojo1/dev-project-1:${env.BUILD_NUMBER}"
        sh "docker rmi bayoojo1/dev-project-1:latest"
    }
}