<!DOCTYPE html>
<html>
    <head>

  <%
        Dim con,rec,R,rs,n,k,patient, medecaments,symptomes,la
        Set con=Server.createObject("Adodb.Connection")
        Set rec= Server.CreateObject("Adodb.recordset")
        con.open "SDN"
        R=Request.QueryString("r")
        P=Request.QueryString("i")
        'Response.write "rendV : "&R
        Set  rs = con.Execute("exec fichier "&R&"")
        Set  patient = con.Execute("select concat(nomPatient,' ',prenomPatient)as t from TPatient where idPatient ="&P&"")
        Set medecaments = con.Execute("exec fichier_2 "&R&"")
        Set symptomes = con.Execute("exec fichier_1 "&R&"")
        Set la = con.Execute("exec fichier_3 "&R&"")

   %>

    <meta charset="UTF-8">
	<link rel="stylesheet" href="/css/style2.css">
        <style>
            .ordonnance{
                margin: auto;
                height: 90%;
                width: 85%;
				margin-top :7%;
            }
            #ordonnanceTable{
                margin: auto;
                height: 100%;
                width: 100%;
                border: 4px solid #0b1b68;
               
            }
            #ordonnanceTable th{
               background-color: #0b1b68;
               color: white;
                
            }
            #ordonnanceTable tr td{
                max-width: 33%;
            }
            hr{
                border-radius: 10%;
                width: 100%;
                margin: auto;
            }
            .signature{
                max-width: 90px;
                max-height: 60px;
                padding-left: 45%;
            }
            #ordonnanceTable tr td label{
                text-align: center;
                font-weight: bold;
                padding-left: 12%;
            } 
            #ordonnanceTable tr td h4{
                text-align: center;
            }
            #ordonnanceTable tr td p{
                text-align: center;
            }
            .cachet{
                max-width: 270px;
                max-height: 130px;
            }
            
        </style>
    </head>
    <body>
		<header class="header">
		<h2>Ordonnance Medecale : <span>Mes Ordonnances</span> </h2>
	</header>
        <div class="ordonnance">
            <table id="ordonnanceTable">
                <th colspan="3"><h3>Ordonnance Médecale</h3></th>
               
                <tr>
                    <td>
                    <h4>Le Medecin :</h4>
                    <%
                    
                       Response.write("<p>"& rs(0)  &"</p>")
                    
                    %>
                    </td>
                    <td><h4>Le Patient :</h4>
                    <%
                    
                       Response.write("<p>"&patient(0) &" </p>")
                    
                    %>
                    </td>
                    <td>
                    <h4>Date :</h4>
                    <%
                    
                       Response.write("<p>"& rs(1)&"</p>")
                    
                    %>
                    </td>
                </tr>
                <tr>
                    <td colspan="3"><hr color="#0b1b68" size="8px"><br></td>
                </tr>
                <tr>
                    <td><label>Description Ordonnance :</label></td>
                    <td><label>Symptomes de Consultation :</label></td>
                    <td><label>Dignostic de Consultation :</label></td>
                </tr>
                <tr>
                    <td rowspan="3">
                     <%
                    
                       Response.write("<p>"& rs(3)&"</p>")
                    
                    %>
                    
                    </td>
                    <td><ul>
                    <%
                        Do Until symptomes.EOF
                        For i = 0 To 0
                        Response.write("<li>"  & symptomes(i) & "</li>" ) 
                        Next
                        symptomes.MoveNext
                        Loop 
                        %>
                    </ul></td>
                    <td><ul>
                    
                     <%
                    
                       Response.write("<li>"& rs(4)&"</li>")
                    
                    %>
                    
                    
                    </ul></td>
                </tr>
                <tr>
                    <td><label>maladie diagnostiquée :</label></td>
                    <td><label>Médicaments recommandés :</label></td>
                </tr>
                <tr>
                    <td><ul>
                    
                      <%
                        Response.write("<li>"  & la(0) & "</li>" ) 
                       %>
                    </ul></td>
                    <td><ul>
                     <%
                        Do Until medecaments.EOF
                        Response.write("<li>")
                        For each x in medecaments.fields
                        Response.write(""  & x.value & "" ) 
                        Next
                         Response.write("</li>")
                         medecaments.MoveNext
                        Loop 
                        %>
                </ul></td>
                </tr>
            </tr>
            <tr>
                <td colspan="3"><hr color="#0b1b68" size="8px"><br></td>
            </tr>
            <tr>
                <td align="center"><img src="/images/logo.png"></td>
                <td ><img class="cachet" src="/images/cachet.png"></td>
                <td><h4>Signature : </h4><img class="signature" src="/images/signature.png"></td>
            </tr>

            </table>
        </div>
    </body>
</html>