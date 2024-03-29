pipeline {

   parameters {
    choice(name: 'action', choices: 'create\ndestroy', description: 'Create/update or destroy the eks cluster.')
	string(name: 'cluster', defaultValue : 'demo', description: "EKS cluster name;eg demo creates cluster named eks-demo.")
	string(name: 'role', defaultValue : '<role-arn>/eks-admin', description: "IAM Role that auth with EKS cluste")
    choice(name: 'k8s_version', choices: '1.19\n1.18\n1.17', description: 'K8s version to install.')
    string(name: 'instance_type', defaultValue : 'm5.large', description: "k8s worker node instance type.")
    string(name: 'num_workers', defaultValue : '2', description: "k8s number of worker instances.")
    string(name: 'max_workers', defaultValue : '4', description: "k8s maximum number of worker instances that can be scaled.")
    string(name: 'region', defaultValue : 'us-east-1', description: "AWS region.")
  }
  
  agent any
  tools {
        terraform 'terraform-12' 
		git       'github'  
    }
  stages {
    stage('checkout') {
        steps {
            git 'https://github.com/iamnst19/Istio_EKS_Terraform.git'
        }
    }
	stage('Setup') {
		steps {
			script {
				currentBuild.displayName = "#" + env.BUILD_NUMBER + " " + params.action + " eks-" + params.cluster
				plan = params.cluster + '.plan'
			}
		}
	}
    stage('Checking Terraform') {
        steps {
            sh 'terraform -version'
        }
    }
	
    stage('TF Plan') {
      when {
        expression { params.action == 'create' }
		}	
		steps {
			script {
			dir('cluster') {			
				withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'AWS_Credentials', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
				sh """
					terraform init
					terraform plan \
						-var cluster-name=${params.cluster} \
						-var role=${params.role} \
						-out ${plan}
					echo ${params.cluster}
				"""
				}
			}
        }
      }
	}

    stage('TF Apply') {
      when {
        expression { params.action == 'create' }
		}	
		steps {
			script {
			dir('cluster') {
				withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', 
				accessKeyVariable: 'AWS_ACCESS_KEY_ID', 
				credentialsId: 'AWS_Credentials', 
				secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {

				sh """
					terraform apply -input=false -auto-approve ${plan}
				"""
				}
             }
        }
    }
	}
    
	stage('Cluster setup') {
      when {
        expression { params.action == 'create' }
      }
      steps {
        script {
		dir('cluster') {
          withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', 
          credentialsId: 'AWS_Credentials', 
          accessKeyVariable: 'AWS_ACCESS_KEY_ID',  
          secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
            
            sh """
              aws eks update-kubeconfig --name ${params.cluster} --region ${params.region}
              # Add configmap aws-auth if its not there:
              if [  "\$(kubectl -n kube-system get cm aws-auth 2> /dev/null)" ]
              then
	        kubectl -n kube-system delete cm aws-auth
                echo "Adding aws-auth configmap to ns kube-system..."
                terraform output config_map_aws_auth | awk '!/^\$/' | kubectl apply -f -
              else
                true # coz please dont break this!
              fi
            """
		  }
		}
	  }
	}
	}

	stage('Istio Install') {
	  when {
        expression { params.action == 'create' }
      }
	  steps{
		script{
		dir('cluster') {
		  withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', 
          credentialsId: 'AWS_Credentials', 
          accessKeyVariable: 'AWS_ACCESS_KEY_ID',  
          secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
			
			sh """ 
			  istioctl install --set profile=default -y  --kubeconfig /var/lib/jenkins/.kube/config
			"""
		  }
	  }
	}
	}
	}
	stage('Injecting istio proxy'){
	  when {
        expression { params.action == 'create' }
      }
	  steps{
		script{
		dir('cluster') {
		  withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', 
          credentialsId: 'AWS_Credentials', 
          accessKeyVariable: 'AWS_ACCESS_KEY_ID',  
          secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
			
			sh """
			  kubectl label --overwrite ns istio-system istio-injection=enabled
			  kubectl label namespace default istio-injection=enabled
			"""
		  }
	  }
	}
	}
	}
 
	stage('Install Addons'){
	  when {
        expression { params.action == 'create' }
      }
	  steps{
		script{
		dir('addons') {
		  withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', 
          credentialsId: 'AWS_Credentials', 
          accessKeyVariable: 'AWS_ACCESS_KEY_ID',  
          secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
			
			sh """ 
			 chmod +x kiali-deploy.sh
             ./kiali-deploy.sh
              
			"""
		  }
	  }
	}
	}
	}

	stage('Deploying Kiali Virtual Service'){
	  when {
        expression { params.action == 'create' }
      }
	  steps{
		script{
		dir('addons') {
		  withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', 
          credentialsId: 'AWS_Credentials', 
          accessKeyVariable: 'AWS_ACCESS_KEY_ID',  
          secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
		  
			sh """
				kubectl apply -f kiali-gateway.yaml
			"""
		  }
		}
	  }
	}
	}
    stage('Deploying Sample App'){
	  when {
        expression { params.action == 'create' }
       }
	  steps{
		script{
		dir('sample-app') {
		  withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', 
          credentialsId: 'AWS_Credentials', 
          accessKeyVariable: 'AWS_ACCESS_KEY_ID',  
          secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
		  
			sh """
				kubectl apply -f app.yaml
			"""
		  }
		}
	  }
	}
	}
    
    stage('Deploying App Virtual Service'){
	  when {
        expression { params.action == 'create' }
      }
	  steps{
		script{
		dir('sample-app') {
		  withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', 
          credentialsId: 'AWS_Credentials', 
          accessKeyVariable: 'AWS_ACCESS_KEY_ID',  
          secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
		  
			sh """
				kubectl apply -f app_gateway.yaml
			"""
		  }
		}
	  }
	 }
	}		    
    stage('TF Destroy') {
      when {
        expression { params.action == 'destroy' }
      }
      steps {
        script {
		dir('cluster'){
				withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'AWS_Credentials', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
				sh """
				terraform destroy -auto-approve
				"""
				}
            }
        }
     }
    }
  }
  post {
        always {
            emailext body: 'Your Pipeline has completed', recipientProviders: [[$class: 'DevelopersRecipientProvider'], [$class: 'RequesterRecipientProvider']], subject: 'Build Status'
        }
    }
}
