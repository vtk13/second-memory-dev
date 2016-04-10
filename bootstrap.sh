#!/usr/bin/env bash

apt-get update
apt-get install -y mc apache2 postgresql php5 php5-pgsql nodejs nodejs-legacy npm composer
a2enmod rewrite
unlink /etc/apache2/sites-enabled/000-default.conf

sudo -u postgres createdb sm
sudo -u postgres bash -c 'echo "CREATE USER sm WITH password '"'"'sm'"'"'" | psql'
sudo -u postgres bash -c 'echo "GRANT ALL privileges ON DATABASE sm TO sm" | psql'

cd /var/www/sms/
cp /vagrant/.env /var/www/sms/.env
composer install
php artisan migrate

# todo copy-and-paste from second-memory/build.sh
export USE_BASIC=0
export BASIC_SERVER_USER=
export BASIC_SERVER_PASSWORD=
export API_HOST=localhost:8081

cd /var/www/sm/
npm install -g node-pre-gyp
npm install
rm -f public/client.js public/test.js public/vendor.js
nodejs node_modules/webpack/bin/webpack.js
cp -Rf node_modules/bootstrap/dist/ public/css/bootstrap
