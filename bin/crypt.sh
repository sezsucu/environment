#!/usr/bin/env bash

# extracts public key from private key
function extractPublicRSAKey()
{
    if [[ $# == 0 || "$1" == "" ]]; then
        echo "Usage: crypt.sh public privateKey.pem > publicKey.txt"
        exit 1
    fi
    keyFile=$1
    (>&2 echo "Using $keyFile")
    openssl rsa -in "$keyFile" -pubout
}

# creates a private rsa key
function createRSAKey()
{
    if [[ $# == 0 || "$1" == "" ]]; then
        echo "Usage: crypt.sh create privateKey.pem"
        exit 1
    fi
    keyFile=$1
    if [[ -e "$keyFile" ]]; then
        echo "ERROR: File already exists '$keyFile'"
        exit 1
    fi
    openssl genrsa -out $keyFile 4096
    chmod 600 $keyFile
    echo "Generated $keyFile"
}

# encrypts the input, either with symmetric key or private or public key
# notice that when using rsa, you can't encrypt too much data
function encryptData()
{
    if [[ $# == 0 || "$1" == "" ]]; then
        openssl enc -aes-256-cbc -salt -base64 <&0 >&1
    elif [[ $# == 1 ]]; then
        keyFile=$1
        read -r line < "$keyFile"
        if [[ "$line" =~ .*PRIVATE.* ]]; then
            openssl rsautl -inkey $keyFile -encrypt >&1
        elif [[ "$line" =~ .*PUBLIC.* ]]; then
            openssl rsautl -inkey $keyFile -pubin -encrypt >&1
        else
            openssl enc -aes-256-cbc -salt -base64 -pass file:$keyFile <&0 >&1
        fi
    else
        echo "Usage: crypt.sh encrypt [privateKey.file|publicKey.file|key.file] < input > output"
    fi
}

# decrypts the input, either with symmetric key or private or public key
function decryptData()
{
    if [[ $# == 0 || "$1" == "" ]]; then
        openssl enc -d -aes-256-cbc -base64 <&0 >&1
    elif [[ $# == 1 ]]; then
        keyFile=$1
        read -r line < "$keyFile"
        if [[ "$line" =~ .*PRIVATE.* ]]; then
            openssl rsautl -inkey $keyFile -decrypt <&0
        elif [[ "$line" =~ .*PUBLIC.* ]]; then
            openssl rsautl -inkey $keyFile -pubin -decrypt <&0
        else
            openssl enc -d -aes-256-cbc -base64 -pass file:$keyFile <&0 >&1
        fi
    else
        echo "Usage: crypt.sh decrypt [privateKey.pem|key.file] < input > output"
    fi
}

# signs the data using private key
function signData()
{
    if [[ $# == 0 || "$1" == "" ]]; then
        echo "Usage: crypt.sh sign privateKey.pem < input > signature.file"
        exit 1
    fi
    keyFile=$1
    (>&2 echo "Using $keyFile")
    openssl dgst -sha256 -sign $keyFile <&0
}

# verifies the given signature for the given file using the public key
function verifyData()
{
    if [[ $# == 0 || "$1" == "" ]]; then
        echo "Usage: crypt.sh verify publicKey.txt signature.file < input"
        exit 1
    fi
    keyFile="$1"
    sigFile="$2"
    (>&2 echo "Using $keyFile")
    openssl dgst -sha256 -verify $keyFile -signature $sigFile <&0
}

# adds password to a private key file
function addPassword()
{
    if [[ $# == 0 || "$1" == "" ]]; then
        echo "Usage: crypt.sh add privateKey.pem > protected.privateKey.pem"
        exit 1
    fi
    keyFile=$1
    (>&2 echo "Using $keyFile")
    openssl rsa -aes256 -in $keyFile >&1
}

# removes password from a private key file
function removePassword()
{
    if [[ $# == 0 || "$1" == "" ]]; then
        echo "Usage: crypt.sh remove protected.privateKey.pem > privateKey.pem"
        exit 1
    fi
    keyFile=$1
    (>&2 echo "Using $keyFile")
    openssl rsa -in $keyFile >&1
}

# generate a key file with the given length
function generateKey()
{
    if [[ $# == 0 || "$1" == "" ]]; then
        echo "Usage: crypt.sh (gen)erate 32 > key.file"
        exit 1
    fi
    openssl rand -base64 $1
}


command=$1
shift

case "$command" in
    cre*)
        createRSAKey "$*"
        ;;

    pub*)
        extractPublicRSAKey "$*"
        ;;

    enc*)
        encryptData "$*"
        ;;

    dec*)
        decryptData "$*"
        ;;

    sig*)
        signData "$*"
        ;;

    ver*)
        verifyData $*
        ;;

    rem*)
        removePassword $*
        ;;

    add*)
        addPassword $*
        ;;

    gen*)
        generateKey $*
        ;;
    *)
        echo "crypt.sh (cre)ate /path/to/privateKey.pem"
        echo "creates a private key"
        echo "crypt.sh (pub)lic /path/to/privateKey.file > publicKey.txt"
        echo "extracts the public key from the private key"
        echo "crypt.sh ((enc)rypt|(dec)rypt) (privateKey.pem|publicKey.txt)"
        echo "encrypts or decrypts a small message with a private or public key"
        echo "crypt.sh [(sig)n] /path/to/privateKey.file < originalFile > signature.file"
        echo "creates a signature"
        echo "crypt.sh (ver)ify /path/to/publicKey.file signature.file < originalFile"
        echo "verifies the signature"
        echo "crypt.sh (add) /path/to/privateKey.without.password > passwordProtectedPrivate.file"
        echo "add a password to an existing key"
        echo "crypt.sh (rem)ove /path/to/passwordProtectedPrivate.file > privateKey.without.password"
        echo "remove a password from a key"
        echo ""
        echo "crypt.sh (gen)erate n > secretKey.txt"
        echo "generate random n-byte key"
        echo "crypt.sh (enc)rypt secretKey.txt < bigMessage.txt > enc.bin"
        echo "encrypts any size message using aes256"
        echo "crypt.sh (dec)rypt secretKey.txt < enc.bin > mesg.txt"
esac
