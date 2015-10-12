#!/bin/sh
gpg2 -dq ~/.mailpw.gpg | awk -F'\t' '$1 = "pmooney@pfmooney.com" {print $2}'
