"======================================================== 
" Highlight All Function 
"======================================================== 
syn match cFunction "\<[a-zA-Z_][a-zA-Z_0-9]*\>[^()]*)("me=e-2 
syn match cFunction "\<[a-zA-Z_][a-zA-Z_0-9]*\>\s*("me=e-1 
hi cFunction gui=NONE guifg=#B5A1FF 
"======================================================== 
" Highlight All Math Operator 
"======================================================== 
" C math operators 
syn match cMathOperator display "[-+\*/%=]" 
" C pointer operators 
syn match cPointerOperator display "->\|\." 
" C logical operators - boolean results 
syn match cLogicalOperator display "[!<>]=\=" 
syn match cLogicalOperator display "==" 
" C bit operators 
syn match cBinaryOperator display "\(&\||\|\^\|<<\|>>\)=\=" 
syn match cBinaryOperator display "\~" 
syn match cBinaryOperatorError display "\~=" 
" More C logical operators - highlight in preference to binary 
syn match cLogicalOperator display "&&\|||" 
syn match cLogicalOperatorError display "\(&&\|||\)=" 
" Math Operator 
hi cMathOperator guifg=#3EFFE2 
hi cPointerOperator guifg=#3EFFE2 
hi cLogicalOperator guifg=#3EFFE2 
hi cBinaryOperator guifg=#3EFFE2 
hi cBinaryOperatorError guifg=#3EFFE2 
hi cLogicalOperator guifg=#3EFFE2 
hi cLogicalOperatorError guifg=#3EFFE2

syntax keyword group1 foreach if then else elsif while repeat until disable integer unsigned signed byte always initial

"这句是匹配所有以GTK或者Gtk等等不分大小写开头的句子。
syn match   glibFunction "\<[Gg][Tt][Kk][a-zA-Z_0-9]*\>"   
"这就是将上述匹配高亮，颜色可自定义。各颜色的列表在帮助文档中可以查到，我这有现成的文件，有需求可以管我要。
hi glibFunction cterm=bold ctermfg=Red 
syntax keyword gcType gint guint glong gshort gulong gushort gchar guchar gboolean
"这两句 高亮GNU的数据类型为Type类型的颜色。
hi gcType cterm=bold 


