with LCA;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Strings.Unbounded;     use Ada.Strings.Unbounded;
with  Ada.Text_IO.Unbounded_IO; use  Ada.Text_IO.Unbounded_IO;


procedure lca_sujet is
    
    package SDA is new LCA(T_Cle => Unbounded_String, T_Donnee => Integer);
    use SDA;


    procedure Affiche_couple(Cle: in Unbounded_String; Donnee: in Integer) is
    begin
        Put(Cle);
        Put(" : ");
        Put(Donnee, 1);
        New_Line;
    end Affiche_couple;

    procedure Affiche_LCA is new Pour_Chaque(Traiter => Affiche_couple);

    Ma_LCA : T_LCA;
begin
    Initialiser(Ma_LCA);
    Enregistrer(Ma_LCA, To_Unbounded_String("un"), 1);
    Enregistrer(Ma_LCA, To_Unbounded_String("deux"), 2);
    Affiche_LCA(Ma_LCA);
end lca_sujet;
