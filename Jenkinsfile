pipeline{
    // agent {label 'Node1'}
    tools{
        jdk 'Myjava'
        maven 'Mymaven'
    } 

    environment{
     //   Build_server='ec2-user@172.31.29.112'
       // jenkinsslave='ec2-user@172.31.30.146'
        deploy_server='ec2-user@172.31.22.3'
        Build4='ec2-user@172.31.21.87'
        // Novsec2jenkinsmaster='ec2-user@172.31.33.73'
         IMAGE_NAME='vikranth2/java-mvn-privaterepos:$BUILD_NUMBER'
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
                    sleep(time:90,unit: "SECONDS")
                    echo "package the code"
                    sshagent(['Build4']) {
                         echo 'PACKAGE-Hello World'
                         withCredentials([usernamePassword(credentialsId: 'docker', passwordVariable: 'PASSWORD', usernameVariable: 'USERNAME')]) {
                       sh "scp -o StrictHostKeyChecking=no server-script.sh ${Build4}:/home/ec2-user"
                    sh "ssh -o StrictHostKeyChecking=no ${Build4}  'bash ~/server-script.sh '" 
                    sh "ssh -o StrictHostKeyChecking=no ${Build4} sudo docker build -t ${IMAGE_NAME} /home/ec2-user/addressbook"
                    sh "ssh -o StrictHostKeyChecking=no ${Build4}  sudo docker login -u $USERNAME -p $PASSWORD"
                    sh "ssh -o StrictHostKeyChecking=no ${Build4} sudo docker push ${IMAGE_NAME}" 
                         }

                     }
                }
             }
        }

        stage("TF will provison deploy server"){
            steps{
                script{
                    dir('terraform'){
                    sh "terraform init"
                    sh "terraform apply --auto-approve"
                    EC2_PUBLIC_IP=sh(
                        script: "terraform output ec2-ip",
                        returnStdout: true
                    ).trim()
                    }
                }
            }
        }

        stage("Deploy"){
             steps{
               script{
                  echo "${EC2_PUBLIC_IP}"
                    sshagent(['Deploy_server']) {
                         echo 'Deploy the code'
                  withCredentials([usernamePassword(credentialsId: 'docker', passwordVariable: 'PASSWORD', usernameVariable: 'USERNAME')]) {       
                sh "ssh  -o StrictHostKeyChecking=no ec2-user@${EC2_PUBLIC_IP} sudo docker login -u ${USERNAME} -p ${PASSWORD}"
                sh "ssh  ec2-user@${EC2_PUBLIC_IP} sudo docker run -itd -P ${IMAGE_NAME} "
                  }
                    }
               } 
           } 
        }   
    }
}