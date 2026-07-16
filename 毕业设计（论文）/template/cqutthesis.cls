\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cqutthesis}[2026/07/16 CQUT undergraduate thesis template]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ctexbook}}
\ProcessOptions\relax
\LoadClass[a4paper,UTF8,zihao=-4,fontset=none,openany,oneside]{ctexbook}

\RequirePackage{fontspec}
\RequirePackage{xeCJK}
\RequirePackage[a4paper,left=25mm,right=20mm,top=25mm,bottom=25mm,headheight=7mm,headsep=5mm,footskip=10mm]{geometry}
\RequirePackage{graphicx}
\RequirePackage{tikz}
\RequirePackage{tikzpagenodes}
\RequirePackage{eso-pic}
\RequirePackage{pdfpages}
\RequirePackage{fancyhdr}
\RequirePackage{titlesec}
\RequirePackage{titletoc}
\RequirePackage{setspace}
\RequirePackage{indentfirst}
\RequirePackage{amsmath}
\RequirePackage{mathspec}
\RequirePackage{booktabs}
\RequirePackage{caption}
\RequirePackage{chngcntr}
\RequirePackage{enumitem}
\RequirePackage[absolute,overlay]{textpos}
\RequirePackage{hyperref}

\setCJKmainfont[BoldFont={Songti SC Bold}]{Songti SC}
\setCJKsansfont[BoldFont={Heiti SC}]{Heiti SC}
\setCJKmonofont{Songti SC}
\newCJKfontfamily\cqutheiti{Hiragino Sans GB W6}
\newCJKfontfamily\cqutsongti[BoldFont={Songti SC Bold}]{Songti SC}
\newCJKfontfamily\cqutfangsong{STFangsong}
\setmainfont{Times New Roman}
\setmathsfont(Digits,Latin){Times New Roman}

\hypersetup{hidelinks,unicode=true,hypertexnames=false}
\setlength{\parindent}{2em}
\setlength{\parskip}{0pt}
\setstretch{1.5}
\emergencystretch=2em
\setcounter{secnumdepth}{3}
\setcounter{tocdepth}{3}
\ctexset{chapter={name={,},number=\arabic{chapter}}}

\makeatletter
\newif\ifcqutwatermark
\cqutwatermarkfalse
\newcommand{\enablewatermark}{\cqutwatermarktrue}
\newcommand{\disablewatermark}{\cqutwatermarkfalse}

% Cover metadata.
\def\cqut@university{重庆理工大学}
\def\cqut@title{论文题目}
\def\cqut@college{学院全称}
\def\cqut@major{专业全称}
\def\cqut@class{班级全称}
\def\cqut@author{学生姓名}
\def\cqut@studentid{学号}
\def\cqut@advisor{指导教师}
\def\cqut@advisortitle{职称}
\def\cqut@date{20XX 年 XX 月}
\newcommand{\university}[1]{\def\cqut@university{#1}}
\newcommand{\thesistitle}[1]{\def\cqut@title{#1}}
\newcommand{\college}[1]{\def\cqut@college{#1}}
\newcommand{\major}[1]{\def\cqut@major{#1}}
\newcommand{\classinfo}[1]{\def\cqut@class{#1}}
\newcommand{\authorname}[1]{\def\cqut@author{#1}}
\newcommand{\studentid}[1]{\def\cqut@studentid{#1}}
\newcommand{\advisor}[1]{\def\cqut@advisor{#1}}
\newcommand{\advisortitle}[1]{\def\cqut@advisortitle{#1}}
\newcommand{\thesisdate}[1]{\def\cqut@date{#1}}

\AddToShipoutPictureBG{%
  \begin{tikzpicture}[remember picture,overlay]
    \ifcqutwatermark
      \foreach \cqut@watermarky in {55mm,148mm,241mm}{%
        \foreach \cqut@watermarkx in {38mm,105mm,172mm}{%
          \node[rotate=35] at
            ([xshift=\cqut@watermarkx,yshift=\cqut@watermarky]current page.south west)
            {\includegraphics[width=72mm]{assets/watermark-logo.png}};%
        }%
      }%
    \fi
  \end{tikzpicture}%
}

\setlength{\TPHorizModule}{1bp}
\setlength{\TPVertModule}{1bp}
\TPMargin{0pt}
\newcommand{\cqut@coverline}[3]{%
  \begin{textblock*}{#3bp}(#1bp,\dimexpr#2bp-0.4bp\relax)\rule{#3bp}{0.72bp}\end{textblock*}}
\newcommand{\cqut@coverlabel}[4]{%
  \begin{textblock*}{#3bp}(#1bp,#2bp)\cqutfangsong\fontsize{15.95bp}{19bp}\selectfont #4\end{textblock*}}
\newcommand{\cqut@covervalue}[4]{%
  \begin{textblock*}{#3bp}(#1bp,#2bp)\centering\cqutfangsong\fontsize{15.95bp}{19bp}\selectfont #4\end{textblock*}}
\newcommand{\makecover}{%
  \begingroup
  \setlength{\parindent}{0pt}
  \thispagestyle{empty}
  \begin{textblock*}{314.3bp}(120.6bp,91.6bp)%
    \includegraphics[width=314.3bp,trim=0 0 597 0,clip]{assets/cqut-logo-horizontal.png}%
  \end{textblock*}
  \begin{textblock*}{288bp}(148.7bp,195.1bp)\centering\cqutheiti\fontsize{36bp}{43bp}\selectfont{}毕业设计（论文）\end{textblock*}

  \begin{textblock*}{44bp}(96bp,307.9bp)\cqutsongti\fontsize{21.95bp}{26bp}\selectfont 题目\end{textblock*}
  \begin{textblock*}{341.1bp}(140bp,305.7bp)\centering\cqutheiti\fontsize{21.95bp}{28bp}\selectfont \cqut@title\end{textblock*}
  \cqut@coverline{140}{332}{341.1}
  \cqut@coverline{137}{390.4}{338.1}

  \cqut@coverlabel{165}{436.2}{64}{学\hspace{2em}院}
  \cqut@covervalue{229.1}{436.2}{207.9}{\cqut@college}
  \cqut@coverline{229.1}{451.3}{207.9}
  \cqut@coverlabel{165}{479.9}{64}{专\hspace{2em}业}
  \cqut@covervalue{229.1}{479.9}{207.9}{\cqut@major}
  \cqut@coverline{229.1}{495}{207.9}
  \cqut@coverlabel{165}{523.6}{64}{班\hspace{2em}级}
  \cqut@covervalue{229.1}{523.6}{207.9}{\cqut@class}
  \cqut@coverline{229.1}{538.7}{207.9}

  \cqut@coverlabel{165}{567.3}{64}{学生姓名}
  \cqut@covervalue{229.1}{567.3}{87.9}{\cqut@author}
  \cqut@coverline{229.1}{582.4}{87.9}
  \cqut@coverlabel{317}{567.3}{32}{学号}
  \cqut@covervalue{349.1}{567.3}{87.9}{\cqut@studentid}
  \cqut@coverline{349.1}{582.4}{87.9}

  \cqut@coverlabel{165}{611}{64}{指导教师}
  \cqut@covervalue{229.1}{611}{96}{\cqut@advisor}
  \cqut@coverline{229.1}{626}{96}
  \cqut@coverlabel{325.1}{611}{31.9}{职称}
  \cqut@covervalue{357}{611}{80}{\cqut@advisortitle}
  \cqut@coverline{357}{626}{80}

  \cqut@coverlabel{165}{654.7}{64}{时\hspace{2em}间}
  \cqut@covervalue{229.1}{654.7}{219.9}{\cqut@date}
  \cqut@coverline{229.1}{669.6}{219.9}
  \null
  \endgroup
  \clearpage
}

% Insert the university commitment form as an unnumbered A4 second page.
\newcommand{\makecommitment}{%
  \includepdf[
    pages=1,
    fitpaper=false,
    pagecommand={\thispagestyle{empty}}
  ]{assets/cqut-integrity-commitment.pdf}%
}

% Page furniture used by contents, abstract, body, acknowledgement and references.
\newcommand{\cqut@headerleft}{\raisebox{-0.5pt}[0pt][0pt]{\cqutsongti\zihao{-5}\cqut@university 毕业设计（论文）}}
\newcommand{\cqut@headerright}{\raisebox{-0.5pt}[0pt][0pt]{\cqutsongti\zihao{-5}\cqut@title}}
\fancypagestyle{cqut}{%
  \fancyhf{}
  \fancyhead[L]{\cqut@headerleft}
  \fancyhead[R]{\cqut@headerright}
  \renewcommand{\headrulewidth}{0.4pt}
  \fancyfoot[C]{\zihao{-5}\thepage}
}
\fancypagestyle{plain}{\fancyhf{}\fancyhead[L]{\cqut@headerleft}\fancyhead[R]{\cqut@headerright}\renewcommand{\headrulewidth}{0.4pt}\fancyfoot[C]{\zihao{-5}\thepage}}

% Heading hierarchy follows the supplied school sample.
\titleformat{\chapter}[block]{\centering\cqutheiti\zihao{3}}{第\thechapter 章\quad}{0pt}{}
\titlespacing*{\chapter}{0pt}{-19pt}{0pt}
\titleformat{name=\chapter,numberless}[block]{\centering\cqutheiti\zihao{3}}{}{0pt}{}
\titlespacing*{name=\chapter,numberless}{0pt}{-19pt}{25pt}
\titleformat{\section}{\cqutheiti\zihao{-3}}{\thesection\quad}{0pt}{}
\titlespacing*{\section}{0pt}{16pt}{8pt}
\titleformat{\subsection}{\cqutheiti\zihao{4}}{\thesubsection\quad}{0pt}{}
\titlespacing*{\subsection}{0pt}{12pt}{6pt}
\titleformat{\subsubsection}{\cqutheiti\zihao{-4}}{\thesubsubsection\quad}{0pt}{}

% Formula, table and figure numbering follows the chapter-based school rules.
\counterwithin{equation}{chapter}
\counterwithin{table}{chapter}
\counterwithin{figure}{chapter}
\renewcommand{\theequation}{\thechapter.\arabic{equation}}
\renewcommand{\thetable}{\thechapter-\arabic{table}}
\renewcommand{\thefigure}{\thechapter.\arabic{figure}}
\DeclareCaptionFont{cqutcaption}{\cqutsongti\zihao{5}}
\DeclareCaptionLabelFormat{cqutlabel}{#1#2}
\captionsetup{font=cqutcaption,labelformat=cqutlabel,labelsep=space}

% The two list levels correspond to “1、” and “（1）”.
\newlist{cqutitems}{enumerate}{2}
\setlist[cqutitems,1]{label=\arabic*、,leftmargin=2em,itemindent=0pt}
\setlist[cqutitems,2]{label=（\arabic*）,leftmargin=2em,itemindent=0pt}

\renewcommand{\contentsname}{目\quad 录}
\titlecontents{chapter}[1em]{\cqutheiti\zihao{-4}}{\contentslabel{1em}}{}{\titlerule*[0.7pc]{.}\contentspage}
\titlecontents{section}[2.75em]{\cqutsongti\zihao{-4}}{\contentslabel{1.75em}}{}{\titlerule*[0.7pc]{.}\contentspage}
\titlecontents{subsection}[4.6em]{\cqutsongti\zihao{-4}}{\contentslabel{2.6em}}{}{\titlerule*[0.7pc]{.}\contentspage}

\newif\ifcqut@romanstarted
\cqut@romanstartedfalse
\newcommand{\frontmatterstart}{\clearpage\pagestyle{cqut}\pagenumbering{Roman}\cqut@romanstartedtrue}
\newcommand{\cqut@displaytitle}[1]{%
  \vspace*{-11pt}%
  \noindent\makebox[\textwidth][c]{\cqutheiti\zihao{3}#1}\par
  \vspace{\baselineskip}}
\renewcommand{\tableofcontents}{%
  \thispagestyle{cqut}
  \cqut@displaytitle{目\quad 录}
  \@starttoc{toc}}
\newcommand{\makeabstract}[2]{%
  \clearpage
  \ifcqut@romanstarted\else\pagenumbering{Roman}\cqut@romanstartedtrue\fi
  \addcontentsline{toc}{chapter}{\texorpdfstring{摘\quad 要}{摘要}}
  \thispagestyle{cqut}
  \cqut@displaytitle{摘\quad 要}
  \cqutsongti\zihao{-4}#1\par\vspace{\baselineskip}
  {\bfseries 关键词：}#2
}
\newcommand{\makeenglishabstract}[2]{%
  \clearpage\thispagestyle{cqut}
  \addcontentsline{toc}{chapter}{Abstract}
  \vspace*{-11pt}\noindent\makebox[\textwidth][c]{\fontspec{Times New Roman}\zihao{3}Abstract}\par\vspace{\baselineskip}
  \begingroup\fontspec{Times New Roman}\zihao{-4}#1\par\vspace{\baselineskip}\textbf{Key words: }#2\endgroup
}
\newcommand{\mainmatterstart}{\clearpage\pagenumbering{arabic}\pagestyle{cqut}}
\newcommand{\acknowledgements}{\clearpage\chapter*{致\quad 谢}\addcontentsline{toc}{chapter}{致谢}}
\newcommand{\references}{\clearpage\addcontentsline{toc}{chapter}{参考文献}}
\newcounter{cqutappendix}
\newcommand{\appendixchapter}[1]{%
  \clearpage
  \refstepcounter{cqutappendix}
  \chapter*{\texorpdfstring{附录\arabic{cqutappendix}\quad #1}{附录\arabic{cqutappendix} #1}}
  \addcontentsline{toc}{chapter}{\texorpdfstring{附录\arabic{cqutappendix}\quad #1}{附录\arabic{cqutappendix} #1}}}
\let\cqut@originalthebibliography\thebibliography
\renewcommand{\thebibliography}[1]{%
  \cqut@originalthebibliography{#1}%
  \setlength{\itemsep}{0pt}%
  \setlength{\parsep}{0pt}%
  \setlength{\itemindent}{-6pt}}

% Numeric citations are rendered as superscripts in square brackets.
\renewcommand{\@cite}[2]{\textsuperscript{[#1\if@tempswa , #2\fi]}}
\makeatother

\endinput
