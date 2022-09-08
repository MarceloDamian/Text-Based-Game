#!/usr/bin/env perl

# warnings and strict are enabled.
$^W=1;
use strict;

my $firstnum= $ARGV[0];
my $secondnum= $ARGV[1];
my $arguments= scalar @ARGV;

# Cases to make sure arguments are valid.
if ($arguments < 3 || $arguments > 3)
{
	print "Error there needs to be 3 arguments. Two dimensions(integers) and textfile\n";
}
if ($firstnum =~ m/^[^0-9]+$/)
{	print "$firstnum is not a number\n";
	exit;
}
elsif ($secondnum =~ m/^[^0-9]+$/)
{	print "$secondnum is not a number\n";
	exit;
}
elsif($firstnum <= 0 || $secondnum <= 0)
{   
	die "You have entered a negative dimension.\n";
	exit;
}
elsif ($firstnum<11)
{	
	die "$firstnum is not greater than 11\n";
    exit;
}
elsif ($secondnum<11)
{	
	die "$secondnum is not greater than 11\n";
    exit;
}
elsif ($firstnum % 2 ==0)
{	
	$firstnum +=1;
}
elsif ($secondnum % 2 == 0)
{	
	$secondnum +=1;
}

open(FILE, $ARGV[2]) || die "Could not open file\n";

my $steps; 

# Variables for position 
my $x= int($firstnum/2)+1;
my $y= int($secondnum/2)+1;

# Variables for initial position.
my $originx = $x;
my $originy = $y;

# Variables for counters.
my $fitbit=0;
my $origincounter=0;

# Variables for varied positon.
my $ys = 0;
my $yn = 0;
my $xe = 0;
my $xw = 0;

# Counting times visited origin as well as position. 
while ($steps = <FILE>) {
	chomp $steps;
	if ($steps=~/^[^news]+$/)
	{
		die "error.\n";
	}
	my @steps= split(//, $steps);

	foreach my $step (@steps) {

		if ($step eq "n")
		{
			$yn+=1;
			$y+=1;
			#print " $y  ";
			$fitbit+=1;       #after this step it doesn't freaking continue.....
		}
		if ($step eq "s")
		{
			$ys-=1;
			$y-=1;
			$fitbit+=1;
		}	
		if($step eq "w")
		{
			$xw+=1;
			$x+=1;
			$fitbit+=1;
		}	
		if ($step eq "e")
		{
			$xe-=1;
			$x-=1;
			$fitbit+=1;
		}	

		if ($x == $originx && $y == $originy)
		{   
			$origincounter +=1;
			$xe=0;
			$xw=0;
			$yn=0;
			$ys=0;
		}
	}

	# Checking to see if you hit any walls or gates along the way. 

	print "The walk was $fitbit steps long. You returned to the origin $origincounter time(s).\n";

	if ($xe <= -1 * $originx)
	{
		print "\nYou have reached the gate!!! You win!\n";
		exit;
	}
	if ($xw >= $originx)
	{
		print "\nYou have hit the west wall\n";
		exit;
	}	
	if ( $yn >= $originy)
	{
		print "\nYou have hit the north wall\n";
		exit;
	}
	if ($ys < -1 * $originy )#in the south direction it is less than zero
	{
		print "\nYou have hit the south wall\n";
		exit;
	}
	exit;
}               

close FILE; # File closed. 
