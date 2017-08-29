# 
# /*
#  * *********** WARNING **************
#  * This file generated by ModPerl::WrapXS/0.01
#  * Any changes made here will be lost
#  * ***********************************
#  * 01: lib/ModPerl/Code.pm:709
#  * 02: \xampp\perl\bin\.cpanplus\5.10.1\build\mod_perl-2.0.4\blib\lib/ModPerl/WrapXS.pm:626
#  * 03: \xampp\perl\bin\.cpanplus\5.10.1\build\mod_perl-2.0.4\blib\lib/ModPerl/WrapXS.pm:1175
#  * 04: \xampp\perl\bin\.cpanplus\5.10.1\build\mod_perl-2.0.4\Makefile.PL:423
#  * 05: \xampp\perl\bin\.cpanplus\5.10.1\build\mod_perl-2.0.4\Makefile.PL:325
#  * 06: \xampp\perl\bin\.cpanplus\5.10.1\build\mod_perl-2.0.4\Makefile.PL:56
#  * 07: \xampp\perl\bin\cpanp-run-perl.bat:21
#  */
# 


package APR::BucketType;

use strict;
use warnings FATAL => 'all';


use APR ();
use APR::XSLoader ();
our $VERSION = '0.009000';
APR::XSLoader::load __PACKAGE__;



1;
__END__

=head1 NAME

APR::BucketType - Perl API for APR bucket types



=head1 Synopsis

  use APR::BucketType ();
  
  my $name = $b_type->name;


=head1 Description

C<APR::BucketType> allows you to query bucket object type properties.



=head1 API

C<APR::BucketType> provides the following functions and/or methods:




=head2 C<name>

Get the name of the bucket type:

  my $bucket_type_name = $b_type->name;

=over 4

=item arg1: C<$b_type>
( C<L<APR::BucketType object|docs::2.0::api::APR::BucketType>> )

=item ret: C<$bucket_type_name> ( string )

=item since: 2.0.00

=back

Example:

  use APR::Bucket ();
  use APR::BucketType ();
  my $eos_b = APR::Bucket::eos_create($ba);
  my $b_type = $eos_b->type;
  my $name = $b_type->name;

Now C<$name> contains I<'EOS'>.







=head1 See Also

L<mod_perl 2.0 documentation|docs::2.0::index>.




=head1 Copyright

mod_perl 2.0 and its core modules are copyrighted under
The Apache Software License, Version 2.0.




=head1 Authors

L<The mod_perl development team and numerous
contributors|about::contributors::people>.

=cut
