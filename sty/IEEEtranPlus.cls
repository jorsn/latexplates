\NeedsTeXFormat{LaTeX2e}
\ProvidesExplClass{IEEEtranPlus}{2024-05-02}{1.0.0}{IEEEtran with improved defaults and venue presets}

\RequirePackage{bootstrap}

\cs_new:Nn \ieeep_cinput:nnn { \exp_args:cc {#1 ExpandableDocumentCommand} {CLASSINPUT #2} {} {#3} }

\keys_define:nn { ieeep } {
, margins       .code:n = \ExecuteKeyOptions [ieeep / margins] { #1 },
, margins/top    .code:n = { \ieeep_cinput:nnn {Provide} {toptextmargin}    {#1} }
, margins/bottom .code:n = { \ieeep_cinput:nnn {Provide} {bottomtextmargin} {#1} }
, margins/inner  .code:n = { \ieeep_cinput:nnn {Provide} {innersidemargin}  {#1} }
, margins/outer  .code:n = { \ieeep_cinput:nnn {Provide} {outersidemargin}  {#1} }

, paper      .choice:
, paper/a4       .code:n = \ExecuteKeyOptions [ieeep] { #1 paper }
, paper/letter   .code:n = \ExecuteKeyOptions [ieeep] { #1 paper }

, columns    .choices:nn =
    { one, two }
    { \str_set:NV \ieeep_columns_str {\l_keys_choice_tl column} }
, columns     .initial:n = {two}
, onecolumn      .code:n = \ExecuteKeyOptions [ieeep] { columns / one }
, twocolumn      .code:n = \ExecuteKeyOptions [ieeep] { columns / two }

, compress   .bool_set:N = \ieeep_compress_bool
, compress    .default:n = true
, compress    .initial:n = false

% presets
, notecolumn     .code:n = \ExecuteKeyOptions [ieeep] { columns / one, margins = { top=3cm, bottom=3cm, inner=2cm, outer=6cm } }

, venue             .choice:
, venue/tit/onecolumn .code:n = \ExecuteKeyOptions [ieeep] { journal, notecolumn }
, venue/tit           .code:n = \ExecuteKeyOptions [ieeep] { journal }
, venue/isit2024      .code:n = \ExecuteKeyOptions [ieeep] { conference, paper=a4, margins = { top=0.5in, bottom=0.5in } }
, venue/globecom2024  .code:n = \ExecuteKeyOptions [ieeep] {
    conference, paper=letter,
    margins = { top=0.73in, bottom=0.97in, inner=0.585in, outer=0.59in }
    }
    %margins for a4: { top=1.84cm, bottom=4.28cm, inner=1.23cm, outer=1.28cm }
, venue/icc2025       .code:n = \ExecuteKeyOptions [ieeep] {
    conference, paper=letter,
    %margins = { top=0.73in, bottom=0.97in, inner=0.585in, outer=0.59in }
    }
    %margins for a4: { top=1.84cm, bottom=4.28cm, inner=1.23cm, outer=1.28cm }
% itw: submission untested
, venue/itw2024       .code:n = \ExecuteKeyOptions [ieeep] {
    conference, paper=letter,
    margins = {top=0.735in, bottom=1.02in},
  }

, conference .code:n = {
    \PassOptionsToClass{conference}{IEEEtran}
    % some IEEE conferences require fontsize >= 10pt
    \PassOptionsToPackage{cmex10}{amsmath}
  }


, unknown        .code:n = { \exp_args:NV \PassOptionsToClass \l_keys_key_str {IEEEtran} }
}

\ProcessKeyOptions[ ieeep ]

\PassOptionsToPackage \ieeep_columns_str {ifcol}
\PassOptionsToClass   \ieeep_columns_str {IEEEtran}


\RequirePackage{ifcol}

\iftwocol
  \bool_if:nTF \ieeep_compress_bool {
    \AddToHook {class/IEEEtran/after} {
      \setlength \floatsep         {0.4\baselineskip plus  0.2\baselineskip minus 0.2\baselineskip}
      \setlength \dblfloatsep      {0.4\baselineskip plus  0.2\baselineskip minus 0.2\baselineskip}
      \setlength \textfloatsep     {0.4\baselineskip plus  0.2\baselineskip minus 0.2\baselineskip}
      \setlength \dbltextfloatsep  \textfloatsep
      \setlength \abovecaptionskip {0.3\baselineskip plus  0.2\baselineskip minus 0.2\baselineskip}
      \setlength \belowcaptionskip \abovecaptionskip
    }
  } {}
\else
  \AddToHook {class/IEEEtran/after} {
    \cs_if_exist:NTF \CLASSINPUToutersidemargin {
      \marginparwidth = \dimexpr\CLASSINPUToutersidemargin - 1cm
    } {}
    \marginparpush = 1.5ex
  }
\fi

\LoadClass{IEEEtran}

% vim: ts=2 sw=2
