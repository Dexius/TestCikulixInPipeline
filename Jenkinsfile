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
        stage("Проверка поведения") {
            parallel {
                stage("Запуск vrunner") {
                    steps {
							timestamps {
								cmd("set LOGOS_CONFIG=logger.rootLogger=DEBUG")
								// cmd("runner vanessa --settings tools/vrunner.json")
							}
                    }
                }
                stage("Functional Tests") {
                    steps {
                        timestamps {
                            PowerShell('Start-Sleep 5')  
                        }                 
                    }
                }
            }	
        }
	
		// parallel {
		// 	stage("Проверка поведения") {
		// 		steps {
		// 			script {
		// 				if (!firstInitFail) {
		// 					timestamps {
		// 						cmd("set LOGOS_CONFIG=logger.rootLogger=DEBUG")
		// 						cmd("runner vanessa --settings tools/vrunner.json")
		// 					}
		// 				}
		// 			}
		// 		}
		// 	}
		// 	stage("Активируем окно 1С") {
		// 		steps {
		// 			script {
		// 				if (!firstInitFail) {
		// 					timestamps {
		// 						PowerShell('echo "Test"')                   
		// 					}
		// 				}
		// 			}
		// 		}
		// 	}
		// }		
    }   
    post {
        always {                

            // allure includeProperties: false, jdk: '', results: [[path: 'build/out/allure']]

            // publishHTML target: [
            //     allowMissing: false, 
            //     alwaysLinkToLastBuild: false, 
            //     keepAll: false, 
            //     reportDir: 'build/out', 
            //     // reportFiles: 'allure-report/index.html,pickles/Index.html', 
            //     reportFiles: 'allure-report/index.html',                 
            //     reportName: 'HTML Report', 
            //     reportTitles: ''
            //     ]

            // script{
            //     if (firstInitFail)
            //         currentBuild.result = 'FAILURE'
            // }
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

def PowerShell(psCmd) {
    psCmd=psCmd.replaceAll("%", "%%")
    bat "powershell.exe -NonInteractive -ExecutionPolicy Bypass -Command \"\$ErrorActionPreference='Stop';[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;$psCmd;EXIT \$global:LastExitCode\""
}
