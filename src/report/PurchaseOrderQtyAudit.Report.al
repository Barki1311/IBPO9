// ============================================================
//  Report 50100 – Einkaufsbestellungen: Mengenübersicht (Audit)
//  Zeigt: Menge bestellt / Menge empfangen / Menge fakturiert
//  Verwendung: Einkauf > Berichte > Mengenübersicht Audit
// ============================================================
report 67042 "Purchase Order Qty Audit"
{
    Caption = 'Einkaufsbestellungen – Mengenübersicht (Audit)';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Reports/PurchaseOrderQtyAudit1.rdlc';

    // ─── DATASET ────────────────────────────────────────────
    dataset
    {
        // ── Kopf-Ebene: Einkaufsbestellung (archivierte + offene) ──
        dataitem(PurchaseHeader; "Purchase Header")
        {
            DataItemTableView = where("Document Type" = const(Order));
            RequestFilterFields = "No.", "Buy-from Vendor No.", "Order Date", Status;

            column(ReportTitle;         'Einkaufsbestellungen – Mengenübersicht (Audit)') { }
            column(CompanyName;         CompanyName()) { }
            column(PrintedDateTime;     CurrentDateTime()) { }
            column(FilterText;          GetFiltersText()) { }

            // Kopffelder
            column(DocNo;               "No.") { }
            column(OrderDate;           "Order Date") { }
            column(VendorNo;            "Buy-from Vendor No.") { }
            column(VendorName;          "Buy-from Vendor Name") { }
            column(PurchaserCode;       "Purchaser Code") { }
            column(Status;              Format(Status)) { }
            column(CurrencyCode;        "Currency Code") { }

            // ── Zeilen-Ebene ────────────────────────────────
            dataitem(PurchaseLine; "Purchase Line")
            {
                DataItemLink = "Document Type" = field("Document Type"),
                               "Document No."  = field("No.");
                DataItemTableView = where("Document Type" = const(Order),
                                          Type          = const(Item));

                // Zeilenfelder
                column(LineNo;          "Line No.") { }
                column(ItemNo;          "No.") { }
                column(Description;     Description) { }
                column(UnitOfMeasure;   "Unit of Measure Code") { }

                // ── Die 3 Audit-Kernmengen ──────────────────
                column(QtyOrdered;      Quantity)
                {
                    Caption = 'Menge bestellt';
                }
                column(QtyReceived;     "Quantity Received")
                {
                    Caption = 'Menge empfangen (WE)';
                }
                column(QtyInvoiced;     "Quantity Invoiced")
                {
                    Caption = 'Menge fakturiert';
                }

                // Abgeleitete Felder (Differenzen)
                column(QtyOutstanding;  "Outstanding Quantity")
                {
                    Caption = 'Ausstehend (noch nicht geliefert)';
                }
                column(QtyRecvNotInv;   "Qty. Rcd. Not Invoiced")
                {
                    Caption = 'Empfangen, noch nicht fakturiert';
                }

                // Wertfelder
                column(DirectUnitCost;  "Direct Unit Cost") { }
                column(LineAmount;      "Line Amount") { }
                column(AmtRecvNotInv;   "Amt. Rcd. Not Invoiced (LCY)") { }

                // ── Statusampel (berechnet in Code) ─────────
                column(DeliveryStatus;  DeliveryStatusTxt) { }
                column(InvoiceStatus;   InvoiceStatusTxt)  { }

                // Fortschritt in Prozent
                column(PctReceived;     PctReceivedDecimal)  { }
                column(PctInvoiced;     PctInvoicedDecimal)  { }

                trigger OnAfterGetRecord()
                begin
                    CalcAuditFields();
                end;
            }

            // ── Zwischensummen pro Bestellung ───────────────
            dataitem(HeaderTotals; "Integer")
            {
                DataItemTableView = where(Number = const(1));

                column(TotalQtyOrdered;   TotalQtyOrderedAmt)  { }
                column(TotalQtyReceived;  TotalQtyReceivedAmt) { }
                column(TotalQtyInvoiced;  TotalQtyInvoicedAmt) { }
                column(TotalQtyRNI;       TotalQtyRNIAmt)      { }
                column(TotalLineAmount;   TotalLineAmountAmt)  { }

                trigger OnPreDataItem()
                begin
                    // Variablen auf 0 setzen – werden in PurchaseLine.OnAfterGetRecord befüllt
                    Clear(TotalQtyOrderedAmt);
                    Clear(TotalQtyReceivedAmt);
                    Clear(TotalQtyInvoicedAmt);
                    Clear(TotalQtyRNIAmt);
                    Clear(TotalLineAmountAmt);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                // Zurücksetzen der Summenvariablen für jede neue Bestellung
                Clear(TotalQtyOrderedAmt);
                Clear(TotalQtyReceivedAmt);
                Clear(TotalQtyInvoicedAmt);
                Clear(TotalQtyRNIAmt);
                Clear(TotalLineAmountAmt);
            end;
        }

        // ── Gesamttotals (Report-Ende) ───────────────────────
        dataitem(GrandTotal; "Integer")
        {
            DataItemTableView = where(Number = const(1));

            column(GrandTotalQtyOrdered;   GrandTotalQtyOrdered)  { }
            column(GrandTotalQtyReceived;  GrandTotalQtyReceived) { }
            column(GrandTotalQtyInvoiced;  GrandTotalQtyInvoiced) { }
            column(GrandTotalQtyRNI;       GrandTotalQtyRNI)      { }
            column(GrandTotalLineAmount;   GrandTotalLineAmount)   { }
        }
    }

    // ─── REQUEST PAGE (Filter-Dialog) ────────────────────────
    requestpage
    {
        SaveValues = true;

        layout
        {
            area(Content)
            {
                group(grpOptions)
                {
                    Caption = 'Optionen';

                    field(ShowOnlyOpenItems; ShowOnlyOpenItems)
                    {
                        ApplicationArea = All;
                        Caption = 'Nur offene / teilweise gelieferte Zeilen';
                        ToolTip = 'Aktivieren, um Zeilen mit vollständiger Lieferung UND vollständiger Fakturierung auszublenden.';
                    }
                    field(ShowOnlyRNI; ShowOnlyRNI)
                    {
                        ApplicationArea = All;
                        Caption = 'Nur „Empfangen, nicht fakturiert"';
                        ToolTip = 'Aktivieren, um nur Zeilen anzuzeigen, bei denen Wareneingang gebucht, aber noch keine Rechnung vorhanden ist.';
                    }
                    field(fldVendorFilter; VendorFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'Lieferantenfilter';
                        ToolTip = 'Schränkt den Bericht auf bestimmte Lieferanten ein (kommagetrennt oder Bereich z.B. 10000..19999).';
                    }
                }
            }
        }

        trigger OnOpenPage()
        begin
            ShowOnlyOpenItems := true;
        end;
    }

    // ─── CODE SECTION ────────────────────────────────────────
    var
        // Laufvariablen pro Zeile
        DeliveryStatusTxt:   Text[30];
        InvoiceStatusTxt:    Text[30];
        PctReceivedDecimal:  Decimal;
        PctInvoicedDecimal:  Decimal;

        // Summenvariablen pro Bestellung
        TotalQtyOrderedAmt:  Decimal;
        TotalQtyReceivedAmt: Decimal;
        TotalQtyInvoicedAmt: Decimal;
        TotalQtyRNIAmt:      Decimal;
        TotalLineAmountAmt:  Decimal;

        // Gesamttotals
        GrandTotalQtyOrdered:  Decimal;
        GrandTotalQtyReceived: Decimal;
        GrandTotalQtyInvoiced: Decimal;
        GrandTotalQtyRNI:      Decimal;
        GrandTotalLineAmount:  Decimal;

        // Options
        ShowOnlyOpenItems: Boolean;
        ShowOnlyRNI:       Boolean;
        VendorFilter:      Text[250];

        // Hilfstexte
        Txt_NotDelivered:    Label 'Nicht geliefert',  MaxLength = 30;
        Txt_PartDelivered:   Label 'Teilw. geliefert', MaxLength = 30;
        Txt_FullDelivered:   Label 'Vollst. geliefert',MaxLength = 30;
        Txt_NotInvoiced:     Label 'Nicht fakturiert', MaxLength = 30;
        Txt_PartInvoiced:    Label 'Teilw. fakturiert', MaxLength = 30;
        Txt_FullInvoiced:    Label 'Vollst. fakturiert', MaxLength = 30;

    // ── Berechnung der Audit-Felder ───────────────────────────
    local procedure CalcAuditFields()
    var
        Qty:     Decimal;
        QtyRecv: Decimal;
        QtyInv:  Decimal;
    begin
        Qty     := PurchaseLine.Quantity;
        QtyRecv := PurchaseLine."Quantity Received";
        QtyInv  := PurchaseLine."Quantity Invoiced";

        // ── Prozentwerte ────────────────────────────────────
        if Qty <> 0 then begin
            PctReceivedDecimal := Round(QtyRecv / Qty * 100, 0.01);
            PctInvoicedDecimal := Round(QtyInv  / Qty * 100, 0.01);
        end else begin
            PctReceivedDecimal := 0;
            PctInvoicedDecimal := 0;
        end;

        // ── Lieferstatus ────────────────────────────────────
        if QtyRecv = 0 then
            DeliveryStatusTxt := Txt_NotDelivered
        else
            if QtyRecv >= Qty then
                DeliveryStatusTxt := Txt_FullDelivered
            else
                DeliveryStatusTxt := Txt_PartDelivered;

        // ── Fakturastatus ───────────────────────────────────
        if QtyInv = 0 then
            InvoiceStatusTxt := Txt_NotInvoiced
        else
            if QtyInv >= Qty then
                InvoiceStatusTxt := Txt_FullInvoiced
            else
                InvoiceStatusTxt := Txt_PartInvoiced;

        // ── Zeilenfilter (Optionen) ──────────────────────────
        if ShowOnlyOpenItems then
            if (QtyRecv >= Qty) and (QtyInv >= Qty) then
                CurrReport.Skip();

        if ShowOnlyRNI then
            if PurchaseLine."Qty. Rcd. Not Invoiced" = 0 then
                CurrReport.Skip();

        // ── Summierung pro Bestellung ────────────────────────
        TotalQtyOrderedAmt  += Qty;
        TotalQtyReceivedAmt += QtyRecv;
        TotalQtyInvoicedAmt += QtyInv;
        TotalQtyRNIAmt      += PurchaseLine."Qty. Rcd. Not Invoiced";
        TotalLineAmountAmt  += PurchaseLine."Line Amount";

        // ── Gesamtsummierung ─────────────────────────────────
        GrandTotalQtyOrdered  += Qty;
        GrandTotalQtyReceived += QtyRecv;
        GrandTotalQtyInvoiced += QtyInv;
        GrandTotalQtyRNI      += PurchaseLine."Qty. Rcd. Not Invoiced";
        GrandTotalLineAmount  += PurchaseLine."Line Amount";
    end;

    // ── Filtertext für Kopfzeile ──────────────────────────────
    local procedure GetFiltersText(): Text
    var
        FilterTxt: Text;
    begin
        FilterTxt := PurchaseHeader.GetFilters();
        if VendorFilter <> '' then
            FilterTxt += '; Lieferant: ' + VendorFilter;
        exit(FilterTxt);
    end;

    // ── OnPreReport: Lieferantenfilter anwenden ───────────────
    trigger OnPreReport()
    begin
        if VendorFilter <> '' then
            PurchaseHeader.SetFilter("Buy-from Vendor No.", VendorFilter);
    end;
}
