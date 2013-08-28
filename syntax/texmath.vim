" texmath.vim
" @Author:      Tom Link (mailto:micathom AT gmail com?subject=[vim])
" @Website:     http://www.vim.org/account/profile.php?user_id=4037
" @License:     GPL (see http://www.gnu.org/licenses/gpl.txt)
" @Created:     2007-11-15.
" @Last Change: 2010-11-15.
" @Revision:    0.0.75

" Use only as embedded syntax to be included from other syntax files.

if version < 600
    syntax clear
elseif exists("b:current_syntax")
    finish
endif
scriptencoding utf-8

if exists(':HiLink')
    let s:delhilink = 0
else
    let s:delhilink = 1
    if version < 508
        command! -nargs=+ HiLink hi link <args>
    else
        command! -nargs=+ HiLink hi def link <args>
    endif
endif


" syn match texmathArgDelimiters /[{}\[\]]/ contained containedin=texmathMath
syn match texmathCommand /\\[[:alnum:]]\+/ contained containedin=texmath
syn match texmathMathWord /[[:alnum:].]\+/ contained containedin=texmathMath
syn match texmathUnword /\(\\\\\|[^[:alnum:]${}()[\]^_\\]\+\)/ contained containedin=texmath
syn match texmathPairs /\([<>()[\]]\|\\[{}]\|\\[lr]\(brace\|vert\|Vert\|angle\|ceil\|floor\|group\|moustache\)\)/
            \ contained containedin=texmath
syn match texmathSub /_/ contained containedin=texmathMath
syn match texmathSup /\^/ contained containedin=texmathMath

syn region texmathText matchgroup=Statement
            \ start=/\\text{/ end=/}/ skip=/\\[{}]/
            \ contained containedin=texmath
syn region texmathArgDelimiters matchgroup=Delimiter
            \ start=/\\\@<!{/ end=/\\\@<!}/ skip=/\\[{}]/
            \ contained contains=@texmathMath containedin=texmath


if has('conceal') && &enc == 'utf-8'
    if &conceallevel == 0
        setlocal conceallevel=2
    endif
    if empty(&concealcursor)
        setlocal concealcursor=n
    endif

    if !exists('g:did_tex_syntax_inits')
        let s:tex_conceal = exists("g:tex_conceal") ? g:tex_conceal : 'admgs'

        if s:tex_conceal =~ 'm'
            " Copied from $VIMRUNTIME/syntax/tex.vim
            " Math Symbols {{{2
            " (many of these symbols were contributed by BjÃ¶rn Winckler)
            let s:texMathList = [
                        \ ['angle'		, 'â '],
                        \ ['approx'		, 'â'],
                        \ ['ast'		, 'â'],
                        \ ['asymp'		, 'â'],
                        \ ['backepsilon'	, 'â'],
                        \ ['backsimeq'	, 'â'],
                        \ ['barwedge'	, 'â¼'],
                        \ ['because'	, 'âµ'],
                        \ ['between'	, 'â¬'],
                        \ ['bigcap'		, 'â©'],
                        \ ['bigcup'		, 'âª'],
                        \ ['bigodot'	, 'â'],
                        \ ['bigoplus'	, 'â'],
                        \ ['bigotimes'	, 'â'],
                        \ ['bigsqcup'	, 'â'],
                        \ ['bigtriangledown', 'â'],
                        \ ['bigvee'		, 'â'],
                        \ ['bigwedge'	, 'â'],
                        \ ['blacksquare'	, 'â'],
                        \ ['bot'		, 'â¥'],
                        \ ['boxdot'		, 'â¡'],
                        \ ['boxminus'	, 'â'],
                        \ ['boxplus'	, 'â'],
                        \ ['boxtimes'	, 'â '],
                        \ ['bumpeq'		, 'â'],
                        \ ['Bumpeq'		, 'â'],
                        \ ['cap'		, 'â©'],
                        \ ['Cap'		, 'â'],
                        \ ['cdot'		, 'Â·'],
                        \ ['cdots'		, 'â¯'],
                        \ ['circ'		, 'â'],
                        \ ['circeq'		, 'â'],
                        \ ['circlearrowleft', 'âº'],
                        \ ['circlearrowright', 'â»'],
                        \ ['circledast'	, 'â'],
                        \ ['circledcirc'	, 'â'],
                        \ ['complement'	, 'â'],
                        \ ['cong'		, 'â'],
                        \ ['coprod'		, 'â'],
                        \ ['cup'		, 'âª'],
                        \ ['Cup'		, 'â'],
                        \ ['curlyeqprec'	, 'â'],
                        \ ['curlyeqsucc'	, 'â'],
                        \ ['curlyvee'	, 'â'],
                        \ ['curlywedge'	, 'â'],
                        \ ['dashv'		, 'â£'],
                        \ ['diamond'	, 'â'],
                        \ ['div'		, 'Ã·'],
                        \ ['doteq'		, 'â'],
                        \ ['doteqdot'	, 'â'],
                        \ ['dotplus'	, 'â'],
                        \ ['dotsb'		, 'â¯'],
                        \ ['dotsc'		, 'â¦'],
                        \ ['dots'		, 'â¦'],
                        \ ['dotsi'		, 'â¯'],
                        \ ['dotso'		, 'â¦'],
                        \ ['doublebarwedge'	, 'â©'],
                        \ ['downarrow'	, 'â'],
                        \ ['Downarrow'	, 'â'],
                        \ ['emptyset'	, 'â'],
                        \ ['eqcirc'		, 'â'],
                        \ ['eqsim'		, 'â'],
                        \ ['eqslantgtr'	, 'âª'],
                        \ ['eqslantless'	, 'âª'],
                        \ ['equiv'		, 'â¡'],
                        \ ['exists'		, 'â'],
                        \ ['fallingdotseq'	, 'â'],
                        \ ['forall'		, 'â'],
                        \ ['ge'		, 'â¥'],
                        \ ['geq'		, 'â¥'],
                        \ ['geqq'		, 'â§'],
                        \ ['gets'		, 'â'],
                        \ ['gneqq'		, 'â©'],
                        \ ['gtrdot'		, 'â'],
                        \ ['gtreqless'	, 'â'],
                        \ ['gtrless'	, 'â·'],
                        \ ['gtrsim'		, 'â³'],
                        \ ['hookleftarrow'	, 'â©'],
                        \ ['hookrightarrow'	, 'âª'],
                        \ ['iiint'		, 'â­'],
                        \ ['iint'		, 'â¬'],
                        \ ['Im'		, 'â'],
                        \ ['in'		, 'â'],
                        \ ['infty'		, 'â'],
                        \ ['int'		, 'â«'],
                        \ ['lceil'		, 'â'],
                        \ ['ldots'		, 'â¦'],
                        \ ['le'		, 'â¤'],
                        \ ['leftarrow'	, 'âµ'],
                        \ ['Leftarrow'	, 'â¸'],
                        \ ['leftarrowtail'	, 'â¢'],
                        \ ['left('		, '('],
                        \ ['left\['		, '['],
                        \ ['left\\{'	, '{'],
                        \ ['Leftrightarrow'	, 'â'],
                        \ ['leftrightsquigarrow', 'â­'],
                        \ ['leftthreetimes'	, 'â'],
                        \ ['leq'		, 'â¤'],
                        \ ['leqq'		, 'â¦'],
                        \ ['lessdot'	, 'â'],
                        \ ['lesseqgtr'	, 'â'],
                        \ ['lesssim'	, 'â²'],
                        \ ['lfloor'		, 'â'],
                        \ ['lneqq'		, 'â¨'],
                        \ ['ltimes'		, 'â'],
                        \ ['mapsto'		, 'â¦'],
                        \ ['measuredangle'	, 'â¡'],
                        \ ['mid'		, 'â£'],
                        \ ['mp'		, 'â'],
                        \ ['nabla'		, 'â'],
                        \ ['ncong'		, 'â'],
                        \ ['nearrow'	, 'â'],
                        \ ['ne'		, 'â '],
                        \ ['neg'		, 'Â¬'],
                        \ ['neq'		, 'â '],
                        \ ['nexists'	, 'â'],
                        \ ['ngeq'		, 'â±'],
                        \ ['ngeqq'		, 'â±'],
                        \ ['ngtr'		, 'â¯'],
                        \ ['ni'		, 'â'],
                        \ ['nleftarrow'	, 'â'],
                        \ ['nLeftarrow'	, 'â'],
                        \ ['nLeftrightarrow', 'â'],
                        \ ['nleq'		, 'â°'],
                        \ ['nleqq'		, 'â°'],
                        \ ['nless'		, 'â®'],
                        \ ['nmid'		, 'â¤'],
                        \ ['notin'		, 'â'],
                        \ ['nprec'		, 'â'],
                        \ ['nrightarrow'	, 'â'],
                        \ ['nRightarrow'	, 'â'],
                        \ ['nsim'		, 'â'],
                        \ ['nsucc'		, 'â'],
                        \ ['ntriangleleft'	, 'âª'],
                        \ ['ntrianglelefteq', 'â¬'],
                        \ ['ntriangleright'	, 'â«'],
                        \ ['ntrianglerighteq', 'â­'],
                        \ ['nvdash'		, 'â¬'],
                        \ ['nvDash'		, 'â­'],
                        \ ['nVdash'		, 'â®'],
                        \ ['nwarrow'	, 'â'],
                        \ ['odot'		, 'â'],
                        \ ['oint'		, 'â®'],
                        \ ['ominus'		, 'â'],
                        \ ['oplus'		, 'â'],
                        \ ['oslash'		, 'â'],
                        \ ['otimes'		, 'â'],
                        \ ['owns'		, 'â'],
                        \ ['partial'	, 'â'],
                        \ ['perp'		, 'â¥'],
                        \ ['pitchfork'	, 'â'],
                        \ ['pm'		, 'Â±'],
                        \ ['precapprox'	, 'âª·'],
                        \ ['prec'		, 'âº'],
                        \ ['preccurlyeq'	, 'â¼'],
                        \ ['preceq'		, 'âª¯'],
                        \ ['precnapprox'	, 'âª¹'],
                        \ ['precneqq'	, 'âªµ'],
                        \ ['precsim'	, 'â¾'],
                        \ ['prod'		, 'â'],
                        \ ['propto'		, 'â'],
                        \ ['rceil'		, 'â'],
                        \ ['Re'		, 'â'],
                        \ ['rfloor'		, 'â'],
                        \ ['rightarrow'	, 'â¶'],
                        \ ['Rightarrow'	, 'â¹'],
                        \ ['rightarrowtail'	, 'â£'],
                        \ ['right)'		, ')'],
                        \ ['right]'		, ']'],
                        \ ['right\\}'	, '}'],
                        \ ['rightsquigarrow', 'â'],
                        \ ['rightthreetimes', 'â'],
                        \ ['risingdotseq'	, 'â'],
                        \ ['rtimes'		, 'â'],
                        \ ['searrow'	, 'â'],
                        \ ['setminus'	, 'â'],
                        \ ['sim'		, 'â¼'],
                        \ ['sphericalangle'	, 'â¢'],
                        \ ['sqcap'		, 'â'],
                        \ ['sqcup'		, 'â'],
                        \ ['sqsubset'	, 'â'],
                        \ ['sqsubseteq'	, 'â'],
                        \ ['sqsupset'	, 'â'],
                        \ ['sqsupseteq'	, 'â'],
                        \ ['subset'		, 'â'],
                        \ ['Subset'		, 'â'],
                        \ ['subseteq'	, 'â'],
                        \ ['subseteqq'	, 'â«'],
                        \ ['subsetneq'	, 'â'],
                        \ ['subsetneqq'	, 'â«'],
                        \ ['succapprox'	, 'âª¸'],
                        \ ['succ'		, 'â»'],
                        \ ['succcurlyeq'	, 'â½'],
                        \ ['succeq'		, 'âª°'],
                        \ ['succnapprox'	, 'âªº'],
                        \ ['succneqq'	, 'âª¶'],
                        \ ['succsim'	, 'â¿'],
                        \ ['sum'		, 'â'],
                        \ ['Supset'		, 'â'],
                        \ ['supseteq'	, 'â'],
                        \ ['supseteqq'	, 'â«'],
                        \ ['supsetneq'	, 'â'],
                        \ ['supsetneqq'	, 'â«'],
                        \ ['surd'		, 'â'],
                        \ ['swarrow'	, 'â'],
                        \ ['therefore'	, 'â´'],
                        \ ['times'		, 'Ã'],
                        \ ['to'		, 'â'],
                        \ ['top'		, 'â¤'],
                        \ ['triangleleft'	, 'â²'],
                        \ ['trianglelefteq'	, 'â´'],
                        \ ['triangleq'	, 'â'],
                        \ ['triangleright'	, 'â³'],
                        \ ['trianglerighteq', 'âµ'],
                        \ ['twoheadleftarrow', 'â'],
                        \ ['twoheadrightarrow', 'â '],
                        \ ['uparrow'	, 'â'],
                        \ ['Uparrow'	, 'â'],
                        \ ['updownarrow'	, 'â'],
                        \ ['Updownarrow'	, 'â'],
                        \ ['varnothing'	, 'â'],
                        \ ['vartriangle'	, 'â'],
                        \ ['vdash'		, 'â¢'],
                        \ ['vDash'		, 'â¨'],
                        \ ['Vdash'		, 'â©'],
                        \ ['vdots'		, 'â®'],
                        \ ['veebar'		, 'â»'],
                        \ ['vee'		, 'â¨'],
                        \ ['Vvdash'		, 'âª'],
                        \ ['wedge'		, 'â§'],
                        \ ['wr'		, 'â']]
            for texmath in s:texMathList
                exe "syn match texMathSymbol '\\\\".texmath[0]."\\>' contained containedin=texmath conceal cchar=".texmath[1]
            endfor
            unlet texmath s:texMathList

            " Copied from $VIMRUNTIME/syntax/tex.vim
            if &ambw == "double"
                syn match texMathSymbol '\\gg\>'			contained containedin=texmath conceal cchar=â«
                syn match texMathSymbol '\\ll\>'			contained containedin=texmath conceal cchar=âª
            else
                syn match texMathSymbol '\\gg\>'			contained containedin=texmath conceal cchar=â«
                syn match texMathSymbol '\\ll\>'			contained containedin=texmath conceal cchar=âª
            endif
        endif

        if s:tex_conceal =~ 'g'
            " Copied from $VIMRUNTIME/syntax/tex.vim
            fun! s:Greek(group,pat,cchar)
                exe 'syn match '.a:group." '".a:pat."' contained containedin=texmath conceal cchar=".a:cchar
            endfun
            call s:Greek('texGreek','\\alpha\>'		,'Î±')
            call s:Greek('texGreek','\\beta\>'		,'Î²')
            call s:Greek('texGreek','\\gamma\>'		,'Î³')
            call s:Greek('texGreek','\\delta\>'		,'Î´')
            call s:Greek('texGreek','\\epsilon\>'		,'Ïµ')
            call s:Greek('texGreek','\\varepsilon\>'	,'Îµ')
            call s:Greek('texGreek','\\zeta\>'		,'Î¶')
            call s:Greek('texGreek','\\eta\>'		,'Î·')
            call s:Greek('texGreek','\\theta\>'		,'Î¸')
            call s:Greek('texGreek','\\vartheta\>'		,'Ï')
            call s:Greek('texGreek','\\kappa\>'		,'Îº')
            call s:Greek('texGreek','\\lambda\>'		,'Î»')
            call s:Greek('texGreek','\\mu\>'		,'Î¼')
            call s:Greek('texGreek','\\nu\>'		,'Î½')
            call s:Greek('texGreek','\\xi\>'		,'Î¾')
            call s:Greek('texGreek','\\pi\>'		,'Ï')
            call s:Greek('texGreek','\\varpi\>'		,'Ï')
            call s:Greek('texGreek','\\rho\>'		,'Ï')
            call s:Greek('texGreek','\\varrho\>'		,'Ï±')
            call s:Greek('texGreek','\\sigma\>'		,'Ï')
            call s:Greek('texGreek','\\varsigma\>'		,'Ï')
            call s:Greek('texGreek','\\tau\>'		,'Ï')
            call s:Greek('texGreek','\\upsilon\>'		,'Ï')
            call s:Greek('texGreek','\\phi\>'		,'Ï')
            call s:Greek('texGreek','\\varphi\>'		,'Ï')
            call s:Greek('texGreek','\\chi\>'		,'Ï')
            call s:Greek('texGreek','\\psi\>'		,'Ï')
            call s:Greek('texGreek','\\omega\>'		,'Ï')
            call s:Greek('texGreek','\\Gamma\>'		,'Î')
            call s:Greek('texGreek','\\Delta\>'		,'Î')
            call s:Greek('texGreek','\\Theta\>'		,'Î')
            call s:Greek('texGreek','\\Lambda\>'		,'Î')
            call s:Greek('texGreek','\\Xi\>'		,'Î§')
            call s:Greek('texGreek','\\Pi\>'		,'Î ')
            call s:Greek('texGreek','\\Sigma\>'		,'Î£')
            call s:Greek('texGreek','\\Upsilon\>'		,'Î¥')
            call s:Greek('texGreek','\\Phi\>'		,'Î¦')
            call s:Greek('texGreek','\\Psi\>'		,'Î¨')
            call s:Greek('texGreek','\\Omega\>'		,'Î©')
            delfun s:Greek
        endif

        if s:tex_conceal =~ 's'
            fun! s:SuperSub(group,leader,pat,cchar)
                exe 'syn match '.a:group." '".a:leader.a:pat."' contained containedin=texmath conceal cchar=".a:cchar
                exe 'syn match '.a:group."s '".a:pat."' contained containedin=texmath conceal cchar=".a:cchar.' nextgroup='.a:group.'s'
            endfun
            call s:SuperSub('texSuperscript','\^','0','â°')
            call s:SuperSub('texSuperscript','\^','1','Â¹')
            call s:SuperSub('texSuperscript','\^','2','Â²')
            call s:SuperSub('texSuperscript','\^','3','Â³')
            call s:SuperSub('texSuperscript','\^','4','â´')
            call s:SuperSub('texSuperscript','\^','5','âµ')
            call s:SuperSub('texSuperscript','\^','6','â¶')
            call s:SuperSub('texSuperscript','\^','7','â·')
            call s:SuperSub('texSuperscript','\^','8','â¸')
            call s:SuperSub('texSuperscript','\^','9','â¹')
            call s:SuperSub('texSuperscript','\^','a','áµ')
            call s:SuperSub('texSuperscript','\^','b','áµ')
            call s:SuperSub('texSuperscript','\^','c','á¶')
            call s:SuperSub('texSuperscript','\^','d','áµ')
            call s:SuperSub('texSuperscript','\^','e','áµ')
            call s:SuperSub('texSuperscript','\^','f','á¶ ')
            call s:SuperSub('texSuperscript','\^','g','áµ')
            call s:SuperSub('texSuperscript','\^','h','Ê°')
            call s:SuperSub('texSuperscript','\^','i','â±')
            call s:SuperSub('texSuperscript','\^','j','Ê²')
            call s:SuperSub('texSuperscript','\^','k','áµ')
            call s:SuperSub('texSuperscript','\^','l','Ë¡')
            call s:SuperSub('texSuperscript','\^','m','áµ')
            call s:SuperSub('texSuperscript','\^','n','â¿')
            call s:SuperSub('texSuperscript','\^','o','áµ')
            call s:SuperSub('texSuperscript','\^','p','áµ')
            call s:SuperSub('texSuperscript','\^','r','Ê³')
            call s:SuperSub('texSuperscript','\^','s','Ë¢')
            call s:SuperSub('texSuperscript','\^','t','áµ')
            call s:SuperSub('texSuperscript','\^','u','áµ')
            call s:SuperSub('texSuperscript','\^','v','áµ')
            call s:SuperSub('texSuperscript','\^','w','Ê·')
            call s:SuperSub('texSuperscript','\^','x','Ë£')
            call s:SuperSub('texSuperscript','\^','y','Ê¸')
            call s:SuperSub('texSuperscript','\^','z','á¶»')
            call s:SuperSub('texSuperscript','\^','A','á´¬')
            call s:SuperSub('texSuperscript','\^','B','á´®')
            call s:SuperSub('texSuperscript','\^','D','á´°')
            call s:SuperSub('texSuperscript','\^','E','á´±')
            call s:SuperSub('texSuperscript','\^','G','á´³')
            call s:SuperSub('texSuperscript','\^','H','á´´')
            call s:SuperSub('texSuperscript','\^','I','á´µ')
            call s:SuperSub('texSuperscript','\^','J','á´¶')
            call s:SuperSub('texSuperscript','\^','K','á´·')
            call s:SuperSub('texSuperscript','\^','L','á´¸')
            call s:SuperSub('texSuperscript','\^','M','á´¹')
            call s:SuperSub('texSuperscript','\^','N','á´º')
            call s:SuperSub('texSuperscript','\^','O','á´¼')
            call s:SuperSub('texSuperscript','\^','P','á´¾')
            call s:SuperSub('texSuperscript','\^','R','á´¿')
            call s:SuperSub('texSuperscript','\^','T','áµ')
            call s:SuperSub('texSuperscript','\^','U','áµ')
            call s:SuperSub('texSuperscript','\^','W','áµ')
            call s:SuperSub('texSuperscript','\^','+','âº')
            call s:SuperSub('texSuperscript','\^','-','â»')
            call s:SuperSub('texSuperscript','\^','<','Ë')
            call s:SuperSub('texSuperscript','\^','>','Ë')
            call s:SuperSub('texSuperscript','\^','/','Ë')
            call s:SuperSub('texSuperscript','\^','(','â½')
            call s:SuperSub('texSuperscript','\^',')','â¾')
            call s:SuperSub('texSuperscript','\^','\.','Ë')
            call s:SuperSub('texSuperscript','\^','=','Ë­')
            call s:SuperSub('texSubscript','_','0','â')
            call s:SuperSub('texSubscript','_','1','â')
            call s:SuperSub('texSubscript','_','2','â')
            call s:SuperSub('texSubscript','_','3','â')
            call s:SuperSub('texSubscript','_','4','â')
            call s:SuperSub('texSubscript','_','5','â')
            call s:SuperSub('texSubscript','_','6','â')
            call s:SuperSub('texSubscript','_','7','â')
            call s:SuperSub('texSubscript','_','8','â')
            call s:SuperSub('texSubscript','_','9','â')
            call s:SuperSub('texSubscript','_','a','â')
            call s:SuperSub('texSubscript','_','e','â')
            call s:SuperSub('texSubscript','_','i','áµ¢')
            call s:SuperSub('texSubscript','_','o','â')
            call s:SuperSub('texSubscript','_','u','áµ¤')
            call s:SuperSub('texSubscript','_','+','â')
            call s:SuperSub('texSubscript','_','-','â')
            call s:SuperSub('texSubscript','_','/','Ë')
            call s:SuperSub('texSubscript','_','(','â')
            call s:SuperSub('texSubscript','_',')','â')
            call s:SuperSub('texSubscript','_','\.','â¸')
            call s:SuperSub('texSubscript','_','r','áµ£')
            call s:SuperSub('texSubscript','_','v','áµ¥')
            call s:SuperSub('texSubscript','_','x','â')
            call s:SuperSub('texSubscript','_','\\beta\>' ,'áµ¦')
            call s:SuperSub('texSubscript','_','\\delta\>','áµ¨')
            call s:SuperSub('texSubscript','_','\\phi\>'  ,'áµ©')
            call s:SuperSub('texSubscript','_','\\gamma\>','áµ§')
            call s:SuperSub('texSubscript','_','\\chi\>'  ,'áµª')
            delfun s:SuperSub
        endif
        unlet s:tex_conceal
    endif

    syn match texmathMathFont /\\\(math[[:alnum:]]\+\|Bbb\|frak\)/
                \ contained containedin=texmath
                \ conceal
    syn cluster texmath contains=texmathArgDelimiters,texmathCommand,texmathMathFont,texmathPairs,texmathUnword,texmathText,texMathSymbol,texGreek,texSubscript,texSuperscript
else
    syn match texmathMathFont /\\\(math[[:alnum:]]\+\|Bbb\|frak\)/ contained containedin=texmath
    syn cluster texmath contains=texmathArgDelimiters,texmathCommand,texmathMathFont,texmathPairs,texmathUnword,texmathText
endif

syn cluster texmathMath contains=@texmath,texmathMathWord,texmathSup,texmathSub

" Statement PreProc
HiLink texmathSup Type
HiLink texmathSub Type
" HiLink texmathArgDelimiters Comment
HiLink texmathCommand Statement
HiLink texmathText Normal
HiLink texmathMathFont Type
HiLink texmathMathWord Identifier
HiLink texmathUnword Constant
HiLink texmathPairs PreProc


if s:delhilink
    delcommand HiLink
endif
" let b:current_syntax = 'texmath'

