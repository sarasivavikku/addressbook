pipeline{
    agent any
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
        }

        stage("Package"){
             steps{
                script{
                    echo "package the code"
                    sh "mvn package"
                }
             }
        }
    }
}