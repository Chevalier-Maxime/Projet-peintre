
package body modelemachinesequentiel1 is

	--sequence : tableauDoubletTriangle;
	N, pointeur:integer;
	ptCourant : pointeurSurPointeurDT;

	procedure Init(taille : in integer) is
	begin
		N:=taille;
		--
			Ada.Text_Io.Put("N :"&Integer'Image(N));
			Ada.Text_Io.New_Line;
		--
	end Init;

	procedure Demarrer(sequence : in tableauDoubletTriangle) is
	begin
		pointeur:=0;
		ptCourant := sequence(pointeur);

	end Demarrer;

	function elementCourant return Triangle is
	begin
		--
			Ada.Text_Io.Put("Pointeur Element courant :"&Integer'Image(pointeur));
			Ada.Text_Io.New_Line;
		--
		return ptCourant.Objet;
	end elementCourant;
		
	function finDeSequence return boolean is
	begin
			--
			Ada.Text_Io.Put("Fin de sequence :"&Boolean'Image(pointeur=N));
			Ada.Text_Io.New_Line;
			--
		return pointeur=N;
	end finDeSequence;
	
	
	
	procedure Avancer(sequence :in tableauDoubletTriangle) is
	begin
		 
		ptCourant := ptCourant.Succ;

		if (ptCourant = null) then
			pointeur:=pointeur+1;

			while (sequence(pointeur)=null) and (sequence(pointeur).Objet.s1=null) and not(finDeSequence) loop
				pointeur:=pointeur+1;
			end loop;
			ptCourant:=sequence(pointeur);
		end if;
		--
			Ada.Text_Io.Put("Pointeur après avancer:"&Integer'Image(pointeur));
			Ada.Text_Io.New_Line;
		--
	end Avancer;

end modelemachinesequentiel1;






