package body triobjet is 


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
	while i < tailleTableauSommet-1 loop
		
		zLu := tabS(i).z;
		if zLu > max then
			max := zLu;
		end if;
		
		if zLu < min then
			min := zLu;
		end if;
		
		i:=i+1;
		
	end loop;

end trouveMinMax;

-- Procedure permettant de trier les triangles d'un fichier OFF dans un tableau de liste selon leur coordonnée Z
procedure trierTriangle (tabDT : in out tableauDoubletTriangle; tabS : in tableauSommet; nbFace : in integer) is
	min, max : float;
	ptCourant : pointeurSurPointeurDT;
	c : float;
	i,indice : integer;
begin	
	trouveMinMax(tabS, min, max);
	i:=0;
	while i < nbFace loop
		ptCourant := new DoubletTriangle; 									--Nouvelle allocation en mémoire pour chaque double triangle
		creerDoubletTriangle (ptCourant, tabS); 							--Le ptCourant pointe sur un nouveau Doublet Triangle
		c := ptCourant.Objet.minZ; 		  									--On récupère le z minimum de la structure
		indice := Integer(Float'Floor(Float(nbFace)*((c-min)/(max-min))));  --On calcule l'indice ou placer le doublet triangle
		insererDoubletTriangle (ptCourant, indice, tabDT); 					--On place le doublet triangle dans le tableau au bon endroit
		i:=i+1;
	end loop;
end trierTriangle;

end triobjet;
