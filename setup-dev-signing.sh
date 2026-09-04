#!/bin/zsh
set -euo pipefail

project_dir="${0:A:h}"
identity="DisplayHarbor Development"

if security find-identity -v -p codesigning 2>/dev/null | grep -Fq "\"$identity\""; then
    echo "Signing identity already exists: $identity"
    exit 0
fi

temp_root="${TMPDIR:-/tmp}"
if [[ ! -d "$temp_root" ]]; then
    temp_root="/tmp"
fi
temp_dir="$(mktemp -d "$temp_root/displayharbor-signing.XXXXXX")"
trap 'rm -rf "$temp_dir"' EXIT

certificate="$temp_dir/DisplayHarbor Development.cer"
private_key="$temp_dir/DisplayHarbor Development.key"
bundle="$temp_dir/DisplayHarbor Development.p12"
certificate_password="$(openssl rand -hex 32)"
export DISPLAYHARBOR_CERTIFICATE_PASSWORD="$certificate_password"

openssl req -x509 -newkey rsa:2048 -sha256 -nodes \
    -days 3650 \
    -subj "/CN=$identity/O=DisplayHarbor Development/OU=Local Development" \
    -addext "keyUsage=digitalSignature" \
    -addext "extendedKeyUsage=codeSigning" \
    -keyout "$private_key" \
    -out "$certificate" \
    >/dev/null 2>&1

pkcs12_legacy_args=()
if [[ "$(openssl version 2>/dev/null || true)" == OpenSSL\ 3* ]]; then
    pkcs12_legacy_args=(-legacy)
fi

openssl pkcs12 -export "${pkcs12_legacy_args[@]}" \
    -out "$bundle" \
    -inkey "$private_key" \
    -in "$certificate" \
    -passout env:DISPLAYHARBOR_CERTIFICATE_PASSWORD \
    -name "$identity" \
    >/dev/null

login_keychain="$(security default-keychain -d user | sed -e 's/^[[:space:]]*//' -e 's/^\"//' -e 's/\"$//')"
security import "$bundle" -k "$login_keychain" \
    -P "$certificate_password" \
    -T /usr/bin/codesign \
    -T /usr/bin/security \
    >/dev/null

# Trust this local-only certificate in the user's login keychain so codesign can
# resolve it consistently. It is not a distribution or notarization identity.
security add-trusted-cert -d -r trustRoot -k "$login_keychain" "$certificate" \
    >/dev/null 2>&1 || true

if ! security find-identity -v -p codesigning 2>/dev/null | grep -Fq "\"$identity\""; then
    echo "Unable to register signing identity: $identity" >&2
    exit 1
fi

echo "Created signing identity: $identity"
echo "This identity is for local development only."
