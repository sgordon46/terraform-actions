
resource "random_shuffle" "zones" {
  input        = ["us-east1-b","us-east1-c","us-east1-d","us-east4-c","us-east4-b","us-east4-a","us-central1-c","us-central1-a","us-central1-f","us-central1-b","us-west1-b","us-west1-c","us-west1-a","us-east5-a","us-east5-b","us-east5-c","us-south1-a","us-south1-b","us-south1-c","us-west2-a","us-west2-b","us-west2-c","us-west3-a","us-west3-b","us-west3-c","us-west4-a","us-west4-b","us-west4-c"]
  result_count = 1
}

resource "random_shuffle" "images" {
  input        = ["centos-cloud/centos-stream-8","centos-cloud/centos-stream-9","debian-cloud/debian-10","debian-cloud/debian-11-arm64","debian-cloud/debian-11","ubuntu-os-cloud/ubuntu-1804-lts-arm64","ubuntu-os-cloud/ubuntu-1804-lts","ubuntu-os-cloud/ubuntu-2004-lts-arm64","ubuntu-os-cloud/ubuntu-2004-lts","ubuntu-os-cloud/ubuntu-2204-lts-arm64","ubuntu-os-cloud/ubuntu-2204-lts","ubuntu-os-cloud/ubuntu-2210-amd64","ubuntu-os-cloud/ubuntu-2210-arm64","ubuntu-os-cloud/ubuntu-minimal-1804-lts-arm64","ubuntu-os-cloud/ubuntu-minimal-1804-lts","ubuntu-os-cloud/ubuntu-minimal-2004-lts-arm64","ubuntu-os-cloud/ubuntu-minimal-2004-lts","ubuntu-os-cloud/ubuntu-minimal-2204-lts-arm64","ubuntu-os-cloud/ubuntu-minimal-2204-lts","ubuntu-os-cloud/ubuntu-minimal-2210-amd64","ubuntu-os-cloud/ubuntu-minimal-2210-arm64"]
  result_count = 1
}

data "template_file" "default" {
  template = file("${path.module}/templates/user-data.sh.tpl")

  vars = {
    tl_username = var.tl_username
    tl_password = var.tl_password
    tl_console = var.tl_console
  }

}

resource "google_compute_instance" "vm_instance" {
  name = "${var.name}-${var.project}"
  machine_type = "e2-small"
  project = var.project
  zone = random_shuffle.zones.result[0]

  metadata_startup_script = data.template_file.default.rendered

  boot_disk {
    initialize_params {
      image = random_shuffle.images.result[0]
    }
  }


  labels = {
    environment = "dev",
    type = "host"
  }

  network_interface {
    # A default network is created for all GCP projects
    network = "default"
    access_config {
    }
  }
}