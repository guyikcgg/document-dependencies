#!/usr/bin/perl

# images.perl
# print the relative path of the images included in a LyX file.
#   Copyright (C) 2017  Cristian G Guerrero
#
#   This program is free software: you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#   (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program.  If not, see <http://www.gnu.org/licenses/>.


# Libraries
use Getopt::Long;

# Global variables
my $imgpath = "img";
my $allpaths = "";

# Usage
sub Usage {
	print
"Usage:\n
\t$0 [--img-path\t<path to img directory (relative to .tex file)>] TeXfile\n";
}

# Get the options
#    img-path      path to img directory (relative to .tex file)
GetOptions("img-path=s" => \$path)
or die Usage();

# Read `filename` parameter
my $filename = @ARGV[0]
or die "No input file was specified\n";

# Open the file into `MYINPUTFILE`
open(MYINPUTFILE, "<$filename")
or die "Couldn't open '$filename' for input. Is it a valid file?\n";

# Read file into list
my(@lines) = <MYINPUTFILE>;

# Get a string including the complete path of every line in the file
# containing the 'path to img directory' indicated in the parameters
foreach(@lines) {
	# Get the current line
	my $img = $_;
	# Check that the current line contains `imgpath`
	if ($img =~ /$imgpath/) {
		# Trim line. Get only the part after 'filename' (Only for LyX)
		if ($img =~ m/filename.(.*)/) {
			# Get the string in the first group defined in the regular expression above (.*) i.e. the rest of the line.
			my $path = $1;
			# Concatenate the selected string into `allpaths` variable
			$allpaths = $allpaths . " " . $path;
		}
	}
}

# Print `allpaths` to STDOUT
print "$allpaths";

# Close the file
close(MYINPUTFILE);
