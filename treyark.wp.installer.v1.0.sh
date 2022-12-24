#!/bin/bash

#
#...................................Part 1
#...................................Header
#
#
# To use this script, you can save it as a .sh file on your server's home directory "cd ~/"
# Create a .sh file using nano
# sudo mkdir ~/treyarkMedia && sudo nano ~/treyarkMedia/treyark.wp.installer.v1.0.sh
# Now paste in this code, save and exit.

# Make it executable and run the script with this command:
# sudo chmod +x ~/treyarkMedia/treyark.wp.installer.v1.0.sh && cd ~/treyarkMedia && sudo ./treyark.wp.installer.v1.0.sh && cd -

sudo apt update
sleep 1
sudo apt upgrade -y
echo " "

sleep 1
cat >/tmp/logoexample.txt <<EOF

                               ...,,/,,. . 
                               ..,,@@@,,,. .                                     
                             ..,,(@@@@@@**,...                                    
                           ..,,*@@@@@@@@@**,...                                  
                          ..,*(@@@@@@@@@@@(**....                                
                        ..,**@@@@@@@@@@@@@@@**,...                               
                       ..,*%@@@@@@@@@@@@@@@@@/*,...                              
                     ..,,*@@@@@@@@@@@@@@@@@@@@&**,...                            
                    ..,*(@@@@@@@@@@% &@@@@@@@@@@/*,...                           
                   ..,*@@@@@@@@@@@////(@@@@@@@@@@%**,...                         
                 ..,*/@@@@@@@@@@%/*,****&@@@@@@@@@@*/*...                        
                .,,*&@@@@@@@@@@**,,..,,,*/@@@@@@@@@@ /*,...  .                   
              ..,**@@@@@@@@@@&**,...  ...,*@@@@@@@@@@@*/*...  .                  
            ...,*&@@@@@@@@@@/*,..       ..,*(@@@@@@@@@@///..,.  .                
            .,,*@@@@@@@@@@@**,..         ..,,,@@@@@@@@@@&,*. .,  ..              
          ..,* @@@@@@@@@@/**...      .,  **../**( **  **(,.**  ,. ..             
        ..,,*@@@@@@@@@@@**,..      ,*  *, .*../(..(*./(../* .*. ,,  ,.           
       ..,*/@@@@@@@@@@ *,...     ,,  *, ,*  // ./. (( .(* ,/. */ .*. ,,          
       .,,&@@@@@@@@@@***...     , .*. */  /* */  (/ ,(, /(  // */  /*  *.        
       ..,@@@@@@@@@%**...                                                        
       ..,,&@@@@@@**,...                                                         
        ...,/@@@&,,...                                                           
          ....@,...                                                              
   

EOF

cat >/tmp/logoexample2.txt <<EOF
                                                          
   
 ::::::::::: :::::::::  :::::::::: :::   :::   :::     :::::::::  :::    ::: 
     :x:     :x:    :x: :x:        :x:   :x: :x: :x:   :x:    :x: :x:   :x:  
     x:x     x:x    x:x x:x         x:x x:x x:x   x:x  x:x    x:x x:x  x:x   
     xxx     xxxx:xxx:  xxxx:xxx     xxxx: xxxx:xxxxx: xxxx:xxx:  xxxx:xx    
     xxx     xxx    xxx xxx           xxx  xxx     xxx xxx    xxx xxx  xxx   
     xxx     xxx    xxx xxx           xxx  xxx     xxx xxx    xxx xxx   xxx  
     xxx     xxx    xxx xxxxxxxxxx    xxx  xxx     xxx xxx    xxx xxx    xxx 
 
            ::::    ::::  :::::::::: ::::::::: :::::::::::     :::           
            x:x:x: :x:x:x :x:        :x:    :x:    :x:       :x: :x:         
            x:x x:x:x x:x x:x        x:x    x:x    x:x      x:x   x:x        
            xxx  x:x  xxx xxxx:xxx   xxx    x:x    xxx     xxxx:xxxxx:       
            xxx       xxx xxx        xxx    xxx    xxx     xxx     xxx       
            xxx       xxx xxx        xxx    xxx    xxx     xxx     xxx       
            xxx       xxx xxxxxxxxxx xxxxxxxxx xxxxxxxxxxx xxx     xxx  
 
 

EOF

var_logo='/tmp/logoexample.txt'
var_logo2='/tmp/logoexample2.txt'
cat $var_logo
echo " "
sleep 1
cat $var_logo2
echo " "
rm /tmp/logoexample.txt
rm /tmp/logoexample2.txt



#...................................Part 2
#................................Script Begin



# Ask the user for: Domain name, Admin Email, New DB Username & Pwd:

read -p "Please enter the domain name to use for this new site, Don't add the 'www':   " var_DomainName
echo " "
read -p "Enter your Administrative email to use for SSL Certification:   " var_AdminEmail
echo " "
read -p "We will be creating a new database, enter the database name you would like to use:   " var_DatabaseName
echo " "
read -p "Create a Database User Name:   " var_DatabaseUserName
echo " "
read -p "Create a Database Password:   " var_DatabasePassword
echo " "
echo " "
sleep 1
echo "Here are the details you provided:"
echo " "
sleep 1
echo "1) Domain Name............$var_DomainName"
echo "2) Administrative email...$var_AdminEmail"
echo "3) Database Name..........$var_DatabaseName"
echo "4) Database User Name.....$var_DatabaseUserName"
echo "5) Database Password......$var_DatabasePassword"
echo " "
sleep 1
read -p "Are these values correct? [y/n]" var_confirmationOne
echo " "

# check if the details are correct, if so echo "great!" and proceed,
if [ $var_confirmationOne == "n" ]; then
    # if not echo instructions to restart
    echo " "
    echo "If you need to modify your settings before proceeding, Press [ctrl + C] to exit, then start over."
    sleep 1
    echo " "
    echo "Press Enter to continue running the script"
    read -s -p ""
    echo "Continuing script..."
    echo " "
else
    echo "Great!"
    sleep 1
fi
echo " "
var_Date=$(date +"%m.%d.%Y")
echo "Today is $var_Date"
sleep 1
echo " "

#-------------------------------PAUSE------------IN
sleep 1
echo " "
echo "Create site directory "
echo "Press Enter to continue running the script"
read -s -p ""
echo "Continuing script..."
echo " "
#-------------------------------PAUSE------------OUT

sudo mkdir -p /var/www/$var_DomainName/public_html

#-------------------------------PAUSE------------IN
sleep 1
echo " "
echo "Create Apache2 configuration file"
echo "Press Enter to continue running the script"
read -s -p ""
echo "Continuing script..."
echo " "
#-------------------------------PAUSE------------OUT

## Create a config file for our website  & add this text into the file

cat >/etc/apache2/sites-available/$var_DomainName.conf <<EOF

<VirtualHost *:80>
    ServerAdmin $var_AdminEmail
    ServerName $var_DomainName
    ServerAlias www.$var_DomainName
    DocumentRoot /var/www/$var_DomainName/public_html
    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined

  <Directory /var/www/$var_DomainName/public_html/>
          AllowOverride All
  </Directory>

</VirtualHost>

EOF

#-------------------------------PAUSE------------IN
sleep 1
echo " "
echo "Next: Create a Database"
echo "Press Enter to continue running the script"
read -s -p ""
echo "Continuing script..."
echo " "
#-------------------------------PAUSE------------OUT

# If /root/.my.cnf doesn't exist then it'll ask for root password  
sudo mysql -uroot -p$*PASSWORD_OF_MYSQL_ROOT_USER* -e "CREATE DATABASE $var_DatabaseName DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;"
sleep 1
sudo mysql -uroot -p$*PASSWORD_OF_MYSQL_ROOT_USER* -e "GRANT ALL ON $var_DatabaseName.* TO '$var_DatabaseUserName'@'localhost' IDENTIFIED BY '$var_DatabasePassword';"
sleep 1
sudo mysql -uroot -p$*PASSWORD_OF_MYSQL_ROOT_USER* -e "FLUSH PRIVILEGES;"
sleep 1

#mysql -uroot -p$*PASSWORD_OF_MYSQL_ROOT_USER* -e "CREATE DATABASE $MAINDB"
#mysql -uroot -p$*PASSWORD_OF_MYSQL_ROOT_USER* -e "GRANT ALL PRIVILEGES ON $MAINDB.* TO $MAINDB@localhost IDENTIFIED BY '$PASSWDDB!'"




#
#mysql -e "CREATE DATABASE $var_DatabaseName DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci"
#mysql -e "GRANT ALL ON $var_DatabaseName.* TO "$var_DatabaseUserName"@"localhost" IDENTIFIED BY "$var_DatabasePassword"
#mysql -e "FLUSH PRIVILEGES"



#-------------------------------PAUSE------------IN
sleep 1
echo " "
echo "Restart Apache"
echo "Press Enter to continue running the script"
read -s -p ""
echo "Continuing script..."
echo " "
#-------------------------------PAUSE------------OUT

sudo systemctl restart apache2

#-------------------------------PAUSE------------IN
sleep 1
echo " "
echo "Download the latest version of wordpress"
echo "Press Enter to continue running the script"
read -s -p ""
echo "Continuing script..."
echo " "
#-------------------------------PAUSE------------OUT

sudo mkdir /tmp/script3r_$var_Date
curl -o /tmp/script3r_$var_Date/wp_$var_Date.tar.gz https://wordpress.org/latest.tar.gz && cd /tmp/script3r_$var_Date && tar -xf wp_$var_Date.tar.gz && rm -r wp_$var_Date.tar.gz && cd -

#-------------------------------PAUSE------------IN
sleep 1
echo " "
echo "Create an .htaccess file for WP"
echo "Press Enter to continue running the script"
read -s -p ""
echo "Continuing script..."
echo " "
#-------------------------------PAUSE------------OUT

touch /tmp/script3r_$var_Date/wordpress/.htaccess

#-------------------------------PAUSE------------IN
sleep 1
echo " "
echo "Create wp-config.php file"
echo "Press Enter to continue running the script"
read -s -p ""
echo "Continuing script..."
echo " "
#-------------------------------PAUSE------------OUT

cp /tmp/script3r_$var_Date/wordpress/wp-config-sample.php /tmp/script3r_$var_Date/wordpress/wp-config.php

#-------------------------------PAUSE------------IN
sleep 1

echo " "
echo "Create wp-content upgrade directory"
echo "Press Enter to continue running the script"
read -s -p ""
echo "Continuing script..."
echo " "
#-------------------------------PAUSE------------OUT

sudo mkdir /tmp/script3r_$var_Date/wordpress/wp-content/upgrade

#-------------------------------PAUSE------------IN
sleep 1
echo " "
echo "Copy Wordpress files to the $var_DomainName/public_html directory"
echo "Press Enter to continue running the script"
read -s -p ""
echo "Continuing script..."
echo " "
#-------------------------------PAUSE------------OUT

sudo cp -a /tmp/script3r_$var_Date/wordpress/. /var/www/$var_DomainName/public_html

#-------------------------------PAUSE------------IN
sleep 1
echo " "
echo "Configure permissions for the WordPress directory"
echo "Press Enter to continue running the script"
read -s -p ""
echo "Continuing script..."
echo " "
#-------------------------------PAUSE------------OUT
#at some point delete this file:
#sudo rm -r /tmp/script3r_$var_Date
sudo chown -R www-data:www-data /var/www/$var_DomainName/public_html

sudo find /var/www/$var_DomainName/public_html/ -type d -exec chmod 750 {} \;

sudo find /var/www/$var_DomainName/public_html/ -type f -exec chmod 640 {} \;


#-------------------------------PAUSE------------IN
sleep 1
echo " "
echo "Obtain WordPress Secret Key"
echo "Press Enter to continue running the script"
read -s -p ""
echo "Continuing script..."
echo " "
#-------------------------------PAUSE------------OUT

# Create a variable called "var_wp_key" and store the WP secret key value within it.

var_wp_key=$(curl -s https://api.wordpress.org/secret-key/1.1/salt/)
echo "$var_wp_key"

#-------------------------------PAUSE------------IN
sleep 1
echo " "
echo "Comment out example keys"
echo "Press Enter to continue running the script"
read -s -p ""
echo "Continuing script..."
echo " "
#-------------------------------PAUSE------------OUT

# comment out the example keys
sudo sed -i "/AUTH_KEY/i /*" /var/www/$var_DomainName/public_html/wp-config.php

sudo sed -i "/NONCE_SALT/a */" /var/www/$var_DomainName/public_html/wp-config.php

#-------------------------------PAUSE------------IN
sleep 1
echo " "
echo "Add Database connection settings to the WordPress configuration file"
echo "Press Enter to continue running the script"
read -s -p ""
echo "Continuing script..."
echo " "
#-------------------------------PAUSE------------OUT

# Use sed to find and replace the text in the file
sed -i "s/database_name_here/$var_DatabaseName/" /var/www/$var_DomainName/public_html/wp-config.php
sed -i "s/username_here/$var_DatabaseUserName/" /var/www/$var_DomainName/public_html/wp-config.php
sed -i "s/password_here/$var_DatabasePassword/" /var/www/$var_DomainName/public_html/wp-config.php

#-------------------------------PAUSE------------IN
sleep 1
echo " "
echo "Place the new keys at the end of the file"
echo "Press Enter to continue running the script"
read -s -p ""
echo "Continuing script..."
echo " "
#-------------------------------PAUSE------------OUT

# Place the keys at the end of the file
echo "$var_wp_key" >>/var/www/$var_DomainName/public_html/wp-config.php

#-------------------------------PAUSE------------IN
sleep 1
echo " "
echo "Comment out the ending two lines of code before we replace them"
echo "Press Enter to continue running the script"
read -s -p ""
echo "Continuing script..."
echo " "
#-------------------------------PAUSE------------OUT


# Comment out the ending two lines of code before we replace them at the bottom of the file :
sudo sed -i "/ABSPATH/i /*" /var/www/$var_DomainName/public_html/wp-config.php 

sudo sed -i "/require_once/a */" /var/www/$var_DomainName/public_html/wp-config.php 

#Example of append new line above, and below
# Above 
# sudo sed -i "/TARGET_PATTERN/i NEW_CODE_LINE_HERE" /var/www/$var_DomainName/public_html/wp-config.php
# Below
# sudo sed -i "/TARGET_PATTERN/a NEW_CODE_LINE_HERE" /var/www/$var_DomainName/public_html/wp-config.php

#-------------------------------PAUSE------------IN
sleep 1
echo " "
echo "Add FS_Method -Direct"
echo "Press Enter to continue running the script"
read -s -p ""
echo "Continuing script..."
echo " "
#-------------------------------PAUSE------------OUT


sudo sed -i "/DB_COLLATE/a define('FS_METHOD', 'direct');" /var/www/$var_DomainName/public_html/wp-config.php

#-------------------------------PAUSE------------IN
sleep 1
echo " "
echo "Replace last two lines of code"
echo "Press Enter to continue running the script"
read -s -p ""
echo "Continuing script..."
echo " "
#-------------------------------PAUSE------------OUT

# Replace last two lines of code
secondToLastLine="if ( ! defined( 'ABSPATH' ) ) {"
thirdToLastLine="        define( 'ABSPATH', __DIR__ . '/' ); }"
LastLine="require_once ABSPATH . 'wp-settings.php';"

echo " " >> /var/www/$var_DomainName/public_html/wp-config.php
echo " " >> /var/www/$var_DomainName/public_html/wp-config.php
echo "$secondToLastLine" >> /var/www/$var_DomainName/public_html/wp-config.php
echo "$thirdToLastLine" >> /var/www/$var_DomainName/public_html/wp-config.php
echo " " >> /var/www/$var_DomainName/public_html/wp-config.php
echo " " >> /var/www/$var_DomainName/public_html/wp-config.php
echo "$LastLine" >> /var/www/$var_DomainName/public_html/wp-config.php


#-------------------------------PAUSE------------IN
sleep 1
echo " "
echo "Enable Website and Obtain SSL Certificate"
echo "Press Enter to continue running the script"
read -s -p ""
echo "Continuing script..."
echo " "
#-------------------------------PAUSE------------OUT
sleep 1
echo "Enabling Website"
sudo a2ensite $var_DomainName.conf

echo "Restart Apache"
sudo systemctl restart apache2

sleep 1
echo "Obtaining SSL Certificate"
sudo certbot --apache -d $var_DomainName -d www.$var_DomainName

#-------------------------------PAUSE------------IN
sleep 1
echo " "
echo "Restart Apache Again"
echo "Press Enter to continue running the script"
read -s -p ""
echo "Continuing script..."
echo " "
#-------------------------------PAUSE------------OUT

sudo systemctl restart apache2

#-------------------------------PAUSE------------IN
sleep 1
echo " "
echo "Remove temp files"
echo "Press Enter to continue running the script"
read -s -p ""
echo "Continuing script..."
echo " "
#-------------------------------PAUSE------------OUT

sudo rm -r /tmp/script3r_$var_Date

#-------------------------------PAUSE------------END
sleep 1
echo "This script is complete, check your site here $var_DomainName"
echo " "
echo "Press Enter to exit the script"
read -s -p ""
sleep 1
echo "Bye!"
echo " "


