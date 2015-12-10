With modele;Use modele;
with triobjet;use triobjet;
with lectureoff; use lectureoff;
with ecritureps; use ecritureps;
with Ada.Real_Time; use Ada.Real_Time; -- POUR CALCULER LE TEMPS D'EXECUTION DU TRI

With Ada.Command_Line;
Use Ada.Command_Line;
With Ada.Text_IO;
Use Ada.Text_IO;	

procedure main is
	nbSommet, nbFace : integer;
	Temps1, Temps2: Ada.Real_Time.Time;
	Duree: Ada.Real_Time.Time_Span;
	nbTpsm: long_integer;
	
begin
	if (Argument_Count /= 2) then
		Ada.Text_Io.Put(" le programme s'utilise de la manière suivant : main nomfichierOFF nomfichierPS");
	else
		ouvrir(Argument(1));
		nbSommet := 0;
		nbFace :=0;
		chargerNbSommetsNbFaces(nbSommet, nbFace);
		
		--~  On doit maintenant declarer le tableau de la bonne taille
		declare
			tabSommet : tableauSommet(0..nbSommet);
			tabDT : tableauDoubletTriangle(0..nbFace);
			numeroSommetCourant,i : integer;
		begin
			
			i :=0;
			while i <= nbFace loop
				tabDT(i) := Null;
				i:=i+1;
			end loop;
			
			--~ On remplis de tableau de sommet en les lisants au fur et à mesure
			numeroSommetCourant :=0;
			while numeroSommetCourant < nbSommet loop
				--demander de lire les sommets
				tabSommet(numeroSommetCourant) := chargerSommet(nbSommet, numeroSommetCourant);
				numeroSommetCourant:= numeroSommetCourant+1;
			end loop;
			
			Temps1 := Ada.Real_Time.Clock;
			
			trierTriangle (tabDT, tabSommet, nbFace);
			
			Temps2 := Ada.Real_Time.Clock;
			Duree := Temps2 - Temps1;
			
			nbTpsm := Long_Integer(Duree / Milliseconds(1));
			Ada.Text_Io.Put("Le tris a pris " & Integer'Image(Duree / Milliseconds(1)) & " ms a s'executer. Cependant, il faut prendre en compte la lecture dans le fichier à chaque triangle");
			
			--On va maintenant ecrire des les résultats dans un fichier ps
			creerFichier(Argument(2));
			ecrire(tabDT);
			fermerFichier;

			--On désaloue la mémoire utilisé
			desalouerTriangle(tabDT);

		end;
		
	end if;
end main;
