
/*
 * *********** WARNING **************
 * This file generated by ModPerl::WrapXS/0.01
 * Any changes made here will be lost
 * ***********************************
 * 01: C:\xampp\perl\bin\.cpanplus\5.10.1\build\mod_perl-2.0.4\blib\lib/ModPerl/WrapXS.pm:699
 * 02: C:\xampp\perl\bin\.cpanplus\5.10.1\build\mod_perl-2.0.4\blib\lib/ModPerl/WrapXS.pm:1160
 * 03: C:\xampp\perl\bin\.cpanplus\5.10.1\build\mod_perl-2.0.4\Makefile.PL:423
 * 04: C:\xampp\perl\bin\.cpanplus\5.10.1\build\mod_perl-2.0.4\Makefile.PL:325
 * 05: C:\xampp\perl\bin\.cpanplus\5.10.1\build\mod_perl-2.0.4\Makefile.PL:56
 * 06: \xampp\perl\bin\cpanp-run-perl.bat:21
 */


#ifndef MODPERL_XS_TYPEDEFS_H
#define MODPERL_XS_TYPEDEFS_H

#include "apr_uuid.h"
#include "apr_sha1.h"
#include "apr_md5.h"
#include "apr_base64.h"
#include "apr_getopt.h"
#include "apr_hash.h"
#include "apr_lib.h"
#include "apr_general.h"
#include "apr_signal.h"
#include "apr_thread_rwlock.h"
#include "util_script.h"
typedef server_rec * Apache2__ServerRec;
typedef server_addr_rec * Apache2__ServerAddr;
typedef conn_rec * Apache2__Connection;
typedef request_rec * Apache2__RequestRec;
typedef subrequest_rec * Apache2__SubRequest;
typedef process_rec * Apache2__Process;
typedef ap_method_list_t * Apache2__MethodList;
typedef piped_log * Apache2__PipedLog;
typedef module * Apache2__Module;
typedef command_rec * Apache2__Command;
typedef cmd_parms * Apache2__CmdParms;
typedef ap_configfile_t * Apache2__ConfigFile;
typedef ap_directive_t * Apache2__Directive;
typedef ap_conf_vector_t * Apache2__ConfVector;
typedef ap_filter_t * Apache2__Filter;
typedef ap_filter_rec_t * Apache2__FilterRec;
typedef apr_pool_t * APR__Pool;
typedef apr_sockaddr_t * APR__SockAddr;
typedef apr_in_addr_t * APR__InAddr;
typedef apr_socket_t * APR__Socket;
typedef apr_ipsubnet_t * APR__IpSubnet;
typedef apr_bucket * APR__Bucket;
typedef apr_bucket_brigade * APR__Brigade;
typedef apr_bucket_alloc_t * APR__BucketAlloc;
typedef apr_bucket_type_t * APR__BucketType;
typedef apr_uri_t * APR__URI;
typedef apr_uuid_t * APR__UUID;
typedef apr_md5_ctx_t * APR__MD5;
typedef apr_sha1_ctx_t * APR__SHA1;
typedef apr_getopt_t * APR__Getopt;
typedef apr_getopt_option_t * APR__GetoptOption;
typedef apr_finfo_t * APR__Finfo;
typedef apr_proc_t * APR__Process;
typedef apr_time_exp_t * APR__ExplodedTime;
typedef apr_array_header_t * APR__ArrayHeader;
typedef apr_table_t * APR__Table;
typedef apr_hash_t * APR__Hash;
typedef apr_thread_mutex_t * APR__ThreadMutex;
typedef apr_thread_rwlock_t * APR__ThreadRWLock;
typedef apr_mmap_t * APR__Mmap;
typedef modperl_filter_t * Apache2__OutputFilter;

#endif /* MODPERL_XS_TYPEDEFS_H */
