With modele;Use modele;
with triobjet;use triobjet;
with lectureoff; use lectureoff;
with ecritureps; use ecritureps;

With Ada.Command_Line;
Use Ada.Command_Line;
With Ada.Text_IO;
Use Ada.Text_IO;	

procedure main is
	nbSommet, nbFace : integer;
	
	procedure fonctionTest(tabDT : in tableauDoubletTriangle; taille : in integer) is
		ptCourant : pointeurSurPointeurDT;
		i : integer;
	begin
		i:=0;
		while i <= taille loop
			
			Ada.Text_Io.Put( "i: " & Integer'Image(i));
			Ada.Text_Io.New_Line;
			
			ptCourant := tabDT(i);
			while (ptCourant /= NULL) and then (ptCourant.Objet.s1 /= NULL) loop
				Ada.Text_Io.Put(" Triangle");
				Ada.Text_Io.New_Line;
				Ada.Text_Io.Put( "x: " & Float'Image(ptCourant.Objet.s1.x) & " y: " & Float'Image(ptCourant.Objet.s1.y) & " z: " & Float'Image(ptCourant.Objet.s1.z));
				Ada.Text_Io.New_Line;
				Ada.Text_Io.Put( "x: " & Float'Image(ptCourant.Objet.s2.x) & " y: " & Float'Image(ptCourant.Objet.s2.y) & " z: " & Float'Image(ptCourant.Objet.s2.z));
				Ada.Text_Io.New_Line;
				Ada.Text_Io.Put( "x: " & Float'Image(ptCourant.Objet.s3.x) & " y: " & Float'Image(ptCourant.Objet.s3.y) & " z: " & Float'Image(ptCourant.Objet.s3.z));
				Ada.Text_Io.New_Line;
				
				ptCourant := ptCourant.Succ; --comprend pas
			end loop;
			
			i:=i+1;
		end loop;
	end fonctionTest;
	
begin
	if (Argument_Count /= 2) then
		Ada.Text_Io.Put(" le programme s'utilise de la manière suivant : main nomfichierOFF nomfichierPS");
	else
		ouvrir(Argument(1));
		--
		Ada.Text_Io.Put("On a ouvert le fichier");
		Ada.Text_Io.New_Line;
		--
		nbSommet := 0;
		nbFace :=0;
		chargerNbSommetsNbFaces(nbSommet, nbFace);
		--
		Ada.Text_Io.Put("On a charge nbSommet et nbFace" & Integer'Image(nbSommet) & " " & Integer'Image(nbFace));
		Ada.Text_Io.New_Line;
		--
		
		declare
			tabSommet : tableauSommet(0..nbSommet);
			tabDT : tableauDoubletTriangle(0..nbFace);
			numeroSommetCourant,i : integer;
		begin
			
			i :=0;
			while i <= nbFace loop
				tabDT(i) := new DoubletTriangle;
				i:=i+1;
			end loop;
			
			numeroSommetCourant :=0;
			--
			Ada.Text_Io.Put("On entre dans la boucle");
			Ada.Text_Io.New_Line;
			--
			while numeroSommetCourant < nbSommet loop
				
				--demander de lire les sommets
				tabSommet(numeroSommetCourant) := chargerSommet(nbSommet, numeroSommetCourant);
				
				--
				Ada.Text_Io.Put("On a insere un sommet dans le tableau");
				Ada.Text_Io.New_Line;
				--
				
				numeroSommetCourant:= numeroSommetCourant+1;
			end loop;
			
			--
			Ada.Text_Io.Put("On est sorti de la boucle");
			Ada.Text_Io.New_Line;
			--
			
			trierTriangle (tabDT, tabSommet, nbFace);
			
			fonctionTest(tabDT, nbFace);
			

			--
			Ada.Text_Io.Put("On écrit le fichier");
			Ada.Text_Io.New_Line;
			--
			creerFichier(Argument(2));
			ecritureDesTriangles(tabDT);
			fermerFichier;

			--ecrire(tabDT, Argument(2));
			desalouerTriangle(tabDT);

		end;
		
	end if;
end main;
