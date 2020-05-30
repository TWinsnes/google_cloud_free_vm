provider "google" {
  project     = "home-nebula"
  region      = "us-east1"
}

resource "google_compute_instance" "free_vm" {
    name = "freebie"
    machine_type = "f1-micro"
    
    boot_disk {
        initialize_params {
            image = "ubuntu-os-cloud/ubuntu-minimal-2004-lts"
            size = 30
        }
    }
}