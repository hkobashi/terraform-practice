# terraform-practice
 [参考URL](https://github.com/BuchioS/beginners_terraform_for_aws)

# Terraform Resource Repository
AWS Infra management repository.

# Versions
## Terraform
`brew install tfenv`
`terraform -install-autocomplete`
`tfenv install 0.13.5`
`terraform -v`
> Terraform v0.13.5

## AWS CLI
`aws --version`
> aws-cli/2.1.1 Python/3.9.0 Darwin/19.6.0 source/x86_64

## Direnv
### Install
`brew install direnv`
`echo 'eval "$(direnv hook bash)"' >> ~/.bashrc` or `echo 'eval "$(direnv hook zsh)"' >> ~/.zshrc`
`cp .envrc.sample .envrc`

# New Environment Command
## Directory Change(Exec Directory)
> coorum/environments/immutable
> coorum/environments/not_immutable

## Initialize
`terraform init`

## Change Env
`terraform workspace`

## Downloads tfvars File
`aws s3 cp s3://jp.coorum.files.private/coorum/terraform/env.tfvars coorum/globals/secret/env.tfvars`

# Run Terraform Command
## Case: coorum application container(Directory: coorum/globals/secret)
`terraform apply -var-file=env.tfvars`

## Case: other
`terraform apply`
