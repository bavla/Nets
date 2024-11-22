<HTML>
 <HEAD>
  <TITLE>2. Deleted loops in N1 (44)</TITLE>
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
}
// -->
</SCRIPT>
 </HEAD>
<BODY bgcolor="darkgreen" text="yellow" link="#FFFFFF" vlink="#FFFF00" alink="#FFFF00">
 <center>
 <table><tr><td>
  <EMBED SRC="island.svg" NAME="network"
   HEIGHT="537.00" WIDTH="689.00"
   TYPE="image/svg-xml"
   PLUGINSPAGE="http://www.adobe.com/svg/viewer/install/">
 </td><td>
<FORM NAME="hilite_form">
 <TABLE BORDER="0" CELLPADDING="0" CELLSPACING="2" WIDTH="100%">
  <TR>
   <TD><INPUT TYPE="checkbox" VALUE="" ONCLICK="hilite_elem(this,0)">Lines among clusters</TD></tr>
   <TD><INPUT TYPE="checkbox" VALUE="" ONCLICK="hilite_elem(this,1)">Cluster 0</TD></tr>
   <TD><INPUT TYPE="checkbox" VALUE="" ONCLICK="hilite_elem(this,2)">Cluster 1</TD></tr>
   <TD><INPUT TYPE="checkbox" VALUE="" ONCLICK="hilite_elem(this,3)">Cluster 2</TD></tr>
   <TD><INPUT TYPE="checkbox" VALUE="" ONCLICK="hilite_elem(this,4)">Cluster 3</TD></tr>
   <TD><INPUT TYPE="checkbox" VALUE="" ONCLICK="hilite_elem(this,5)">Cluster 4</TD></tr>
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
