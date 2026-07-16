\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{customcv}[2026/07/18 v1.0 基于 moderncv 的自定义简历类]

% 将选项透传给 moderncv 类
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{moderncv}}
\ProcessOptions\relax

% 加载基类 moderncv，并使用默认设置（衬线字体 roman）
\LoadClass[11pt,a4paper,roman]{moderncv}

% 标准版式与主题颜色设置
\moderncvstyle{banking}
\moderncvcolor{black}
\nopagenumbers{}

% 自定义高级配色
\definecolor{color0}{RGB}{33, 37, 41}      % 炭黑：正文主色
\definecolor{color1}{RGB}{30, 58, 138}     % 石板蓝：章节标题
\definecolor{color2}{RGB}{100, 116, 139}   % 石板灰：日期、地点与副标题
\definecolor{linkcolor}{RGB}{37, 99, 235}  % 精炼蓝：超链接颜色

% 宏包依赖
\RequirePackage{ragged2e}
\RequirePackage[left=2.0cm, right=2.0cm, top=1.0cm, bottom=1.0cm]{geometry}
\RequirePackage{import}
\RequirePackage{multicol}
\RequirePackage{enumitem}
\RequirePackage{amssymb}
\RequirePackage{fontawesome5}
\RequirePackage{xeCJK}
\RequirePackage{setspace}
\RequirePackage{newunicodechar}

% 全局行距设置
\setstretch{1.12}

% =========================================================================
% 列表符号样式选项
% 通过注释/取消注释下方对应的行来切换不同的列表符号样式：
% =========================================================================

% 样式 A：圆点 •
% \setlist[itemize]{leftmargin=1.5em, label={\color{color1}\textbullet}, itemsep=0.12em, topsep=0.10em, parsep=0.04em}

% 样式 B：短横线 –
\setlist[itemize]{leftmargin=1.5em, label={\color{color1}\textendash}, itemsep=0.18em, topsep=0.15em, parsep=0.05em}

% 样式 C：右角标 >
% \setlist[itemize]{leftmargin=1.5em, label={\color{color1}\small\faAngleRight}, itemsep=0.15em, topsep=0.10em, parsep=0.02em}

% 样式 D：纯缩进
% \setlist[itemize]{leftmargin=1.0em, label={}, itemsep=0.15em, topsep=0.10em, parsep=0.02em}

% =========================================================================
% 中文字体设置
% macOS 默认衬线字体使用 Songti SC (宋体)。如果是 Windows 或 Linux 用户，可将下方
% 替换为您的系统支持的衬线字体（例如 SimSun 或 FandolSong 字体）。
% =========================================================================
\setCJKmainfont[
  BoldFont=Songti SC Bold,
]{Songti SC}
\setCJKsansfont[
  BoldFont=Songti SC Bold,
]{Songti SC}
\setCJKmonofont[
  BoldFont=Songti SC Bold,
]{Songti SC}

% =========================================================================
% 英文字体设置
% 衬线体: Tinos Nerd Font | 非衬线体: Arimo Nerd Font | 等宽字体: Cousine Nerd Font
% =========================================================================
\providecommand*{\customcvfontpath}{}

\IfFileExists{\customcvfontpath fonts/Tinos/TinosNerdFont-Regular.ttf}{
  \setmainfont[
    Path=\customcvfontpath fonts/Tinos/,
    BoldFont=TinosNerdFont-Bold.ttf,
    ItalicFont=TinosNerdFont-Italic.ttf,
    BoldItalicFont=TinosNerdFont-BoldItalic.ttf,
  ]{TinosNerdFont-Regular.ttf}
  \setsansfont[
    Path=\customcvfontpath fonts/Arimo/,
    BoldFont=ArimoNerdFont-Bold.ttf,
    ItalicFont=ArimoNerdFont-Italic.ttf,
    BoldItalicFont=ArimoNerdFont-BoldItalic.ttf,
  ]{ArimoNerdFont-Regular.ttf}
  \setmonofont[
    Path=\customcvfontpath fonts/JetBrainsMono/,
    BoldFont=JetBrainsMonoNerdFont-Bold.ttf,
    ItalicFont=JetBrainsMonoNerdFont-Italic.ttf,
    BoldItalicFont=JetBrainsMonoNerdFont-BoldItalic.ttf,
  ]{JetBrainsMonoNerdFont-Regular.ttf}
}{
  \setmainfont{Times New Roman}
  \setsansfont{Arial}
}

% 外部链接 ↗ 符号支持
\newfontfamily\cvlinkiconfont[%
  Path=\customcvfontpath fonts/JetBrainsMono/,%
  BoldFont=JetBrainsMonoNerdFont-Bold.ttf,%
  ItalicFont=JetBrainsMonoNerdFont-Italic.ttf,%
  BoldItalicFont=JetBrainsMonoNerdFont-BoldItalic.ttf,%
]{JetBrainsMonoNerdFont-Regular.ttf}
\newunicodechar{↗}{{\cvlinkiconfont ↗}}
\AtBeginDocument{%
  \@ifpackageloaded{hyperref}{\pdfstringdefDisableCommands{\def↗{}}}{}%
}

\definecolor{highlightcolor}{RGB}{0, 82, 217}
\RequirePackage{tikz}
\pgfdeclarelayer{background}
\pgfsetlayers{background,main}

% 荧光笔划线样式
\newcommand{\highlight}[1]{%
  \tikz[baseline=(x.base)]{%
    \node[inner sep=0pt, outer sep=0pt](x){#1};%
    \begin{pgfonlayer}{background}%
      \fill[highlightcolor!35] ([yshift=-0.5pt]x.south west) rectangle ([yshift=3.6pt]x.south east);%
    \end{pgfonlayer}%
  }%
}

% =========================================================================
% 自定义样式
% =========================================================================

% 参数使用说明：
% \customcventry[垂直间距]{#2 城市/地点}{#3 职位/岗位角色}{#4 学校/公司/项目名称}{#5 专业/部门/技术栈}{#6 日期时间}{#7 详细描述(多行列表)}
\newcommand{\customcventry}[7][0.85em]{%
  \noindent
  {\bfseries\color{color0} #4}% 学校/公司/项目名称
  \ifx\relax#3\relax
    \ifx\relax#5\relax\else{\small\color{color2} \enspace ｜ \enspace {\ttfamily #5}}\fi%
  \fi
  \hfill
  {\small\color{color2} #6}% 日期
  \par\addvspace{0.15em}%
  \ifx\relax#3\relax
    \ifx\relax#2\relax\else
      \noindent{\small\color{color2} #2}% 地点
      \par\addvspace{0.15em}%
    \fi
  \else
    \noindent{\small\color{color0} #3}% 职位/岗位角色
    \ifx\relax#5\relax\else{\small\color{color2} \quad\textbar\quad {\ttfamily #5}}\fi% 专业/部门/技术栈
    \hfill\ifx\relax#2\relax\else{\small\color{color2} #2}\fi% 地点
    \par\addvspace{0.15em}%
  \fi
  \ifx\relax#7\relax%
  \else%
    \noindent
    \begin{minipage}{\maincolumnwidth}%
      #7%
    \end{minipage}%
    \par\addvspace{#1}%
  \fi%
}
