#!groovy
import groovy.json.JsonSlurper

def firstInitFail = false

pipeline {
    agent {
        label "newbdd"
    }
    options {
        buildDiscarder(logRotator(numToKeepStr:'10'))
    }
    
    stages {	
        stage("Проверка поведения") {
            steps {
                script {
                    if (!firstInitFail) {
                        timestamps {
							cmd("dir /w")
                            cmd("runner vanessa --settings tools/vrunner.json")
                        }
                    }
                }
            }
        }     
    }   
    post {
        always {                

            allure includeProperties: false, jdk: '', results: [[path: 'build/out/allure']]

            publishHTML target: [
                allowMissing: false, 
                alwaysLinkToLastBuild: false, 
                keepAll: false, 
                reportDir: 'build/out', 
                // reportFiles: 'allure-report/index.html,pickles/Index.html', 
                reportFiles: 'allure-report/index.html',                 
                reportName: 'HTML Report', 
                reportTitles: ''
                ]

            script{
                if (firstInitFail)
                    currentBuild.result = 'FAILURE'
            }
        }
    }
}

def cmd(command) {
    if (isUnix()) {
        sh "${command}"
    } else {
         bat "chcp 65001\n${command}"
    }
}
