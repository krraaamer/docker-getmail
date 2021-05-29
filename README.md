# docker-getmail
This Docker-build is based on the original implementation by  [flyffies/docker-getmail](https://github.com/Flyffies/docker-getmail), with a few modifications to better-implement support for multiple users/accounts.

This image allows you to retrieve email from multiple accounts and deposit them in a ***maildir*** directory for a given user.  I use this image along with the [Dovecot CE Docker Image](https://hub.docker.com/r/dovecot/dovecot/) to retrieve mail from my personal/work accounts (IMAP/POP) and self-host a central IMAP server which is accessed by my desktop/laptop/phone.

## Environmental Variables
You should configure the `TZ` environmental variable to your local timezone (i.e. `America/Los_Angeles`).  If you do not specify an environmental variable for timezone, `Etc/UTC` will be used by default.

Specifying a `SLEEP_TIME` will instruct the image how frequently you would like mail to be re-checked (in seconds).  If you do not specify a re-check interval via `SLEEP_TIME`, the image will default to checking every `600` seconds (10 minutes).

## Mount Points
This Docker-build is built on the premise of a `/config` mount-point and a `/mail` mount-point.

The image will re-check the `/config` folder for configuration files ending in the ****.getmail*** extension; each account which you would like to grab mails for should have a separate configuration file (i.e. `personal.getmail`, `home-gmail.getmail`, `work.getmail`).

The image stores run-data (i.e. lists of retrieved messages to not re-download in the future) in the `/config/data` directory.

Ideally, `/mail` will be mounted to the user-mail directory for an IMAP instance (i.e. Dovecot, as referenced above).  Ultimately, it will be up to the individual ****.getmail*** file to dictate where messages for a given source/account will be deposited to.

## Sample Retriever
See below for an example `/config/my-gmail-account.getmail` file:

    [retriever]
    type = SimpleIMAPSSLRetriever
    server = imap.gmail.com
    username = my-gmail-account@gmail.com
    password = gmail-per-app-password-ftw
    port = 993
    
    [options]
    read_all = false
    delete = false
    verbose = 1
    
    [destination]
    type = Maildir
    path = /mail/kramer/maildir/
