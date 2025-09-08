#!/usr/bin/env bash

PACKAGE_GROUP_REGEX_TITLE="^#\sGROUP\s(.*)"
PACKAGE_GROUP_REGEX_COMMENT="^#\s(.*)"

SYSTEMD_SERVICE_REGEX_UNIT="([a-z-]*\.service)"

abort() {
    echo
    echo -e "\e[31mHyprcore install warning: $1\e[0m"
    echo
    exit 1
}

execute_command() {
    title=$1
    command=$2
    gum spin --align right --spinner dot --title "$title" --show-error -- $command

    output=$(echo -e "\t\t${title}")
    gum style \
        --foreground "#00FF00" \
        "$output"
}

install_package() {
    if [[ $(is_package_installed "$1") == 0 ]]; then
        echo 1
    else
        title=$(echo -e "\t\t$1")
        gum spin --align right --spinner dot --title "$title" --show-error -- sudo pacman -S --noconfirm --needed "$1" >> $HYPRCORE_LOG
        echo 0
    fi
    return
}

install_package_group() {
    while read -r LINE
    do
        if [[ $LINE == "" ]]
        then
            continue
        fi

        if [[ "$LINE" =~ $PACKAGE_GROUP_REGEX_TITLE ]]; then
            output=$(echo -e "\t${BASH_REMATCH[1]}")
            gum style \
                --foreground 212 \
                "$output"
            continue
        elif [[ "$LINE" =~ $PACKAGE_GROUP_REGEX_COMMENT ]]; then
            continue
        else
            output=$(echo -e "\t\t${LINE}")
            result=$(install_package $LINE)
            case $result in
                0)
                    foreground="#00FF00"
                    ;;
                1)
                    # output="${output}"
                    foreground="#FFFF00"
                    ;;
            esac
            gum style \
                --foreground $foreground \
                "$output"
        fi
    done < $1
}

is_package_installed() {
    package=$1

    if $(pacman -Qi $package &>/dev/null); then
        echo 0
    else
        echo 1
    fi
    return
}

mark_as_executable() {
    title=$(echo -e "\t\tMark as executable: $1")
    chmod +x $1
    gum style \
        --foreground "#00FF00" \
        "$title"
}

print_title() {
    title="HyprCore Installation"
    gum style \
    --align center \
    --border double \
    --border-foreground "#0082c7" \
    --foreground "#0082c7" \
    --margin "1 2" \
    --padding "2 4" \
    --width 50 \
    "$title"
}

run_makepkg() {
    package=$1
    title=$(echo -e "\t\tRunning makepkg for $package")
    gum spin --align right --spinner dot --title "$title" --show-error -- makepkg -si --needed --noconfirm -D $HYPRCORE_CACHE/$package
    gum style \
        --foreground "#00FF00" \
        "$title"
}

systemd_disable_service() {
    title=$(echo -e "\t\t$1")
    service=$2
    if $(systemctl is-enabled --quiet $service); then
        gum spin --align right --spinner dot --title "$title" --show-error -- sudo systemctl disable --quiet "$service" >> $HYPRCORE_LOG
    fi
    gum style \
        --foreground "#00FF00" \
        "$title ($service)"
}

systemd_enable_service() {
    title=$(echo -e "\t\t$1")
    service=$2
    if ! $(systemctl is-enabled --quiet $service); then
        gum spin --align right --spinner dot --title "$title" --show-error -- sudo systemctl enable --quiet "$service" >> $HYPRCORE_LOG
    fi
    gum style \
        --foreground "#00FF00" \
        "$title ($service)"
}

systemd_enable_user_service() {
    title=$(echo -e "\t\t$1")
    service=$2

    if [[ "$service" =~ $SYSTEMD_SERVICE_REGEX_UNIT ]]; then
            unit=$(echo -e "\t${BASH_REMATCH[1]}")
    fi
    if ! $(systemctl --user is-enabled --quiet $unit); then
        gum spin --align right --spinner dot --title "$title" --show-error -- systemctl --user --quiet enable "$service" >> $HYPRCORE_LOG
    fi
    gum style \
        --foreground "#00FF00" \
        "$title ($service)"
}

systemd_mask_service() {
    title=$(echo -e "\t\tPrevent service to be enabled")
    service=$1

    # if $(systemctl is-enabled $service &>/dev/null); then
        gum spin --align right --spinner dot --title "$title" --show-error -- sudo systemctl mask --quiet "$service" >> $HYPRCORE_LOG
    # fi
    gum style \
        --foreground "#00FF00" \
        "$title ($service)"
}