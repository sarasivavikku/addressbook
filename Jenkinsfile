pipeline {
    agent any
    parameters{
        string(name:'Env',defaultValue:'Test',description:'version to deploy')
        booleanParam(name:'executeTests',defaultValue: 'true',description:'decide to run tc')
    }
         stages {
                 
                 stage("Compile"){
                     steps{
                         script{
                         echo "Compiling the code"
                         }
                     }
                 }
                 
                 stage("UnitTest"){
                    when {
                        expression{
                            param.executeTests == true
                        }
                    }
                     steps{
                         script{
                         echo "Testing the code in  ${params.Env} env"
                         }
                     }
                 }
                 
                 stage("Package"){
                     steps{
                         script{
                         echo "Package the code"
                         }
                     }
                 }
             }  
       
        }   
