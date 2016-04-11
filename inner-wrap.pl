use strict;
use argola;
use chobaktime;
use me::formulaic;
use me::flio;
use me::compute;

my $resdir_set = 0;
my $resdir_loc;

my $resinf;

my $modif = { };


sub opto_do__resd__y {
  $resdir_loc = &argola::getrg();
  $resdir_set = 10;
} &argola::setopt('-resd',\&opto_do__resd__y);


&argola::help_opt('--help','help-file.nroff');

&argola::runopts();

if ( $resdir_set < 5 )
{
  die "\nFATAL ERROR:\n" .
    "  Please use the -resd option to specify a resource directory.\n" .
  "\n";
}

if ( !( -d $resdir_loc ) )
{
  die "\nFATAL ERROR: Resource directory non-existent (or not a directory):\n" .
    "  " . $resdir_loc . ":\n" .
  "\n";
}

{
  my $lc_ls_h;
  my $lc_now;
  my @lc_ls_r;
  
  $lc_now = &chobaktime::nowo();
  
  $lc_ls_h = &me::flio::smpvar(($resdir_loc . '/last-stamp.txt'),('xx:20:' . $lc_now . ':fiat:xxx'));
  @lc_ls_r = split(/:/,$lc_ls_h);
  
  $resinf = {
    
    # 'ampli' is actually applied by sheer multiplication
    'ampli' => &me::flio::smpvar(($resdir_loc . '/amli-seq.txt'), $modif->{'ampli'}, 1.01),
    
    # This says how many seconds to wait before decay starts kicking in. The default
    # is 24 hours.
    'wait' => &me::flio::smpvar(($resdir_loc . '/before-decay.txt'), $modif->{'wait'},
    int(0.2 + (60 * 60 * 24)) ),
    
    # 'dcy_f' is also applied by sheer multiplication
    'dcy_f' => &me::flio::smpvar(($resdir_loc . '/decay_factor.txt'), $modif->{'dcy_f'}, .999),
    
    'dcy_r' => &me::flio::smpvar(($resdir_loc . '/decay_rate.txt'), $modif->{'dcy_r'},
    int(0.2 + (60 * 60)) ),
    
    # 'nparts' is the number of segments that meditation is divided into.
    'nparts' => &me::flio::smpvar(($resdir_loc . '/num_of_parts.txt'), $modif->{'nparts'}, 3),
    
    'last_d' => $lc_ls_r[1],
    'last_w' => $lc_ls_r[2],
    'invoke_at' => $lc_now,
    
  };
}


&me::compute::valus($resinf,$modif);

system("echo","Now for: " . $resinf->{'endurance'});






