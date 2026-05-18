table 67025 "UTT SalesBuffer" //50024
{
    Caption = 'Sales Buffer';
    //TableType = Temporary;
    DataClassification = CustomerContent;

    fields
    {
        field(1; User; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(2; "Artikelnr."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(3; Artikelkategorie; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(4; "Kostenträger"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(5; Debitor; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(6; Debitorengruppe; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(7; Warenart; Enum "KVSTEX Item Type")
        {
            Caption = 'Item Type', Comment = 'DEU = Warenart,ENU = Item Type,DEA = Warenart';
            DataClassification = CustomerContent;
        }
        field(8; Produktgruppe; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(9; Produktbuchungsgruppe; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(10; Lagerbuchungsgruppe; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(11; Land; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(12; "Verkäufercode"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(13; Beschreibung; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(14; Schussleistung; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(15; "Soll Menge"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(16; "Soll Verkaufsbetrag"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(17; "Soll Einstandsbetrag"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(18; "Ist Menge"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(19; "Ist Verkaufsbetrag"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(20; "Ist Einstandsbetrag"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(21; EntryNo; Integer)
        {

        }
        field(22; "Entry Date"; Date)
        {

        }
        field(23; "Customer Name"; Text[50])
        {

        }
        field(50000; "Cutset Lfm"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(50001; "Cutset FW"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(50002; "Ist Menge Meter"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(50003; "Ist Menge Stück"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(50004; "Ist Menge QM"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(50005; "Menge QM - M"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(50006; Gesamtmeter; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(50007; Einheit; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(50008; "Soll Menge Meter"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(50009; "Soll Menge Stück"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(50010; "Soll Menge QM"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(50011; "Soll Menge QM - M"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(50012; "Soll Cutset Lfm"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(50013; "Soll Cutset FW"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(50015; "Soll Gesamtmeter"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(50016; "IST Menge KG"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(50017; "Soll Menge KG"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(50018; "Forecast Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(50019; "Forecast Qty"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(50020; "Forecast STK"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(50021; "Forecast Meter"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(50022; "Forecast QM"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(50023; "Forecast KG"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(50024; "Forecast STK-M"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(50025; "Forecast QM-M"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(50026; "Forecast Gesamt meter"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(50027; "IST STK Meter"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(50028; "unit Price"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(50029; Parent; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(50030; "Composition Key Total"; Code[10])
        {
            Caption = 'Composition key total', Comment = 'DEU = Rohstoffschlüssel gesamt,DEA = Rohstoffschlüssel gesamt';
            Description = 'ktex';
            TableRelation = "KVSTEX Composition Key";
            DataClassification = CustomerContent;
        }
        field(50031; OriginGar; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(50032; "Garneinsatz KG IST"; Decimal)
        {
            DecimalPlaces = 2 : 2;
            DataClassification = CustomerContent;
        }
        field(50033; "Garneinsatz Kosten IST"; Decimal)
        {
            DecimalPlaces = 2 : 2;
            DataClassification = CustomerContent;
        }
        field(50034; "Garneinsatz KG SOLL"; Decimal)
        {
            DecimalPlaces = 2 : 2;
            DataClassification = CustomerContent;
        }
        field(50035; "Garneinsatz Kosten SOLL"; Decimal)
        {
            DecimalPlaces = 2 : 2;
            DataClassification = CustomerContent;
        }
        field(50036; "Garneinsatz KG Forcast"; Decimal)
        {
            DecimalPlaces = 2 : 2;
            DataClassification = CustomerContent;
        }
        field(50037; "Garneinsatz Kosten Forcast"; Decimal)
        {
            DecimalPlaces = 2 : 2;
            DataClassification = CustomerContent;
        }
        field(50038; "Garneinsatz KG IST 2"; Decimal)
        {
            DecimalPlaces = 2 : 2;
            DataClassification = CustomerContent;
        }
        field(50039; "Garneinsatz Kosten IST 2"; Decimal)
        {
            DecimalPlaces = 2 : 2;
            DataClassification = CustomerContent;
        }
        field(50040; "Garneinsatz KG SOLL 2"; Decimal)
        {
            DecimalPlaces = 2 : 2;
            DataClassification = CustomerContent;
        }
        field(50041; "Garneinsatz Kosten SOLL 2"; Decimal)
        {
            DecimalPlaces = 2 : 2;
            DataClassification = CustomerContent;
        }
        field(50042; "Garneinsatz KG Forcast 2"; Decimal)
        {
            DecimalPlaces = 2 : 2;
            DataClassification = CustomerContent;
        }
        field(50043; "Garneinsatz Kosten Forcast 2"; Decimal)
        {
            DecimalPlaces = 2 : 2;
            DataClassification = CustomerContent;
        }
        field(50044; Kettgarn; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(50045; "Kettgarn Kredior"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(50046; "Kettgarn Detex"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(50047; "document No."; text[50])
        {
            DataClassification = CustomerContent;
        }

        field(50048; "DocLineNo."; text[20])
        {
            DataClassification = CustomerContent;
        }
        field(50049; "location Code"; text[50])
        {
            DataClassification = CustomerContent;
        }

        field(50050; postingDate; date)
        {
            DataClassification = CustomerContent;
        }
        field(50051; OrderDate; date) { DataClassification = CustomerContent; }
        field(50052; modifiedAt; date) { DataClassification = CustomerContent; }
        field(50053; PlanedDeliveryDate; date) { DataClassification = CustomerContent; }
        field(50054; ShipmentDate; date) { DataClassification = CustomerContent; }
        field(50055; QtyShipped; decimal) { DataClassification = CustomerContent; }
        field(50056; OustandingQty; decimal) { DataClassification = CustomerContent; }
        field(50057; status; text[50]) { DataClassification = CustomerContent; }
        field(50058; OrderQty; decimal) { DataClassification = CustomerContent; }
        field(50059; Invoice_Value; decimal) { DataClassification = CustomerContent; }
        field(50060; OrderRequestedDate; date) { DataClassification = CustomerContent; }
        field(50061; PromdisedDeliveryDate; Date) { DataClassification = CustomerContent; }
        field(50062; Currency; code[50]) { DataClassification = CustomerContent; }
        field(50063; OrderType; text[50]) { DataClassification = CustomerContent; }
        field(50064; OrderCreationDate; date) { DataClassification = CustomerContent; }
        field(50066; Incoterm; Text[50]) { DataClassification = CustomerContent; }
        field(50067; PaymentTherm; text[50]) { DataClassification = CustomerContent; }
        field(50068; City; Text[50]) { DataClassification = CustomerContent; }
















    }

    keys
    {
        key(Key1; EntryNo)
        {
            Clustered = true;
        }
        key(Key2; Artikelkategorie, Debitor, "Artikelnr.")
        {
            SumIndexFields = "Soll Menge", "Soll Verkaufsbetrag", "Soll Einstandsbetrag", "Ist Menge", "Ist Verkaufsbetrag", "Ist Einstandsbetrag";
        }
        key(Key3; "Kostenträger", Debitor, "Artikelnr.")
        {
            SumIndexFields = "Soll Menge", "Soll Verkaufsbetrag", "Soll Einstandsbetrag", "Ist Menge", "Ist Verkaufsbetrag", "Ist Einstandsbetrag";
        }
        key(Key4; Debitorengruppe, Debitor, "Artikelnr.")
        {
            SumIndexFields = "Soll Menge", "Soll Verkaufsbetrag", "Soll Einstandsbetrag", "Ist Menge", "Ist Verkaufsbetrag", "Ist Einstandsbetrag";
        }
        key(Key5; Warenart)
        {
            SumIndexFields = "Soll Menge", "Soll Verkaufsbetrag", "Soll Einstandsbetrag", "Ist Menge", "Ist Verkaufsbetrag", "Ist Einstandsbetrag";
        }
        key(Key6; Lagerbuchungsgruppe)
        {
            SumIndexFields = "Soll Menge", "Soll Verkaufsbetrag", "Soll Einstandsbetrag", "Ist Menge", "Ist Verkaufsbetrag", "Ist Einstandsbetrag";
        }
        key(Key7; Land)
        {
            SumIndexFields = "Soll Menge", "Soll Verkaufsbetrag", "Soll Einstandsbetrag", "Ist Menge", "Ist Verkaufsbetrag", "Ist Einstandsbetrag";
        }
        key(Key8; "Cutset FW")
        {
            SumIndexFields = "Soll Menge", "Soll Verkaufsbetrag", "Soll Einstandsbetrag", "Ist Menge", "Ist Verkaufsbetrag", "Ist Einstandsbetrag", "Cutset Lfm";
        }
        key(Key9; User, "Artikelnr.", Debitor)
        {
            SumIndexFields = "Soll Menge", "Soll Verkaufsbetrag", "Soll Einstandsbetrag", "Ist Menge", "Ist Verkaufsbetrag", "Ist Einstandsbetrag";
        }
    }

    fieldgroups
    {
    }
}

