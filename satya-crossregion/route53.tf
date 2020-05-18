data "aws_route53_zone" "cloud" {
  name         = "cloudlinuxacademy.com."
}

resource "aws_route53_record" "www" {
  allow_overwrite = true
  zone_id = "${data.aws_route53_zone.cloud.zone_id}"
  name    = "prod.${data.aws_route53_zone.cloud.name}"
  type    = "CNAME"
  ttl     = "60"
  records = ["${aws_lb.applb.dns_name}"]
}
