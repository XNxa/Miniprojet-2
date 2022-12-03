with Ada.Text_IO;            use Ada.Text_IO;
with SDA_Exceptions;         use SDA_Exceptions;
with Ada.Unchecked_Deallocation;

package body LCA is

	procedure Free is
		new Ada.Unchecked_Deallocation (Object => T_Cellule, Name => T_LCA);


	procedure Initialiser(Sda: out T_LCA) is
	begin
		Sda := null;
	end Initialiser;


	function Est_Vide (Sda : T_LCA) return Boolean is
	begin
		return (Sda = null);
	end;


	function Taille (Sda : in T_LCA) return Integer is
		compteur : Integer := 0;
		Pointeur : T_LCA := Sda; -- Pointeur sur les différentes cellules de la Lca pour les parcourir
	begin
		while Pointeur /= null loop
			compteur := compteur +1;
			Pointeur := Pointeur.All.Suivant;
		end loop;
		return compteur;
	end Taille;


	procedure Enregistrer (Sda : in out T_LCA ; Cle : in T_Cle ; Donnee : in T_Donnee) is
		Pointeur : T_LCA := Sda; -- Permet de parcourir la lca 
	begin
		while Pointeur /= null and then Pointeur.all.Cle /= Cle loop
			Pointeur := Pointeur.All.Suivant;
		end loop;
		if Pointeur = null then
			Sda := New T_Cellule'(Cle, Donnee, Sda);
		else
			Pointeur.All.Donnee := Donnee;
		end if;
	 	
	end Enregistrer;


	function Cle_Presente (Sda : in T_LCA ; Cle : in T_Cle) return Boolean is
		Pointeur : T_LCA := Sda;
	begin
		while Pointeur /= null and then Pointeur.all.Cle /= Cle loop
			Pointeur := Pointeur.All.Suivant;
		end loop;
				
		return (Pointeur /= null); -- Si on arrive à la fin de la boucle alors la clé est absente.
	end Cle_Presente;

	function La_Donnee (Sda : in T_LCA ; Cle : in T_Cle) return T_Donnee is
		Pointeur : T_LCA := Sda;
		Donnee : T_Donnee;
	begin
		while Pointeur /= null and then Pointeur.all.Cle /= Cle loop
			Pointeur := Pointeur.All.Suivant;
		end loop;
		if Pointeur = null then 
			raise Cle_Absente_Exception;
		else
			Donnee := Pointeur.All.Donnee;
		end if;
		return Donnee;		
	end La_Donnee;


	procedure Supprimer (Sda : in out T_LCA ; Cle : in T_Cle) is
		A_Detruire : T_LCA; -- Variable temporaire pour Free la cellule sans provoquer de fuite mémoire
	begin
		if Sda /= Null then
			if Sda.All.Cle /= Cle then
				Supprimer(Sda.all.Suivant, Cle);
			else
				A_Detruire := Sda;
				Sda := Sda.All.Suivant;
				Free(A_Detruire);
			end if;
		else
			raise Cle_Absente_Exception;
		end if;
	end Supprimer;


	procedure Vider (Sda : in out T_LCA) is
		A_Detruire : T_LCA; -- Variable temporaire pour Free la cellule sans provoquer de fuite mémoire
	begin
		while not Est_Vide(Sda) loop
			A_Detruire := Sda;
			Sda := Sda.All.Suivant;
			Free(A_Detruire);
		end loop;
	end Vider;


	procedure Pour_Chaque (Sda : in T_LCA) is
		Pointeur : T_LCA := Sda;
	begin
		while Pointeur /= null loop
		begin
			Traiter(Pointeur.All.Cle, Pointeur.All.Donnee);
			Pointeur := Pointeur.All.suivant ;
			
			-- Si la procédure Traiter lève une exception on la traite et on continue le Pour_Chaque
			exception		
				when others => 
					Pointeur := Pointeur.All.Suivant;
		end;		
		end loop;
	end Pour_Chaque;


end LCA;
