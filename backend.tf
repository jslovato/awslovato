terraform {
  backend "remote" {
    organization = "awslovato"

    workspaces {
      name = "tf-awslovato"
    }
  }
}