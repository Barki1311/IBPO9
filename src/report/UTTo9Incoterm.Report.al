report 67041 "UTT o9Incoterm"
{
    // version Richter

    // utt
    // ..............................
    // 
    // 01   12.07.2019  bb   utt     neu erstellt
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'UTT 09 Incoterm';
    Permissions = TableData "UTT SalesBuffer" = rimd,
                  TableData "KVS Target-Perf. Power BI" = rimd,
                  TableData "KVSExp.-Act. COS Entry" = rimd,
                  TableData "KVSCOSTurnoverEntry" = rimd;


    dataset
    {
        dataitem(Customer; customer)
        {

            dataitem("SalesShptLine"; "Sales Shipment Line")
            {
                DataItemLink = "Bill-to Customer No." = FIELD("No."), "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Filter"), "Shortcut Dimension 2 Code" = FIELD("Global Dimension 2 Filter");
                DataItemTableView = SORTING("Bill-to Customer No.", "Currency Code");
                RequestFilterFields = "Document No.", Type, "No.";

                trigger OnAfterGetRecord();
                var
                    ItemLoc: Record Item;
                    ItemSourceLoc: Code[20];
                    HasBomLoc: Boolean;
                    LSalesShptHeader: Record "Sales shipment Header";
                    LForcastAmount: Decimal;
                    LCurrencyDate: Date;
                    EntryNo: integer;
                    CustomerLoc: record Customer;
                    GeneralLedgerSetup: Record "General Ledger Setup";
                    SalesOrderLine: Record "Sales line";
                    SalesOrderLineArch: Record "Sales Line Archive";
                begin

                    LSalesShptHeader.get(SalesShptLine."Document No.");
                    ItemLoc.GET("No.");
                    siv.reset();
                    siv.SetRange(User, UserId);
                    siv.SetRange("Artikelnr.", ItemLoc."No.");
                    siv.setrange(Debitor, LSalesShptHeader."Sell-to Customer No.");
                    //siv.SetRange(Incoterm, LSalesShptHeader."Shipment Method Code");
                    if not siv.Findlast() then begin
                       
                        siv.INIT;
                        siv.EntryNo := SIVGetNextEntryNo();
                        siv.User := USERID;
                        siv."Artikelnr." := "No.";
                        siv.Debitor := "Sell-to Customer No.";
                        CustomerLoc.get("Sell-to Customer No.");
                        siv."customer name" := CopyStr(CustomerLoc."name", 1, StrLen(siv."Customer Name"));
                        siv.Incoterm := LSalesShptHeader."Shipment Method Code";
                        if siv.Incoterm = '' then
                            siv.Incoterm := CustomerLoc."Shipment Method Code";
                        siv.postingDate :=LSalesShptHeader."Posting Date";
                        siv.City :=LSalesShptHeader."Ship-to City";
                        if siv.City = '' then
                            siv.City := CustomerLoc."City";
                        siv.Insert();

                      
                    end;




                end;

                trigger OnPreDataItem();
                var
                    CompanyInfo: Record "Company Information";
                begin
                    CompanyInfo.get();
                    //SETFILTER("Document Type", '%1|%2', "Document Type"::Order, "Document Type"::"Blanket Order");
                    SETRANGE(Type, Type::Item);
                    SETFILTER("Quantity", '>%1', 0);
                    SetFilter("Unit Price", '>%1', 0);
                    //SETRANGE(KVSFCYDeliveryScheduleNo, '');
                    //SETRANGE("Blanket Order No.",'');
                    SETRANGE("Shipment Date", StartDate, EndDate);
                    CompanyInfo.get;
                    case CompanyInfo."Country/Region Code" of
                        'DE':
                            Setfilter("KVSTEX Item Type", '%1|%2|%3|%4', "KVSTEX Item Type"::"Finished Product", "KVSTEX Item Type"::Yarn, "KVSTEX Item Type"::"KVS Cutset", "KVSTEX Item Type"::"KVS Colour Ribbon");
                        //setrange("Order No.",'DA24-10624');
                        'MX':
                            Setfilter("KVSTEX Item Type", '%1|%2|%3|%4|%5', "KVSTEX Item Type"::"Finished Product", "KVSTEX Item Type"::Yarn, "KVSTEX Item Type"::"KVS Cutset", "KVSTEX Item Type"::"KVS Colour Ribbon", "KVSTEX Item Type"::"Raw Commodity");
                    //setrange("Order No.",'DA24-10624');
                    end;

                    //Setfilter("KVSTEX Item Type", '%1|%2|%3', "KVSTEX Item Type"::"Finished Product", "KVSTEX Item Type"::Yarn, "KVSTEX Item Type"::"KVS Cutset", "KVSTEX Item Type"::"KVS Colour Ribbon");
                    //setrange("Order No.",'DA24-10624');
                    // SETRANGE("Sell-to Customer No.", Customer."No.");
                end;
            }


        }



    }
    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(StartDate; StartDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Start Date';
                        ToolTip = 'Specifies the value of the Start Date field';
                    }
                    field(EndDate; EndDate)
                    {
                        ApplicationArea = All;
                        Caption = 'End Date';
                        ToolTip = 'Specifies the value of the End Date field';
                    }
                    // field(NewCurrency; NewCurrency)
                    // {
                    //     ApplicationArea = All;
                    //     Caption = 'Sales Conversion Currency';
                    //     ToolTip = 'Specifies the value of the Sales Conversion Currency field';
                    // }
                    // field(CurrencyDate; CurrencyDate)
                    // {
                    //     ApplicationArea = All;
                    //     Caption = 'Cost of goods Exchange rate Date';
                    //     ToolTip = 'Specifies the value of the Cost of goods Exchange rate Date field';
                    // }
                    // field(ExcludeDeliverySchedule; ExcludeDeliverySchedule)
                    // {
                    //     ApplicationArea = All;
                    //     Caption = 'Without Delivery Schedules';
                    //     ToolTip = 'Specifies the value of the Without Delivery Schedules field';
                    // }
                    // field(ExcludeSalesLines; ExcludeSalesLines)
                    // {
                    //     ApplicationArea = All;
                    //     Caption = 'Exclude SalesShptLines';
                    //     ToolTip = 'Specifies the value of the Exclude SalesShptLines field';
                    // }
                    // field(CalcGarneinsatz; CalcGarneinsatz)
                    // {
                    //     ApplicationArea = All;
                    //     Caption = 'Calculate cost of goods';
                    //     ToolTip = 'Specifies the value of the Calculate cost of goods field';
                    // }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport();
    begin

    end;

    trigger OnPreReport();
    begin
        siv.DeleteAll();
    end;

    procedure SetDataFilter(PStartDate: Date; PEndDate: Date; CSV: Boolean)
    var
        myInt: Integer;
    begin
        StartDate := PStartDate;
        EndDate := PEndDate;
        CreateCSV := CSV;

    end;

    procedure getOutstream(var POutstream: OutStream): OutStream;
    begin
        OutS := POutstream

    end;

    var
        Text000: Label 'Period: %1', Comment = 'ENU = Period: %1, DEA = Periode: %1';
        Item: Record Item;
        ValueEntryBuffer: Record "Value Entry" temporary;
        CustFilter: Text[250];
        ItemLedgEntryFilter: Text[250];
        PeriodText: Text[30];
        NextEntryNo: Integer;
        PrintOnlyOnePerPage: Boolean;
        Profit: Decimal;
        ProfitPct: Decimal;
        _kuma16: Integer;
        siv: Record "UTT SalesBuffer";
        Item1: Record Item;
        AbwMenge: Decimal;
        AbwVerkauf: Decimal;
        AbwEinstand: Decimal;
        PlanFilter: Text[250];
        Customer1: Record Customer;
        ArtKat: Record "Item Category";
        ArtikelAusblenden: Boolean;
        DebitorenAusblenden: Boolean;
        DiffMenge: Decimal;
        DiffVerkauf: Decimal;
        DiffEinstand: Decimal;
        ShowDif: Option Betrag,Prozent;
        SalesSetup: Record "Sales & Receivables Setup";
        DefDim: Record "Default Dimension";
        "_KUMA.ea": Boolean;
        ItemLedgerEntry: Record "Item Ledger Entry";
        ITEM3: Record Item;
        ProdBOMHeader: Record "Production BOM Header";
        ProdBOMLine: Record "Production BOM Line";
        ActiveVersionCode: Code[10];
        VersionMgt: Codeunit VersionManagement;
        _UTT__: Integer;
        ExcelBuf: Record "Excel Buffer" temporary;
        PrintToExcel: Boolean;
        i: Integer;
        iz: Integer;
        Factor: Decimal;
        Window: Dialog;
        TxtReportName: Label 'Soll-Ist-Vergleich Excel', Comment = 'ENU = Soll-Ist-Vergleich Excel, ESM = Soll-Ist-Vergleich Excel, DEA = Soll-Ist-Vergleich Excel';
        TxtDate: Label 'Datum', Comment = 'DEU = Datum, ENU = Date, ESM = Fecha, DEA = Datum';
        TxtUser: Label 'User', Comment = 'DEU = Benutzer, ENU = User, ESM = Usuario, DEA = Benutzer';
        Output: Option Cust,CustGroup,Data,Footer,Total,CustGrp,Diff,TotalCustGrp;
        CurrCustomer: Code[50];
        idx: Integer;
        CustomerCounter: Integer;
        "uttP99--": Integer;
        UserSetup: Record "User Setup";
        CustSetup: Record "Sales & Receivables Setup";
        CustRec: Record Customer;

        Pos: Integer;
        x: Integer;
        StatisticGrp: Text[120];
        ItemCrossRef: Record "Item Reference";
        vRefNo: Code[20];
        C_KVS013: Label 'Reference No.:', Comment = 'DEU = Referenznr.:, ENU = Reference No.:, DEA = Referenznr.:';
        HelpCustTab: Record Customer;
        "Sales Line Buffer": Record "Sales Line" temporary;
        StartDate: Date;
        EndDate: Date;
        TxtError1: Label 'please set as filter the  sales plan name!! ', Comment = 'DEU = bitte Umsatzplanname eingeben!!, ENU = please set as filter the  sales plan name!! , DEA = bitte Umsatzplanname eingeben!!';
        txtError2: Label 'plase set the start and end date !!', Comment = 'DEU = bitte Start- und Enddatum eingeben !!, ENU = plase set the start and end date !!, DEA = bitte Start- und Enddatum eingeben !!';
        ExcludeDeliverySchedule: Boolean;
        ExcludeSalesLines: Boolean;
        SalesLineRahmenAuftrag: Record "Sales Line";
        TempSalesLine: Record "Sales Line" temporary;
        NextLineNo: Integer;
        ItemInfo: Record Item;
        PrintAmountsInLCY: Boolean;
        SalesInvHeader: Record "Sales Invoice Header";
        CurrExchRate: Record "Currency Exchange Rate";
        SalescreditHeader: Record "Sales Cr.Memo Header";
        CurrenyCode: Code[20];
        NewCurrency: Code[20];
        COSPlanEntryBuff: Record "KVSExp.-Act. COS Entry";
        COSPlanEntry: Record "KVSCOSTurnoverEntry";
        SalesPlanLedgerEntry: Record "KVSTurnoverPlanLedgerEntry";
        SalesPlanName: Record "KVSTurnoverPlanName";
        SOLLISTCOstEntry: Record "KVSExp.-Act. COS Entry";
        CalcGarneinsatz: Boolean;
        Marked: Boolean;
        CurrencyDate: Date;
        Found: Boolean;
        RwItem: Code[20];
        CreateCSV: Boolean;
        O9SalesActualXML: XmlPort "UTT O9SalesActual";
        OutS: OutStream;
        PLANT_CD: text;












    local procedure CalcProfitPct();
    begin
        with ValueEntryBuffer do begin
            if "Sales Amount (Actual)" <> 0 then
                ProfitPct := ROUND(100 * Profit / "Sales Amount (Actual)", 0.1)
            else
                ProfitPct := 0;
        end;
    end;

    local procedure SIVGetNextEntryNo(): Integer
    var 
    sivLoc:Record "UTT SalesBuffer";
    begin
        if sivLoc.FindLast() then
            exit(sivLoc.EntryNo + 1)
        else
            exit(1);
    end;

    procedure UTT___();
    begin
    end;

    
   

    

   

}

