provider "databricks" {
  host     = "https://dbc-33f2a9fe-79a8.cloud.databricks.com"
  token    = var.databricks_token
}

resource "databricks_cluster" "example" {
  cluster_name            = "example-cluster"
  spark_version           = "7.3.x-scala2.12"
  node_type_id           = "i3.xlarge"
  num_workers            = 2

  autotermination_minutes = 20
}

resource "databricks_job" "example_job" {
  name = "Example Job"
  existing_cluster_id = databricks_cluster.example.id

  notebook_task {
    notebook_path = "/Users/your_username/notebooks/data_exploration"
  }
}

variable "databricks_token" {
  description = "Databricks personal access token"
  type        = string
}