\NeedsTeXFormat{LaTeX2e}
\ProvidesExplClass{IEEEtranPlus}{2024-01-23}{0.1}{IEEEtran with improved defaults and venue presets}

\cs_new:Nn \ieeep_cinput:nnn { \exp_args:cc {#1 ExpandableDocumentCommand} {CLASSINPUT #2} {} {#3} }

\keys_define:nn { ieeep } {
, margins        .meta:n = { margins / #1 },
, margins/top    .code:n = { \ieeep_cinput:nnn {Provide} {toptextmargin}    {#1} }
, margins/bottom .code:n = { \ieeep_cinput:nnn {Provide} {bottomtextmargin} {#1} }
, margins/inner  .code:n = { \ieeep_cinput:nnn {Provide} {innersidemargin}  {#1} }
, margins/outer  .code:n = { \ieeep_cinput:nnn {Provide} {outersidemargin}  {#1} }

, paper      .choice:
, paper/a4       .meta:n = { #1 paper }
, paper/letter   .meta:n = { #1 paper }

, columns    .choices:nn =
    { one, two }
    { \str_set:NV \ieeep_columns_str {\l_keys_choice_tl column} }
, columns     .initial:n = {two}
, onecolumn      .meta:n = { columns / one }
, twocolumn      .meta:n = { columns / two }

, compress   .bool_set:N = \ieeep_compress_bool
, compress    .default:n = true
, compress    .initial:n = false

% presets
, notecolumn     .meta:n = { columns / one, margins = {top=3cm, bottom=3cm, inner=2cm, outer=6cm} }

, venue             .choice:
, venue/tit/onecolumn .meta:n = { journal, notecolumn }
, venue/tit           .meta:n = { journal }
, venue/isit2024      .meta:n = { conference, paper=a4, margins = { top=0.5in, bottom=0.5in } }
, venue/globecom2024  .meta:n = {
    conference, paper=letter,
    margins/inner=0.57in, margins/outer=0.59in
    %margins for a4: { top=1.84cm, bottom=4.28cm, inner=1.23cm, outer=1.28cm }
  }
% itw: untested
, venue/itw2024       .meta:n = { conference, paper=letter, margins = { top = 0.5in, bottom = 0.5in } }

, unknown        .code:n = { \exp_args:NV \PassOptionsToClass \l_keys_key_str {IEEEtran} }
}

\ProcessKeysOptions{ ieeep }

\PassOptionsToPackage \ieeep_columns_str {ifcol}
\PassOptionsToClass   \ieeep_columns_str {IEEEtran}


\RequirePackage{ifcol}

\iftwocol
  \bool_if:nTF \ieeep_compress_bool {
    \AddToHook {class/IEEEtran/after} {
      \setlength \textfloatsep    {0.7\baselineskip plus  0.1\baselineskip minus 0.4\baselineskip}
      \setlength \dbltextfloatsep {0.7\baselineskip plus  0.1\baselineskip minus 0.4\baselineskip}
    }
  } {}
\else
  \ieeep_cinput:nn {Provide} {toptextmargin}    {3cm}
  \ieeep_cinput:nn {Provide} {bottomtextmargin} {3cm}
  \ieeep_cinput:nn {Provide} {innersidemargin}  {2cm}
  \ieeep_cinput:nn {Provide} {outersidemargin}  {6cm}

  \AddToHook {class/IEEEtran/after} {
    \cs_if_exist:NTF \CLASSINPUToutersidemargin {
      \marginparwidth = \dimexpr\CLASSINPUToutersidemargin - 1cm
    } {}
    \marginparpush = 1.5ex
  }
\fi

\LoadClass{IEEEtran}

% vim: ts=2 sw=2
