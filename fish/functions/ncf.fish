function ncf
  set -l nvim_config_dir $XDG_CONFIG_HOME/nvim/
  set -l ncf_config_dir $XDG_CONFIG_HOME/fish/functions/ncf.fish

  set -lx nvim (fish_opt -s n -l nvim --required-val )
  set nvim $nvim (fish_opt -s e -l edit --long-only)
  set nvim $nvim (fish_opt -s c -l cd --long-only)
  argparse $nvim -- $argv 

  or return

  #echo "flag::" $_flag_n ", name::" $_flag_name ", value::" $_flag_value

  if test -n _flag_n
	  switch $_flag_n
		  case "--edit" or "e" or "edit"
			  nvim $nvim_config_dir
		  case "--cd" or "c" or "cd"
			  cd $nvim_config_dir
		  case "*"
			  return
	  end
  else 
	  return
  end
  omf reload

end
