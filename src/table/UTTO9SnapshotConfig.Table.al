table 67027 UTTO9SnapshotConfig
{
    Caption = 'O9 Snapshot Configuration', Comment = 'DEU=O9-Snapshot-Konfiguration,DEA=O9-Snapshot-Konfiguration';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code', Comment = 'DEU=Code,DEA=Code';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                SalesSetup: Record "Sales & Receivables Setup";
                NoSeriesMgt: Codeunit NoSeriesManagement;
            begin
                // if Code <> xRec.Code then begin
                //     SalesSetup.Get();
                //     NoSeriesMgt.TestManual(SalesSetup."SIV Snapshot Config. Nos.");
                //     NoSeriesCode := '';
            end;

        }
        field(2; Description; Text[100])
        {
            Caption = 'Description', Comment = 'DEU=Beschreibung,DEA=Beschreibung';
            DataClassification = CustomerContent;
        }
        field(3; TurnoverPlanFilter; Code[20])
        {
            Caption = 'Turnover Plan Filter', Comment = 'DEU=Umsatzplan-Filter,DEA=Umsatzplan-Filter';
            DataClassification = CustomerContent;
            TableRelation = KVSTurnoverPlanName;
        }
        field(4; CurrencyCode; Code[20])
        {
            Caption = 'Currency Code', Comment = 'DEU=Währungscode,DEA=Währungscode';
            DataClassification = CustomerContent;
            TableRelation = Currency;
        }
        field(5; StartDate; Date)
        {
            Caption = 'Start Date', Comment = 'DEU=Startdatum,DEA=Startdatum';
            DataClassification = CustomerContent;
        }
        field(6; Active; Boolean)
        {
            Caption = 'Active', Comment = 'DEU=Aktiv,DEA=Aktiv';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
            // OtherConfig: Record UTTO9SnapshotConfig;
            begin
                // if Active then begin
                //     OtherConfig.SetRange(Active, true);
                //     OtherConfig.SetFilter(Code, '<>%1', Code);
                //     OtherConfig.ModifyAll(Active, false);
                // end;
            end;
        }
        field(7; NoSeriesCode; Code[20])
        {
            Caption = 'No. Series', Comment = 'DEU=Nummernserie,DEA=Nummernserie';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(8; EndDate; Date)
        {
            Caption = 'End Date', Comment = 'DEU=Enddatum,DEA=Enddatum';
            DataClassification = CustomerContent;
        }
        field(9; DateFormel; DateFormula)
        {
            Caption = 'Date Formel', Comment = 'DEU=Datumsformel,DEA=Datumsformel';
            DataClassification = CustomerContent;
        }
        field(10; XMLPortName; Text[50])
        {
            Caption = 'XML Port Name', Comment = 'DEU=XML-Port-Name,DEA=XML-Port-Name';
            DataClassification = CustomerContent;

            trigger OnLookup()
            var
                AllObjWithCaption: Record AllObjWithCaption;
            begin
                AllObjWithCaption.FilterGroup(2);
                AllObjWithCaption.SetRange("Object Type", AllObjWithCaption."Object Type"::XMLport);
                AllObjWithCaption.SetFilter("Object Name", '*O9*');
                AllObjWithCaption.FilterGroup(0);

                if PAGE.RunModal(PAGE::"Objects", AllObjWithCaption) = ACTION::LookupOK then
                    XMLPortName := AllObjWithCaption."Object Name";
            end;
        }
        field(11;KeepHistory; Boolean)
        {
            Caption = 'Keep History', Comment = 'DEU=Historie behalten,DEA=Historie behalten';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        SalesSetup: Record "Sales & Receivables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        // if Code = '' then begin
        //     SalesSetup.Get();
        //     SalesSetup.TestField("SIV Snapshot Config. Nos.");
        //     NoSeriesMgt.InitSeries(SalesSetup."SIV Snapshot Config. Nos.", xRec.NoSeriesCode, 0D, Code, NoSeriesCode);
        // end;
    end;
}
