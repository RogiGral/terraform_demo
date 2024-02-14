provider "aws" {
    region = "eu-central-1" 
}

################################################################################################    Archive Handlers

data "archive_file" "zip_handlers" {
    type        = "zip"
    source_dir  = "${path.module}/handlers/"
    output_path = "${path.module}/output/handlers.zip"
}