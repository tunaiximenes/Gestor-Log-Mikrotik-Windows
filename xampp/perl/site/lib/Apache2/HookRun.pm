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


package Apache2::HookRun;

use strict;
use warnings FATAL => 'all';



use Apache2::XSLoader ();
our $VERSION = '2.000004';
Apache2::XSLoader::load __PACKAGE__;



1;
__END__

=head1 NAME

Apache2::HookRun - Perl API for Invoking Apache HTTP phases




=head1 Synopsis

  # httpd.conf
  PerlProcessConnectionHandler MyApache2::PseudoHTTP::handler

  #file:MyApache2/PseudoHTTP.pm
  #---------------------------
  package MyApache2::PseudoHTTP;
  
  use Apache2::HookRun ();
  use Apache2::RequestUtil ();
  use Apache2::RequestRec ();
  
  use Apache2::Const -compile => qw(OK DECLINED DONE SERVER_ERROR);
  
  # implement the HTTP protocol cycle in protocol handler
  sub handler {
      my $c = shift;
      my $r = Apache2::RequestRec->new($c);
  
      # register any custom callbacks here, e.g.:
      # $r->push_handlers(PerlAccessHandler => \&my_access);
  
      $rc = $r->run_post_read_request();
      return $rc unless $rc == Apache2::Const::OK or $rc == Apache2::Const::DECLINED;
  
      $rc = $r->run_translate_name;
      return $rc unless $rc == Apache2::Const::OK or $rc == Apache2::Const::DECLINED;
  
      $rc = $r->run_map_to_storage;
      return $rc unless $rc == Apache2::Const::OK or $rc == Apache2::Const::DECLINED;
  
      # this must be run all a big havoc will happen in the following
      # phases
      $r->location_merge($path);
  
      $rc = $r->run_header_parser;
      return $rc unless $rc == Apache2::Const::OK or $rc == Apache2::Const::DECLINED;
  
      my $args = $r->args || '';
      if ($args eq 'die') {
          $r->die(Apache2::Const::SERVER_ERROR);
          return Apache2::Const::DONE;
      }
  
      $rc = $r->run_access_checker;
      return $rc unless $rc == Apache2::Const::OK or $rc == Apache2::Const::DECLINED;
  
      $rc = $r->run_auth_checker;
      return $rc unless $rc == Apache2::Const::OK or $rc == Apache2::Const::DECLINED;
  
      $rc = $r->run_check_user_id;
      return $rc unless $rc == Apache2::Const::OK or $rc == Apache2::Const::DECLINED;
  
      $rc = $r->run_type_checker;
      return $rc unless $rc == Apache2::Const::OK or $rc == Apache2::Const::DECLINED;
  
      $rc = $r->run_fixups;
      return $rc unless $rc == Apache2::Const::OK or $rc == Apache2::Const::DECLINED;
  
      # $r->run_handler is called internally by $r->invoke_handler,
      # invoke_handler sets all kind of filters, and does a few other
      # things but it's possible to call $r->run_handler, bypassing
      # invoke_handler
      $rc = $r->invoke_handler;
      return $rc unless $rc == Apache2::Const::OK or $rc == Apache2::Const::DECLINED;
  
      $rc = $r->run_log_transaction;
      return $rc unless $rc == Apache2::Const::OK or $rc == Apache2::Const::DECLINED;
  
      return Apache2::Const::OK;
  }





=head1 Description

C<Apache2::HookRun> exposes parts of the Apache HTTP protocol
implementation, responsible for invoking callbacks for each L<HTTP
Request cycle
phase|docs::2.0::user::handlers::http/HTTP_Request_Cycle_Phases>.

Armed with that API, you could run some of the http protocol framework
parts when implementing your own protocols. For example see how HTTP
AAA (access, auth and authz) hooks are called from a protocol handler,
implementing L<a command
server|docs::2.0::user::handlers::protocols/Command_Server>, which has
nothing to do with HTTP. Also you can see in L<Synopsis|/Synopsis> how
to re-implement Apache HTTP cycle in the protocol handler.

Using this API you could probably also change the normal Apache
behavior (e.g. invoking some hooks earlier than normal, or later), but
before doing that you will probably need to spend some time reading
through the Apache C code. That's why some of the methods in this
document, point you to the specific functions in the Apache source
code. If you just try to use the methods from this module, without
understanding them well, don't be surprised if you will get some nasty
crashes, from which mod_perl can't protect you.






=head1 API

C<Apache2::HookRun> provides the following functions and/or methods:








=head2 C<die>

Kill the current request

  $r->die($type);

=over 4

=item obj: C<$r>
( C<L<Apache2::RequestRec object|docs::2.0::api::Apache2::RequestRec>> )

The current request

=item arg1: C<$type> ( integer )

Why the request is dieing. Expects an Apache status constant.

=item ret: no return value

=item since: 2.0.00

=back

This method doesn't really abort the request, it just handles the
sending of the error response, logging the error and such.  You want
to take a look at the internals of C<ap_die()> in
F<httpd-2.0/modules/http/http_request.c> for more details.





=head2 C<invoke_handler>

Run the
L<response|docs::2.0::user::handlers::http/PerlResponseHandler> phase.

  $rc = $r->invoke_handler();

=over 4

=item obj: C<$r>
( C<L<Apache2::RequestRec object|docs::2.0::api::Apache2::RequestRec>> )

The current request

=item ret: C<$rc> ( integer )

The status of the current phase run: C<Apache2::Const::OK>,
C<Apache2::HTTP_...>

=item since: 2.0.00

=back

C<invoke_handler()> allows modules to insert filters, sets a default
handler if none is set, runs C<L<run_handler()|/C_run_handler_>> and
handles some errors.

For more details see C<ap_invoke_handler()> in
F<httpd-2.0/server/config.c>.








=head2 C<run_access_checker>

Run the resource L<access
control|docs::2.0::user::handlers::http/PerlAccessHandler> phase.

  $rc = $r->run_access_checker();

=over 4

=item obj: C<$r>
( C<L<Apache2::RequestRec object|docs::2.0::api::Apache2::RequestRec>> )

the current request

=item ret: C<$rc> ( integer )

The status of the current phase run: C<Apache2::Const::OK>,
C<Apache2::Const::DECLINED>, C<Apache2::HTTP_...>.

=item since: 2.0.00

=back

This phase runs before a user is authenticated, so this hook is really
to apply additional restrictions independent of a user. It also runs
independent of 'C<Require>' directive usage.







=head2 C<run_auth_checker>

Run the
L<authentication|docs::2.0::user::handlers::http/PerlAuthenHandler>
phase.

  $rc = $r->run_auth_checker();

=over 4

=item obj: C<$r>
( C<L<Apache2::RequestRec object|docs::2.0::api::Apache2::RequestRec>> )

the current request

=item ret: C<$rc> ( integer )

The status of the current phase run: C<Apache2::Const::OK>,
C<Apache2::Const::DECLINED>, C<Apache2::HTTP_...>.

=item since: 2.0.00

=back

This phase is used to check to see if the resource being requested is
available for the authenticated user (C<$r-E<gt>user> and
C<$r-E<gt>ap_auth_type>).

It runs after the L<access_checker|/C_run_access_checker_> and
L<check_user_id|/C_run_auth_checker_> hooks.

Note that it will only be called if Apache determines that access
control has been applied to this resource (through a 'C<Require>'
directive).







=head2 C<run_check_user_id>

Run the
L<authorization|docs::2.0::user::handlers::http/PerlAuthzHandler>
phase.

  $rc = $r->run_check_user_id();

=over 4

=item obj: C<$r>
( C<L<Apache2::RequestRec object|docs::2.0::api::Apache2::RequestRec>> )

The current request

=item ret: C<$rc> ( integer )

The status of the current phase run: C<Apache2::Const::OK>,
C<Apache2::Const::DECLINED>, C<Apache2::HTTP_...>.

=item since: 2.0.00

=back

This hook is used to analyze the request headers, authenticate the
user, and set the user information in the request record
(C<$r-E<gt>user> and C<$r-E<gt>ap_auth_type>).

This hook is only run when Apache determines that
authentication/authorization is required for this resource (as
determined by the 'C<Require>' directive).

It runs after the L<access_checker|/C_run_access_checker_> hook, and
before the L<auth_checker|/C_run_auth_checker_> hook.








=head2 C<run_fixups>

Run the L<fixup|docs::2.0::user::handlers::http/PerlFixupHandler>
phase.

  $rc = $r->run_fixups();

=over 4

=item obj: C<$r>
( C<L<Apache2::RequestRec object|docs::2.0::api::Apache2::RequestRec>> )

The current request

=item ret: C<$rc> ( integer )

The status of the current phase run: C<Apache2::Const::OK>,
C<Apache2::Const::DECLINED>, C<Apache2::HTTP_...>.

=item since: 2.0.00

=back

This phase allows modules to perform module-specific fixing of HTTP
header fields.  This is invoked just before the
L<response|docs::2.0::user::handlers::http/PerlResponseHandler> phase.






=head2 C<run_handler>

Run the
L<response|docs::2.0::user::handlers::http/PerlResponseHandler> phase.

  $rc = $r->run_handler();

=over 4

=item obj: C<$r>
( C<L<Apache2::RequestRec object|docs::2.0::api::Apache2::RequestRec>> )

The request_rec

=item ret: C<$rc> ( integer )

The status of the current phase run: C<Apache2::Const::OK>,
C<Apache2::Const::DECLINED>, C<Apache2::HTTP_...>.

=item since: 2.0.00

=back

C<run_handler()> is called internally by
C<L<invoke_handler()|/C_invoke_handler_>>. Use C<run_handler()> only
if you want to bypass the extra functionality provided by
C<L<invoke_handler()|/C_invoke_handler_>>.








=head2 C<run_header_parser>

Run the L<header
parser|docs::2.0::user::handlers::http/PerlHeaderParserHandler> phase.

  $rc = $r->run_header_parser();

=over 4

=item obj: C<$r>
( C<L<Apache2::RequestRec object|docs::2.0::api::Apache2::RequestRec>> )

The current request

=item ret: C<$rc> ( integer )

C<Apache2::Const::OK> or C<Apache2::Const::DECLINED>.

=item since: 2.0.00

=back





=head2 C<run_log_transaction>

Run the L<logging|docs::2.0::user::handlers::http/PerlLogHandler>
phase.

  $rc = $r->run_log_transaction();

=over 4

=item obj: C<$r>
( C<L<Apache2::RequestRec object|docs::2.0::api::Apache2::RequestRec>> )

The current request

=item ret: C<$rc> ( integer )

The status of the current phase run: C<Apache2::Const::OK>,
C<Apache2::Const::DECLINED>, C<Apache2::HTTP_...>

=item since: 2.0.00

=back

This hook allows modules to perform any module-specific logging
activities over and above the normal server things.






=head2 C<run_map_to_storage>

Run the
L<map_to_storage|docs::2.0::user::handlers::http/PerlMapToStorageHandler>
phase.

  $rc = $r->run_map_to_storage();

=over 4

=item obj: C<$r>
( C<L<Apache2::RequestRec object|docs::2.0::api::Apache2::RequestRec>> )

The current request

=item ret: C<$rc> ( integer )

C<Apache2::Const::DONE> (or C<Apache2::HTTP_*>) if this contextless request was
just fulfilled (such as C<TRACE>), C<Apache2::Const::OK> if this is not a
file, and C<Apache2::Const::DECLINED> if this is a file.  The core
map_to_storage (C<Apache2::HOOK_RUN_LAST>) will C<directory_walk()> and
C<file_walk()> the C<$r-E<gt>filename> (all internal C functions).

=item since: 2.0.00

=back

This phase allows modules to set the per_dir_config based on their own
context (such as C<E<lt>ProxyE<gt>> sections) and responds to
contextless requests such as C<TRACE> that need no security or
filesystem mapping based on the filesystem.






=head2 C<run_post_read_request>


Run the
L<post_read_request|docs::2.0::user::handlers::http/PerlPostReadRequestHandler>
phase.

  $rc = $r->run_post_read_request();

=over 4

=item obj: C<$r>
( C<L<Apache2::RequestRec object|docs::2.0::api::Apache2::RequestRec>> )

The current request

=item ret: C<$rc> ( integer )

The status of the current phase run: C<Apache2::Const::OK> or
C<Apache2::Const::DECLINED>.

=item since: 2.0.00

=back

This phase is run right after C<read_request()> or
C<internal_redirect()>, and not run during any subrequests.  This hook
allows modules to affect the request immediately after the request has
been read, and before any other phases have been processes.  This
allows modules to make decisions based upon the input header fields





=head2 C<run_translate_name>

Run the L<translate|docs::2.0::user::handlers::http/PerlTransHandler>
phase.

  $rc = $r->run_translate_name();

=over 4

=item obj: C<$r>
( C<L<Apache2::RequestRec object|docs::2.0::api::Apache2::RequestRec>> )

The current request

=item ret: C<$rc> ( integer )

The status of the current phase run: C<Apache2::Const::OK>,
C<Apache2::Const::DECLINED>, C<Apache2::HTTP_...>.

=item since: 2.0.00

=back

This phase gives modules an opportunity to translate the URI into an
actual filename.  If no modules do anything special, the server's
default rules will be applied.





=head2 C<run_type_checker>

Run the
L<type_checker|docs::2.0::user::handlers::http/PerlTypeHandler> phase.

  $rc = $r->run_type_checker();

=over 4

=item obj: C<$r>
( C<L<Apache2::RequestRec object|docs::2.0::api::Apache2::RequestRec>> )

the current request

=item ret: C<$rc> ( integer )

The status of the current phase run: C<Apache2::Const::OK>,
C<Apache2::Const::DECLINED>, C<Apache2::HTTP_...>.

=item since: 2.0.00

=back

This phase is used to determine and/or set the various document type
information bits, like C<Content-type> (via C<$r-E<gt>content_type>),
language, etc.







=head1 See Also

L<mod_perl 2.0 documentation|docs::2.0::index>.




=head1 Copyright

mod_perl 2.0 and its core modules are copyrighted under
The Apache Software License, Version 2.0.




=head1 Authors

L<The mod_perl development team and numerous
contributors|about::contributors::people>.

=cut

