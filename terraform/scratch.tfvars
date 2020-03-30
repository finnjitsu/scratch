stack_name                 = "scratch"
account_alias              = "finnjitsu"
vpc_cidr                   = "10.0.0.0/16"
app_subnet_a_cidr          = "10.0.0.0/24"
app_subnet_b_cidr          = "10.0.1.0/24"
db_subnet_a_cidr           = "10.0.2.0/24"
db_subnet_b_cidr           = "10.0.3.0/24"
web_subnet_a_cidr          = "10.0.4.0/24"
web_subnet_b_cidr          = "10.0.5.0/24"
scheduled_downtime_flag    = "ScratchScheduledDowntime"
scheduled_downtime_enabled = true
stop_schedule              = "15 14 ? * 1-5 *"
start_schedule             = "0 12 ? * 1-5 *"