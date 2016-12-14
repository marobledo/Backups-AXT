#!/usr/bin/perl
#use Time::Local;
use strict;
use warnings;

sub fecha()
{
    my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time());
    $year+=1900;
    $mon+=1;
    if ($mon <= 9) 
    {
         $mon="0".$mon;
    }    
    if ($mday >= 9) 
    {
        return $mday."-".$mon."-".$year;
    }
    else
    {
        return "0".$mday."-".$mon."-".$year;    
    }
}

sub fecha_ayer()
{
    my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time() - 24 * 60 * 60);
    $year+=1900;
    $mon+=1;
    if ($mon <= 9)
    {
         $mon="0".$mon;
    }
    if ($mday >= 9) 
    {
        return $mday."-".$mon."-".$year;
    }
    else
    {
        return "0".$mday."-".$mon."-".$year;    
    }
}

sub hora()
{
    my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time());
    return $hour.":".$min.":".$sec;
}



my $fecha = fecha();
my $fecha_ayer = fecha_ayer();
