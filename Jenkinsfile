def COLOR_MAP = [
    'SUCCESS': 'good', 
    'FAILURE': 'danger',
]

def getBuildUser() {
    return currentBuild.rawBuild.getCause(Cause.UserIdCause).getUserId()
}

pipeline {
    agent any

     stages {
        stage("Build") {
            steps {
                sh 'docker-compose build'
                sh 'docker-compose -f docker-compose.test.yml up -d'
                sh 'cp laravel-app/.env.example laravel-app/.env'
                sh 'echo DB_HOST=${DB_HOST} >> laravel-app/.env'
                sh 'echo DB_USERNAME=${DB_USERNAME} >> laravel-app/.env'
                sh 'echo DB_DATABASE=${DB_DATABASE} >> laravel-app/.env'
                sh 'echo DB_PASSWORD=${DB_PASSWORD} >> laravel-app/.env'
                // sh 'echo APP_DEBUG=false >> laravel-app/.env' uncomment this for prod
                sh 'docker-compose run --rm composer install'
                sh 'pwd'
                sh 'sudo chown -R www-data:ubuntu laravel-app/'
                sh 'sudo docker exec -i php php /var/www/html/laravelapp/artisan key:generate'
                sh 'sudo docker exec -i php php /var/www/html/laravelapp/artisan migrate'
            }
        }
        stage("Unit test") {
            steps {
                sh 'docker exec -i php php /var/www/html/laravelapp/artisan test'
            }
        }
    }

    
    // Post-build actions
    // post {
    //     always {
    //         script {
    //             BUILD_USER = getBuildUser()
    //         }
    //         echo 'I will always say hello in the console.'
    //         slackSend channel: '#slack-test-channel',
    //             color: COLOR_MAP[currentBuild.currentResult],
    //             message: "*${currentBuild.currentResult}:* Job ${env.JOB_NAME} build ${env.BUILD_NUMBER} by ${BUILD_USER}\n More info at: ${env.BUILD_URL}"
    //     }
    //  }
}
 
