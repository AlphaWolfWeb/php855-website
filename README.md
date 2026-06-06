# PHP Website Container

This stack deploys a PHP/Apache website container designed to work with Nginx Proxy Manager on a shared Docker network.

## Configuration

Before deploying, configure the following environment variables:

| Variable   | Example     | Description                                    |
| ---------- | ----------- | ---------------------------------------------- |
| DOMAIN_COM | example_com | Used for the container name and website folder |
| NETWORK    | web_network | Docker network shared with Nginx Proxy Manager |

### Important

Use **underscores instead of dots** in `DOMAIN_COM`.

**Correct:**

```text
example_com
my_website_com
blog_example_com
```

**Incorrect:**

```text
example.com
my-website.com
```

The value of `DOMAIN_COM` is used for Docker container names and filesystem paths. Using underscores helps avoid issues with container naming and path handling.

## Deployment

1. Create a new Stack in Portainer.
2. Paste the stack YAML.
3. Add the environment variables:

```text
DOMAIN_COM=example_com
NETWORK=web_network
```

4. Deploy the stack.

If `NETWORK` is not specified, the stack will automatically use:

```text
web_network
```

## Directory Structure

The website files will be stored in:

```text
/opt/docker/example_com/
```

The container will automatically create:

```text
/opt/docker/example_com/
├── public_html/
│   └── index.php
└── logs/
```

The web root is:

```text
/var/www/public_html
```

Place all publicly accessible website files inside the `public_html` directory.

### Secure File Storage

One advantage of this layout is that only files inside `public_html` are served by Apache. Files stored outside of `public_html` are not directly accessible from the web.

For example:

```text
/opt/docker/example_com/
├── .env
├── config/
│   └── database.php
├── backups/
├── logs/
└── public_html/
    ├── index.php
    ├── assets/
    └── uploads/
```

This provides a safe location for:

- `.env` files
- Database credentials
- API keys
- Configuration files
- Backup files
- Log files
- Private uploads
- Other sensitive application data

Keeping sensitive files outside `public_html` helps prevent accidental exposure through the web server.

## Nginx Proxy Manager

Create a Proxy Host in Nginx Proxy Manager.

**Domain Names**

```text
example.com
```

**Forward Hostname / IP**

```text
example_com
```

**Forward Port**

```text
80
```

**Scheme**

```text
http
```

The website container and Nginx Proxy Manager must be connected to the same Docker network.

## Creating the Shared Network

If the network does not already exist, create it:

```bash
docker network create web_network
```

Or specify a custom network name using the `NETWORK` environment variable.

## Notes

- No host ports need to be exposed.
- Designed for use behind Nginx Proxy Manager.
- Uses the official PHP Apache image.
- The default `index.php` file can be replaced with your own application files.
- Multiple websites can share the same Docker network while remaining isolated in separate containers.
- The directory structure follows a common shared-hosting style layout while keeping sensitive files outside the public web root.
