use strict;
use warnings;
use Test::More;
use t::Utils;

setup;
cleanup('local/bin/hello', <./local/lib/*>, <./local/bin/*>);

mkdir './local/'     unless -d './local/';
mkdir './local/bin/' unless -d './local/bin/';
mkdir './local/lib/' unless -d './local/lib/';

is scalar(<./local/bin/*>), undef;
is scalar(<./local/lib/*>), undef;

{
    unshift @INC, '../../lib';
    require inc::Module::Install;
    inc::Module::Install->import();

    name('test');
    version(0.01);

    my $env = env_for_c(PREFIX => './local/');
    $env->install_bin($env->program('hello', 'hello.c'));
    $env->install_lib($env->shared_library('hello', 'hello.c'));

    WriteMakefileForC();
}
run_make('install');
run_make('clean');

isnt scalar(<./local/bin/*>), undef;
isnt scalar(<./local/lib/*>), undef;

done_testing;
