#!/usr/bin/env python3
#coding=utf-8

import os
import shutil
import deploy
import unittest

TEST_HOME = "tests_tmp"
TEST_FILE = "file"
TEST_FILE_BAK = "{}.bak".format(TEST_FILE)
TEST_FILE_OLD = "{}.old".format(TEST_FILE)
TEST_DIR = "dir"
TEST_DIR_DIST = "dir_dist"
TEST_DIR_BAK = "{}.bak".format(TEST_DIR)
TEST_DIR_OLD = "{}.old".format(TEST_DIR)
TEST_NOT_DIR = "not_a_dir"
TEST_LINK_FILE = "link_file"
TEST_LINK_DIR = "link_dir"

class TestBackup(unittest.TestCase):

	def setUp(self):
		os.mkdir(TEST_HOME)
		os.chdir(TEST_HOME)

	def tearDown(self):
		os.chdir("..")
		shutil.rmtree(TEST_HOME)

	def test_file_same_dir(self):
		with open(TEST_FILE, "w"):
			pass
		deploy.make_backup(TEST_FILE)
		self.assertTrue(os.path.exists(TEST_FILE_BAK), "backup was not created")

	def test_file_ch_extension(self):
		with open(TEST_FILE, "w"):
			pass
		deploy.make_backup(TEST_FILE, extension="old")
		self.assertTrue(os.path.exists(TEST_FILE_OLD))

	def test_dest_not_directory(self):
		with open(TEST_FILE, "w"):
			pass
		with open(TEST_NOT_DIR, "w"):
			pass
		with self.assertRaises(NotADirectoryError, msg="dest must be a directory"):
			deploy.make_backup(TEST_FILE, TEST_NOT_DIR)

	def test_file_other_dir(self):
		with open(TEST_FILE, "w"):
			pass
		os.mkdir(TEST_DIR)
		deploy.make_backup(TEST_FILE, TEST_DIR)
		target = "{}/{}".format(TEST_DIR, TEST_FILE_BAK)
		self.assertTrue(os.path.exists(target), "backup was not created")

	def test_file_same_dir_abs_path(self):
		with open(TEST_FILE, "w"):
			pass
		abs_path = os.path.abspath(TEST_FILE)
		deploy.make_backup(abs_path)
		self.assertTrue(os.path.exists(TEST_FILE_BAK))

	def test_dir_same_dir(self):
		os.mkdir(TEST_DIR)
		deploy.make_backup(TEST_DIR)
		self.assertTrue(os.path.exists(TEST_DIR_BAK), "directory was not copied")

	def test_dir_chg_extension(self):
		os.mkdir(TEST_DIR)
		deploy.make_backup(TEST_DIR, extension="old")
		self.assertTrue(os.path.exists(TEST_DIR_OLD))

	def test_dir_other_dir(self):
		os.mkdir(TEST_DIR)
		os.mkdir(TEST_DIR_DIST)
		deploy.make_backup(TEST_DIR, TEST_DIR_DIST)
		target = os.path.join(TEST_DIR_DIST, TEST_DIR_BAK)
		self.assertTrue(os.path.exists(target))

	def test_link_file(self):
		with open(TEST_FILE, "w"):
			pass
		os.symlink(TEST_FILE, TEST_LINK_FILE)
		deploy.make_backup(TEST_LINK_FILE)
		self.assertTrue(os.path.exists(TEST_FILE_BAK))

	def test_link_file_ch_extension(self):
		with open(TEST_FILE, "w"):
			pass
		os.symlink(TEST_FILE, TEST_LINK_FILE)
		deploy.make_backup(TEST_LINK_FILE, extension="old")
		self.assertTrue(os.path.exists(TEST_FILE_OLD))

	def test_link_dir(self):
		os.mkdir(TEST_DIR)
		os.symlink(TEST_DIR, TEST_LINK_DIR)
		deploy.make_backup(TEST_LINK_DIR)
		self.assertTrue(os.path.exists(TEST_DIR_BAK))

	def test_link_dir_ch_extension(self):
		os.mkdir(TEST_DIR)
		os.symlink(TEST_DIR, TEST_LINK_DIR)
		deploy.make_backup(TEST_LINK_DIR, extension="old")
		self.assertTrue(os.path.exists(TEST_DIR_OLD))

class TestDeployer(unittest.TestCase):

	def setUp():
		pass	

if __name__ == '__main__':
	unittest.main()
