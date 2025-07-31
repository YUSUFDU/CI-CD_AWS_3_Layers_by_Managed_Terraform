provider "aws" {
  alias  = "default"
  region = var.aws_region
}

provider "aws" {
  alias  = "us_east_1"
  region = var.us_east_1_region
}

provider "aws" {
  alias  = "eu_central_1"
  region = "eu-central-1"
}

provider "aws" {
  alias  = "us_west_2"
  region = "us-west-2"
}
