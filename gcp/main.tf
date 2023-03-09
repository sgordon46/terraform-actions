#export GOOGLE_APPLICATION_CREDENTIALS="/Users/sgordon/credentials/sgordon-primary-5ba6698bdd90.json"

#gcloud compute zones list --filter='name:us*' | awk '{print $1}' | tail -n +2| tr -s '\n' ',' | sed -e 's/,/","/g'
#gcloud compute images list | grep -e debian-cloud -e centos-cloud -e ubuntu-os-cloud | awk '{print $2,"/",$3}'|tr -d ' '| tail -n +2| tr -s '\n' ',' | sed -e 's/,/","/g'

#project1-366201
#project2-366201
#sgordon-primary

#gcloud iam roles create AgentlessPermissions2 --organization=845555366449 --file=custom_role.yaml

provider "google" {
  region = "us-central1"
  zone    = "us-central1-a"
}


module "vm-primary"{
    count=var.count-of_each
    source = "./modules/instance"
    project = "sgordon-primary"
    name = "vm-${count.index}"
}

module "vm-project1"{
    count=var.count-of_each
    source = "./modules/instance"
    project = "project1-366201"
    name = "vm-${count.index}"

}

module "vm-project2"{
    count=var.count-of_each
    source = "./modules/instance"
    project = "project2-366201"
    name = "vm-${count.index}"

}

