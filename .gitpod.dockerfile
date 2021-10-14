# Gitpod docker image for WordPress | https://github.com/thegreenwebfoundation/gitpod-wordpress
# License: MIT (c) 2021 Chris Adams "Bills"
# Version: 0.1
FROM gitpod/workspace-mysql

### General Settings ###
ENV PHP_VERSION="7.4"
ENV APACHE_DOCROOT="public_html"
ENV WORDPRESS_ROOT="/workspace/wordpress/"


### MailHog ###
USER root
ARG DEBIAN_FRONTEND=noninteractive
RUN go install github.com/mailhog/MailHog@latest && \
    go get github.com/mailhog/mhsendmail@latest && \
    cp $GOPATH/bin/MailHog /usr/local/bin/mailhog && \
    cp $GOPATH/bin/mhsendmail /usr/local/bin/mhsendmail && \
    ln $GOPATH/bin/mhsendmail /usr/sbin/sendmail && \
    ln $GOPATH/bin/mhsendmail /usr/bin/mail

### WP-CLI ###
USER root
ARG DEBIAN_FRONTEND=noninteractive
RUN wget -q https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -O $HOME/wp-cli.phar && \
    wget -q https://raw.githubusercontent.com/wp-cli/wp-cli/v2.3.0/utils/wp-completion.bash -O $HOME/wp-cli-completion.bash && \
    chmod +x $HOME/wp-cli.phar && \
    mv $HOME/wp-cli.phar /usr/local/bin/wp && \
    chown gitpod:gitpod /usr/local/bin/wp

