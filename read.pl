#!/usr/bin/perl
print "content-type: text/html \n\n";
print '<head>';
#print '<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />';
print '<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />';
print qq|<meta charset="utf-8">
  <title>jQuery UI Datepicker - Default functionality</title>
  <link rel="stylesheet" href="//10.128.64.74/js/themes/smoothness/jquery-ui.css">
  <script src="http://10.128.64.74/js/jquery-1.11.1.js"></script>
  <script src="http://10.128.64.74/js/jquery-ui-git.js"></script>
  <link rel="stylesheet" href="/resources/demos/style.css">
  <script>
  \$(function() { 
    \$( "#datepicker" ).datepicker();
  });
  </script>
</head>|;
 

print "<html><body>";

print "Dame el nombre del respaldo que deseas consultar";

print '<form action="http://10.128.64.74/cgi-bin/backup/download.pl" method="post" >';
print 'Hostname: <input type="text" name="ID">';
print 'Fecha: <input type="text" id="datepicker">';
print '<input type="submit" value="Send">';
print '</form>';

print '</body></html>';
