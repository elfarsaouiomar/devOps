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
                sh 'docker-compose down' // Stop the container(s)
                sh 'docker stop $(docker ps -a -q)' // stop all runing docker
                sh 'docker rm $(docker ps -a -q)' // delete all runing docker
                sh 'docker-compose build' /// build new image
                sh 'docker-compose -f docker-compose.test.yml up -d' // run docker as daemon
                sh 'cp laravel-app/.env.example laravel-app/.env' // create new .env file
                sh 'echo DB_HOST=${DB_HOST} >> laravel-app/.env'  // cp env var to env file
                sh 'echo DB_USERNAME=${DB_USERNAME} >> laravel-app/.env' // cp DB_USERNAME var to env file
                sh 'echo DB_DATABASE=${DB_DATABASE} >> laravel-app/.env' // cp DB_DATABASE var to env file
                sh 'echo DB_PASSWORD=${DB_PASSWORD} >> laravel-app/.env' // cp DB_PASSWORD var to env file
                sh 'echo DB_PORT=${DB_PORT} >> laravel-app/.env' // cp DB_PASSWORD var to env file
                // sh 'echo APP_DEBUG=false >> laravel-app/.env' uncomment this for prod
                sh 'docker-compose run --rm composer install' // run compser to install dependencies
                sh 'sudo chown -R www-data:ubuntu laravel-app/' // change permission 
                sh 'sudo docker exec -i php php /var/www/html/laravelapp/artisan key:generate' // generate key laravel
                sh 'sudo docker exec -i php php /var/www/html/laravelapp/artisan migrate' // run migration
            }
        }
        stage("Unit test") {
            steps {
                sh 'docker exec -i php php /var/www/html/laravelapp/artisan test' // run unit test 
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
 
