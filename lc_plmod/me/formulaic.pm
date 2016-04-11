package me::formulaic;
use strict;

sub firstof {
  my $lc_rsiz;
  my $lc_rnum;
  
  $lc_rsiz = @_;
  $lc_rnum = 0;
  while ( $lc_rnum < ( $lc_rsiz - 0.5 ) )
  {
    if ( defined($_[$lc_rnum]) )
    {
      return ($_[$lc_rnum]);
    }
    $lc_rnum = int($lc_rnum + 1.2);
  }
}

sub ofee {
  my $lc_a;
  $lc_a = @_;
  return $lc_a;
}

sub byseq {
  my $lc_src;
  my @lc_tbl;
  my $lc_rcnt;
  my $lc_newo;
  
  $lc_src = $_[0];
  { my $lc2_x; $lc2_x = $_[1]; @lc_tbl = @$lc2_x; }
  if ( &ofee(@lc_tbl) < 0.5 ) { return $lc_src; }
  
  # If the input is too small - return the minimum.
  $lc_rcnt = shift(@lc_tbl);
  if ( $lc_src < $lc_rcnt->[0] ) { return($lc_rcnt->[1]); }
  
  # Now - till the table is gone:
  while ( &ofee(@lc_tbl) > 0.5 )
  {
    $lc_newo = shift(@lc_tbl);
    if ( $lc_newo->[0] > ( $lc_rcnt->[0] + 0.5 ) )
    {
      # If the new is big enough to replace the old ...
      if ( $lc_src < $lc_newo->[0] )
      {
        my $lc3_prgrs;
        my $lc3_rtp;
        
        # Find the progress along this segment:
        $lc3_prgrs = ( ( $lc_src - $lc_rcnt->[0] ) / ( $lc_newo->[0] - $lc_rcnt->[0] ) );
        
        # Now let me do algebra in-comments:
        #$lc3_prgrs = ( ( $lc3_rtp - $lc_rcnt->[1] ) / ( $lc_newo->[1] - $lc_rcnt->[1] ) );
        #$lc3_prgrs = ( $lc3_rtp - $lc_rcnt->[1] ) / ( $lc_newo->[1] - $lc_rcnt->[1] );
        #$lc3_prgrs * ( $lc_newo->[1] - $lc_rcnt->[1] ) = ( $lc3_rtp - $lc_rcnt->[1] );
        #( $lc3_prgrs * ( $lc_newo->[1] - $lc_rcnt->[1] ) ) = $lc3_rtp - $lc_rcnt->[1];
        #$lc3_rtp - $lc_rcnt->[1] = ( $lc3_prgrs * ( $lc_newo->[1] - $lc_rcnt->[1] ) );
        $lc3_rtp = ( $lc3_prgrs * ( $lc_newo->[1] - $lc_rcnt->[1] ) ) + $lc_rcnt->[1];
        return(int($lc3_rtp + 0.5));
      }
      
      $lc_rcnt = $lc_newo;
    }
  }
  return($lc_rcnt->[1]);
  
  # If we have gotten this far - return the maximum.
}


1;
