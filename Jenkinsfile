pipeline {
 agent any
    stages {
        stage('Docker Down & Up') {
          steps{
                sh 'pwd'
                // sh 'docker-compose down' // Stop the container(s)
                // sh 'docker stop $(docker ps -a -q) > /dev/null 2&>1' // stop all runing docker
                // sh 'docker rm $(docker ps -a -q)  > /dev/null 2&>1' // delete all runing docker
                // sh 'docker-compose build' /// build new image
                // sh 'docker-compose -f docker-compose.test.yml up -d' // run docker as daemon
          }
        }

        stage('Create Env file') {
          steps{
            sh 'just pass '
                // sh 'cp laravel-app/.env.example laravel-app/.env' // create new .env file
                /* groovylint-disable-next-line GStringExpressionWithinString */
                // sh 'echo DB_HOST=${DB_HOST} >> laravel-app/.env'  // cp env var to env file
                // sh 'echo DB_USERNAME=${DB_USERNAME} >> laravel-app/.env' // cp DB_USERNAME var to env file
                // sh 'echo DB_DATABASE=${DB_DATABASE} >> laravel-app/.env' // cp DB_DATABASE var to env file
                // sh 'echo DB_PASSWORD=${DB_PASSWORD} >> laravel-app/.env' // cp DB_PASSWORD var to env file
                // sh 'echo DB_PORT=${DB_PORT} >> laravel-app/.env' // cp DB_PASSWORD var to env file
                // sh 'echo APP_DEBUG=false >> laravel-app/.env' // uncomment this for prod
                // sh 'docker-compose run --rm composer install --ignore-platform-reqs' // run compser to install dependencies
          }
        }

        stage('migration & permissions') {
          steps{
             sh 'sudo chown -R www-data:$(whoami) laravel-app/' // change permission 
             sh 'sudo docker exec -i php php /var/www/html/laravelapp/artisan key:generate' // generate key laravel
             sh 'sudo docker exec -i php php /var/www/html/laravelapp/artisan migrate' // run migration
          }
        }

        stage('Unit test') {
           steps{
            sh 'docker exec -i php mkdir /var/www/html/laravelapp/tests/Unit > /dev/null 2&>1' // create Unit Folder ==> fix Test directory "/var/www/html/laravelapp/./tests/Unit" not found
            sh 'docker exec -i php php /var/www/html/laravelapp/artisan test' // run unit test 
           }  
        }
        stage('Send Notification'){
           steps{
            notifyBuild(currentBuild.result)
           }
        }

    } 
}

def notifyBuild(String buildStatus = 'STARTED') {
  // build status of null means successful
  buildStatus =  buildStatus ?: 'SUCCESSFUL'

  // Default values
  def colorName = 'RED'
  def colorCode = '#FF0000'
  def subject = "${buildStatus}: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'"
  def summary = "${subject} (${env.BUILD_URL})"

  // Override default values based on build status
  if (buildStatus == 'STARTED') {
    color = 'YELLOW'
    colorCode = '#FFFF00'
  } else if (buildStatus == 'SUCCESSFUL') {
    color = 'GREEN'
    colorCode = '#00FF00'
  } else {
    color = 'RED'
    colorCode = '#FF0000'
  }

  // Send notifications
  slackSend (color: colorCode, message: summary)
}
