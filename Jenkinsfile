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
            steps {
                parallel (
                    "Запуск runner" : {
                        cmd("runner vanessa --settings tools/vrunner.json")
                    },
                    // "Активация окна когда есть кеш" : {
                    //     PowerShell('Start-Sleep 10; Add-Type -AssemblyName Microsoft.VisualBasic ;$process  = Get-Process 1cv8* | select -skip 1 -last 1 ;[Microsoft.VisualBasic.Interaction]::AppActivate($process.id)')
                    // }
                )
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
    // при запуске Jenkins не в режиме UTF-8 нужно написать chcp 1251 вместо chcp 65001
    if (isUnix()) { sh "${command}" } else { bat "chcp 65001\n${command}"}
}

def cmd_failsafe(command) {
    // при запуске Jenkins не в режиме UTF-8 нужно написать chcp 1251 вместо chcp 65001
    if (isUnix()) { sh "${command}" } else { bat (script: "chcp 65001\n${command}",  returnStatus: true)}
}

def PowerShell(psCmd) {
    psCmd=psCmd.replaceAll("%", "%%")
    bat "powershell.exe -NonInteractive -ExecutionPolicy Bypass -Command \"\$ErrorActionPreference='Stop';[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;$psCmd;EXIT \$global:LastExitCode\""
}
