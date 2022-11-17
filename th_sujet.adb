with TH;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Strings.Unbounded;     use Ada.Strings.Unbounded;
with Ada.Text_IO.Unbounded_IO; use  Ada.Text_IO.Unbounded_IO;

procedure th_sujet is
    
    function hachage(cle : Unbounded_String) return Integer is
    begin 
        return Length(cle);
    end hachage;

    package SDA is new TH(Taille_TH => 11, T_Cle => Unbounded_String, T_Donnee => Integer, fonction_hachage=>hachage);
    use SDA;

    procedure Affiche_couple(Cle: in Unbounded_String; Donnee: in Integer) is
    begin
        Put(Cle);
        Put(" : ");
        Put(Donnee, 1);
        New_Line;
    end Affiche_couple;

    procedure Afficher_TH is new Pour_Chaque(Traiter => Affiche_couple);

    Ma_TH : T_TH;
begin
    Initialiser(Ma_TH);
    Enregistrer(Ma_TH, To_Unbounded_String("un"), 1);
    Enregistrer(Ma_TH, To_Unbounded_String("deux"), 2);
    Enregistrer(Ma_TH, To_Unbounded_String("trois"), 3);
    Enregistrer(Ma_TH, To_Unbounded_String("quatre"), 4);
    Enregistrer(Ma_TH, To_Unbounded_String("cinq"), 5);
    Enregistrer(Ma_TH, To_Unbounded_String("quatre-vingt-dix-neuf"), 99);
    Enregistrer(Ma_TH, To_Unbounded_String("vingt-et-un"), 21);
    Afficher_TH(Ma_TH);
end th_sujet;