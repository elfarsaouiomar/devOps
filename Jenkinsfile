pipeline {
 agent any
 stages {
        stage("Build") {
            steps {
                sh 'Docker build .'
                sh 'docker-compose build && docker-compose up -d'
                sh 'docker exec -it php cp /var/www/html/laravelapp/.env.example /var/www/html/laravelapp/.env'
                sh 'docker exec -it php php /var/www/html/laravelapp/artisan artisan key:generate'
                sh 'docker exec -it php php /var/www/html/laravelapp/artisan migrate'
            }
        }
        stage("Unit test") {
            steps {
                sh 'docker exec -it php php /var/www/html/laravelapp/artisan test'
            }
        }
  }
}