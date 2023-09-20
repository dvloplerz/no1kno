function start_ssh
	eval $(ssh-agent -c)
	ssh-add $HOME/.ssh/zGhub
end	

