<?php

$config['password_confirm_current'] = true;
$config['password_db_dsn'] = 'mysql://vimbadmin:password@mysql/vimbadmin';
$config['password_crypt_hash'] = 'sha256';
$config['password_query'] = 'UPDATE mailbox SET password=%c WHERE username=%u';