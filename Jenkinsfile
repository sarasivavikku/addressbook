pipeline{
    agent any

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

        stage("Deploy"){
             steps{
                script{
                    echo "Deploy  the code"
                    sh "mvn deploy"
                }
             }
        }
    }
}