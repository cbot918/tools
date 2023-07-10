CONTAINER=dby
PORT=5432
NETWORK=default
DB_USER=postgres
DB_PASSWORD="12345"
DB_NAME=dby
HOST=$(docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $CONTAINER)


# cmd list
if [ "$1" = "" ]; then
  echo -e '
usage:
  create     :create db docker
  q          :exec query
  attach     :attach db
  host       :see docker ip


examples:
  ./psql.sh create
  ./psql.sh q "create table users(name varchar(255));"
  ./psql.sh attach
  ./psql.sh host
'
fi

# create db
if [ "$1" = "create" ]; then
  docker run -p $PORT:5432 --name $CONTAINER -e POSTGRES_PASSWORD=$DB_PASSWORD -e POSTGRES_DB=$DB_NAME -d postgres
fi

# operate db
if [ "$1" = "q" ]; then
  docker run -it --rm --network $NETWORK postgres psql -h $HOST -U $DB_USER -d $DB_NAME -c "$2"
fi

# connect with docker cli
if [ "$1" = "attach" ]; then
  docker run -it --rm --network $NETWORK postgres psql -h $HOST -U $DB_USER -d $DB_NAME -c "create table users (name varchar(255));"
fi

# util
if [ "$1" = "host" ]; then
  echo $HOST
fi