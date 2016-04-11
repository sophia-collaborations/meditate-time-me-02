package me::flio;
use strict;
use wraprg;

sub smpvar {
  my $lc_cm;
  my $lc_rt;
  my $lc_rsiz;
  my $lc_rnum;
  
  if ( !( -f $_[0] ) )
  {
    $lc_rsiz = @_;
    $lc_rnum = 1;
    while ( $lc_rnum < ( $lc_rsiz - 0.5 ) )
    {
      if ( defined($_[$lc_rnum]) )
      {
        return ($_[$lc_rnum]);
      }
      $lc_rnum = int($lc_rnum + 1.2);
    }
  }
  
  $lc_cm = "cat";
  &wraprg::lst($lc_cm,$_[0]);
  $lc_rt = `$lc_cm`;
  return $lc_rt;
}


1;
