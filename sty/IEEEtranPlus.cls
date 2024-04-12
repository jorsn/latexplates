\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{IEEEtranPlus}[2024-01-23 v0.0.0 IEEEtran with improved defaults]

\RequirePackage{etoolbox}
\newif\ifieeeplus@compress\ieeeplus@compressfalse

\DeclareOption{twocolumn}{
  \PassOptionsToClass{\CurrentOption}{ifcol}
}
\DeclareOption{onecolumn}{
  \PassOptionsToClass{\CurrentOption}{ifcol}
}

\DeclareOption{compress}{\ieeeplus@compresstrue}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{IEEEtran}}

\ExecuteOptions{twocolumn}
\ProcessOptions\relax

\RequirePackage{ifcol}

\iftwocol
  \PassOptionsToClass{twocolumn}{IEEEtran}
  \ifieeeplus@compress
    % >= 0.5 inches was required by ISIT 2024
    % (https://web.archive.org/web/20240412094337/https://2024.ieee-isit.org/information-autors)
    \providecommand{\CLASSINPUTtoptextmargin}{0.5in}
    \providecommand{\CLASSINPUTbottomtextmargin}{0.5in}
  \fi
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
