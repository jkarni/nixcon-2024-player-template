# NixCon 2024 - NixOS on garnix: Production-grade hosting as a game

This is a template repo for participating in the game. To play you need to:

- Fork this repo on github.
- Get a garnix account [here](https://garnix.io).
- Enable garnix for the forked repo [here](https://github.com/apps/garnix-ci).

## Viewing your server requests and responses in logs

To ensure your server is responding correctly, you can monitor its logs.

First, you'll need SSH access to the server. To enable this, define your SSH public key using the `playerConfig` module with the `sshKey` option.

After committing changes to the main branch, the Garnix app will automatically trigger a deployment.
You can track the deployment status by visiting [the servers page in Garnix](https://garnix.io/servers).
Your server's domain, as well as both its IPv4 and IPv6 addresses, will be displayed in the deployment logs.

Once you have sshed into the server, you can check incoming requests and responses by running the following command:

```sh
tail /var/log/nginx/access.log
```
