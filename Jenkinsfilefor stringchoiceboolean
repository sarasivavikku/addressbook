pipeline {
    agent any
    parameters{
        string(name:'Env',defaultValue:'Test',description:'version to deploy')
        booleanParam(name:'executeTests',defaultValue: 'true',description:'decide to run tc')
        choice(name:'APPVERSION',choices:['1.1','1.2','1.3'])
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
                    input {
                        message "select the version to the package"
                        ok "version selected"
                        parameters{
                            choice(name:'NEWVERSION', choices:['2.3',2.4,2.7])
                        }
                    }
                     steps{
                         script{
                         echo "Package the code ${params.APPVERSION}"
                         echo "Package the code ${NEWVERSION}"
                         }
                     }
                 }
             }  
       
        }   
