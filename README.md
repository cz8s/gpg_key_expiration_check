# Check the keys you own

This script only checks the keys you own.
If you don't have a secret key, it will ignore the public part.
The reason is, that you will have parcemonie running anyway and
you can't do anything about expiring keys you don't own.

It will also check all subkeys.

It will ignore keys that have expired already.
Reason is, that everyone most likely has old 1024 keys
in their keyring and don't want to be alerted about them.
