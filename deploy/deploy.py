#!/usr/bin/env python3
#encoding=utf-8

##
#@file deploy.py
#
# doxygen documentation for this script
#

"""
author: mklj

=== TODO ===

learn doxygen and use it ! or maybe sphinx ?
check the config file - potential problems are :
	directories name ending: w/ or w/o slash --> use path.join ?
	same path for conf_file and symlink : conf_file might be overwritten
"""

ERR_MSG_PY3 = "You need python3 to execute this script"

try:
	import configparser
except ImportError as e:
	print(ERR_MSG_PY3)
	exit(3)
import os
import argparse
import shutil

def yes_or_no(question, default="yes"):
	"""
	Ask a yes/no question
	If answering yes, returns True
	"""
	yes_synonyms = ["yes", "y"]
	no_synonyms = ["no", "n"]

	# the 'default' arg can only be "yes", "no" or None
	tip = str()
	if default == "yes":
		tip = "[Y/n]"
		yes_synonyms.append("")
	elif default == "no":
		tip = "[y/N]"
		no_synonyms.append("")
	elif default == None:
		tip = "[y/n]"
	else:
		raise ValueError("'default' arg can only be  \"yes\", \"no\" or \
			\"None\"")

	answer = input("{} {} >> ".format(question, tip))
	correct_answers = yes_synonyms + no_synonyms

	while answer.lower() not in correct_answers:
		answer = input("{} >> ".format(tip))
	return (answer in yes_synonyms)

def make_backup(src, dest=None, extension="bak"):
	"""!
	Makes a backup of src (directory or file) by copying into directory 
	dest (default dest is the directory of src).
	Symlinks are followed both in src and dest. The backup_extension
	parameter is added at the end of the copy filename.
	
	If dest is not a directory, raises a NotADirectoryError.

	@param src the file or directory to backup

	Returns the absolute path to the backup.
	"""
	if dest is not None and not os.path.isdir(dest):
		raise NotADirectoryError("{} is not a directory".format(dest))
	if dest is None:
		dest = os.path.dirname(src)
	dest_dir = os.path.realpath(dest)
	dest_base = os.path.basename(os.path.realpath(src))
	dest = "{}.{}".format(os.path.join(dest_dir, dest_base), extension)
	copy_path = str()
	try:
		if os.path.isfile(src):
			copy_path = shutil.copy2(src, dest, follow_symlinks=True)
		elif os.path.isdir(src):
			copy_path = shutil.copytree(src, dest, symlinks=True)
		print("{} copied to {}".format(src, dest))
	except IOError as e:
		print("I/O error({0}): {1}.".format(e.errno, e.strerror))
	return copy_path

class FilesDeployer(configparser.ConfigParser):
	"""
	An object whose purpose is to symlink the configurations files at the right
	place. The path for each file is defined in a configuration file, by default
	'./deploy.ini'.
	For each symlink to create, if the destination path already exists, and is a
	regular file, the user is asked wether he wants to make a backup of it.

	About the config file:
	TBD
	"""

	MSG_NO_PATHS = "You must define a paths file. method read_config(paths_file)"
	MSG_HELP_FILES = "the files to be symlinked"

	MSG_FILE_NOT_IN_CONFIG = "'{}' is not declared in config file."
	MSG_FILE_EXISTS = "File '{}' already exists."
	MSG_ASK_BACKUP = "Do you want to make a backup ?"
	MSG_FILE_BACKUP = "'{}' moved to '{}'"
	MSG_FILE_OVERWRITE = "'{}' will be overwritten !"
	MSG_FILE_SYMLINK = "'{}' symlinked to {}"

	OUTPUT_SPACER = "{}\n".format('-'*30)

    @staticmethod
    def chk_configfile(configfile):
        """
        may raise several FilesDeployerErrors
        """
       pass 

	def __init__(self, configfile, backup_ext="bak"):
        """
        """
        chk_configfile(configfile):
		super().__init__()
        self._configfile = os.path.realpath(configfile)
		self._backup_ext = backup_ext
        if self.get("env", "prefix"):
            self._prefix = self.get("env", "prefix")
        else:
            self._prefix = os.environ.get("HOME")
		self._prefix = os.environ.get("HOME")


	def __str__(self):
		s = ["prefix = {}\n".format(self._prefix)]
		s.append("PATHS:\n")
		if self.options('paths'):
			files_paths = list()
			for opt in self.options("paths"):
				files_paths.append("\t{} - {}\n".format(
					opt, self.get('paths', opt)))
			files_paths.sort(key = lambda y: y.lower())
			s += files_paths
		else:
			s.append("\t{}".format(self.MSG_NO_PATHS))
		return "".join(s)

	def set_prefix(self, new_prefix):
	    self._prefix = new_prefix	

	# def set_paths(self, paths_file):
	# 	try:
	# 		with open(paths_file, "r") as infile:
	# 			l = [line.strip() for line in infile]
	# 			paths = dict()
	# 			for elt in l:
	# 				t = elt.split()
	# 				paths[t[0]] = t[1]
	# 			self._paths = paths
	# 	except IOError as e:
	# 		print("I/O error({0}): {1}: {2}. {3}.)".format(
	# 		      e.errno, e.strerror, paths_file, self.MSG_NO_PATHS))

	#def read_config(self, paths_file):
		#try:
			#with open(paths_file, "r") as infile:
				#self.read(paths_file)
		#except IOError as e:
			#print("I/O error({0}): {1}: {2}. {3}.)".format(
				  #e.errno, e.strerror, paths_file, self.MSG_NO_PATHS))

	def deploy(self, conf_file):
		"""
		"""
		if conf_file in self.options("paths"):
			#dest = self._prefix + self.get("paths", conf_file)
			dest = os.path.join(self._prefix, self.get("paths", conf_file)
			if os.path.exists(dest):
				# ask wether to make a backup, otherwise, file will be lost
				if yes_or_no("{} {}".format(
					self.MSG_FILE_EXISTS.format(dest), self.MSG_ASK_BACKUP)):
					backup_path = dest + '.' + self._backup_ext
					make_backup(dest, extension=self._backup_ext)
					print(self.MSG_FILE_BACKUP.format(dest, backup))
				else:
					print(self.MSG_FILE_OVERWITE.format(dest))
				# remove former file / directory before symlinking
				if os.path.islink(dest) or os.path.isfile(dest):
					os.remove(dest)
				else:
					shutil.rmtree(dest)
			try:
				os.symlink(conf_file, dest)
				print(self.MSG_FILE_SYMLINK.format(conf_file, dest))
			except OSError as e:
				print("Cannot symlink: OSError({0}): {1}.".format(
					e.errno, e.strerror))
			# insert spacer between output for each file processed
		else:
            # TODO raise an error, or a warning ?
			print(self.MSG_FILE_NOT_IN_CONFIG.format(conf_file))
		print(self.OUTPUT_SPACER)

def main():
	# parameters for the argparse.ArgumentParser object
	PROG_NAME = "deploy"

	argparser = argparse.ArgumentParser()
	self.add_argument("files", nargs="*", help=self.MSG_HELP_FILES)
	# TODO: add backup extension option to parser
		
if __name__ == "__main__":
	main()
	# fd = FilesDeployer("debug.ini")
	#print(fd)
	#fd.parse_args()
	#print(FilesDeployer.__mro__)
	# print("=== FILES IN ARGS ===")
	# for f in fd._args.files:
	# 	print(f)
	# 	fd.deploy(f)
