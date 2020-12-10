pipeline {
 agent any
 stages {
        stage("Build") {
            steps {
                sh 'docker-compose -f docker-compose.test.yml up -d'
                sh 'docker exec -i php cp /var/www/html/laravelapp/.env.example /var/www/html/laravelapp/.env'
                sh 'docker exec -i php php /var/www/html/laravelapp/artisan artisan key:generate'
                sh 'docker exec -i php php /var/www/html/laravelapp/artisan migrate'
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