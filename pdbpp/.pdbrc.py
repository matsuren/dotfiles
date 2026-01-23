import pdb
import os


class Config(pdb.DefaultConfig):
    def __init__(self):
        if "TMUX" in os.environ:
            self.editor = "tmux popup -E -w 90% -h 90% nvim +{lineno} {filename}"
        else:
            self.editor = "nvim +{lineno} {filename}"
