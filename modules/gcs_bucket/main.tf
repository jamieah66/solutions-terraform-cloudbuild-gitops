resource "google_storage_bucket" "my_bucket" {
  name          = "iac-terraform-gitops-cb-bkt"    # Globally unique name
  location      = "us-east1-c"                     # Multi-region or single region (e.g., US-CENTRAL1)
  storage_class = "STANDARD"                       # Options: STANDARD, NEARLINE, COLDLINE, ARCHIVE

  # Force destroy allows deleting the bucket even if it contains objects
  force_destroy = true 

  # Enforce uniform IAM policies for security (Best Practice)
  uniform_bucket_level_access = true

  # Block all public internet access to the bucket contents (Best Practice)
  public_access_prevention = "enforced"

  # Automatically delete or transition files based on rules
  lifecycle_rule {
    condition {
      age = 90 # Days
    }
    action {
      type = "Delete"
    }
  }

  labels = {
    environment = "dev"
    managed_by  = "terraform"
  }
}
