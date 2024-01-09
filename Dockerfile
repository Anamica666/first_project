#OS
FROM ubuntu:latest

#apache installing
RUN apt-get update && \
    apt-get install -y apache2

#creating directory for virtual hosts
RUN mkdir -p /var/www/html/site1.com && \
    mkdir -p /var/www/html/site2.com

#this is to copy index file
COPY index1.html /var/www/html/site1.com/index.html
COPY index2.html /var/www/html/site2.com/index.html

#this is where u make conf changes ports are mentioned here itself
COPY site1.com.conf /etc/apache2/sites-available/
COPY site2.com.conf /etc/apache2/sites-available/

# copy custom ports configuration
COPY ports.conf /etc/apache2

#Enable the virtual hosts
RUN a2ensite site1.com.conf && \
    a2ensite site2.com.conf

#ports to be exposed 80 and 81
EXPOSE 8080
EXPOSE 8181

#this is to start apache in the foreground
CMD ["apache2ctl", "-D", "FOREGROUND"]

#restart apache
RUN service apache2 restart
