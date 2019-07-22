# k8-cluster-level1
My git repository for this Level 1 test:

https://github.com/bibek2003/k8-cluster-level1.git

Solutions to Tasks:
-------------------

1: Kubernetes cluster creation on GCP
-------------------------------------
a) Cluster created on GCP on 3 Ubuntu instanes first manually and then recreated it using Terraform
    - Terraform configuration file "main.tf" available in the repository and could be used to deploy the Ubuntu instances on GCP
    - Need to install Terraform first on a Linux workstation i.e. Desktop/Laptop/VM/Cloud Instances etc.
    - You need to provide your own credential and project ID for your GCP account in the main.tf file before starting to deply
    - Once the file is updated with correct details, need to use the command "terraform init" and then execute "terraform plan"
    - If everything looks fine execute "terraform apply"
    - This will deploy 3 instances (i.e. 1 master node and 2 worker nodes) to be used in a kubernetes cluster
    - Nodes could be accessible over ssh using the userid "k8user" and default password "abc@123" as defined in the main.tf file.
  
      Note: Password could be changed after the nodes are deployed.
      
 b) Prepare the nodes for Kubernetes cluster setup and actual setup
      - Login to all the three nodes and clone my git repository
         
         git clone https://github.com/bibek2003/k8-cluster-level1.git
         
      - Execute the the bash script "cluster-setup-prep-all-nodes.sh" on all of them
      
          cd k8-cluster-level1
          ./cluster-setup-prep-all-nodes.sh
          
 c)  Initialize the cluster:
 
      - Once the above steps are complete, perform cluster initialization i.e. bootstrap the cluster on the 1st node i.e Master Node by         executing the script "cluster-initialize-on-master.sh".   [On MASTER node only]
      
           cd k8-cluster-level1
           ./cluster-initialize-on-master.sh
         
         This will also install the overlay network using Flannel network framework
           
       - The abpve script generates a file "/tmp/join-worker-to-cluster.sh" in /tmp directory which contains command to join the other             worker nodes to the cluster. Just execute the command as it is on the other two worker nodes.
      
           Example:
           root@k8-vm1-8234d4ed3aaabbe4:~/kubernetes-cluster-setup/k8-cluster-level1# cat /tmp/join-worker-to-cluster.sh
           kubeadm join 10.128.0.11:6443 --token o1xrke.y8a3o8eri5jb32c5 --discovery-token-ca-cert-hash \                sha256:5f627e08290eccbd737e77f094896c25ad77446bf1623d2e886a63dc9b80c35b

           Note: the above command is single line without any break
           
         - Test the cluster using the command "kubectl get nodes -o wide"
         
            
2:	Install nginx ingress controller on the cluster
----------------------------------------------------

    - Execute the the bash script "install-nginx-ingress-controller.sh" available in my git repository on the master node to install           Nginx Ingress Controller on the cluster
    
          cd k8-cluster-level1
          ./install-nginx-ingress-controller.sh
          
     - The above script will setup LoadBalancer/NodePort Service For Ingress Controller
     
     Note: necessary YAML files are available in the cloned git repository which could be used by the above script.
     
Tasks 3 and 4: Create namespaces and Deploy "Guest-book" application on the cluster
-----------------------------------------------------------------------------------

    - Execite the script "deploy-guestbook-application.sh" on the master node from cloned git repository
          
         cd k8-cluster-level1
          ./deploy-guestbook-application.sh
          
          Note: The above script will perform the following tasks:
                - Clone the provided git repository for Guest-Book application
                   https://github.com/kubernetes/examples.git
                - Create namespaces staging and production
                - Deploy redis master deployment and service on both ghe namespaces
                - Deploy redis slave deployement and service on both ghe namespaces
                - Deploy frontend Deployment and service on both the namespaces
             
            - Test the deployment and services using the following command
            kubectl get deploy -n staging
            kubectl get deploy -n production
            kubectl get service -n staging
            kubectl get service -n production
            

Task 5 and 6: Expose staging and production application
-------------------------------------------------------

   - Execute the script "create-ingress-resource.sh" to create ingress resorces and expose the application
      
          cd k8-cluster-level1
          ./create-ingress-resource.sh
                
      Note: The above script will add necessary host entries in /etc/host and then create the ingress resource.
      
Task 7: Pod autoscaler on both namespaces which will scale frontend pod replicas up and down based on CPU utilization of pods.  
-----------------------------------------------------------------------------------------------------------------------------
   
     - Execute the script "horizontal-pod-autoscalar.sh" on the master node
     
            cd k8-cluster-level1
            ./horizontal-pod-autoscalar.sh
        
        Note: The above script will perform the following tasks:
              - Deploy metrics-server on the cluster which catures resource metrics from the cluster resource i.e. cpu, memory etc
              - Deployment packages are available in the mentioned git repository however for this installation I have copied it in my                   repository and could be used by the above script.
              
                 https://github.com/kubernetes-incubator/metrics-server.git
               - Create the hprizontal autoscaling resource that scales up and down pods based on CPU utilization
               
Task 8: Simulate Horizontal autoscaling for both namespaces
-----------------------------------------------------------

      - Execute the following scripts to simulate autoscaling
      
          ./simulate-pod-autoscale-production.sh
          ./simulate-pod-autoscale-staging.sh
          
          Note: This will generate load on the server using the command "siege" scale up frondend pods which CPU utilization exceeds 20%                  and scale down when cpu utilization goes below 20%
          
          
          
Task 9: Steps 2 to 9 could be clubbed into a single wrapper script that will perform the tasks at a single go however due to lack of time could not complete it.


In the context of above test, please explain the following:
•	What was the node size chosen for the Kubernetes nodes? And why?
  - I have choosen n1-standard-2 because it provide 2 vCPU and 8 GB memory and 10 GB persistant disk which seems to be a nearest match with the recommendation for Kubernetes cluster.
  
•	What method was chosen to install the demo application and ingress controller on the cluster, justify the method used
  - I have used the "Kubernetes Deployment" methode as it seems to be easier and configure evrything within the cluster using pods and services.

•	What would be your chosen solution to monitor the application on the cluster and why?
   -Prometheus with Grafana could be the best choice because it provides Deployment based installation and provides  richer features and cool dashboard.

•	What additional components / plugins would you install on the cluster to manage it better? 
   - I would like to deploy Kubernetes dashboad, Jenkins for CI/CD and Helm for package repository. I would also Like to integrate automation tool like Ansible with the cluster.


            

