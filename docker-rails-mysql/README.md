# set up

### add database.yml
```
development:
  <<: *default
  host: db
  socket: /var/run/mysqld/mysqld.sock
```


### run docker-compose

```
$ docker-compose up
$ docker-compose run --rm app bin/rails db:setup
$ docker-compose run --rm app bin/rails db:migrate
```

