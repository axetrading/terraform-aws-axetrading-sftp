provider "aws" {
  region = "ap-southeast-2"
  alias  = "sydney"
  assume_role {
    role_arn     = local.assume_role
    session_name = "terraform"
  }
}

provider "aws" {
  region = "us-east-1"
  alias  = "northvirginia"
  assume_role {
    role_arn     = local.assume_role
    session_name = "terraform"
  }
}

provider "aws" {
  region = "eu-west-2"
  alias  = "london"
  assume_role {
    role_arn     = local.assume_role
    session_name = "terraform"
  }
}

provider "aws" {
  region = "ap-southeast-1"
  alias  = "singapore"
  assume_role {
    role_arn     = local.assume_role
    session_name = "terraform"
  }
}