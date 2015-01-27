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




easy!)

(note: [Eugene Ware](http://github.com/eugeneware) has a Docker wordpress container build on nginx with some other goodies; you can check out his work [here](http://github.com/eugeneware/docker-wordpress-nginx).)


(N.B. the way that Docker handles permissions may vary depending on your current Docker version. If you're getting errors like
```
dial unix /var/run/docker.sock: permission denied
```
when you run the below commands, simply use sudo. This is a [known issue](https://twitter.com/docker/status/366040073793323008).)


This repo contains a recipe for making a [Docker](http://docker.io) container for Wordpress, using Linux, Apache and MySQL.
To build, make sure you have Docker [installed](http://www.docker.io/gettingstarted/), clone this repo somewhere, and then run:
```
docker build -rm -t <yourname>/wordpress .
```

Or, alternately, build DIRECTLY from the github repo like some sort of AMAZING FUTURO JULES-VERNESQUE SEA EXPLORER:
```
docker build -rm -t <yourname>/wordpress git://github.com/jbfink/docker-wordpress.git
```

Then run it, specifying your desired ports! Woo!
```
docker run --name wordpress -d -p <http_port>:80 <yourname>/wordpress
```


Check docker logs after running to see MySQL root password and Wordpress MySQL password, as so

```
echo $(docker logs wordpress | grep password)
```

(note: you won't need the mysql root or the wordpress db password normally)


Your wordpress container should now be live, open a web browser and go to http://localhost:<http_port>, then fill out the form. No need to mess with wp-config.php, it's been auto-generated with proper values.


You can shutdown your wordpress container like this:
```
docker stop wordpress
```

And start it back up like this:
```
docker start wordpress
```

Enjoy your wordpress install courtesy of Docker!
