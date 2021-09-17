name "backend"
description "A role to install mysql database servers"
run_list "recipe[mysql]"
env_run_lists { 
 "dev" => [ ]
 "qa"  => [ ] 
}
