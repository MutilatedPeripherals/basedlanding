# Steps for new subdomain setup when you already have nginx running as reverse proxy

1. create basic conf file: 
    ```
    sudo nano /etc/nginx/sites-available/basedsolutions.xmp.systems.conf
    ```

    And add: 
    ```
    server {
        server_name basedsolutions.xmp.systems;

        location / {
            proxy_pass http://127.0.0.1:4000;
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto $scheme;
        }

        client_max_body_size 5M;
    }

    server {
        listen 80;
        server_name basedsolutions.xmp.systems;

        location / {
            return 301 https://$host$request_uri;
        }
    }
    ```
    
2. Create symbolic link to enable the site: 
    ```
    sudo ln -s /etc/nginx/sites-available/basedsolutions.xmp.systems.conf /etc/nginx/sites-enabled/
    ```

3. run certbot to get ssl cert and key for the new domain:
    ```
    sudo certbot --nginx -d basedsolutions.xmp.systems
    ```

4. test the conf file:
    ```
    sudo nginx -t
    ```

5. restart nginx:
    ```
    sudo systemctl restart nginx
    ```