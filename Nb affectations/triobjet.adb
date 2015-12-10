package body triobjet is 	
--~ 
--~ nbPointeur : int;
--~ nbStruct : int;
nbAffectation : integer;

--Fonction permettant de renvoyer un doublet Triangle lu dans un fichier OFF
procedure creerDoubletTriangle ( ptDT : in out pointeurSurPointeurDT; tabS : in tableauSommet) is 
	ptTriangle : pointeurTriangle;
begin
	ptTriangle := new Triangle;
	ptTriangle.all := lectureoff.chargerTriangle(tabS);
	ptDT.Objet := ptTriangle.all;
	ptDT.Succ := NULL;
	FreeTriangle(ptTriangle);
	
end creerDoubletTriangle;

--Procedure permettant de trouver le minimum et le maximum de y dans un tableau de sommet
procedure trouveMinMax( tabS : in tableauSommet; min : out float; max : out float) is
	i, tailleTableauSommet : integer;
	zLu : float;
begin
	tailleTableauSommet := tabS'LENGTH;
	zLu := tabS(0).z ;
	min := zLu;
	max := zLu;
	
	i:=1;
	
	nbAffectation := nbAffectation +4;
	
	while i < tailleTableauSommet-1 loop
		
		zLu := tabS(i).z;
		if zLu > max then
			max := zLu;
			nbAffectation := nbAffectation +1;
		end if;
		
		if zLu < min then
			min := zLu;
			nbAffectation := nbAffectation +1;
		end if;
		
		i:=i+1;
		
		nbAffectation := nbAffectation +2;
	end loop;

end trouveMinMax;

-- Procedure permettant de trier les triangles d'un fichier OFF dans un tableau de liste selon leur coordonnée Z
procedure trierTriangle (tabDT : in out tableauDoubletTriangle; tabS : in tableauSommet; nbFace : in integer) is
	min, max : float;
	ptCourant : pointeurSurPointeurDT;
	c : float;
	i,indice : integer;
begin
	
	nbAffectation :=0;
	
	trouveMinMax(tabS, min, max);
	
	i:=0;
	nbAffectation := nbAffectation +1;
	while i < nbFace loop
		ptCourant := new DoubletTriangle; 									--Nouvelle allocation en mémoire pour chaque double triangle
		
		nbAffectation := nbAffectation +1;
		
		creerDoubletTriangle (ptCourant, tabS); 							--Le ptCourant pointe sur un nouveau Doublet Triangle
		
		c := ptCourant.Objet.minZ; 		  									--On récupère le z minimum de la structure
		
		nbAffectation := nbAffectation +1;
		
		indice := Integer(Float'Floor(Float(nbFace)*((c-min)/(max-min))));  --On calcule l'indice ou placer le doublet triangle
		
		nbAffectation := nbAffectation +1;
		
		insererDoubletTriangle (ptCourant, indice, tabDT); 					--On place le doublet triangle dans le tableau au bon endroit
		--~ dans le pire cas insererDoublet Triangle fait 3 affectations
		nbAffectation := nbAffectation +3;
		
		i:=i+1;
		
		nbAffectation := nbAffectation +1;
	end loop;
end trierTriangle;

procedure testPerformance (tabDT : in tableauDoubletTriangle) is
	i : integer;
	nbElements:float;
	compteur : float;
	ptCourant : pointeurSurPointeurDT;
begin
	
	i:=0;
	nbElements := 0.0;
	while i<tabDT'LENGTH loop
		compteur :=0.0;
		ptCourant := tabDT(i);
			while (ptCourant /= NULL) loop
				compteur:=compteur+1.0;
				ptCourant := ptCourant.Succ; 
			end loop;
			
		Ada.Text_Io.Put("La liste a l'indice " & Integer'Image(i) & " du tableau contient " & Float'Image(compteur) & " elements");
		Ada.Text_Io.New_Line;
		i:= i+1;
		nbElements:= nbElements + compteur;
	end loop;
	Ada.Text_Io.Put("Il y a eu " & Integer'Image(nbAffectation) &" affectations pendant le tris");
	Ada.Text_Io.New_Line;
	Ada.Text_Io.Put("Le tableau de liste a une longueur de " & Integer'Image(tabDT'LENGTH));
	Ada.Text_Io.New_Line;
	Ada.Text_Io.Put("Il y a en moyenne " & Float'Image(nbElements/Float(i)) & " elements par case ");
	Ada.Text_Io.New_Line;
	
end testPerformance;

end triobjet;
