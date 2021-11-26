# devops-course-task6c-terraform

This repository contains GCP DM configuration file created using Terraform, which creates compute instance type e2-micro with a Debian 9 OS and installed NGINX web server.

# Improvements
## Splitting the code
Putting all code in one file is absolutelly okay when you're getting familiar with Terraform. However, it is strongly recommended to split the code logically  into the following files:

* `main.tf` - create all resources
* `provider.tf` - contains Provider's configuration. It's not changed as much as other parts of code, so it's better to keep it in a separate file.
* `variables.tf` - contains declarations of variables used in `main.tf`
* `outputs.tf` - contains outputs from the resources created in `main.tf`

* `terraform.tfvars` - the values of variables are specified here. They are usually project-specific, so it's better to add it to `.gitignore`. You shoild try keeping Terraform code as generic as possible, so itcan be easily re-used by other people.
* `terraform.tfvars.example` - this one contains some examples on how to specify the variables, some comments, etc. Store in in the repo, so everyone can use it as an example

## Using .gitignore file
Some files and folders are generated when you use `terraform` CLI and you don't eant to send them to the repository. That is aslo true for the files containing sensitive information, like GCP Service Accoun's key. Please be very careful with that stuff and avoid sending them to the repos, especially to the public ones!
And `.gitignore` file is exactly what we need here. Please carefully review the [one that is used here](.gitignore).

## VM bootstrap script
The `nginx.sh` bootstrap script must be there when you run `terraform apply`, so I've added it.

## Ouputs file
As it was mentioned, the `outputs.tf` here contains outputs from the resources created by the module. More specifically for this particular case, it references VM's external IP, which is printed out every time you run `terraform apply`

## Main file
Avoid using hard-coded parameter in the `main.tf`. Use references to the variables instead. Review the `main.tf` file here to see how it works.

## Provider
It is not really necessary to specify `project`, `region` and `zone` in the `provider` configuration. You may want to create different resources and place them to the different zones in the differebt projects. As for the `region` here, it is not required to create `google_compute_instance` and `google_compute_firewall` resources. So the only parameter that you need specify in the `provider` is credentials. Please tale a look at the `main.tf` and `provider.tf` files here to see how it works.

## Project-specific input parameters
The `terraform.tfvars` contains project-specific values, like `project_name` and `credentials_file_name` here. Avoid specifying them as defauls in the `variables.tf` file since it is stored in the public repo and you don't want sending any project-specific data to it. Please reveiw the `variables.tf` to see which variables have defualt values and which ones do not.

## Injecting GCP credentials

## Useful links
* [Terraform Best Practices - Code Structure](https://www.terraform-best-practices.com/code-structure)