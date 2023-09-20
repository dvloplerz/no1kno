#!/usr/bin/env bash

id=$(./hyprws | jaq -jcr ".[0] | select(.id) | .id ")
name=$(./hyprws | jaq -jcr ".[0] | select(.id) | .name ")
length=$(./hyprws | jaq -jcr ".[] | select(.) | length")
r_l=$(./hyprws | jaq -jcr ".[] | select(.)")
f_l=$(./hyprws | jaq -jcr ". | select(.) | length")

for i in $(seq 0 $f_l )
do
  if [ $i -eq $(expr $f_l - 1) ]
  then
    break;
  fi
  printf '(literal :content "(label :text \`%s :: %s\` )")\n' $(./hyprws | jaq -jcr ".[$i] | select(.id) | .id") $(./hyprws | jaq -jcr ".[$i] | select(.name) | .name")
done

