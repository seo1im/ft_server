# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: marvin <marvin@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/03/13 05:13:03 by marvin            #+#    #+#              #
#    Updated: 2020/03/16 04:52:15 by marvin           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:buster

# install package
RUN apt-get update -y
RUN apt-get install -y nginx
RUN apt-get install -y openssl
RUN apt-get install -y php7.3 php7.3-fpm php-cli php-mbstring php7.3-mysql
RUN apt-get install -y wget
RUN apt-get install -y mariadb-server

RUN wget https://files.phpmyadmin.net/phpMyAdmin/4.9.4/phpMyAdmin-4.9.4-all-languages.tar.gz
RUN wget https://wordpress.org/latest.tar.gz

# COPY file
RUN mkdir /set_file
COPY ./src/conf/set_sql /set_file/
COPY ./src/conf/default /set_file/
COPY ./src/conf/config.inc.php /set_file/
COPY ./src/conf/wp-config.php /set_file/
COPY ./src/service.sh /set_file/
RUN mv phpMyAdmin-4.9.4-all-languages.tar.gz /set_file/
RUN mv latest.tar.gz /set_file/

CMD bash /set_file/service.sh