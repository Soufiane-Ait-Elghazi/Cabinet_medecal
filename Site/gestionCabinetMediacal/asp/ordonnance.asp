<%
Option Explicit
Dim con,rec,i,n,nomPatient,idPatient,date,idM,nomDiagnostic,idDiagnostic,idMaladie,nomMaladie,description,prix,a,l,idRDV,idOrd,c,m
Set con=Server.createObject("Adodb.Connection")
Set rec= Server.CreateObject("Adodb.recordset")
  con.open "SDN"
n = Request.Form("symptome").Count 
For i = 1 to Request.Form("symptome").Count 
    Request.Form("symptome")(i)
Next

For i = 1 to Request.Form("medecament").Count 
    Request.Form("medecament")(i)
Next
description=Request.Form("description")
nomPatient=Request.Form("idPatient")
'nomDiagnostic=Request.Form("diagnostic")
'response.write(Request.Form("diagnostic"))
nomMaladie=Request.Form("maladie")
prix=Request.Form("prix")

idM = Request.Form("idM")
Set idPatient= con.Execute("select idPatient from TPatient where concat(nomPatient,' ',prenomPatient) like '"&nomPatient&"'")
'Set idDiagnostic= con.Execute("select idDiagnostic from TDiagnostic where nomDiagnostic like '"&nomDiagnostic&"'")
Set idDiagnostic=Request.Form("diagnostic")
Set idMaladie= con.Execute("select idMaladie from TMaladie where nomMaladie like '"&nomMaladie&"'")
set date = con.execute("SELECT CAST( GETDATE() AS Date ) ;")
Set idRDV= con.Execute("select idRendezVous from TRendezVous where  idPatient ='"&idPatient(0)&"' and idMedecin ='"&idM&"'and dateRendezVous like '"&date(0)&"'")
 'Response.write(idRDV(0))
  'Response.write(idPatient(0))
 ' Response.write(nomPatient)
  'Response.write(date(0))
  'Response.write(idM)
  'Response.write(idDiagnostic(0))
  'Response.write(idMaladie(0))
  'Response.write(Request.Form("medecament"))
  'Response.write(description)
  ' Response.write(prix)
   a=Request.Form("symptome")
   'Response.write(a)
   ' Response.Redirect "fichier.asp?symptome="&a&"&idM="&idM&"&idPatient="&idPatient&"&idDiagnostic="&idDiagnostic&"&idMaladie="&idMaladie&"&description='"&description&"'&prix="&prix
   ' Response.Redirect "fichier.asp?symptome="&a&"&idM="&idM&"&idPatient="&idPatient(0)&"&idDiagnostic="&idDiagnostic(0)&"&idMaladie="&idMaladie(0)&"&description="&description&"&prix="&prix
	'Response.write(idDiagnostic(0))
    'Response.write(c)
    
    
    For i = 1 to Request.Form("symptome").Count 
       l = Request.Form("symptome")(i)
        'Response.write(Request.Form("symptome")(i))
        'Response.write(c)
		'Response.write("hello_1")
      con.execute("exec Medecin_ajouter_description '"& description &"'")
	  set idOrd = con.execute("SELECT CAST((select MAX(TOrdonnance.idOrdonnance) from TOrdonnance ) AS INT) ;")
	  c = idOrd(0)
	  'Response.write(c)
	   con.execute("exec Medecin_RemplirOrdnnce '"&idRDV(0)&"','"&idDiagnostic&"','"&l&"','"&prix&"','"&c&"'")
      'con.execute("exec Medecin_RemplirOrdnnce '"&idRDV(0)&"','"&idDiagnostic(0)&"','"&l&"','"&prix&"','"&c&"'")
  
    Next
    For i = 1 to Request.Form("medecament").Count 
      m = Request.Form("medecament")(i)
      'Response.write(m)
      con.execute("exec Medecin_remplir_TContenir '"& m &"'")
    Next

    
  

%>