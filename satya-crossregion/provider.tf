provider "aws" {
  profile    = "${var.profile}"
  region     = "${var.region}"
}
provider "aws" {
  profile = "${var.profile}"
  alias   = "us-east-1"
  region  = "us-east-1"
}