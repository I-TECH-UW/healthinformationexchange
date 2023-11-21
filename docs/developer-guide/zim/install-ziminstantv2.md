### Installation Guide: Zimbabawe HIE

#### Introduction
This section shows the quick instructions of running the ZIM HIE instantV2 setup.

#### Requirements:

- Zim HIE repository ie https://github.com/mohcc/hie-zimbabwe.git

#### Steps:

1.Clone the Zim HIE repository ie https://github.com/mohcc/hie-zimbabwe.git

2.Make sure you have an understanding of files listed under the (Migrating HIE Components to instant HIE V2) section above.

3.In the root folder of the cloned repository,run ./get-cli.sh.This downloads the architecure specific instant CLI executable and saves it in the root directory.This allows the CLI to be run with the ./instant command.

4. The above command creates three folders and you need only one basing on your operating system.We will concetrate on the instant-linux folder which you can rename to instant

5.Test that you can now run the CLI with the instant command by running ./instant,this should return a list of the avialable commands

6.You can now start launching the packages,start by launching the reverse proxy since its depended on by many other packages ie run ./instant package init -n reverse-proxy-nginx --env-file .env

7.You can now run any package that you want to start ie run ./instant package init -n addpackagenamehere --env-file .env







