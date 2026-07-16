\NeedsTeXFormat{LaTeX2e}
\makeatletter
\ProvidesClass{\@currpath\@currname}[2026/07/16 CQUT exam paper]
\makeatother

\newif\ifshowanswers
\showanswersfalse
\newif\ifcqutwatermark
\cqutwatermarkfalse
\DeclareOption{answers}{\showanswerstrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ctexart}}
\ProcessOptions\relax

\LoadClass[a4paper,UTF8,zihao=-4,fontset=none]{ctexart}
\RequirePackage{fontspec}
\RequirePackage{xeCJK}
\setCJKmainfont[BoldFont={Songti SC Bold}]{Songti SC}
\setCJKsansfont[BoldFont={Songti SC Bold}]{Songti SC}
\setmainfont{Times New Roman}
\setsansfont{Arial}

\RequirePackage[a4paper,
  left=27mm,right=27mm,
  top=56.7mm,bottom=27.5mm,
  headheight=38.1mm,headsep=2.4mm,
  footskip=8mm]{geometry}
\RequirePackage{amsmath,amssymb}
\RequirePackage{unicode-math}
\setmathfont{STIX Two Math}
\RequirePackage{fancyhdr}
\RequirePackage{lastpage}
\RequirePackage{graphicx}
\RequirePackage{tikz}
\RequirePackage{tikzpagenodes}
\RequirePackage{eso-pic}
\RequirePackage{enumitem}
\RequirePackage{diagbox}
\RequirePackage{xcolor}
\RequirePackage{array}

\makeatletter

\newcommand{\university}[1]{\gdef\@university{#1}}
\newcommand{\semester}[1]{\gdef\@semester{#1}}
\newcommand{\department}[1]{\gdef\@department{#1}}
\newcommand{\course}[1]{\gdef\@course{#1}}
\newcommand{\examtype}[1]{\gdef\@examtype{#1}}
\newcommand{\examtime}[1]{\gdef\@examtime{#1}}
\newcommand{\papertype}[1]{\gdef\@papertype{#1}}
\newcommand{\enablewatermark}{\cqutwatermarktrue}
\newcommand{\disablewatermark}{\cqutwatermarkfalse}

\university{学校名称}
\semester{20XX～20XX学年第X学期}
\department{开课学院名称}
\course{课程名称}
\examtype{考核方式}
\examtime{XXX}
\papertype{X}

\newcommand{\cqut@field}[2]{#1\underline{\makebox[#2][c]{}}}
\newcommand{\cqut@valuefield}[3]{#1\underline{\makebox[#2][c]{\bfseries #3}}}

\newcommand{\cqut@header}{\ignorespaces
  \begin{minipage}{\headwidth}
    \centering
    {\CJKfamily{rm}\bfseries\fontsize{16pt}{19pt}\selectfont
      \@university 本科生课程考试试卷\par}
    \vspace{5.1mm}
    {\fontsize{10.56pt}{12.5pt}\selectfont \@semester\par}
    \vspace{3.5mm}
    {\fontsize{10.56pt}{13pt}\selectfont
      \noindent
      \cqut@valuefield{开课学院}{31mm}{\@department}\hfill
      \cqut@valuefield{课程名称}{51mm}{\@course}\hfill
      \cqut@valuefield{考核方式}{18mm}{\@examtype}\par
      \vspace{2.0mm}
      \noindent
      \cqut@valuefield{考试时间}{17mm}{\@examtime}\ 分钟
      \hspace{11mm}\underline{\makebox[17mm][c]{\bfseries\@papertype}}卷
      \hfill
      \underline{\makebox[39mm][c]{第\ \thepage\ 页\ 共\ \pageref{LastPage}\ 页}}\par
      \vspace{2.1mm}
      \noindent
      \cqut@field{考生姓名}{32mm}\hfill
      \cqut@field{考生班级}{36mm}\hfill
      \cqut@field{考生学号}{39mm}
    }
  \end{minipage}\unskip
}

\pagestyle{fancy}
\fancyhf{}
\fancyhead[C]{\cqut@header}
\fancyfoot[C]{{\fontsize{9pt}{10pt}\selectfont 第\thepage{}页，共\pageref{LastPage}页}}
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}
\fancypagestyle{plain}{\pagestyle{fancy}}

\AddToShipoutPictureBG{
  \begin{tikzpicture}[remember picture,overlay]
    \ifcqutwatermark
      \foreach \cqut@watermarky in {55mm,148mm,241mm}{
        \foreach \cqut@watermarkx in {38mm,105mm,172mm}{
          \node[rotate=35] at
            ([xshift=\cqut@watermarkx,yshift=\cqut@watermarky]current page.south west)
            {\includegraphics[width=72mm]{assets/watermark-logo.png}};
        }
      }
    \fi
    \ifnum\value{page}=1
      \coordinate (cqut@frametop) at
        ([xshift=-2mm,yshift=-4.8mm]current page text area.north west);
    \else
      \coordinate (cqut@frametop) at
        ([xshift=-2mm]current page text area.north west);
    \fi
    \draw[line width=.4pt]
      (cqut@frametop)
      rectangle ([xshift=2mm]current page text area.south east);
  \end{tikzpicture}
}

\setlength{\parindent}{0pt}
\setlength{\parskip}{0pt}
\setlength{\emergencystretch}{3em}
\AtBeginDocument{\fontsize{12pt}{18pt}\selectfont}

\newlist{examquestions}{enumerate}{1}
\setlist[examquestions]{
  label=\arabic*.,ref=\arabic*,
  labelindent=0mm,leftmargin=0pt,widest=26.,labelsep=1.5mm,align=left,
  itemindent=*,listparindent=0pt,
  topsep=2mm,partopsep=0pt,parsep=0pt,itemsep=3mm
}

\newif\ifcqut@firstpart
\cqut@firstparttrue
\newcommand{\exampart}[3]{
  \par
  \ifcqut@firstpart\vspace*{-1mm}\global\cqut@firstpartfalse
  \else\vspace{2.5mm}\fi
  {\bfseries\fontsize{12pt}{18pt}\selectfont #1、\quad #2 (#3)\par}
  \vspace{1.5mm}
}

\newlength{\cqut@choicewd}
\newlength{\cqut@choicemax}
\newcommand{\choices}[4]{
  \settowidth{\cqut@choicemax}{（A）\ #1}
  \foreach \cqut@choice in {#2,#3,#4}{
    \settowidth{\cqut@choicewd}{（A）\ \cqut@choice}
    \ifdim\cqut@choicewd>\cqut@choicemax\setlength{\cqut@choicemax}{\cqut@choicewd}\fi
  }
  \par\vspace{2.7mm}\noindent
  \ifdim\cqut@choicemax<.225\linewidth
    \makebox[.25\linewidth][l]{（A）\ #1}\makebox[.25\linewidth][l]{（B）\ #2}\makebox[.25\linewidth][l]{（C）\ #3}\makebox[.25\linewidth][l]{（D）\ #4}
  \else\ifdim\cqut@choicemax<.46\linewidth
    \makebox[.5\linewidth][l]{（A）\ #1}\makebox[.5\linewidth][l]{（B）\ #2}\par\vspace{2.7mm}\noindent
    \makebox[.5\linewidth][l]{（C）\ #3}\makebox[.5\linewidth][l]{（D）\ #4}
  \else
    （A）\ #1\par\vspace{1mm}
    （B）\ #2\par\vspace{1mm}
    （C）\ #3\par\vspace{1mm}
    （D）\ #4
  \fi\fi
  \par
}

\newcommand{\choicesinline}[4]{
  \choices{#1}{#2}{#3}{#4}
}

\newcommand{\choicespair}[4]{
  \par\vspace{2.7mm}\noindent
  \makebox[.5\linewidth][l]{（A）\ #1}\makebox[.5\linewidth][l]{（B）\ #2}
  \par\vspace{2.7mm}\noindent
  \makebox[.5\linewidth][l]{（C）\ #3}\makebox[.5\linewidth][l]{（D）\ #4}
  \par
}

\newcommand{\blank}[1][30mm]{\underline{\makebox[#1]{}}}
\newcommand{\answer}[2][30mm]{
  \ifshowanswers
    \underline{\makebox[#1][c]{\color{red!75!black}#2}}
  \else
    \underline{\makebox[#1]{}}
  \fi
}
\newcommand{\choiceanswer}[1]{
  （\quad\ifshowanswers{\color{red!75!black}#1}\else\hspace{1em}\fi\quad）
}
\newcommand{\solution}[2][35mm]{
  \ifshowanswers
    \par\vspace{2mm}\textbf{解：}{\color{blue!70!black}#2}\par
  \else
    \par\vspace{#1}
  \fi
}

\newcommand{\placeholder}[1]{
  \ifmmode\mbox{\CJKfontspec{Songti SC}#1}\else#1\fi}

\makeatother
\endinput
