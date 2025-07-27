s() {
    local host_alias="$1"
    local user_host="$2"
    local identity_file="${3:-~/.ssh/id_rsa}"

    local user=$(echo "$user_host" | grep -q "@" && echo "${user_host%@*}" || echo "root")
    local host="${user_host#*@}"

    local ssh_config="$HOME/.ssh/config"

    if grep -q "Host $host_alias" "$ssh_config"; then
        echo "Host '$host_alias' already exists in $ssh_config"
    else
        {
            echo -e "\nHost $host_alias"
            echo "    HostName $host"
            echo "    User $user"
            echo "    IdentityFile $identity_file"
        } >> "$ssh_config"

        echo "Host '$host_alias' added to $ssh_config"
    fi
}

a() {
    local alias_name="$1"
    shift
    local alias_command="$@"

    if [[ -z "$alias_name" || -z "$alias_command" ]]; then
        echo "Usage: a {alias} {command}"
        return 1
    fi

    touch ~/.bash_aliases

    sed -i "/^alias $alias_name=/d" ~/.bash_aliases

    echo "alias $alias_name='$alias_command'" >> ~/.bash_aliases

    source ~/.bash_aliases
}

ashow() {
    local alias_name="$1"

    if [[ -z "$alias_name" ]]; then
        echo "Usage: find_alias {alias}"
        return 1
    fi

    if [[ ! -f ~/.bash_aliases ]]; then
        echo "No aliases file found."
        return 1
    fi

    local alias_cmd
    alias_cmd=$(grep "^alias $alias_name=" ~/.bash_aliases | sed "s/^alias $alias_name='\(.*\)'/\1/")

    if [[ -z "$alias_cmd" ]]; then
        echo "Alias '$alias_name' not found."
    else
        echo "a $alias_name \"$alias_cmd\""
    fi
}
