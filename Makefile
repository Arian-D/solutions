build:
	emacs --batch \
				--eval "(require 'ox-hugo)" \
				--eval "(setq org-confirm-babel-evaluate nil)" \
				--file ./build.org \
				--funcall org-babel-execute-buffer

# install:
# 	cp -r public $out
