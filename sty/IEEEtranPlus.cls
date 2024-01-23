\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{IEEEtranPlus}[2024-01-23 v0.0.0 IEEEtran with improved defaults]

\RequirePackage{etoolbox}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{IEEEtran}}
\ProcessOptions\relax

\RequirePackage{ifcol}

\ifonecol
  \providecommand{\CLASSINPUTtoptextmargin}{3cm}
  \providecommand{\CLASSINPUTbottomtextmargin}{3cm}
  \providecommand{\CLASSINPUTinnersidemargin}{2cm}
  \providecommand{\CLASSINPUToutersidemargin}{6cm}

  \AtBeginDocument{
    \ifcsname CLASSINPUToutersidemargin\endcsname
      \marginparwidth = \dimexpr\CLASSINPUToutersidemargin - 1cm
    \fi
    \marginparpush = 1.5ex
  }
\fi

\LoadClass{IEEEtran}
