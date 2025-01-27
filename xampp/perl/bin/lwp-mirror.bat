@rem = '--*-Perl-*--
@echo off
if "%OS%" == "Windows_NT" goto WinNT
perl -x -S "%0" %1 %2 %3 %4 %5 %6 %7 %8 %9
goto endofperl
:WinNT
perl -x -S %0 %*
if NOT "%COMSPEC%" == "%SystemRoot%\system32\cmd.exe" goto endofperl
if %errorlevel% == 9009 echo You do not have Perl in your PATH.
if errorlevel 1 goto script_failed_so_exit_with_non_zero_val 2>nul
goto endofperl
@rem ';
#!/xampp/perl/bin/perl.exe -w
#line 15

# Simple mirror utility using LWP

=head1 NAME

lwp-mirror - Simple mirror utility

=head1 SYNOPSIS

 lwp-mirror [-v] [-t timeout] <url> <local file>

=head1 DESCRIPTION

This program can be used to mirror a document from a WWW server.  The
document is only transfered if the remote copy is newer than the local
copy.  If the local copy is newer nothing happens.

Use the C<-v> option to print the version number of this program.

The timeout value specified with the C<-t> option.  The timeout value
is the time that the program will wait for response from the remote
server before it fails.  The default unit for the timeout value is
seconds.  You might append "m" or "h" to the timeout value to make it
minutes or hours, respectively.

Because this program is implemented using the LWP library, it only
supports the protocols that LWP supports.

=head1 SEE ALSO

L<lwp-request>, L<LWP>

=head1 AUTHOR

Gisle Aas <gisle@aas.no>

=cut


use LWP::Simple qw(mirror is_success status_message $ua);
use Getopt::Std;

$progname = $0;
$progname =~ s,.*/,,;  # use basename only
$progname =~ s/\.\w*$//; #strip extension if any

$VERSION = "5.810";

$opt_h = undef;  # print usage
$opt_v = undef;  # print version
$opt_t = undef;  # timeout

unless (getopts("hvt:")) {
    usage();
}

if ($opt_v) {
    require LWP;
    my $DISTNAME = 'libwww-perl-' . LWP::Version();
    die <<"EOT";
This is lwp-mirror version $VERSION ($DISTNAME)

Copyright 1995-1999, Gisle Aas.

This program is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.
EOT
}

$url  = shift or usage();
$file = shift or usage();
usage() if $opt_h or @ARGV;

if (defined $opt_t) {
    $opt_t =~ /^(\d+)([smh])?/;
    die "$progname: Illegal timeout value!\n" unless defined $1;
    $timeout = $1;
    $timeout *= 60   if ($2 eq "m");
    $timeout *= 3600 if ($2 eq "h");
    $ua->timeout($timeout);
}

$rc = mirror($url, $file);

if ($rc == 304) {
    print STDERR "$progname: $file is up to date\n"
}
elsif (!is_success($rc)) {
    print STDERR "$progname: $rc ", status_message($rc), "   ($url)\n";
    exit 1;
}
exit;


sub usage
{
    die <<"EOT";
Usage: $progname [-options] <url> <file>
    -v           print version number of program
    -t <timeout> Set timeout value
EOT
}

__END__
:endofperl
