cd /var/www/html/Kd-Portal-Admin-Zone/
git stash
git pull origin stag-deploy

cd /var/www/html/Kd-Portal-Admin-Zone/apps/cars
git stash
git pull origin stag-deploy
npm run build

pm2 delete ecosystem.config.js
pm2 start ecosystem.config.js

cd /var/www/html/Kd-Portal-Admin-Zone/apps/users
git stash
git pull origin stag-deploy
npm run build

pm2 delete ecosystem.config.js
pm2 start ecosystem.config.js

cd /var/www/html/Kd-Portal-Admin-Zone/apps/customers
git stash
git pull origin stag-deploy
npm run build

pm2 delete ecosystem.config.js
pm2 start ecosystem.config.js

cd /var/www/html/Kd-Portal-Admin-Zone/apps/misc
git stash
git pull origin stag-deploy
npm run build

pm2 delete ecosystem.config.js
pm2 start ecosystem.config.js
