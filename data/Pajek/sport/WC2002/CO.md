<HTML>
 <HEAD>
  <TITLE>1. C:\andrej\ANDREJ\CONFER\SUNBELT\portoroz.04\VISZARDS\f2002.net (44)</TITLE>
<SCRIPT LANGUAGE="JavaScript1.2"><!--
/*
* This function turns on/off various layers of the SVG picture.
* It is called when the user clicks on any of the checkboxes in
* the form below.
*
* Input Parameters:
*   checkbox     - Form object (checkbox) that was clicked on.
*   element_name - SVG element name that should be made visible/
*                  invisible.
*/
function hilite_elem (checkbox, element_name)
{
   var svgobj;
   var svgstyle;
   var svgdoc = document.network.getSVGDocument();
  // For selected element, get the elements style object, then set
  // its visibility according to the state of the checkbox.
   svgobj = svgdoc.getElementById(element_name);
   svgstyle = svgobj.getStyle();
   if (!checkbox.checked)
   { // Hide layer.
      svgstyle.setProperty('display', 'none');
   }
   else
   { // SHow layer.
      svgstyle.setProperty('display', 'inline');
   }
  // For all other elements set
  // its visibility to true/false according to position
   for (var i = 0;  i < element_name;  i++)
    { svgobj = svgdoc.getElementById(i);
      svgstyle = svgobj.getStyle();
      svgstyle.setProperty('display', 'none');
      document.hilite_form.elements[i].checked = false;  }
   for (var i = element_name+1;  i < document.hilite_form.elements.length;  i++)
    { svgobj = svgdoc.getElementById(i);
      svgstyle = svgobj.getStyle();
      svgstyle.setProperty('display', 'inline');
      document.hilite_form.elements[i].checked = true;   }
}
// -->
</SCRIPT>
 </HEAD>
<BODY bgcolor="darkgreen" text="yellow" link="#FFFFFF" vlink="#FFFF00" alink="#FFFF00">
 <center>
 <table><tr><td>
  <EMBED SRC="co.svg" NAME="network"
   HEIGHT="537.00" WIDTH="689.00"
   TYPE="image/svg-xml"
   PLUGINSPAGE="http://www.adobe.com/svg/viewer/install/">
 </td><td>
<FORM NAME="hilite_form">
 <TABLE BORDER="0" CELLPADDING="0" CELLSPACING="2" WIDTH="100%">
  <TR>
   <TD><INPUT TYPE="checkbox" VALUE="" ONCLICK="hilite_elem(this,0)">(...1.00]</TD></tr>
   <TD><INPUT TYPE="checkbox" VALUE="" ONCLICK="hilite_elem(this,1)">(1.00...2.00]</TD></tr>
   <TD><INPUT TYPE="checkbox" VALUE="" ONCLICK="hilite_elem(this,2)">(2.00...3.00]</TD></tr>
   <TD><INPUT TYPE="checkbox" VALUE="" ONCLICK="hilite_elem(this,3)">(3.00...4.00]</TD></tr>
   <TD><INPUT TYPE="checkbox" VALUE="" ONCLICK="hilite_elem(this,4)">(4.00...5.00]</TD></tr>
   <TD><INPUT TYPE="checkbox" VALUE="" ONCLICK="hilite_elem(this,5)">(5.00...6.00]</TD></tr>
   <TD><INPUT TYPE="checkbox" VALUE="" ONCLICK="hilite_elem(this,6)">(6.00...7.00]</TD></tr>
   <TD><INPUT TYPE="checkbox" VALUE="" ONCLICK="hilite_elem(this,7)">(7.00...8.00]</TD></tr>
   <TD><INPUT TYPE="checkbox" VALUE="" ONCLICK="hilite_elem(this,8)">(8.00...9.00]</TD></tr>
   <TD><INPUT TYPE="checkbox" VALUE="" ONCLICK="hilite_elem(this,9)">(20.00...21.00]</TD></tr>
   <TD><INPUT TYPE="checkbox" VALUE="" ONCLICK="hilite_elem(this,10)">(21.00...)</TD></tr>
 </TABLE>
 <SCRIPT><!--
  // Make sure all checkboxes are checked whenever the page
  // is reloaded in the browser.
    for (var i = 0;  i < document.hilite_form.elements.length;  i++)
      if (document.hilite_form.elements[i].type == 'checkbox')
        document.hilite_form.elements[i].checked = true;
  // -->
 </SCRIPT>
</FORM>
</td></tr>
 </table>
 </center>
</BODY>
</HTML>
