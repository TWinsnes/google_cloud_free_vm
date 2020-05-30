provider "google" {
    region      = "us-east1"
}

variable "billing_account_id" {
    type = string
}

resource "random_string" "project_number" {
    length = 4
    special = false
    upper = false
    lower = false
}

resource "google_project" "freebie" {
    name = "Freebie VM"
    project_id = "freebie-vm-${random_string.project_number.result}"
    billing_account = var.billing_account_id
}

resource "google_compute_project_metadata" "freebie" {
    project = google_project.freebie.project_id
    metadata = {
        enable-oslogin = true
    }

    depends_on = [
        google_project_service.compute_engine_api,
    ]
}

resource "google_project_service" "compute_engine_api" {
    service = "compute.googleapis.com"
    project = google_project.freebie.project_id

    disable_dependent_services = true
}

resource "google_compute_instance" "free_vm" {
    name = "freebie"
    machine_type = "f1-micro"
    zone = "us-east1-b"
    project = google_project.freebie.project_id

    depends_on = [
        google_project_service.compute_engine_api,
        google_compute_project_metadata.freebie,
    ]

    boot_disk {
        initialize_params {
            image = "ubuntu-os-cloud/ubuntu-minimal-2004-lts"
            size = 30
        }
    }

    network_interface {
        network = "default"

        access_config {
            network_tier = "STANDARD"
        }
    }
}

output "public_ip" {
    value = google_compute_instance.free_vm.network_interface.0.access_config.0.nat_ip
}

output "project_id" {
    value = google_project.freebie.project_id
}

output "vm_name" {
    value = google_compute_instance.free_vm.name
}

output "zone" {
    value = google_compute_instance.free_vm.zone
}