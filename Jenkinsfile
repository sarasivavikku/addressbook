pipeline{
    agent {label 'Node1'}
    tools{
        jdk 'Myjava'
        maven 'Mymaven'
    } 

    environment{
     //   Build_server='ec2-user@172.31.29.112'
       // jenkinsslave='ec2-user@172.31.30.146'
        deploy_server='ec2-user@172.31.22.3'
        // Novsec2jenkinsmaster='ec2-user@172.31.33.73'
        // IMAGE_NAME='vikranth2/java-mvn-privaterepos'
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
            // agent {label 'Node1'}
             steps{
                script{
                    echo "package the code"
                    sshagent(['Build4']) {
                         echo 'PACKAGE-Hello World'
                         withCredentials([usernamePassword(credentialsId: 'docker', passwordVariable: 'PASSWORD', usernameVariable: 'USERNAME')]) {
                       sh "scp -o StrictHostKeyChecking=no server-script.sh ec2-user@172.31.21.87:/home/ec2-user"
                    sh "ssh -o StrictHostKeyChecking=no ec2-user@172.31.21.87  'bash ~/server-script.sh '" 
                    sh "ssh -o StrictHostKeyChecking=no ec2-user@172.31.21.87 sudo docker build -t vikranth2/java-mvn-privaterepos /home/ec2-user/addressbook"
                    sh "ssh -o StrictHostKeyChecking=no ec2-user@172.31.21.87  sudo docker login -u $USERNAME -p $PASSWORD"
                    sh "ssh -o StrictHostKeyChecking=no ec2-user@172.31.21.87 sudo docker push vikranth2/java-mvn-privaterepos" 
                         }

                     }
                }
             }
        }

        stage("Deploy"){
             steps{
               script{
                  echo "deploy the code"
                    sshagent(['Deploy_server']) {
                         echo 'Deploy the code'
                  withCredentials([usernamePassword(credentialsId: 'docker', passwordVariable: 'PASSWORD', usernameVariable: 'USERNAME')]) {       
                sh "ssh  -o StrictHostKeyChecking=no ${deploy_server} sudo yum install docker -y"
                sh "ssh  ${deploy_server} sudo systemctl start docker"
                sh "ssh  ${deploy_server} sudo docker login -u ${USERNAME} -p ${PASSWORD}"
                sh "ssh  ${deploy_server} sudo docker run -itd -P vikranth2/java-mvn-privaterepos "
                  }
                    }
               } 
           } 
        }   
    }
}