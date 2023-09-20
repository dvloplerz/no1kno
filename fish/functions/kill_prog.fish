function kill_prog --argument-names pr
  echo $(pidof $pr) | read $pr
  if test (echo $pr | wc -w) -gt 0
    kill -9 $(echo $pr | cut -d' ' -f$(echo $pr | wc -w))
    echo -e "Killed:- $pr"
  else 
    echo "Nothing is killed"
  end
end
