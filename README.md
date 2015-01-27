# Good Wordpress for Docker (and dokku-alt).

This is a docker / dokku-alt implementation for deploying your Wordpress
applications easily. I have edited the deploy scripts to make sure
this works in a real-life applications.

The container is designed to work with dokku-alt, however you should be
able to use it independently too. I will provide help for dokku-alt.

## 1. Deploying the app

You will need dokku-alt installed on your server: `dokku.example.com`.
Clone this repository locally or use `dokku clone app-name repository-url`.

```
git clone https://github.com/romaninsh/docker-wordpress.git
cd docker-wordpress
git remote add deploy dokku@dokku.example.com:wordpress
git push deploy master
```

If everything goes well, you should receive URL. Opening that URL will
complain about database connection. Let's set up our database next.

## 2. Setting up database.

Dokku allows you to set up and configure database easily.

```
dokku mariadb:create wordpress
dokku mariadb:link wordpress wordpress
```

Refresh your URL and it should redirect you to standard wordpress
install steps.

## 3. Setting up wp-content volume

Wordpress is a CMS and people tend to upload files through wp-admin. In a
standard docker install those files will dissapear when you re-deploy
your site, because a new container is created every time. To make those
files persistent, you'll need to set up a volume.

```
dokku volume:create wordpress /data
dokku volume:link wordpress wordpress
```

Because the volume we created was empty, `volume-init.sh` will automatically
move wp-content folder from the default installation to your volume.
To confirm that wp-content is linked you can peek inside container logs:

```
dokku logs wordpress
```

and it should contain:

```
Moving wp-content to blank volume..
Linking wp-content..
```

## 4. Adding your own themes and plugins

You can access docker containers from host operating system. Type:

```
ls -l /var/lib/docker/vfs/dir/
```

and look for recently created folder. Create symlink to access it easy

```
ln -s /var/lib/docker/vfs/dir/<your-id-here> wordpress
```

Inside you'll find wp-content folder which you can customise. In my installations
it's often linked with it's own repository. Make sure you back up this volume
as it would contain your uploaded files.

## 5. Advanced Use

This wordpress container comes with default wp-config.php file. If you want
to tweak it, copy it to your /data volume, then run:

```
dokku deploy wordpress
```

You can also add your own `.htaccess` file to your data volume and it will
be automatically used.

## 6. Logs

You often would like to access logs from your web server. This container
configures your apache to send logs through stdout to docker in a normal
way. You should be able to see your logs through:

```
dokku logs wordpress
```

## 7. Contributing

If you find that this container is not fully usable in your production
environment, I would love to improve it as long as it's not compromise
it's simplicity.

Start by forking this repository. Then grab the new repository SSH url
and run on your local machine:

```
git remote add my <url>
```

Perform tweaks necessary, test them by doing

```
git push deploy master
```

and when everything is perfect,

```
git push my master
```

Once done, go to your repository on github.com and create pull request. Thank
you for your contribution.
