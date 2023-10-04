#!/bin/bash

if [[ $1 == "--list" ]]; then
    apphost=$(yc compute instance list | grep "reddit-app" | awk {'print $10'})
    dbhost=$(yc compute instance list | grep "reddit-db" | awk {'print $10'})

    cat <<EOT
{
    "_meta": {
        "hostvars": {}
    },
    "app": {
        "hosts": ["${apphost}"],
        "vars": {
            "ansible_user": "ubuntu",
            "ansible_private_key_file": "~/.ssh/ubuntu"
        }
    },
    "db": {
        "hosts": ["${dbhost}"],
        "vars": {
            "ansible_user": "ubuntu",
            "ansible_private_key_file": "~/.ssh/ubuntu"
        }
    }
}
EOT
elif [[ $1 == "--host" ]]; then
    echo '{"_meta": {"hostvars": {}}}'
else
    echo '{}'
fi
