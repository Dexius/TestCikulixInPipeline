#!groovy
import groovy.json.JsonSlurper

def firstInitFail = false

pipeline {
    agent {
        label "debug"
    }
    options {
        buildDiscarder(logRotator(numToKeepStr:'10'))
    }
    
    stages {	
	
		parallel(
			stage("Проверка поведения") {
				steps {
					script {
						if (!firstInitFail) {
							timestamps {
								cmd("set LOGOS_CONFIG=logger.rootLogger=DEBUG")
								cmd("runner vanessa --settings tools/vrunner.json")
							}
						}
					}
				}
			},
			stage("Активируем окно 1С") {
				steps {
					script {
						if (!firstInitFail) {
							timestamps {
								powershell(Start-Sleep -Seconds 5)
								def msg = powershell(returnStdout: true, script: 'echo "Тест выполнен!"')
								println msg                     
								}
						}
					}
				}
			}
		)		
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
         bat "chcp 65001\n$start /w /max {command}"
    }
}
