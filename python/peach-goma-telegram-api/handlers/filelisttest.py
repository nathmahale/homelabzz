from os import listdir
from os.path import isfile, join, pardir
import os


currentDir = join(os.getcwd(), pardir, 'gifs')
onlyfiles = [f for f in listdir(currentDir) if isfile(join(currentDir, f))]

print(onlyfiles)
