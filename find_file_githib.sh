
arr=(liby cbot918 dbmg sshy template qchat eztool temp-db-bulk infra-auto tools gob pooly wsy grpost youtube ppage blogg vsqly sqlitey yugo jsxpg go2v qcode-server qcodem)

github=cbot918

target=db.sh

for i in "${arr[@]}"
do
  if curl -s "https://github.com/$github/$i" | grep -w $target ;then
    echo "got it"
    echo $i
  fi
  sleep 1
done