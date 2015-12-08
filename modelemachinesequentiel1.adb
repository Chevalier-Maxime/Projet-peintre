
package body modelemachinesequentiel1 is

	N, pointeurTete:integer;
	ptCourant : pointeurSurPointeurDT;

	--*************************************************************************************
	--Initialisation de la taille maximale de la séquence
	--*************************************************************************************
	procedure Init(taille : in integer) is
	begin
	
		N:=taille;
			
	end Init;

	--*************************************************************************************
	--DEMARRER
	--*************************************************************************************
	procedure Demarrer(sequence : in tableauDoubletTriangle) is
	begin
		pointeurTete:=0;
		while not finDeSequence and then sequence(pointeurTete)=Null loop
			pointeurTete := pointeurTete+1;
		end loop;
		ptCourant := sequence(pointeurTete);
	end Demarrer;

	--*************************************************************************************
	--ELEMENTCOURANT
	--*************************************************************************************
	function elementCourant return Triangle is
		begin		
		return ptCourant.Objet;
	end elementCourant;
		
	--*************************************************************************************
	--FINDESEQUENCE
	--*************************************************************************************
	function finDeSequence return boolean is
		begin
		return pointeurTete=N;
	end finDeSequence;
	
	
	--*************************************************************************************
	--AVANCER
	--*************************************************************************************
	procedure Avancer(sequence :in tableauDoubletTriangle) is
		begin
		ptCourant := ptCourant.Succ;
		if (ptCourant= null) then
			pointeurTete := pointeurTete+1;
			while not(finDeSequence) and then sequence(pointeurTete)=null loop
				pointeurTete := pointeurTete+1;
			end loop;
			if not(finDeSequence) then
				ptCourant := sequence(pointeurTete);
			end if;
		end if;
	end Avancer;

end modelemachinesequentiel1;






