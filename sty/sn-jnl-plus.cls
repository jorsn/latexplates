\NeedsTeXFormat{LaTeX2e}
\RequirePackage{bootstrap}
\ProvidesExplPackage{sn-jnl-plus}{2024-01-23}{0.1}{fixable version of class sn-jnl}

\keys_define:nn { sn-jnl-plus } {
  suppressedPkgs .clist_set:N =  \snJnlSetup_suppressedPkgs,
  suppressedPkgs .initial:n   =  {
    program % program is loaded by sn-jnl.cls and sets catcodes incompatible with pgf
    ,algorithm
    ,algorithmicx
    ,algpseudocode
    ,listings
  },
  branded .bool_set:N = \snJnlSetup_branded,
  branded .initial:n = true,
}

\ProcessKeysOptions{ sn-jnl-plus }

%%%%%%%%%%%%%%%
% suppress pkgs

\clist_map_inline:Nn \snJnlSetup_suppressedPkgs { \suppresspackage{#1} }

% boilerplate would load cite, but sn-jnl uses the incompatible natbib
\AddToHook{package/boilerplate/before}{ \suppresspackage{cite} }
\AddToHook{package/boilerplate/after}{ \unsuppresspackage{cite} }


%%%%%%%%%%%%
% load class

\LoadClass{sn-jnl}

%%%%%%%%%%%%%%%%%
% unsuppress pkgs

\clist_map_inline:Nn \snJnlSetup_suppressedPkgs { \unsuppresspackage{#1} }


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% fix acknowledgement and abstract to abide to QINP rules

\def\@acknow{}
\long\def\EarlyAcknow#1 \par{
\def\@acknow{\abstractfont\abstracthead*{Acknowledgment}
#1\par}}

\def\printabstract{\ifx\@acknow\empty\else\@acknow\fi\par%
    \ifx\@abstract\empty\else\@abstract\fi\par}


\ExplSyntaxOff
  %% Article Header Definition
  %  based on documentclass but added before/after hooks 
  \renewcommand{\@maketitle}{\newpage\null%
      %\if@remarkboxon\vbox to 0pt{\vspace*{-78pt}\hspace*{-18pt}\FMremark}\else\vskip21pt\fi%%\par%
      \UseHook{cmd/@maketitle/before}%
      \hsize\textwidth\parindent0pt%%%\vskip7pt%
      %% Aritle Type
      {\hbox to \textwidth{{\Artcatfont\ArtType\hfill}\par}}
      %% Aritle Title
      \ifx\@title\empty\else%
          \removelastskip\vskip20pt\nointerlineskip%
          {\Titlefont\@title\par}
          %\addcontentsline{toc}{chapter}{\@title}% for bookmarks
      \fi%
      %% Aritle SubTitle
      \ifx\@subtitle\empty\else%
          \vskip9pt%
          {{\SubTitlefont\@subtitle\par}}
      \fi%
      %% Aritle Authors, Address and Correspondings
      \ifnum\aucount>0
          \global\punctcount\aucount%
          \vskip15pt%
          \artauthors\par%%     authors and emails
          {\vskip7pt\addressfont\auaddress\par%%      corresponding adress
  	 \removelastskip\vskip15pt%
  	\ifnum\emailcnt>0\relax%
             \ifx\corrauthemail\@empty\else{\ifnum\aucount>1*\fi}%
  	   Corresponding author(s). E-mail(s): \corrauthemail\par\fi%
  	   \ifx\authemail\@empty\else Contributing authors:\ \authemail\fi%
          \fi%
          \ifequalcont{\par$^{\dagger}$\@equalconttext\par}\fi%
  	 \removelastskip\vskip24pt%
          \ifpresentaddress{\par\@presentaddresstext\par}\fi%
  	}
       \fi%
       {\printabstract\par}%
       {\printkeywords\par}%
       \ifx\@pacs\empty\else%
         \loop\ifnum\PacsCount>0%
            \csname\romannumeral\PacsTmpCnt StorePacsTxt\endcsname\par%
            \StepDownCounter{\PacsCount}%
            \StepUpCounter{\PacsTmpCnt}%
         \repeat%
      \fi%
      %%{\printhistory\par}%
      %%{\ifx\@motto\empty\else\@motto\fi}%
      \removelastskip\vskip36pt\vskip0pt%
      \UseHook{cmd/@maketitle/after}%
      }%
\ExplSyntaxOn


%%%%%%%%%
% unbrand

\def\ps@titlepageUnbranded{
  \def\@oddhead{}
  \let\@evenhead\@oddhead
  \def\@oddfoot{\vbox to 18pt{\vfill\reset@font\rmfamily\hfil\thepage\hfil}}
  \def\@evenfoot{}
}
\def\ps@unbranded{
  \def\@oddfoot{}
  \let\@evenfoot\@oddfoot
  \def\@evenhead{\hbox to \hsize{\headerfont\thepage\qquad\rightmark\hfill}}
  \def\@oddhead{\hbox to \hsize{\headerfont\hfill\leftmark\qquad\thepage}}
  \let\@mkboth\markboth
}
\bool_if:NTF \snJnlSetup_branded {} {
  \let\ps@titlepage\ps@titlepageUnbranded
  \def\@afterheading{\pagestyle{unbranded}}
}

% vim: ts=2 sw=2
