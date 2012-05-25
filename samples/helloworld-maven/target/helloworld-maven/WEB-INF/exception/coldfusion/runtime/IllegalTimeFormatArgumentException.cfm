
<cfimport taglib="../.." prefix="ex">
<ex:detail error=#error#>
<cfinclude template="../../udf.cfm">
<cfoutput>
<b>#encodeForErrorSmart(error.mask)#</b> is an invalid mask for the input number: <b>#encodeForErrorSmart(error.date)#</b>.
<BR>
The following list contains all valid TimeFormat masks:
<br>

<h5 class="param"> mask</h5>
<p class="param">A set of masking characters determining the format:</p><ul>
<a name="1138390"> </a>
<li><code>h</code> -- Hours with no leading zero for single-digit hours. (Uses a 12-hour clock.)

<a name="1138405"> </a>
</li>
<li><code>hh</code> -- Hours with a leading zero for single-digit hours. (Uses a 12-hour clock.)
<a name="1138429"> </a>
</li>
<li><code>H</code> -- Hours with no leading zero for single-digit hours. (Uses a 24-hour clock.)
<a name="1138430"> </a>
</li>
<li><code>HH</code> -- Hours with a leading zero for single-digit hours. (Uses a 24-hour clock.)
<a name="1138431"> </a>
</li>
<li><code>m</code> -- Minutes with no leading zero for single-digit minutes
<a name="1138432"> </a>
</li>
<li><code>mm</code> -- Minutes with a leading zero for single-digit minutes
<a name="1138433"> </a>
</li>
<li><code>s</code> -- Seconds with no leading zero for single-digit seconds 
<a name="1138434"> </a>
</li>
<li><code>ss</code> -- Seconds with a leading zero for single-digit seconds 
<a name="1138435"> </a>
</li>
<li><code>t</code> -- Single-character time marker string, such as A or P 
<a name="1138436"> </a>
</li>
<li><code>tt</code> -- Multiple-character time marker string, such as AM or PM 
</li>
</ul>

</cfoutput>
</ex:detail>
