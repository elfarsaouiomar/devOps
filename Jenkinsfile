pipeline {
 agent any
 stages {
        stage("Build") {
            steps {
                sh 'docker rm -vf $(docker ps -a -q)'
                sh 'docker rmi -f $(docker images -a -q)'
                sh 'docker-compose build'
                sh 'docker-compose -f docker-compose.test.yml up -d'
                sh 'cp laravel-app/.env.example laravel-app/.env'
                sh 'docker-compose run --rm composer install'
                sh 'pwd'
                sh 'sudo chown -R www-data:www-data laravel-app/'
                sh 'sudo docker exec -i php php /var/www/html/laravelapp/artisan key:generate'
                sh 'sudo docker exec -i php php /var/www/html/laravelapp/artisan migrate'
            }
        }
        stage("Unit test") {
            steps {
                sh 'docker exec -i php php /var/www/html/laravelapp/artisan test'
            }
        }

        stage("turn off container") {
            steps {
                sh 'docker exec -i php php /var/www/html/laravelapp/artisan test'
            }
        }

        stage("deloy to Server") {
            steps {
                sh 'docker exec -i php php /var/www/html/laravelapp/artisan test'
            }
        }


  }
}