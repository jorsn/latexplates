\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{IEEEtranPlus}[2024-01-23 v0.0.0 IEEEtran with improved defaults]

\RequirePackage{etoolbox}

\DeclareOption{twocolumn}{
  \PassOptionsToClass{\CurrentOption}{ifcol}
}
\DeclareOption{onecolumn}{
  \PassOptionsToClass{\CurrentOption}{ifcol}
}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{IEEEtran}}

\ExecuteOptions{twocolumn}
\ProcessOptions\relax

\RequirePackage{ifcol}

\iftwocol
  \PassOptionsToClass{twocolumn}{IEEEtran}
\else
  \PassOptionsToClass{onecolumn}{IEEEtran}
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
