# install_helpers.bash
# author: Seong Yong-ju <sei40kr@gmail.com>

COLUMNS="$(tput cols)"

BOLD="$(tput bold)"
RED="$(tput setaf 1)"
GREEN="$(tput setaf 2)"
YELLOW="$(tput setaf 3)"
BLUE="$(tput setaf 4)"
PURPLE="$(tput setaf 5)"
CYAN="$(tput setaf 6)"
WHITE="$(tput setaf 7)"
RESET="$(tput sgr0)"

print_line() {
    local empty_line
    empty_line="$(printf "%${COLUMNS}s")"

    echo "${empty_line// /-}"
}

print_title() {
    local title
    title="$1"

    clear
    print_line
    echo "# ${BOLD}${title}${RESET}"
    print_line
    echo ''
}

print_desc() {
    local desc
    desc="$1"

    echo "$desc"
    echo ''
}

menu_item() {
    local title
    title="$1"

    echo "${BOLD}${title}${RESET}"
}

ask_yn() {
    local prompt
    local answer
    prompt="$1"

    read -n1 -rp "${prompt} [yn]: " answer
    echo ''
    echo ''

    if [[ "$answer" == [yY] ]]; then
        return 0
    fi

    return 1
}

error() {
    local msg
    local exit_status
    msg="$1"
    exit_status="$2"

    echo "Error: $msg" >&2
    exit "${exit_status:-1}"
}

pause() {
    print_line
    read -sn 1 -p 'Press enter to continue ...'
}

pacman_query() {
    local -a pkgs
    pkgs=( "$@" )

    pacman -Q "${pkgs[@]}" &>/dev/null
}

pacman_sync() {
    local -a pkgs
    pkgs=( "$@" )
    sudo pacman -Spy --print-format '%r' "${pkgs[@]}" | read -ra repos

    echo 'Installing'

    for pkg in "${pkgs[@]}"; do
        echo "- ${pkg}"
    done

    sudo pacman -Sy --needed --noconfirm --noprogressbar "${pkgs[@]}"
}

trizen_sync() {
    local -a pkgs
    pkgs=( "$@" )

    if ! pacman_query trizen; then
        error 'trizen is not installed. Aborting.'
    fi

    echo 'Installing'

    for pkg in "${pkgs[@]}"; do
        echo "- ${pkg}"
    done

    trizen -Sy --needed --noconfirm --noprogressbar --nopull "${pkgs[@]}"
}

sudo_systemctl_enable() {
    local unit
    unit="$1"

    sudo systemctl enable --now "$unit"
}

systemctl_user_enable() {
    local unit
    unit="$1"

    systemctl --user enable --now "$unit"
}

pip_install() {
    local -a pkgs
    pkgs=( "$@" )

    pip install --user --disable-pip-version-check "${pkgs[@]}"
}
