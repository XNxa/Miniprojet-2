-- Définition de structures de données associatives sous la forme d'une table de hachage.
with LCA;

generic
    Taille_TH : Integer;
	type T_Cle is private;
    type T_Donnee is private;
    with function fonction_hachage(Cle : T_Cle) return Integer;

package TH is

    type T_TH is limited private;

    -- Initialiser une Sda.  La Sda est vide.
	procedure Initialiser(Sda: out T_TH) with
		Post => Est_Vide (Sda);


	-- Est-ce qu'une Sda est vide ?
	function Est_Vide (Sda : T_TH) return Boolean;


	-- Obtenir le nombre d'�l�ments d'une Sda. 
	function Taille (Sda : in T_TH) return Integer with
		Post => Taille'Result >= 0
			and (Taille'Result = 0) = Est_Vide (Sda);


	-- Enregistrer une Donn�e associ�e � une Cl� dans une Sda.
	-- Si la cl� est d�j� pr�sente dans la Sda, sa donn�e est chang�e.
	procedure Enregistrer (Sda : in out T_TH ; Cle : in T_Cle ; Donnee : in T_Donnee) with
		Post => Cle_Presente (Sda, Cle) and (La_Donnee (Sda, Cle) = Donnee)   -- donn�e ins�r�e
				and (not (Cle_Presente (Sda, Cle)'Old) or Taille (Sda) = Taille (Sda)'Old)
				and (Cle_Presente (Sda, Cle)'Old or Taille (Sda) = Taille (Sda)'Old + 1);

	-- Supprimer la Donn�e associ�e � une Cl� dans une Sda.
	-- Exception : Cle_Absente_Exception si Cl� n'est pas utilis�e dans la Sda
	procedure Supprimer (Sda : in out T_TH ; Cle : in T_Cle) with
		Post =>  Taille (Sda) = Taille (Sda)'Old - 1 -- un �l�ment de moins
			and not Cle_Presente (Sda, Cle);         -- la cl� a �t� supprim�e


	-- Savoir si une Cl� est pr�sente dans une Sda.
	function Cle_Presente (Sda : in T_TH ; Cle : in T_Cle) return Boolean;


	-- Obtenir la donn�e associ�e � une Cle dans la Sda.
	-- Exception : Cle_Absente_Exception si Cl� n'est pas utilis�e dans l'Sda
	function La_Donnee (Sda : in T_TH ; Cle : in T_Cle) return T_Donnee;	

	-- Supprimer tous les �l�ments d'une Sda.
	procedure Vider (Sda : in out T_TH) with
		Post => Est_Vide (Sda);


	-- Appliquer un traitement (Traiter) pour chaque couple d'une Sda.
	generic
		with procedure Traiter (Cle : in T_Cle; Donnee: in T_Donnee);
	procedure Pour_Chaque (Sda : in T_TH);


private

	package ma_T_LCA is new LCA(T_Cle => T_Cle, T_Donnee => T_Donnee);
	use ma_T_LCA;

    type T_TH is array(1..Taille_TH) of T_LCA;


end TH;