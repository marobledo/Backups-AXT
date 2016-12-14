#!/usr/bin/perl

####
#
# Ejecuta Resplados de Equipos CISCO
# Este script es llamado por un lanzador el cual corre desde el crontab 
# El argumento que interactua con el programa es un archivo que se genera con el comando 'split'
#    
####

use strict;
use Net::Telnet;
use fecha;


my $fecha = fecha;
my $fecha_ayer = fecha_ayer;
my $horaactual = hora;

my $home= "/opt/respaldos/command/data";
my $hosts = "hosts";
my $output = "output";
my $log = "log";
my $red = "red";


# Toma el argumento del lanzador
my $hosts_split = shift @ARGV;

my $cmdout = "$home/$output/$fecha";
$cmdout =~ s/( |\||\'|\")//g;
`mkdir $cmdout`;
print $cmdout."\n";


# Abrimos los archivos en los cuales vamos a procesar la informacion
open (HOSTS,"<$hosts_split") || die "no puedo abrir archivo de hosts\n";
open (ERROR,">>$home/$log/error.log") || die "no puedo abrir archivo error log\n"; 
open (RED,">>$home/$red/red.log") || die "no puedo abrir el archivo red log\n";
open (LOG,">>$home/$log/script.log") || die "no puedo abrir archivo script log\n"; 


print LOG $fecha." ".$horaactual." comienza el script\n";

while (<HOSTS>) 
{
    chomp $_;
    if ($_ =~ /(.*)/ )
    {
        my $hostname=$1;
        use Net::Telnet;
        my $t = Net::Telnet->new( Timeout => 10, Prompt  => '/[\>\#]/', Errmode => "return");
        my $openResult = $t->open($hostname);
        if ($openResult eq 1)
        {
            my @show_commands = ("show run","show version","show startup","show card","show access-list","show ip interface brief","show version","show interface","show ip ospf neig","show int description","show bgp summary","show interface status","show vlan","show policy-map control-plane");
            my $username = "username";
            my $password = "password";
            my $pwd1 = "pwd1";
            my $pwd2 = "pwd2";
            my $pwd3 = "pwd3";
            my $pwd4 = "pwd4";
            my $len = "terminal len 0";
            my $exit = "exit";
            $t->waitfor('/Username:|Usuario:|Login:|Username: t/');
            $t->print($username);
            $t->waitfor('/Password:|Enter|Login:/');
            $t->print($password);
            $t->waitfor('/>/');
            print "$cmdout/$hostname\n";
            $t->input_log("$cmdout/$hostname");
            $t->timeout('120');
            my $maximo = $t->max_buffer_length(50000000);
            $t->print('terminal len 0');
            $t->print('enable');
            $t->waitfor('/Password:|Enter|Login:/');
            $t->print($pwd1);
            my $eq1 = $t->waitfor("/$hostname#/");
            if ($eq1 eq 1) 
            {
                $t->print($len);
                $t->waitfor("/$hostname#/");
                foreach(@show_commands)
                {
                    $t->print($_);
                    $t->waitfor("/$hostname#/")
                } 
                $t->print($exit);
                $t->waitfor("/$hostname#/");
                print RED "$hostname,ISP\n";
            }
            elsif ($eq1 ne 1)
            {
                $t->print('enable');
                $t->waitfor('/Password:|Enter|Login:/');
                $t->print($pwd2);
                my $eq2 = $t->waitfor("/$hostname#/");
                if ($eq2 eq 1)     
                {
                    $t->print($len);
                    $t->waitfor("/$hostname#/");
                    foreach(@show_commands)
                    {
                        $t->print($_);
                        $t->waitfor("/$hostname#/")
                    } 
                    $t->print($exit);
                    $t->waitfor("/$hostname#/");
                    print RED "$hostname,DCN\n";
                }
                elsif ($pwd2 ne 1)
                {
                    $t->print('enable');
                    $t->waitfor('/Password:|Enter|Login:/');
                    $t->print($pwd3);
                    my $eq3 = $t->waitfor("/$hostname#/");
                    if ($eq3 eq 1)
                    {
                        $t->print($len);
                        $t->waitfor("/$hostname#/");
                        foreach(@show_commands)
                        {
                            $t->print($_);
                            $t->waitfor("/$hostname#/")
                        }
                        $t->print($exit);
                        $t->waitfor("/$hostname#/");
                        print RED "$hostname,NGN\n"; 
                    }
                    elsif ($eq3 ne 1)
                    {
                        $t->print('enable');
                        $t->waitfor('/Password:|Enter|Login:/');
                        $t->print($pwd4);
                        my $eq4 = $t->waitfor("/$hostname#/");
                        if ($eq4 eq 1)
                        {
                            $t->print($len);
                            $t->waitfor("/$hostname#/");
                            foreach(@show_commands)
                            {
                                $t->print($_);
                                $t->waitfor("/$hostname#/")
                            }
                            $t->print($exit);
                            $t->waitfor("/$hostname#/");
                            print RED "$hostname,LEGACY\n";
                        }
                        else
                        {
                            print "$hostname,no tomo ninguna ruta\n";
                            print ERROR "$hostname,Bad enable password \n";
                        }
                    }
                } 
            }
            else 
            {
                print "$hostname,Error loging into device\n";
                print ERROR "$hostname,Error loging into device\n";
            }
        } 
        else 
        {
            print "$hostname, Error connecting to device\n";
            print ERROR "$hostname,Error connecting to device\n";
            next;
        }
    }
    else
    {
        print ERROR "$_ no se pudo conectar\n";
    }
}

print LOG $fecha." ".$horaactual." termina el script\n";


close HOSTS;
close RESULT;
close ERROR;
close RED;
close LOG;

`rm $hosts_split`;

exit;