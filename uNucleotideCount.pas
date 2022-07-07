unit uNucleotideCount;

interface

  uses
     SysUtils, System.Generics.Collections;

  type EInvalidNucleotideException = class(Exception);

  type TDNA = class
    constructor Create(const ASequence : string); overload;
    destructor Destroy; override;
  private
    FNucleotideCounts : TDictionary<char, integer>;
  public
    property NucleotideCounts : TDictionary<char, integer> read FNucleotideCounts;
  end;

implementation

  constructor TDNA.Create(const ASequence : string);
    var
      i : integer;
    begin
      inherited Create;
      self.FNucleotideCounts := TDictionary<char, integer>.Create;
      self.FNucleotideCounts.Add('A',0);
      self.FNucleotideCounts.Add('T',0);
      self.FNucleotideCounts.Add('C',0);
      self.FNucleotideCounts.Add('G',0);
      for i := Low(ASequence) to High(ASequence) do
        if FNucleotideCounts.ContainsKey(ASequence[i]) then
          FNucleotideCounts.Items[ASequence[i]] := FNucleotideCounts.Items[ASequence[i]] + 1
        else
          begin
            raise EInvalidNucleotideException.Create('Invalid nucleotide in strand');
          end;
    end;

  destructor TDNA.Destroy;
    begin
      self.FNucleotideCounts.Free;
      inherited;
    end;

end.
