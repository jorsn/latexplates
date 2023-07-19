$out_dir = 'build/'; # use separate output directory
$pdf_mode = 1;       # use LuaLaTeX (1: pdfLaTeX, 4: LuaLaTeX, 5: XeLaTeX)
@default_files = ('paper');
ensure_path( 'TTFONTS',       'fonts//');
ensure_path( 'OPENTYPEFONTS', 'fonts//');

$lualatex_files = qr/.*poster.*\.tex/;

$pdflatex_orig = $pdflatex;
$pdflatex = 'internal compile %O %S';

sub compile {

  if ($$Psource =~ $lualatex_files) {
    $pdf_mode = 4;
    $cmd = "lualatex";
  } elsif ($$Psource =~ $xelatex_files) {
    $pdf_mode = 5;
    $cmd = "xelatex";
  } else {
    $pdf_mode = 1;
    $cmd = "pdflatex";
  }

  
  return system $cmd, @_;
  #return Run_subst( $cmd );
}
