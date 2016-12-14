#!/usr/bin/perl 

use CGI ':standard';
use CGI::Carp qw(fatalsToBrowser); 
use fecha;

my $fecha = fecha;
my $files_location; 
my $ID; 
my @fileholder;

$files_location = "/opt/respaldos/command/data/output/$fecha";
$log_location = "/opt/respaldos/command/data/output/web/log";

$ID = param('ID');

if ($ID eq '') 
{ 
    print "Content-type: text/html\n\n"; 
    print "Especifica archivo a descargar."; 
} 
else
{
    open(DLFILE, "<$files_location/$ID") || Error('abrir', 'archivo de backup'); 
    @fileholder = <DLFILE>; 
    close (DLFILE) || Error ('cerrar', 'archivo'); 

    open (LOG, ">>$log_location/$ID") || Error('abrir', 'archivo de log');
    print LOG "$ID\n";
    close (LOG);

    print "Content-Type:application/x-download\n"; 
    print "Content-Disposition:attachment;filename=$ID\n\n";
    print @fileholder
}

sub Error {
    print "Content-type: text/html\n\n";
    print "El servidor no puede $_[0] el $_[1]: $! \n";
    exit;
}


