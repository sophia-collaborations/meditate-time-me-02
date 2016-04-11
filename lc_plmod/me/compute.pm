package me::compute;
use me::formulaic;
use strict;

sub valus {
  my $this;
  my $that;
  my $lc_last_endur;
  my $lc_new_endur;
  my $lc_remain_dct; # Time left of elapsation in calculating decay
  my $lc_did_decay;
  $this = $_[0];
  $that = $_[1];
  
  
  
  # CALCULATING THE NEW DURATION:
  
  # First, we calculate the new endurance *prior* to the
  # decay factor.
  $lc_last_endur = $this->{'last_d'};
  $lc_new_endur = int($lc_last_endur * $this->{'ampli'});
  if ( $lc_new_endur < ( $lc_last_endur + 0.5 ) )
  {
    $lc_new_endur = int($lc_last_endur + 1.2);
  }
  
  # Then we account for the decay factor.
  $lc_did_decay = 0;
  $lc_remain_dct = int(( $this->{'invoke_at'} - $this->{'last_w'} ) + 0.2);
  while ( $lc_remain_dct > $this->{'wait'} )
  {
    $lc_new_endur *= $this->{'dcy_f'};
    $lc_remain_dct = int(($lc_remain_dct - $this->{'dcy_r'}) + 0.2);
    $lc_did_decay = 10;
  }
  if ( $lc_did_decay ) { $lc_new_endur = int($lc_new_endur); }
  
  # Final calculations
  $lc_new_endur =
      &me::formulaic::firstof($that->{'endurance'},$lc_new_endur)
  ;
  if ( $lc_new_endur < 20 ) { $lc_new_endur = 20; }
  
  # And finally we save our new endurance.
  $this->{'endurance'} = $lc_new_endur;
  
  # How long do we wait *before* starting:
  $this->{'pre-wait'} = &me::formulaic::byseq($lc_new_endur,[
    [30,20],
    [60,30],
    [(int((2 * 60) + 0.2)), 40],
    [(int((3.5 * 60) + 0.2)), 50],
    [(int((5.5 * 60) + 0.2)), 60],
    [(int((8 * 60) + 0.2)), 70],
    [(int((11 * 60) + 0.2)), 80],
    [(int((15 * 60) + 0.2)), 90],
    [(int((20 * 60) + 0.2)), 100],
    [(int((26 * 60) + 0.2)), 110],
    [(int((34 * 60) + 0.2)), 120]
  ]);
}


1;
