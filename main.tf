// Configure the Google Cloud provider
provider "google" {
 credentials = "${file("CREDENTIAL-FILE.json")}"
 project     = "k8-lab-test"
 region      = "us-central1-a"
}

// Terraform plugin for creating random ids
resource "random_id" "instance_id" {
 byte_length = 8
}

// A single Google Cloud Engine instance #1
resource "google_compute_instance" "default1" {
 name         = "k8-vm1-${random_id.instance_id.hex}"
 machine_type = "n1-standard-2"
 zone         = "us-central1-a"

 boot_disk {
   initialize_params {
     image = "ubuntu-1804-bionic-v20190628"
   }
}
 // Make sure flask is installed on all new instances for later steps
metadata_startup_script = "sudo apt-get update -y; sudo adduser --disabled-password --gecos '' k8user;echo 'k8user:abc@123' | sudo chpasswd; usermod -aG admin k8user; sed -i 's/#Port 22/Port 22/' /etc/ssh/sshd_config; sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config; systemctl restart sshd.service"

 network_interface {
   network = "default"

   access_config {
     // Include this section to give the VM an external ip address
   }
 }
}

// A single Google Cloud Engine instance #2
resource "google_compute_instance" "default2" {
 name         = "k8-vm2-${random_id.instance_id.hex}"
 machine_type = "n1-standard-2"
 zone         = "us-central1-a"

 boot_disk {
   initialize_params {
     image = "ubuntu-1804-bionic-v20190628"
   }
}
 // Make sure flask is installed on all new instances for later steps
metadata_startup_script = "sudo apt-get update -y; sudo adduser --disabled-password --gecos '' k8user;echo 'k8user:abc@123' | sudo chpasswd; usermod -aG admin k8user; sed -i 's/#Port 22/Port 22/' /etc/ssh/sshd_config; sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config; systemctl restart sshd.service"

 network_interface {
   network = "default"

   access_config {
     // Include this section to give the VM an external ip address
   }
 }
}

// A single Google Cloud Engine instance #3
resource "google_compute_instance" "default3" {
 name         = "k8-vm3-${random_id.instance_id.hex}"
 machine_type = "n1-standard-2"
 zone         = "us-central1-a"

 boot_disk {
   initialize_params {
     image = "ubuntu-1804-bionic-v20190628"
   }
}
 // Make sure flask is installed on all new instances for later steps
metadata_startup_script = "sudo apt-get update -y; sudo adduser --disabled-password --gecos '' k8user;echo 'k8user:abc@123' | sudo chpasswd; usermod -aG admin k8user; sed -i 's/#Port 22/Port 22/' /etc/ssh/sshd_config; sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config; systemctl restart sshd.service"

 network_interface {
   network = "default"

   access_config {
     // Include this section to give the VM an external ip address
   }
 }
}

