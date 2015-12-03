With modele;Use modele;
with ecritureps; use ecritureps;

With Ada.Command_Line;
Use Ada.Command_Line;
With Ada.Text_IO;
Use Ada.Text_IO;	

procedure test is
	tri : Triangle;
	s1,s2,s3: Sommet;
	pointeur1,pointeur2,pointeur3 : pointeurSommet;
begin
		s1:=(0.0,0.0,0.0);
		s2:=(520.0,0.0,50.0);
		s3:=(50.0,840.0,0.0);
		pointeur1 := new Sommet;
		pointeur2 := new Sommet;
		pointeur3 := new Sommet;
		pointeur1.all := s1;
		pointeur2.all := s2;
		pointeur3.all := s3;
		tri := (pointeur1,pointeur2,pointeur3,0.0);		
		--
		Ada.Text_Io.Put("Test Ecriture");
		Ada.Text_Io.New_Line;
		--
		creerFichier("TespPlop");
		ajouterUnTriangle(tri);
		fermerFichier;
	
end test;
