pipeline{
    agent {label 'Node1'}
    tools{
        jdk 'Myjava'
        maven 'Mymaven'
    }

    stages{
        stage("Compile"){
             steps{
                script{
                    echo "Compile the code"
                    sh "mvn compile"
                }
             }
        }

        stage("UnitTest"){
             steps{
                script{
                    echo "Test the code"
                    sh "mvn test"
                }
             }
             post{
                always{
                junit 'target/surefire-reports/*.xml'
                }
             }
        }

        stage("Package"){
             steps{
                script{
                    echo "package the code"
                    sshagent(['Build_server_key']) {
                        sh "scp -o StrictHostKeyChecking=no server-script.sh ec2-user@172.31.29.112:/home/ec2-user"
                   sh "ssh -o StrictHostKeyChecking=no ec2-user@172.31.29.112  'bash ~/server-script.sh'"
                     }
                }
             }
        }
    }
}
