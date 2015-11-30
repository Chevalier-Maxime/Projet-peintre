

package body triobjet is 


--Fonction permettant de renvoyer un doublet Triangle lu dans un fichier
procedure creerDoubletTriangle ( ptDT : in out pointeurListeDoubletT; tabS : in tableauSommet) is 
	ptTriangle : pointeurTriangle;
begin
	ptTriangle := new Triangle;
	ptTriangle.all := lectureoff.chargerTriangle(tabS);
	ptDT.Objet := ptTriangle.all; --Je pense qu'il faut pas faire ca, mais changer la structure doubletTriangle en metant un pointeur sur triangle ?
	ptDT.Succ := NULL;
	
	FreeTriangle(ptTriangle); --#TODO a verifier
	
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

-- Procedure permettant de trier les triangles
procedure trierTriangle (tabDT : in out tableauDoubletTriangle; tabS : in tableauSommet; nbFace : in integer) is
	min, max : float;
	ptCourant : pointeurListeDoubletT;
	c : float;
	i,indice : integer;
begin

	
	trouveMinMax(tabS, min, max);

	
	i:=0;
	while i < nbFace loop
			--
			Ada.Text_Io.Put("Ajout triangle : "& Integer'Image(i) );
			Ada.Text_Io.New_Line;
			--
		ptCourant := new DoubletTriangle; --Nouvelle allocation en mémoire pour chaque double triangle ------------------------------------#TODO
		creerDoubletTriangle (ptCourant, tabS); --Le ptCourant pointe sur un nouveau Doublet Triangle
		c := ptCourant.Objet.minZ; 		  --On récupère le z minimum de la structure
		
		
		
		indice := Integer(Float'Floor(Float(nbFace)*((c-min)/(max-min)))); --On calcule l'indice ou placer le doublet triangle

		insererDoubletTriangle (ptCourant.all, indice, tabDT); --On place le doublet triangle dans le tableau au bon endroit
		i:=i+1;
	end loop;
end trierTriangle;



end triobjet;
