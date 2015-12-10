
package body modele is

--Procedure permettant d'inserer un DoubletTriangle dans le tableau
procedure insererDoubletTriangle (ptdoubleT : in out pointeurSurPointeurDT; indice : in integer; tableauDoubletT : in out tableauDoubletTriangle) is
	ptTemp : pointeurSurPointeurDT;
begin
	if tableauDoubletT(indice) = null then
		--~ insertion en tete de liste vide 
		tableauDoubletT(indice) := ptdoubleT;
	else
		--insertion en tete de liste non vide
		--On sauvegarde l'objet pointe par la tete de liste dans un pointeur temporaire
		ptTemp :=tableauDoubletT(indice);
		
		--On fait pointer la tete de liste sur le nouvel element
		tableauDoubletT(indice) := ptdoubleT;
		
		--On racroche la liste a la suie de l'element insere
		ptdoubleT.succ := ptTemp;
	end if;
end insererDoubletTriangle;





--Procedure permettant de désalouer tous les triangles du tableau
procedure desalouerTriangle ( tableauDoubletT : in tableauDoubletTriangle) is
	ptTemp1, ptTemp2 :pointeurSurPointeurDT;
begin
	
	for i in 0..(tableauDoubletT'LENGTH-1) loop
		ptTemp1 := tableauDoubletT(i);
		if (ptTemp1 /= null) then
			ptTemp2 := tableauDoubletT(i).Succ;
		end if;
		while (ptTemp1 /= null) loop
			
			
			FreeSommet(ptTemp1.Objet.s1);
			FreeSommet(ptTemp1.Objet.s2);
			FreeSommet(ptTemp1.Objet.s3);
			FreePSDT(ptTemp1);
			
			if ptTemp2 /= null then
				ptTemp1 := ptTemp2.Succ;
				
				FreeSommet(ptTemp2.Objet.s1);
				FreeSommet(ptTemp2.Objet.s2);
				FreeSommet(ptTemp2.Objet.s3);
				FreePSDT(ptTemp2);
			end if;
			if ptTemp1 /= null then 
				ptTemp2 := ptTemp1.Succ;
			end if;
			
		end loop;
	end loop;
end desalouerTriangle;


end modele;
