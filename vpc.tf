provider "aws" {
  region     = "ap-south-1"
  access_key = "AKIA3FLD3qddfdafsdfY27AQXG2NFU"  #aws acces key
  secret_key = "/Q+yD97Ept2fsdfsdasdasjv2bjVKjewivJGgWhudsdSpkrp05+Qkg" #aws secret key
}


# main.tf

module "my_vpc" {
  source = "./terraform-vpc"

  vpc_name              = "my-vpc"
  vpc_cidr_block        = "10.0.0.0/16"
  subnet_app_cidr_block = "10.0.1.0/24"
  subnet_db_cidr_block  = "10.0.2.0/24"
  subnet_app_name       = "my-app-subet"
  subnet_db_name        = "my-db-sunnet"
  subnet_app_zone       = "ap-south-1a"
  subnet_db_zone        = "ap-south-1b"
  igw_name              = "my-igw"
  routeable_name        = "my-routetable"

}

