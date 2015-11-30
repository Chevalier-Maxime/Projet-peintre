
package body modele is

--Procedure permettant d'inserer un DoubletTriangle dans le tableau
procedure insererDoubletTriangle (doubleT : in out DoubletTriangle; indice : in integer; tableauDoubletT : in out tableauDoubletTriangle) is
	ptTemp : pointeurSurPointeurDT;
begin
		--
			Ada.Text_Io.Put("Indice : "& Integer'Image(indice) );
			Ada.Text_Io.New_Line;
		--
		--
			Ada.Text_Io.Put("NULL? : "& Boolean'Image(tableauDoubletT(indice) = null ) );
			Ada.Text_Io.New_Line;
		--

	if tableauDoubletT(indice) = null then

		tableauDoubletT(indice).all := doubleT;
	else
		--
			Ada.Text_Io.Put("Sucesseur" );
			Ada.Text_Io.New_Line;
		--
		--insertion en tete de liste non vide
		--On sauvegarde l'objet pointe par la tete de liste dans un pointeur temporaire
		ptTemp :=tableauDoubletT(indice);
		
		--On fait pointer la tete de liste sur le nouvel element
		tableauDoubletT(indice).all := doubleT;
		
		--On racroche la liste a la suie de l'element insere
		doubleT.succ := ptTemp;
		
		--#TODO Faut-il alouer le ptTemp ? et donc le liberer a la fin ?
		
	end if;

end insererDoubletTriangle;




--Procedure permettant de désalouer tous les triangles du tableau
procedure desalouerTriangle ( tableauDoubletT : in tableauDoubletTriangle) is
	ptTemp1, ptTemp2 :pointeurSurPointeurDT;
begin
	
	for i in 0..(tableauDoubletT'LENGTH-1) loop
		ptTemp1 := tableauDoubletT(i);
		ptTemp2 := tableauDoubletT(i).Succ;
		while (ptTemp1 /= null) loop
			FreePSDT(ptTemp1);
			
			if ptTemp2 /= null then
				ptTemp1 := ptTemp2.Succ;
				FreePSDT(ptTemp2);
			end if;
			if ptTemp1 /= null then 
				ptTemp2 := ptTemp1.Succ;
			end if;
			
		end loop;
	end loop;
end desalouerTriangle;

end modele;
