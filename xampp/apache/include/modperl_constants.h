#ifndef MODPERL_CONSTANTS_H
#define MODPERL_CONSTANTS_H

/*
 * *********** WARNING **************
 * This file generated by ModPerl::Code/0.01
 * Any changes made here will be lost
 * ***********************************
 * 01: lib/ModPerl/Code.pm:733
 * 02: lib/ModPerl/Code.pm:759
 * 03: C:\xampp\perl\bin\.cpanplus\5.10.1\build\mod_perl-2.0.4\Makefile.PL:383
 * 04: C:\xampp\perl\bin\.cpanplus\5.10.1\build\mod_perl-2.0.4\Makefile.PL:96
 * 05: \xampp\perl\bin\cpanp-run-perl.bat:21
 */

#define MP_ENOCONST -3

SV *modperl_constants_lookup_apache2_const(pTHX_ const char *name);
SV *modperl_constants_lookup_apr_const(pTHX_ const char *name);
SV *modperl_constants_lookup_modperl(pTHX_ const char *name);
const char **modperl_constants_group_lookup_apache2_const(const char *name);
const char **modperl_constants_group_lookup_apr_const(const char *name);
const char **modperl_constants_group_lookup_modperl(const char *name);

#endif /* MODPERL_CONSTANTS_H */