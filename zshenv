source "$HOME/.cargo/env"
. "$HOME/.cargo/env"
if [ -e /Users/ivanov/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/ivanov/.nix-profile/etc/profile.d/nix.sh; fi
export ZEROBREW_DIR=/Users/ivanov/.zerobrew
export ZEROBREW_BIN=/Users/ivanov/.local/bin
export ZEROBREW_ROOT=/opt/zerobrew
export ZEROBREW_PREFIX=/opt/zerobrew/prefix
export PKG_CONFIG_PATH="/opt/zerobrew/prefix/lib/pkgconfig:${PKG_CONFIG_PATH:-}"
_zb_path_append() {
    local argpath="$1"
    case ":${PATH}:" in
        *:"$argpath":*) ;;
        *) export PATH="$argpath:$PATH" ;;
    esac
}
if [[ "$OSTYPE" == "darwin"* ]]; then
    _zb_path_append /usr/local/bin
    _zb_path_append /opt/homebrew/bin
fi
_zb_path_append $ZEROBREW_BIN
_zb_path_append $ZEROBREW_PREFIX/bin
export PATH="/opt/zerobrew/prefix/bin:$PATH"
