$out_dir = 'build/'; # use separate output directory
$pdf_mode = 1;       # use LuaLaTeX (1: pdfLaTeX, 4: LuaLaTeX, 5: XeLaTeX)
@default_files = ('paper');
ensure_path( 'TTFONTS',       'fonts//');
ensure_path( 'OPENTYPEFONTS', 'fonts//');
