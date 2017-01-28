all:
	ipython nbconvert --to markdown nvidia_mem_grapher.ipynb
	mv nvidia_mem_grapher.md README.md
