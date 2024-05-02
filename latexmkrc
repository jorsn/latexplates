$out_dir = 'build/'; # use separate output directory
$pdf_mode = 1;       # use LuaLaTeX (1: pdfLaTeX, 4: LuaLaTeX, 5: XeLaTeX)
$synctex = 1;
@default_files = ('paper');
ensure_path( 'TTFONTS',       'fonts//');
ensure_path( 'OPENTYPEFONTS', 'fonts//');

$lualatex_files = qr/.*(poster|responseletter).*\.tex/;

$pdflatex_orig = $pdflatex;

if ($synctex) {
  $synctex_str = '-synctex=' . $synctex;
} else {
  $synctex_str = ''
}

$pdflatex = 'internal compile ' . $synctex_str . ' -shell-escape %O %S';

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
