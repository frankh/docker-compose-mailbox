# Docker Compose Mailbox

Fully featured mail server using docker-compose

Postfix, dovecot, vimbadmin and roundcube, all in one convenient package.

Includes opendkim for postfix

## Info

The docker compose file runs 6 services

  1. postfix - handle's sending and receiving email
  2. dovecot - sorts incoming mail into IMAP mailboxes
  3. vimbadmin - web interface for creating/managing mailboxes
  4. roundcube - web interface for checking a mailbox
  5. opendkim - Adds domainkey validation so that sent mails aren't flagged as spam
  6. spamassassin - Automatically filters spam for inboxes - learns based on what users mark as spam/not spam

postfix needs port 25 and 587 to be open

dovecot needs port 993

vimbadmin and roundcube need port 80

## Usage Instructions

The instructions assume you are trying to setup an email server for `example.com`

First run `ruby build.rb` and enter all the settings that are needed

You will be asked for:

  1. Email address domain - Enter `example.com` for email addresses like `name@example.com`

  2. Mail server domain - The value of the MX Record for the email address domain.
      The default is `mail.example.com` - but there is technically no reason it has to be a subdomain of
      `example.com`. The domain should have a DNS entry pointing to the server running the docker service.

  3. The DKIM selector - Domain Key Validation helps prevent emails from getting sent to spam. You will
      need to create a TXT DNS key at `<selector>._domainkey.example.com`. The exact DNS entry is created
      at ./data/certs/dkim.txt after running the docker service for the first time.

  4. The postmaster email address - default postmaster@example.com

  5. The vimdadmin domain - The domain the vimbadmin server will listen on. Defaults to `vimbadmin.example.com`.
      You must set up a DNS entry for this domain

  6. Vimbadmin superuser - The login email address for vimbadmin. Can be *any* email address, not just `@example.com`.
      It's recommended that it's *not* for `@example.com`, so you can more easily recover in case of forgotten password

  7. Vimbadmin superuser password - Write this down! If you forget you may be unable to access the admin interface!

  8. Roundcube domain - The domain the roundcube (webmail) server listens on. Defaults to `webmail.example.com`.
      You must set up a DNS entry for this domain

This will create a file `settings.env`, which is used as the environment variables to send to the docker containers
in `docker-compose.yml`

To run the server, use `docker-compose up -d` (-d is for daemon mode, so it runs in the background)

Once you've run it, set up the DNS entries
listed in the next section, and then use vimbadmin to set up your mail boxes

## Summary of DNS entries

You will need to setup the following DNS entries to get everything working. (Assuming all options above are left as the
default)

  1. MX Record - `example.com` must have an MX Record pointing to `mail.example.com`
  2. A or CNAME Record - `mail.example.com` must point to the server running the docker service
  3. A or CNAME Record - `vimbadmin.example.com` must point to the server running the docker service
  4. A or CNAME Record - `webmail.example.com` must point to the server running the docker service
  5. TXT Record - `mail._domainkey.example.com` must be set to the contents given in `./data/certs/dkim.txt`
     (Created after first run)
  6. TXT Record - `example.com` should be set to `v=spf1 mx a:mail.example.com ~all`

## Certificates and keys

Upon running for the first time some certificates and keys will be created in `./data/certs`. If you want to use keys
and certificates you have created, place them in here. The dkim private key must be in `./data/certs/dkim.private`, the
mail server key and certificate must be in `./data/certs/mail.private` and `./data/certs/mail.cert`.

## Backups

Backups will be created every 24 hours for the roundcube/vimbadmin databases and for the dovecot vmail directory

They will be stored in ./data/backup and deleted after 1 week - it's recommended to automatically back these up on a
separate server.

You can manually create a backup by running `ruby backup.rb`, and restore a backup with `ruby restore.rb`
