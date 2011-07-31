<cfimport taglib="../.." prefix="ex">
<ex:detail error=#error#>
<cfoutput>
<b>#error.mask#</b> is an invalid mask for the input number: <b>#error.inputNum#</b>.
<BR>
The following table contains all valid NumberFormat masks:
<br>

<table border="1" cellpadding="3" cellspacing="0">
<caption></caption>
<tr valign="top"><th colspan=2 rowspan=1>
<strong>Mask characters</strong>
</th></tr>
<tr valign="top"><th align="left">
<strong>Character</strong>
</th><th align="left">
<strong>Meaning</strong>
</th></tr>
<tr valign="top"><td valign="top"><PRE>_ (underscore)
</PRE></td><td valign="top">
Optional digit placeholder. 
</td></tr>
<tr valign="top"><td valign="top"><PRE>9
</PRE></td><td valign="top">
Optional digit placeholder. Same as _, but shows decimal places more clearly. 
</td></tr>
<tr valign="top"><td valign="top"><PRE>.
</PRE></td><td valign="top">
Specifies the location of a mandatory decimal point. 
</td></tr>
<tr valign="top"><td valign="top"><PRE>0
</PRE></td><td valign="top">
Located to the left or right of a mandatory decimal point, to force padding with zeros. 
</td></tr>
<tr valign="top"><td valign="top"><PRE>( )
</PRE></td><td valign="top">
Places parentheses around the mask if the number is less than 0.
</td></tr>
<tr valign="top"><td valign="top"><PRE>+
</PRE></td><td valign="top">
Places + in front of positive numbers, - (minus sign) in front of negative numbers.
</td></tr>
<tr valign="top"><td valign="top"><PRE>-
</PRE></td><td valign="top">
Place " " (space) in front of positive, - (minus sign) in front of negative numbers. 
</td></tr>
<tr valign="top"><td valign="top"><PRE>,
</PRE></td><td valign="top">
Separates thousands with commas. 
</td></tr>
<tr valign="top"><td valign="top"><PRE>L,C
</PRE></td><td valign="top">
Specifies left-justify or center-justify a number within the width of the mask column. L or C must appear as the first character of the mask. By default, numbers are right-justified. 
</td></tr>
<tr valign="top"><td valign="top"><PRE>$
</PRE></td><td valign="top">
Places a dollar sign in front of the formatted number. $ must appear as the first character of the mask.
</td></tr>
<tr valign="top"><td valign="top"><PRE>^
</PRE></td><td valign="top">
Separates left from right formatting.
</td></tr>

</table>

</cfoutput>

</ex:detail>
