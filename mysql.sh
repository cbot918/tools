CONTAINER=dby
NETWORK=default
DB_USER=root
DB_PASSWORD=12345
DB_NAME=dby
HOST=$(docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $CONTAINER)


# cmd list
if [ "$1" = "" ]; then
  echo -e "
usage:
  create: create db docker
  q : exec query
  attach: attach db
"
fi

# create db
if [ "$1" = "create" ]; then
  docker run --name $CONTAINER -e MYSQL_ROOT_PASSWORD=$DB_PASSWORD -e MYSQL_DATABASE=$DB_NAME -d mysql
fi

# operate db
if [ "$1" = "q" ]; then
docker run -it --rm --network $NETWORK mysql mysql -h $HOST -u $DB_USER -p$"$DB_PASSWORD" $DB_NAME -e "$2"
fi

# connect with docker cli
if [ "$1" = "attach" ]; then
docker run -it --rm --network $NETWORK mysql mysql -h $HOST -u $DB_USER -p$"$DB_PASSWORD" $DB_NAME
fi



# docker run -p 3307:3306 --name dby -d -e MYSQL_ROOT_PASSWORD=12345 -e POSTGRES_DB=dby postgres

# docker run -it --rm --network $NETWORK mysql mysql -h db -u $DB_USER -p$"$DB_PASSWORD" $DB -e "$1"





# docker run -p 3307:3306 --name dby -d -e MYSQL_ROOT_PASSWORD=12345 -e POSTGRES_DB=dby postgres




# docker run -it --rm mysql mysql -h <container_host> -P <container_port> -u <username> -p<password> <database_name>




# docker run -it --rm --network $NETWORK mysql mysql -h db -u $DB_USER -p$"$DB_PASSWORD" $DB -e "$1"