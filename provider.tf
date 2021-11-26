provider "google" {
  credentials = file(var.credentials_file)
}