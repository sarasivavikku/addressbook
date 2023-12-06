pipeline {
    agent any
    parameters{
        string(name:'Env',defaultValue:'Test',description:'version to deploy')
        booleanParam(name:'executeTests',defaultValue: 'true',description:'decide to run tc')
        choice(name:'APPVERSION',choicees['1.1','1.2','1.3'])
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
                            params.executeTests == true
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
                         echo "Package the code ${params.APPVERSION}"
                         }
                     }
                 }
             }  
       
        }   
