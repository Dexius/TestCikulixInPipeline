#!groovy
import groovy.json.JsonSlurper
// ВНИМАНИЕ:
// Jenkins и его ноды нужно запускать с кодировкой UTF-8
//      строка конфигурации для запуска Jenkins
//      <arguments>-Xrs -Xmx256m -Dhudson.lifecycle=hudson.lifecycle.WindowsServiceLifecycle -Dmail.smtp.starttls.enable=true -Dfile.encoding=UTF-8 -jar "%BASE%\jenkins.war" --httpPort=8080 --webroot="%BASE%\war" </arguments>
//
//      строка для запуска нод
//      @"C:\Program Files (x86)\Jenkins\jre\bin\java.exe" -Dfile.encoding=UTF-8 -jar slave.jar -jnlpUrl http://localhost:8080/computer/slave/slave-agent.jnlp -secret XXX
//      подставляйте свой путь к java, порту Jenkins и секретному ключу
//
// Если запускать Jenkins не в режиме UTF-8, тогда нужно поменять метод cmd в конце кода, применив комментарий к методу

// TODO документировать переменные окружения = параметры сборки
// def dbUserName = "${env.dbUserName}"
//def dbUserName = "--ibconnection /F./build/ibservice"

def RUNNER_IBCONNECTION="${env.RUNNER_IBCONNECTION}"
def RUNNER_DBUSER="${env.RUNNER_DBUSER}"
def firstInitFail = false

pipeline {
    agent {
        label "newbdd"
    }
    options {
        buildDiscarder(logRotator(numToKeepStr:'10'))
    }
    
    stages {
        stage('Уведомления о начале сборки') {
            steps {
                timestamps {
                    script {
                        notifyBuild('Стартовала')
                    }
                }
            }
        }
		
        stage("Проверка поведения") {
            steps {
                script {
                    if (!firstInitFail) {
                        timestamps {
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
