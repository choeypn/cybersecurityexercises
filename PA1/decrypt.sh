#!/bin/bash
#Nat Choeypant
#CSCI461 assignment#1
#Note:this script takes 5 input arguments: signature file, encrypted file, encrypted AES key, sender public RSA key, and owner private key
#This script decrypt and printout the encrypted file, then verify the sender signature on the decrypted file
#Once completed, this program delete the decrypted AES key and file

if [ $# -gt 4 ]; then
	
	# variables
	signature=$1
	secret=$2
	key=$3
	public=$4
	private=$5	
	if openssl rsautl -decrypt -inkey $private -in $key -out key.bin ; then
		if openssl enc -d -aes-256-cbc -in $secret -out secret_file -pass file:./key.bin ; then
			echo "decrypted file:"
			echo "===================================="	
			cat secret_file
			echo "===================================="
			if openssl base64 -d -in $signature -out /tmp/sign.sha256 ; then
				if openssl dgst -sha256 -verify $public -signature /tmp/sign.sha256 secret_file ; then
					echo "verificaiton passed, removing decrypted file and decrypted AES key"
					rm -rf key.bin secret_file
					echo "files removed"
				else
					echo "verificaiton failed, invalid signature to the file"
				fi
			else
				echo "invalid input signature"
			fi

		else
			echo "error, invalid sender AES key"
		fi
	else
		echo "error, invalid private key"
	fi	
else
	echo "invalid number of arguments, require 5 arguments"
fi


