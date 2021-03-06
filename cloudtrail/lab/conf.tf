provider "aws" {
  region     = "us-east-1"
}

resource "aws_cloudtrail" "cloudtrial" {
  name                          = "tf-trail-cloudtrial"
  s3_bucket_name                = "${aws_s3_bucket.s3-bucket.id}"
  s3_key_prefix                 = "prefix"
  include_global_service_events = false
}

resource "aws_s3_bucket" "s3-bucket" {
  bucket        = "tf-test-trail-ucsf"
  force_destroy = true

  policy = <<POLICY
  {
      "Version": "2012-10-17",
      "Statement": [
          {
              "Sid": "AWSCloudTrailAclCheck",
              "Effect": "Allow",
              "Principal": {
                "Service": "cloudtrail.amazonaws.com"
              },
              "Action": "s3:GetBucketAcl",
              "Resource": "arn:aws:s3:::tf-test-trail-ucsf"
          },
          {
              "Sid": "AWSCloudTrailWrite",
              "Effect": "Allow",
              "Principal": {
                "Service": "cloudtrail.amazonaws.com"
              },
              "Action": "s3:PutObject",
              "Resource": "arn:aws:s3:::tf-test-trail-ucsf/*",
              "Condition": {
                  "StringEquals": {
                      "s3:x-amz-acl": "bucket-owner-full-control"
                  }
              }
          }
      ]
  }
  POLICY
}
