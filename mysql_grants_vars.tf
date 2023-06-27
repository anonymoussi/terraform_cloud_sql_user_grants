variable "mysql_databases" {
  default = [
    "foo",
    "bar"
  ]
}

variable "mysql_users" {
  default = [
    "stage-cat",
    "stage-dog",
    "stage-snake"
  ]
}

variable "mysql_grants" {
  default = {
    "cat-0" = {
      name     = "stage-cat"
      database = "foo"
      grant    = ["ALL"]
    },
    "cat-1" = {
      name     = "stage-cat"
      database = "bar"
      grant    = ["SELECT", "EXECUTE", "SHOW VIEW"]
    },
    "dog-0" = {
      name     = "stage-dog"
      database = "bar"
      grant    = ["ALL"]
    }
  }
}
