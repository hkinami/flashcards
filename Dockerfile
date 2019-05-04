FROM nginx:latest

RUN apt-get update && apt-get install -y \
    flite \
    fcgiwrap \
    nkf \
    lame

COPY conf/fcgiwrap /etc/init.d/fcgiwrap
COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY conf/default.conf /etc/nginx/conf.d/default.conf

# RUN cp /usr/share/doc/fcgiwrap/examples/nginx.conf /etc/nginx/fcgiwrap.conf
# RUN echo "include /etc/nginx/fcgiwrap.conf;" >> /etc/nginx/sites-available/default

COPY static /usr/share/nginx/html
RUN chown -R nginx:nginx /usr/share/nginx/html

CMD /etc/init.d/fcgiwrap start \
    && nginx -g 'daemon off;'
