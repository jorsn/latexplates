\NeedsTeXFormat{LaTeX2e}

\ProvidesClass{responseletter}[2023/01/22 response letter class]

\PassOptionsToClass
  { a4paper
  , headings=standardclasses
  , headings=small
  , final
  }
  {scrartcl}
\LoadClass{scrartcl}

\RequirePackage{tabularx,array}

\RequirePackage{pifont}

\RequirePackage{scrlayer-scrpage}
\RequirePackage{scrlayer-notecolumn}


% general styling

\frenchspacing
\addtokomafont{descriptionlabel}{\rmfamily}

\parindent=0pt
\parskip=.7em

% sections (only \review)

\renewcommand{\sectionlinesformat}[4]{%
\Ifstr{#1}{section}{%
    \parbox[t]{\linewidth}{%
      \raggedsection\@hangfrom{\hskip #2#3}{#4}\par%
      \kern-.75\ht\strutbox\rule{\linewidth}{.8pt}%
    }%
  }{%
    \@hangfrom{\hskip #2#3}{#4}}% 
}

\newcounter{review}
\newcounter{comment}[review]

\newcommand{\review}[1][]{
  \refstepcounter{review}
  \section*{Reviewer~\thereview #1}
  \expandafter\label{rev:\thereview}
}


% comments

\AtBeginDocument{
  \newlength{\markparwidth}
  \settowidth{\markparwidth}{\normalfont\textsc{comment}}
  \newlength{\markcolwidth}
  \setlength{\markcolwidth}{\markparwidth+\marginparsep}
}

\DeclareNewNoteColumn[%
  %position=\evensidemargin+\marginparwidth+\marginparsep,
  reversemarginpar,
  %width=\markparwidth,
  font=\raggedleft,%\scshape,
]{marks}

%\usepackage{csquotes}
%\DeclareQuoteStyle{english}
%        {\itshape\textquotedblleft}
%        [\textquotedblleft]
%        {\textquotedblright}
%        [0.05em]
%        {\textquoteleft}
%        {\textquoteright}

\NewDocumentEnvironment{@comm}{O{} +b}{
% I am not sure why this works while \newenvironment doesn't.
% Probably this the “nesting” of environments referred to by the xparse manual.
  \begin{addmargin}{2em}
    #1\small\ignorespaces
    #2
  \end{addmargin}
}{}

\newenvironment{comm}{
  \begin{@comm}[%
      \refstepcounter{comment}
      \leavevmode
      \makenote[marks]{\ding{161}\oldstylenums{\thereview.\thecomment}}%
    ]
}{\end{@comm}}
\newenvironment{comm*}{\begin{@comm}}{\end{@comm}}

% responses. ans environment is currently identity (no changes)
\newenvironment{ans}{
  %\begin{addmargin}[0em]{0em}
    %\leavevmode%
    %\makenote[marks]{answer}%
    %\ignorespaces%
}{}%\end{addmargin}}

% The naming comm/ans is inherited by a collegue. May not be the best.


\newcommand{\metatable}[1]{\newcommand{\@metatable}{#1}}

\renewcommand{\maketitle}{
  {\Large\textbf{Response Letter} \hfill \@date}
  
  {
    \small
    \begin{tabularx}{\textwidth}{@{}>{\bfseries}l X@{}}
      \@metatable
    \end{tabularx}
  }

  \vspace{2em}
}

% vim: ts=2 sw=2
