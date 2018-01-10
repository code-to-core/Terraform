module "nestedA" {
    source = "./modules/nestedA"

    memory = "1G"
}

output "child_memory" {
    value = "${module.nestedA.received}"
}


