pipeline {
        agent none
        stages {
         
          stage("build & SonarQube Scanner") {
            agent any
            steps {
              withSonarQubeEnv('SonarSeminario2024') {
                sh 'mvn clean package sonar:sonar'
              }
            }
          }
        }
      }
