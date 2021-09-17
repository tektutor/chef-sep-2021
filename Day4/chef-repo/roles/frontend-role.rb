name "frontend"
description "A role to install wordpress frontend servers"
run_list "recipe[wordpress]"
env_run_lists { 
 "dev" => [ "recipe[wordpress]" , "recipe[mysql]" ]
 "qa"  => [ ] 
}
