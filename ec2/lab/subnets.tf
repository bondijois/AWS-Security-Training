resource "aws_subnet" "public-subnet" {
  cidr_block = "${var.public_subnet_cidr}"
  vpc_id = "${aws_vpc.default.id}"
  availability_zone = "us-east-1a"

  tags {
    Name = "Public Subnet"
  }
}

resource "aws_route_table_association" "public-subnet" {
  route_table_id = "${aws_route_table.public-route.id}"
  subnet_id = "${aws_subnet.public-subnet.id}"
}

resource "aws_subnet" "private-subnet" {
  cidr_block = "${var.private_subnet_cidr}"
  vpc_id = "${aws_vpc.default.id}"
  availability_zone = "us-east-1b"

  tags {
    Name = "Private Subnet"
  }
}

resource "aws_route_table_association" "private-subnet" {
    subnet_id = "${aws_subnet.private-subnet.id}"
    route_table_id = "${aws_route_table.private-route.id}"
}

