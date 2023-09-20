if status is-interactive
    # Commands to run in interactive sessions can go here
	fish_config theme choose "Rosé Pine"
end

# cargo
set --export CARGO_HOME "$HOME/.cargo"
set --export PATH $CARGO_HOME/bin $PATH

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
