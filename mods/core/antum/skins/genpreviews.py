#!/usr/bin/env python

# License header:
#
# The MIT License (MIT)
#
# Copyright (c) 2021 Jordan Irwin (AntumDeluge)
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of
# this software and associated documentation files (the "Software"), to deal in
# the Software without restriction, including without limitation the rights to
# use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
# of the Software, and to permit persons to whom the Software is furnished to do
# so, subject to the following conditions:
#
#   The above copyright notice and this permission notice shall be included in
#   all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.


import sys, errno

# check for compatible Python version
if sys.version_info.major < 3:
	print("[ERROR] this script requires Python 3, using {}".format(sys.version.split()[0]))
	sys.exit(errno.EPERM)

import os, math, subprocess
from subprocess import CalledProcessError, DEVNULL
from PIL import Image

# FIXME: use "PIL" or "wand" module (ImageMagick) for converting images if available
# FIXME: logging doesn't output until all commands have finished

dlist = []
flist = []

exe = os.path.basename(__file__)


def show_usage():
	print("\nUsage:\n\t{} [-d <out_dir>] <file>|<dir> ...".format(exe))


log_levels = ("debug", "info", "warning", "error")

def log(lvl, msg=None, err=0):
	if not msg:
		msg = lvl
		lvl = None

	if not lvl and not msg:
		msg = "empty log message"
		lvl = "error"
		err = errno.EINVAL
	elif lvl and not lvl.lower() in log_levels:
		msg = "unknown log level: {}".format(lvl)
		lvl = "error"
		err = errno.EINVAL

	if lvl:
		msg = "[{}] {}".format(lvl.upper(), msg)

	print(msg)

	if err:
		sys.exit(err)


WIN32 = sys.platform == "win32"
def get_command(cmd_name):
	cmd = None

	try:
		if WIN32:
			cmd = subprocess.check_output(("where", cmd_name,), stderr=DEVNULL).decode("utf-8").strip(" \t\r\n")
			# user first executable found
			cmd = cmd.split("\r\n")[0]
		else:
			cmd = subprocess.check_output(("which", cmd_name,), stderr=DEVNULL).decode("utf-8").strip(" \t\r\n")
	except CalledProcessError:
		pass

	if cmd:
		cmd = os.path.normpath(cmd)

	return cmd


dir_temp = "/tmp"
for d in (os.getenv("tmp"), os.getenv("temp")):
	if d:
		dir_temp = d
		break

if not os.path.isdir(dir_temp):
	log("error", "can't find temp directory for creating temporary files", errno.ENOENT)

def add_file(fname):
	fname = os.path.normpath(fname)

	if not os.path.isfile(fname):
		log("warning", "not adding non-file: {}".format(fname))
		return

	if not fname.lower().endswith("-preview.png"):
		if fname in flist:
			log("warning", "file already added: {}".format(fname))
		else:
			flist.append(fname)


def create_preview(fname):
	d_out = dir_out
	if not d_out:
		d_out = os.path.dirname(fname)

	# FIXME: needs to be case insensitive
	preview = os.path.join(d_out, "{}-preview".format(os.path.basename(fname).split(".png")[0]))
	preview_overlay = "{}-overlay.png".format(preview)
	preview = "{}.png".format(preview)

	# don't overwrite existing previews
	if not os.path.isfile(preview):
		log("Creating preview for {}".format(fname))

		img = Image.open(fname)
		cut_w = math.floor(img.size[0] / 16)
		cut_h = math.floor(img.size[1] / 8)
		cut_wh = "{}x{}".format(cut_w, cut_h)

		f_basename = ".".join(os.path.basename(fname).split(".")[:-1])
		f_suffix = fname.split(".")[-1]

		base = os.path.join(dir_temp, "{}-TMP".format(f_basename))
		proc = subprocess.Popen((cmd_convert, fname, "-define", "png:format=png32", "-crop", \
				cut_wh, "{}.{}".format(base, f_suffix)))
		out, err = proc.communicate()

		# create transparent block
		proc = subprocess.Popen((cmd_convert, "-size", cut_wh, "-define", "png:format=png32", \
			"canvas:transparent", "{}--1.{}".format(base, f_suffix)))

		flip_arms = (91, 108, 124)
		flip_legs = (81, 97, 113)
		for f in (flip_arms + flip_legs):
			tmp_src = "{}-{}.{}".format(base, f, f_suffix)
			tmp_flip = "{}-{}-flip.{}".format(base, f, f_suffix)

			proc = subprocess.Popen((cmd_convert, tmp_src, "-flop", tmp_flip))
			out, err = proc.communicate()

		pieces = []
		head = (-1, 34, 35, -1, -1, 50, 51, -1)
		torso = (91, 85, 86, "91-flip", 108, 101, 102, "108-flip", 124, 117, 118, "124-flip")
		legs = (-1, "81-flip", 81, -1, -1, "97-flip", 97, -1, -1, "113-flip", 113, -1)
		for piece in (head + torso + legs):
			piece = os.path.join(dir_temp, "{}-TMP-{}.{}".format(f_basename, piece, f_suffix))
			if not os.path.isfile(piece):
				log("error", "failed to create temporary images in \"{}\"".format(dir_temp), errno.ENOENT)

			pieces.append(piece)

		overlay_pieces = []
		head_overlay = [-1, 42, 43, -1, -1, 58, 59]
		while len(head_overlay) < len(pieces):
			head_overlay.append(-1)

		for piece in (head_overlay):
			piece = os.path.join(dir_temp, "{}-TMP-{}.{}".format(f_basename, piece, f_suffix))
			if not os.path.isfile(piece):
				log("error", "failed to create temporary images in \"{}\"".format(dir_temp), errno.ENOENT)

			overlay_pieces.append(piece)

		proc = subprocess.Popen(((cmd_montage,) + tuple(pieces) + ("-define", \
			"png:format=png32", "-background", "none", "-geometry", "+0+0", "-tile", \
			"4x9", preview,)))
		out, err = proc.communicate()

		proc = subprocess.Popen(((cmd_montage,) + tuple(overlay_pieces) + ("-define", \
			"png:format=png32", "-background", "none", "-geometry", "+0+0", "-tile", \
			"4x9", preview_overlay,)))
		out, err = proc.communicate()

		proc = subprocess.Popen((cmd_composite, "-define", "png:format=png32", \
			"-compose", "atop", preview_overlay, preview, preview))
		out, err = proc.communicate()

		# cleanup
		if os.path.isfile(preview_overlay):
			os.remove(preview_overlay)
		with os.scandir(dir_temp) as it:
			for entry in it:
				if entry.is_file() and entry.name.startswith("{}-TMP-".format(f_basename)) and \
						entry.name.endswith(f_suffix):
					os.remove(entry.path)
	else:
		log("warning", "preview already exists: {}".format(preview))


# check for ImageMagick
cmd_convert = get_command("convert")
cmd_montage = get_command("montage")
cmd_composite = get_command("composite")

# Windows has a "convert" executable that is not related to ImageMagick
if WIN32 and cmd_convert.lower().endswith("windows\\system32\\convert.exe"):
	cmd_convert = None

if not cmd_convert:
	log("error", "ImageMagick \"convert\" command not found, check system PATH", errno.ENOENT)
if not cmd_montage:
	log("error", "ImageMagick \"montage\" command not found, check system PATH", errno.ENOENT)
if not cmd_composite:
	log("error", "ImageMagick \"compisite\" command not found, check system PATH", errno.ENOENT)


args = tuple(sys.argv[1:])
dir_out = None

# extract switches
if args and args[0] == "-d":
	if len(args) < 2:
		log("error", "output directory not supplied")
		show_usage()
		sys.exit(errno.ENOENT)

	dir_out = args[1]
	args = args[2:]

if len(args) == 0:
	log("error", "no input")
	show_usage()
	sys.exit(errno.EPERM)

if dir_out:
	if os.path.isfile(dir_out):
		log("error", "cannot output to directory, file exists: {}".format(dir_out), errno.EEXIST)
	elif not os.path.isdir(dir_out):
		os.makedirs(dir_out)

for a in args:
	if os.path.isdir(a):
		dlist.append(a)
	elif os.path.isfile(a):
		add_file(a)
	else:
		log("error", "not a file or directory: {}".format(a))
		sys.exit(errno.ENOENT)

for d in dlist:
	# don't recurse subdirs
	for f in os.listdir(d):
		f = os.path.join(d, f)
		if os.path.isfile(f) and f.lower().endswith(".png"):
			add_file(f)

if len(flist) == 0:
	log("error", "no compatible PNG images found")
	show_usage()
	sys.exit(errno.ENOENT)

for f in flist:
	create_preview(f)
