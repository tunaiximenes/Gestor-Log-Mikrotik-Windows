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
#!/xampp/perl/bin/perl.exe
#line 15
# htmlclean
# Copyright (C) 1998 by ITU

use strict;

sub usage {
  print STDERR <<END;
 usage: $0 file1 [file2 file3 ...]
END
  exit 1;
}

sub print_version {
  my($version) = $HTML::Clean::VERSION;
  print "$0\n\tHTML::Clean::VERSION: $version\n\n";
  exit 0;
}

=head1 NAME

htmlclean - a small script to clean up existing HTML

=head1 SYNOPSIS

B<htmlclean [-v] [-V] file1 [file2 file3 ...]>

=head1 DESCRIPTION

This program provides a command-line interface to the HTML::Clean
module, which can help you to provide more compatible, smaller HTML
files at the expense of reducing the human readability of the HTML
code.  In some cases you may be able to reduce the size of your HTML
by up to 50%!

The HTML::Clean library provides a number of features that improve your
HTML for browsing and serving:

B<htmlclean> passes each file given on the command line to the library
and writes out the new HTML according to the specified options.  The
default is to create a backup file and replace the file with cleaned HTML.

=over 6

=item Removing whitespace, Comments and other useless or redundant constructs

=item Insuring that font tags work across multiple operating systems

=back

For full details see the documentations for L<HTML::Clean> itself.



=head1 OPTIONS

=over 4

=item C<-V>

Print the version of the program.

=item C<-v>

Verbose mode. Print out the original and final file sizes, plus the 
compression percent.  For example:

  5261   4065 22% /tmp/development-es.html
  5258   4061 22% /tmp/development-fr.html
  4651   3683 20% /tmp/development.html

=back

=head1 SEE ALSO

For the library, see L<HTML::Clean>

=head1 AUTHOR

C<htmlclean> is written by Paul Lindner, <paul.lindner@itu.int>

=head1 COPYRIGHT

Copyright (c> 1998 by ITU under the same terms as Perl.

=cut

usage() if ($#ARGV == -1);
usage() if ($#ARGV >=0 && $ARGV[0] eq '-?');


use HTML::Clean;
use Getopt::Long;
my (%opts);

$Getopt::Long::getopt_compat = 1;   # avoid parsing +'s as options (doesn't work!)
&Getopt::Long::config(qw(no_ignore_case no_getopt_compat));
&GetOptions(\%opts, qw(v V t=s 1 2 3 4 5 6 7 8 9));

&print_version if ($opts{'V'});
&usage if ($#ARGV == -1); # we MUST have at least one file

my($verbose) = $opts{'v'};
my $level = 9;
foreach my $i (1, 2, 3, 4, 5, 6, 7, 8, 9) {
  $level = $i if ($opts{$i});
}

&main($level, \@ARGV);
exit 0;

sub main {
  my($level, $files) = @_;

  my $h = new HTML::Clean(); # Just a empty holder..
  print_error('initializing...') if (!$h);
  $h->level($level);

  foreach my $f (@$files) {
    my $result = $h->initialize($f); 
    print_error($f) if ($result == 0);

    my $d = $h->data();
    my $origlen = length($$d);

    # add options to control these...
    $h->compat();
    $h->strip();
    
    my $newlen = length($$d);
    my $pct = 0;
    if ($origlen > 0) {
      $pct = (100 * ($origlen - $newlen)) / $origlen;
    }
    printf "%6d %6d %2d%% %s\n", $origlen, $newlen, $pct, $f if ($verbose);
    
    # Okay, now move the files around..
    rename($f, "$f.bak") || die "Cannot rename '$f': $!\n";
    open(output, ">$f") || die "Cannot overwrite '$f': $!\n";
    print output $$d;
    close(output);
  }
}

  
sub print_error {
  my($msg) = @_;
  print STDERR <<END;
$0: $msg ($!)
END
exit(1);
}



__END__
:endofperl
