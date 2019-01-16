#!/usr/bin/env bash

lastupdate=`cat script/update.time` # get time of last update

lastmodified=`find db/migrate/ -printf '%T+\n' | sort -r | head -n1`
if [[ "$lastupdate" < "$lastmodified" ]] ; then
  echo '$ rake db:migrate'
  rake db:migrate | sed -e 's/^/   /g;' | cat # sed to indent output
fi

lastmodified=`find db/seeds.rb -printf '%T+\n' | sort -r | head -n1`
if [[ "$lastupdate" < "$lastmodified" ]] ; then
  echo '$ rake db:seed'
  rake db:seed | sed -e 's/^/   /g;' | cat # sed to indent output
fi
