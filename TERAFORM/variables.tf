variable "availability_zone" {
  default = "ap-south-1a"
}

variable "ami-ec2" {
  default = "ami-081c93e64252e1b27"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  default = "deployer-key"
}

variable "EBS_size" {
  default = "8"
}

variable "device_name" {
  default = "/dev/sdh"
}


variable "public_key_name" {
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDJDa/Qo0L6dTwgXUzSoFLRW8WBuEVtKJbamqo26j9GsQ9NvR65x1BLgsMfGdaBDG51SK42dgyeBGj0YYhIAmtLDw5PjR1enX2XA4EaYoSrJB5h449HpG3E9MlUlU8f+JWmggNx9yJ7mu0fre69+/dtjbVrqtNWclGeGz9ITrKdGcUy7Ck4OQT9paLF2ut6W1q1/OPCMS6FIeY5A1zQtncw5+utCZ+sbTZVkZ976JdglJKZ1CIDwIy5LrT1sV4J7jxNP36V3/xS3F+dgwIxOG3Yxpl6rAe4WVDSAq8Bq1Tp+HGw4F3NreYBUB9zwPKvBkC7vvueSz6G+CqPcCwLT/nI8Kp0arDW4pYBEb/W6gYRkkmBzMPNGqJO1zNVJ45uojlwGej2diIHdCBqFW6YV+M3WpMxt0KD6yiH3jEmeNP5x0ZT4EqZvus5p4ZSU086oSpQs7oQNGR+8PvHVLY8fCUgA2iv1G7z129eUo/SraWtcqTkegLL+eJZrx7zpMwbK4s= niba@niba-Inspiron-3543"
}


variable "sg_name" {
  default = "allow_tls"
}

variable "sg_description" {
  default = "Allow TLS inbound traffic"
}
