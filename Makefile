SHELL = env PATH=$(HOME)/.rbenv/bin:$(HOME)/.rbenv/shims:${HOME}/.local/bin:${HOME}/.local/share/mise/shims:"$(PATH)" /bin/bash -o pipefail

.PHONY: dev_beta dev_rc dev_beta_sim dev_beta_sim_only dev_rc_sim beta rc rc_debug testflight lds_demo 
test: clean ## Clean
	@./update.sh -a
	@bundle exec fastlane test
beta: 
	@./update.sh -a
	@bundle exec fastlane beta
clean:
	@rm -rf build
