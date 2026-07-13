codeunit 67004 "UTT O9 Project Lib"
{
    TableNo = "Job Queue Entry";
    Permissions = TableData "UTT SalesBuffer" = rimd,
                  TableData "UTT IBPO9 Buffer" = rimd;
    


    trigger OnRun()
    begin
        GetLegalEntry();
        CreateDailySnapshot();
         
        //initZipFile();
        if StrPos(Rec."Parameter String", 'MATERIAL') > 0 then begin

            // clear(TempBlob);
            // TempBlob.CreateOutStream(OutS);
            // MaterialExport(OutS);
            // TempBlob.CreateInStream(InS);
            CreateInStream('MATERIAL');
            SaveOutStream(TempBlob, LegalEntity + '_' + MaterialLbl + '_' + Format(today, 0, '<year4><month,2><day,2>'));
        end;
        if StrPos(Rec."Parameter String", 'MATERIAL_SP') > 0 then begin

            // clear(TempBlob);
            // TempBlob.CreateOutStream(OutS);
            // MaterialExport(OutS);
            // TempBlob.CreateInStream(InS);
            CreateInStream('MATERIAL_SP');
            SaveOutStream(TempBlob, LegalEntity + '_' + Material_SP_Lbl + '_' + Format(today, 0, '<year4><month,2><day,2>'));
        end;

        if StrPos(Rec."Parameter String", 'InventoryCostPerUnit_SP') > 0 then begin

            // clear(TempBlob);
            // TempBlob.CreateOutStream(OutS);
            // MaterialExport(OutS);
            // TempBlob.CreateInStream(InS);
            CreateInStream('InventoryCostPerUnit_SP');
            SaveOutStream(TempBlob, LegalEntity + '_' + InventoryCostPerUnit_SP_Lbl + '_' + Format(today, 0, '<year4><month,2><day,2>'));
        end;
        if StrPos(Rec."Parameter String", 'MATERIALASSOC') > 0 then begin

            // clear(TempBlob);
            // TempBlob.CreateOutStream(OutS);
            // MaterialExport(OutS);
            // TempBlob.CreateInStream(InS);
            CreateInStream('MATERIALASSOC');
            SaveOutStream(TempBlob, LegalEntity + '_' + MaterialassocLbl + '_' + Format(today, 0, '<year4><month,2><day,2>'));
        end;
        if StrPos(Rec."Parameter String", 'LOCATION') > 0 then begin
            // clear(TempBlob);
            // TempBlob.CreateOutStream(OutS);
            // LocationExport(OutS);
            // TempBlob.CreateInStream(InS);
            // SaveOutStream(TempBlob, Rec."Parameter String");
            CreateInStream('LOCATION');
            SaveOutStream(TempBlob, LegalEntity + '_' + LocationLbl + '_' + Format(today, 0, '<year4><month,2><day,2>'));

        end;

        if StrPos(Rec."Parameter String", 'LOCATION_SP') > 0 then begin
            // clear(TempBlob);
            // TempBlob.CreateOutStream(OutS);
            // LocationExport(OutS);
            // TempBlob.CreateInStream(InS);
            // SaveOutStream(TempBlob, Rec."Parameter String");
            CreateInStream('LOCATION_SP');
            SaveOutStream(TempBlob, LegalEntity + '_' + LocationLbl_SP + '_' + Format(today, 0, '<year4><month,2><day,2>'));

        end;

        if StrPos(Rec."Parameter String", 'SUPPLIER') > 0 then begin
            //SupplierExport(OutS);
            CreateInStream('SUPPLIER');
            SaveOutStream(TempBlob, LegalEntity + '_' + SupplierLbl + '_' + Format(today, 0, '<year4><month,2><day,2>'));
        end;
        if StrPos(Rec."Parameter String", 'SUPPLIER_SP') > 0 then begin
            //SupplierExport(OutS);
            CreateInStream('SUPPLIER_SP');
            SaveOutStream(TempBlob, LegalEntity + '_' + SupplierLbl_SP + '_' + Format(today, 0, '<year4><month,2><day,2>'));
        end;
        if StrPos(Rec."Parameter String", 'CUSTOMER') > 0 then begin
            //SupplierExport(OutS);
            CreateInStream('CUSTOMER');
            SaveOutStream(TempBlob, LegalEntity + '_' + CustomerLbl + '_' + Format(today, 0, '<year4><month,2><day,2>'));
        end;
        if StrPos(Rec."Parameter String", 'CUSTOMER_SP') > 0 then begin
            //SupplierExport(OutS);
            CreateInStream('CUSTOMER_SP');
            SaveOutStream(TempBlob, LegalEntity + '_' + CustomerLbl_SP + '_' + Format(today, 0, '<year4><month,2><day,2>'));
        end;
        if StrPos(Rec."Parameter String", 'CUSTOMER_ASSOCIATION') > 0 then begin
            //SupplierExport(OutS);
            CreateInStream('CUSTOMERASSOC');
            SaveOutStream(TempBlob, LegalEntity + '_' + CustomerAssocLbl + '_' + Format(today, 0, '<year4><month,2><day,2>'));
        end;
        if StrPos(Rec."Parameter String", 'UOM') > 0 then begin
            //UOMExport(OutS);
            CreateInStream('UOM');
            SaveOutStream(TempBlob, LegalEntity + '_' + UOMLbl + '_' + Format(today, 0, '<year4><month,2><day,2>'));
        end;
        if StrPos(Rec."Parameter String", 'UOMCONV') > 0 then begin
            //UOMCOnvExport(OutS);
            CreateInStream('UOMCONV');
            SaveOutStream(TempBlob, LegalEntity + '_' + UOMConvLbl + '_' + Format(today, 0, '<year4><month,2><day,2>'));
        end;
        if StrPos(Rec."Parameter String", 'SALES') > 0 then begin
            // clear(TempBlob);
            // TempBlob.CreateOutStream(OutS);
            // MaterialExport(OutS);
            // TempBlob.CreateInStream(InS);
            // SaveOutStream(TempBlob, Rec."Parameter String");
            CreateInStream('SALES');
            SaveOutStream(TempBlob, LegalEntity + '_' + ActualSalesLbl + '_' + Format(today, 0, '<year4><month,2><day,2>'));
        end;
        if StrPos(Rec."Parameter String", 'PURCHASE') > 0 then begin
            // PurchaseExport(OutS);
            CreateInStream('PURCHASE');
            SaveOutStream(TempBlob, LegalEntity + '_' + PO_PKI_Lbl + '_' + Format(today, 0, '<year4><month,2><day,2>'));
        end;
        if StrPos(Rec."Parameter String", 'PURCHASE_SP') > 0 then begin
            // PurchaseExport(OutS);
            CreateInStream('PURCHASE_SP');
            SaveOutStream(TempBlob, LegalEntity + '_' + PO_PKI_SP_Lbl + '_' + Format(today, 0, '<year4><month,2><day,2>'));
        end;

        if StrPos(Rec."Parameter String", 'INVENTORY') > 0 then begin
            // ItemInventoryExport(OutS);
            CreateInStream('INVENTORY');
            SaveOutStream(TempBlob, LegalEntity + '_' + InventoryLbl + '_' + Format(today, 0, '<year4><month,2><day,2>'));
        end;

        if StrPos(Rec."Parameter String", 'QUALITY') > 0 then begin
            CreateInStream('QUALITY');
            SaveOutStream(TempBlob, LegalEntity + '_' + QualityLbl + '_' + Format(today, 0, '<year4><month,2><day,2>'));
        end;
        if StrPos(Rec."Parameter String", 'QUALITYASSOC') > 0 then begin
            CreateInStream('QUALITYASSOC');
            SaveOutStream(TempBlob, LegalEntity + '_' + QualityAssocLbl + '_' + Format(today, 0, '<year4><month,2><day,2>'));
        end;
        if StrPos(Rec."Parameter String", 'BOM_SP') > 0 then begin
            // ItemInventoryExport(OutS);
            CreateInStream('BOM_SP');
            SaveOutStream(TempBlob, LegalEntity + '_' + Bomlbl + '_' + Format(today, 0, '<year4><month,2><day,2>'));
        end;
        if StrPos(Rec."Parameter String", 'ROUTING_SP') > 0 then begin
            // ItemInventoryExport(OutS);
            CreateInStream('ROUTING_SP');
            SaveOutStream(TempBlob, LegalEntity + '_' + Rtglbl + '_' + Format(today, 0, '<year4><month,2><day,2>'));
        end;
        if StrPos(Rec."Parameter String", 'RessourceAvail_SP') > 0 then begin
            // ItemInventoryExport(OutS);
            CreateInStream('ResourceAvail_SP');
            SaveOutStream(TempBlob, LegalEntity + '_' + ResourceAvaillbl + '_' + Format(today, 0, '<year4><month,2><day,2>'));
        end;
        if StrPos(Rec."Parameter String", 'RessourceAvailTime_SP') > 0 then begin
            // ItemInventoryExport(OutS);
            CreateInStream('ResourceAvailTime_SP');
            SaveOutStream(TempBlob, LegalEntity + '_' + ResourceAvailTimelbl + '_' + Format(today, 0, '<year4><month,2><day,2>'));
        end;
        if StrPos(Rec."Parameter String", 'STO_SP') > 0 then begin
            // ItemInventoryExport(OutS);
            CreateInStream('STO_SP');
            SaveOutStream(TempBlob, LegalEntity + '_' + STOLbl + '_' + Format(today, 0, '<year4><month,2><day,2>'));
        end;
        if StrPos(Rec."Parameter String", 'PRO_SP') > 0 then begin
            // ItemInventoryExport(OutS);
            CreateInStream('PRO_SP');
            SaveOutStream(TempBlob, LegalEntity + '_' + ProLbl + '_' + Format(today, 0, '<year4><month,2><day,2>'));
        end;
        if StrPos(Rec."Parameter String", 'SALES_SP') > 0 then begin
            // clear(TempBlob);
            // TempBlob.CreateOutStream(OutS);
            // MaterialExport(OutS);
            // TempBlob.CreateInStream(InS);
            // SaveOutStream(TempBlob, Rec."Parameter String");
            CreateInStream('SALES_SP');
            SaveOutStream(TempBlob, LegalEntity + '_' + ActualSales_SPLbl + '_' + Format(today, 0, '<year4><month,2><day,2>'));
        end;
        if StrPos(Rec."Parameter String", 'OnHandInventory') > 0 then begin
            // ItemInventoryExport(OutS);
            CreateInStream('OnHandInventory');
            SaveOutStream(TempBlob, LegalEntity + '_' + OnHandInventoryLbl + '_' + Format(today, 0, '<year4><month,2><day,2>'));
        end;


    end;

    procedure CreateDailySnapshot()
    var
        SnapshotConfig: Record utto9SnapshotConfig;
    begin
        SnapshotConfig.SetRange(Active, true);
        if SnapshotConfig.FindSet() then
            repeat
                RunSnapshot(SnapshotConfig);
            until SnapshotConfig.Next() = 0;
    end;

    procedure RunSnapshot(SnapshotConfig: Record utto9SnapshotConfig)
    var

        AllObjWithCaption: Record AllObjWithCaption;
        XmlPortId: Integer;
        O9Buffer: record "UTT IBPO9 Buffer";
    begin
        GetLegalEntry();
        SnapshotConfig.TestField(XMLPortName);

        SetStartEndDate(SnapshotConfig.StartDate, SnapshotConfig.EndDate, SnapshotConfig.DateFormel);
        clear(TempBlob);
        TempBlob.CreateOutStream(OutS);

        // Clear the buffer table before export
        CleanBuffer(SnapshotConfig);

        // Find the XMLPort object by name
        AllObjWithCaption.SetRange("Object Type", AllObjWithCaption."Object Type"::XMLport);
        AllObjWithCaption.SetRange("Object Name", SnapshotConfig.XMLPortName);
        if AllObjWithCaption.FindFirst() then begin
            XmlPortId := AllObjWithCaption."Object ID";


            SetStartEndDate(SnapshotConfig.StartDate, SnapshotConfig.EndDate, SnapshotConfig.DateFormel);

            case SnapshotConfig.XMLPortName of
                'UTT O9SalesActual':
                    begin
                        // SetStartEndDate(SnapshotConfig.StartDate, SnapshotConfig.EndDate, SnapshotConfig.DateFormel);
                        SalesExport(OutS);
                        SaveOutStream(TempBlob, LegalEntity + '_' + SnapshotConfig.Description + '_' + Format(today, 0, '<year4><month,2><day,2>'));
                    end;

                'UTT O9SalesActual_SP':
                    begin
                        // SetStartEndDate(SnapshotConfig.StartDate, SnapshotConfig.EndDate, SnapshotConfig.DateFormel);
                        SalesExport_SP(OutS);
                        SaveOutStream(TempBlob, LegalEntity + '_' + SnapshotConfig.Description + '_' + Format(today, 0, '<year4><month,2><day,2>'));


                    end;

                'UTT O9InCoTerm':
                    begin
                        // SetStartEndDate(SnapshotConfig.StartDate, SnapshotConfig.EndDate, SnapshotConfig.DateFormel);
                        IncotermExport(OutS);
                        SaveOutStream(TempBlob, LegalEntity + '_' + SnapshotConfig.Description + '_' + Format(today, 0, '<year4><month,2><day,2>'));

                    end;
                'UTT O9 Purchase Export':
                    begin
                        // SetStartEndDate(SnapshotConfig.StartDate, SnapshotConfig.EndDate, SnapshotConfig.DateFormel);
                        PurchaseExport(OutS);
                        SaveOutStream(TempBlob, LegalEntity + '_' + SnapshotConfig.Description + '_' + Format(today, 0, '<year4><month,2><day,2>'));

                    end;
                'UTT O9 Purchase Export_SP':
                    begin
                        // SetStartEndDate(SnapshotConfig.StartDate, SnapshotConfig.EndDate, SnapshotConfig.DateFormel);
                        PurchaseExport_SP(OutS);
                        SaveOutStream(TempBlob, LegalEntity + '_' + SnapshotConfig.Description + '_' + Format(today, 0, '<year4><month,2><day,2>'));
                    end;
                'UTT O9 Pro':
                    begin
                        // SetStartEndDate(SnapshotConfig.StartDate, SnapshotConfig.EndDate, SnapshotConfig.DateFormel);
                        Pro_Export(OutS);
                        SaveOutStream(TempBlob, LegalEntity + '_' + SnapshotConfig.Description + '_' + Format(today, 0, '<year4><month,2><day,2>'));
                    end;
                else begin
                    Xmlport.Export(XmlPortId, OutS);
                    SaveOutStream(TempBlob, LegalEntity + '_' + SnapshotConfig.Description + '_' + Format(today, 0, '<year4><month,2><day,2>'));
                end;


            end;
        end;
    end;

    procedure MaterialExport(var Outs: OutStream)
    begin
        Xmlport.Export(Xmlport::"UTT O9MaterialDim", OutS);
    end;

    procedure Material_SP_Export(var Outs: OutStream)
    begin
        Xmlport.Export(Xmlport::"UTT O9MaterialDim_SP", OutS);
    end;

    procedure MaterialAssocExport(var Outs: OutStream)
    begin
        Xmlport.Export(Xmlport::"UTT O9MaterialAssoc", OutS);
    end;

    procedure LocationExport(var OutS: OutStream)
    begin
        Xmlport.Export(Xmlport::"UTT O9LocationDim", OutS);

    end;

    procedure LocationExport_SP(var OutS: OutStream)
    begin
        Xmlport.Export(Xmlport::"UTT O9LocationDim_SP", OutS);

    end;

    procedure UOMExport(var OutS: OutStream)
    begin
        Xmlport.Export(xmlport::"UTT O9UOMDim", OutS);
    end;

    procedure CustomerExport(var OutS: OutStream)
    begin
        Xmlport.Export(xmlport::"UTT O9CustomerDim", OutS);
    end;

    procedure CustomerExport_SP(var OutS: OutStream)
    begin
        Xmlport.Export(xmlport::"UTT O9CustomerDim_SP", OutS);
    end;

    procedure CustomerAssoc(var OutS: OutStream)
    begin
        Xmlport.Export(xmlport::"UTT O9CustomerAssoc", OutS);
    end;

    procedure ApplicationAssocExport(var OutS: OutStream)
    begin
        Xmlport.Export(xmlport::"UTT O9ApplicationAssoc", OutS);
    end;

    procedure SalesExport(var Outs: OutStream)
    var
        O9SalesActualXML: XmlPort "UTT O9SalesActual";
        SIV: Record "UTT SalesBuffer";
        O9SalesActualRep: Report "UTT actualSales";
        StartDate: date;
        EndDate: date;
        StartDateFormel: DateFormula;
        EndDateFormel: DateFormula;
        myText: text;

    begin
        StartDateFormel := Dateformel;
        EndDateFormel := Dateformel;

        StartDate := CalcDate(StrSubstNo('-%1', StartDateFormel), RefStartDate);
        EndDate := CalcDate(StrSubstNo('+%1', EndDateFormel), RefEndDate);

        siv.DeleteAll();
        O9SalesActualRep.SetDataFilter(StartDate, EndDate, true);
        O9SalesActualRep.UseRequestPage(false);
        O9SalesActualRep.Run();
        Xmlport.Export(xmlport::"UTT O9SalesActual", Outs);


    end;

    procedure SalesExport_SP(var Outs: OutStream)
    var
        O9SalesActualXML: XmlPort "UTT O9SalesActual_SP";
        SIV: Record "UTT SalesBuffer";
        O9SalesActualRep: Report "UTT actualSales";
        StartDate: date;
        EndDate: date;
        StartDateFormel: DateFormula;
        EndDateFormel: DateFormula;
        myText: text;

    begin
        StartDateFormel := Dateformel;
        EndDateFormel := Dateformel;

        StartDate := CalcDate(StrSubstNo('-%1', StartDateFormel), RefStartDate);
        EndDate := CalcDate(StrSubstNo('+%1', EndDateFormel), RefEndDate);

        siv.DeleteAll();
        O9SalesActualRep.SetDataFilter(StartDate, EndDate, true);
        //O9SalesActualRep.RetrieveOnlyOpenSales(true);
        O9SalesActualRep.UseRequestPage(false);
        O9SalesActualRep.Run();
        Xmlport.Export(xmlport::"UTT O9SalesActual_SP", Outs);


    end;

    procedure IncotermExport(var Outs: OutStream)
    var
        O9SalesActualXML: XmlPort "UTT O9SalesActual";
        SIV: Record "UTT SalesBuffer";
        O9IncotermRep: Report "UTT o9Incoterm";
        StartDate: date;
        EndDate: date;
        StartDateFormel: DateFormula;
        EndDateFormel: DateFormula;
        myText: text;

    begin
        StartDateFormel := Dateformel;
        EndDateFormel := Dateformel;

        StartDate := CalcDate(StrSubstNo('-%1', StartDateFormel), RefStartDate);
        EndDate := CalcDate(StrSubstNo('+%1', EndDateFormel), RefEndDate);

        siv.DeleteAll();
        O9IncotermRep.SetDataFilter(StartDate, EndDate, true);
        O9IncotermRep.UseRequestPage(false);
        O9IncotermRep.Run();
        Xmlport.Export(xmlport::"UTT O9InCoTerm", Outs);


    end;

    procedure PurchaseExport(var Outs: OutStream)
    var
        O9POXMLExport: XmlPort "UTT O9 Purchase Export";
        StartDate: date;
        EndDate: date;
        StartDateFormel: DateFormula;
        EndDateFormel: DateFormula;
    begin
        StartDateFormel := Dateformel;
        EndDateFormel := Dateformel;
        if RefStartDate = RefEndDate then begin
            evaluate(StartDateFormel, '<1y>'); //purchase for last one year 
            StartDate := CalcDate(StrSubstNo('-%1', StartDateFormel), RefStartDate);
            EndDate := CalcDate(StrSubstNo('+%1', StartDateFormel), RefStartDate);

        end else begin
            StartDate := RefStartDate;
            EndDate := RefEndDate;
        end;

        // evaluate(StartDateFormel, '<1y>'); //purchase for last one year 
        // StartDate := CalcDate(StrSubstNo('-%1', StartDateFormel), RefStartDate);
        // EndDate := CalcDate(StrSubstNo('+%1', StartDateFormel), RefStartDate);

        O9POXMLExport.SetDataFilter(StartDate, EndDate);
        //O9POXMLExport.SetDataFilter(RefStartDate, RefEndDate);
        O9POXMLExport.SetDestination(Outs);
        O9POXMLExport.Export();


    end;

    procedure PurchaseExport_SP(var Outs: OutStream)
    var
        O9POXMLExport: XmlPort "UTT O9 Purchase Export_SP";
        StartDate: date;
        EndDate: date;
        StartDateFormel: DateFormula;
        EndDateFormel: DateFormula;
    begin
        StartDateFormel := Dateformel;
        EndDateFormel := Dateformel;
        if RefStartDate = RefEndDate then begin
            evaluate(StartDateFormel, '<3y>'); //purchase for last one year 
            StartDate := CalcDate(StrSubstNo('-%1', StartDateFormel), RefStartDate);
            EndDate := CalcDate(StrSubstNo('+%1', StartDateFormel), RefStartDate);

        end else begin
            StartDate := RefStartDate;
            EndDate := RefEndDate;
        end;

        // evaluate(StartDateFormel, '<1y>'); //purchase for last one year 
        // StartDate := CalcDate(StrSubstNo('-%1', StartDateFormel), RefStartDate);
        // EndDate := CalcDate(StrSubstNo('+%1', StartDateFormel), RefStartDate);

        O9POXMLExport.SetDataFilter(StartDate, EndDate);
        // O9POXMLExport.SetDataFilter(RefStartDate, RefEndDate);
        O9POXMLExport.SetDestination(Outs);
        O9POXMLExport.Export();


    end;

    procedure SupplierExport(var OutS: OutStream)
    begin
        Xmlport.Export(xmlport::"UTT O9SupplierDim", OutS);
    end;

    procedure SupplierExport_SP(var OutS: OutStream)
    begin
        Xmlport.Export(xmlport::"UTT O9SupplierDim_SP", OutS);
    end;

    procedure UOMCOnvExport(var OutS: OutStream)
    begin
        Xmlport.export(xmlport::"UTT O9UOMConversion", OutS);
    end;

    local procedure initZipFile()
    begin
        Clear(DataCompression);
        ZipFileName := 'O9DataExtract_' + Format(CurrentDateTime) + '.zip';
        DataCompression.CreateZipArchive();
    end;

    local procedure createZipFile()
    begin
        TempBlob.CreateOutStream(OutS);
        DataCompression.SaveZipArchive(OutS);
        TempBlob.CreateInStream(InS);
        DownloadFromStream(InS, '', '', '', ZipFileName);


    end;

    local procedure autoCreateZipFile()
    var
        ZipOutS: OutStream;
        ZipInS: InStream;
        ZipFileName: text;
        FilePath: Text;
        ExportFile: File;
        fileMgt: Codeunit "File Management";
        pdfsetup: Record "KVS PDF Setup";
    begin
        //  TempBlob.CreateOutStream(OutS);
        // DataCompression.SaveZipArchive(OutS);
        // TempBlob.CreateInStream(InS);
        // DownloadFromStream(InS, '', '', '', ZipFileName);

        pdfsetup.Get();
        ZipFileName := format('O9Data_') + Format(CurrentDateTime) + '_.csv';
        FilePath := pdfsetup."PDF Temp File Path" + ZipFileName;
        TempBlob.CreateOutStream(ZipOutS);
        //DataCompression.SaveZipArchive(ZipOutS);

        TempBlob.CreateInStream(ZipInS);
        if not GuiAllowed then
            DownloadFromStream(ZipInS, '', '', '', ZipFileName)
        else begin
            fileMgt.BLOBExportToServerFile(TempBlob, FilePath);
            // ExportFile.Create(FilePath);
            // ExportFile.CreateOutStream(ZipOutS);
            // CopyStream(ZipOutS, ZipInS); // Copy data from InStream to OutStream
            // ExportFile.Close();


            //ExportFile.Close();
        end;

        // ZipFileName := format('O9Data_') + Format(CurrentDateTime) + '_.zip';
        // FilePath := 'C:\temp\' + ZipFileName;
        // TempBlob.CreateOutStream(ZipOutS);
        // DataCompression.SaveZipArchive(ZipOutS);
        // TempBlob.CreateInStream(ZipInS);
        // if  GuiAllowed then
        //     DownloadFromStream(ZipInS, '', '', '', ZipFileName)
        // else begin
        //     if ExportFile.Create(FilePath) then begin
        //         ExportFile.CreateOutStream(ZipOutS);
        //         CopyStream(ZipOutS, ZipInS); // Copy data from InStream to OutStream
        //         ExportFile.Close();
        //     end;

        //     //ExportFile.Close();
        // end;
    end;

    procedure SetStartEndDate(PstartDate: Date; PEndDate: Date; PDateformel: DateFormula)
    var
        myInt: Integer;
    begin
        if PstartDate = 0D then
            PStartDate := WorkDate();

        if PEndDate = 0D then
            PEndDate := WorkDate();

        if format(PDateformel) = '' then
            evaluate(PDateformel, '<3Y>');

        RefStartDate := PStartDate;
        RefEndDate := PEndDate;
        Dateformel := PDateformel;

    end;

    internal procedure InventoryExport(OutS: OutStream)
    begin
        Xmlport.Export(xmlport::"UTT O9Inventory-KPI", OutS);
    end;

    internal procedure ItemInventoryExport(OutS: OutStream)
    begin
        Xmlport.Export(xmlport::"UTT O9ItemInventory-KPI", OutS);
    end;

    internal procedure OnHandInventory_SP(OutS: OutStream)
    begin
        Xmlport.Export(xmlport::"UTT O9OnHandInventory_SP", OutS);
    end;

    internal procedure ApllcationDimExport(OutS: OutStream)
    begin
        Xmlport.Export(xmlport::"UTT O9ApplicationsDim", OutS);
    end;

    internal procedure QualityDimExport(OutS: OutStream)
    begin
        Xmlport.Export(xmlport::"UTT O9QualityDim", OutS);
    end;

    internal procedure QualityAssociationExport(OutS: OutStream)
    begin
        Xmlport.Export(xmlport::"UTT O9QualityAssociation", OutS);
    end;

    internal procedure ResourceMasterExport(OutS: OutStream)
    begin
        Xmlport.Export(xmlport::"UTT O9ResourceMaster", OutS);
    end;

    internal procedure ResourceAvailabilityExport(OutS: OutStream)
    begin
        Xmlport.Export(xmlport::"UTT O9ResourceAvailability", OutS);
    end;

    internal procedure ResourceAvailabilityTimeExport(OutS: OutStream)
    begin
        Xmlport.Export(xmlport::"UTT O9ResourceAvailTime_SP", OutS);
    end;

    internal procedure BOMMasterExport(OutS: OutStream)
    begin
        Xmlport.Export(xmlport::"UTT O9BOMMaster", OutS);
    end;

    internal procedure RtgMasterExport(OutS: OutStream)
    begin
        Xmlport.Export(xmlport::"UTT O9RountingMaster", OutS);
    end;

    internal procedure STO_Export(OutS: OutStream)
    begin
        Xmlport.Export(xmlport::"UTT o9 STO", OutS);
    end;

    internal procedure Pro_Export(OutS: OutStream)
    var
        O9PROXMLExport: XmlPort "UTT O9 Pro";
        StartDate: date;
        EndDate: date;
        StartDateFormel: DateFormula;
        EndDateFormel: DateFormula;
    begin
        StartDateFormel := Dateformel;
        EndDateFormel := Dateformel;
        if RefStartDate = RefEndDate then begin
            evaluate(StartDateFormel, '<1y>'); //purchase for last one year 
            StartDate := CalcDate(StrSubstNo('-%1', StartDateFormel), RefStartDate);
            EndDate := CalcDate(StrSubstNo('+%1', StartDateFormel), RefStartDate);

        end else begin
            StartDate := RefStartDate;
            EndDate := RefEndDate;
        end;

        // StartDateFormel := Dateformel;
        // EndDateFormel := Dateformel;

        // evaluate(StartDateFormel, '<1y>'); //purchase for last one year 
        // StartDate := CalcDate(StrSubstNo('-%1', StartDateFormel), RefStartDate);
        // EndDate := CalcDate(StrSubstNo('+%1', StartDateFormel), RefStartDate);

        O9PROXMLExport.SetDataFilter(StartDate, EndDate);
        //O9PROXMLExport.SetDataFilter(RefStartDate, RefEndDate);
        O9PROXMLExport.SetDestination(Outs);
        O9PROXMLExport.Export();


    end;

    // begin
    //     Xmlport.Export(xmlport::"UTT O9 Pro", OutS);
    // end;

    internal procedure InventoryCostPerUnit_SP_Export(OutS: OutStream)
    begin
        Xmlport.Export(xmlport::"UTT O9InventoryCostPerUnit_SP", OutS);
    end;

    internal procedure CleanupOldSnapshots()
    var
        O9Buffer: record "UTT IBPO9 Buffer";
    begin
        if Confirm(MsgCleanupOldSnapshots) then begin
            O9Buffer.DeleteAll();
            Message('Old snapshot data cleaned up successfully.');
        end;

    end;


    local procedure SaveOutStream(var TempBlob: Codeunit "Temp Blob"; FileName: Text)
    var
        MfgSetup: Record "Manufacturing Setup";
        InStrm: InStream;
        ExportFileOutStream: OutStream;
        FileMgt: Codeunit "File Management";
        ExportFile: File;
        DirName: Text;
        Extension: Text;
    begin
        MfgSetup.Get();
        MfgSetup.TestField("IBPO9ExportPath");

        FileName := MfgSetup."IBPO9ExportPath" + FileName;
        //FileName := '\\ivmkfs10.utt.de\programs\NAVISION\o9IBP\IVMK\' + FileName;

        DirName := FileMgt.GetDirectoryName(FileName);
        Extension := FileMgt.GetExtension(FileName);
        if Extension = '' then begin
            Extension := 'csv';
        end;
        FileName := FileMgt.CombinePath(DirName, FileName + '.' + Extension);

        ExportFile.Create(FileName, TextEncoding::UTF8);
        ExportFile.CreateOutStream(ExportFileOutStream);
        TempBlob.CreateInStream(InStrm);
        CopyStream(ExportFileOutStream, InStrm);
        ExportFile.Close();
    end;

    local procedure CreateInStream(JobName: text)
    var
        StartDate: date;
        EndDate: date;
        DateFormel: DateFormula;
    begin
        clear(TempBlob);
        TempBlob.CreateOutStream(OutS);
        case JobName of
            'MATERIAL':
                MaterialExport(OutS);
            'MATERIAL_SP':
                Material_SP_Export(OutS);
            'MATERIALASSOC':
                MaterialAssocExport(OutS);
            'LOCATION':
                LocationExport(OutS);
            'LOCATION_SP':
                LocationExport_SP(OutS);
            'UOM':
                UOMExport(OutS);
            'SUPPLIER':
                SupplierExport(OutS);
            'SUPPLIER_SP':
                SupplierExport_SP(OutS);
            'CUSTOMER':
                CustomerExport(OutS);
            'CUSTOMER_SP':
                CustomerExport_SP(OutS);
            'CUSTOMERASSOC':
                CustomerAssoc(OutS);
            'UOMCONV':
                UOMCOnvExport(OutS);
            'SALES':
                begin
                    SetStartEndDate(StartDate, EndDate, DateFormel);
                    SalesExport(OutS);
                end;
            'SALES_SP':
                begin
                    SetStartEndDate(StartDate, EndDate, DateFormel);
                    SalesExport_SP(OutS);
                end;
            'PURCHASE':
                begin
                    SetStartEndDate(StartDate, EndDate, DateFormel);
                    PurchaseExport(OutS);
                end;
            'PURCHASE_SP':
                begin
                    SetStartEndDate(StartDate, EndDate, DateFormel);
                    PurchaseExport_SP(OutS);
                end;
            'INVENTORY':
                ItemInventoryExport(OutS);
            'OnHandInventory':
                OnHandInventory_SP(OutS);

            'QUALITY':
                QualityDimExport(OutS);
            'QUALITYASSOC':
                QualityAssociationExport(OutS);
            'BOM_SP':
                BOMMasterExport(OutS);
            'Routing_SP':
                RtgMasterExport(OutS);
            'Resource_SP':
                ResourceMasterExport(OutS);
            'STO_SP':
                STO_Export(OutS);
            'PRO_SP':
                begin
                    SetStartEndDate(StartDate, EndDate, DateFormel);
                    Pro_Export(OutS);
                end;

            'INCOTERM':
                IncotermExport(OutS);
            'InventoryCostPerUnit_SP':
                InventoryCostPerUnit_SP_Export(OutS);

        end;

        TempBlob.CreateInStream(InS);
    end;

    local procedure GetLegalEntry(): text
    begin
        CompanyInfo.get();
        case CompanyInfo."Country/Region Code" of
            'DE':
                LegalEntity := 'IVMK';
            'MX':
                LegalEntity := 'IVMP';
        end;
    end;

    procedure GetCurrentXMLPortName(ObjectID: Integer): Text
    var
        AllObjWithCaption: Record AllObjWithCaption;
    begin
        AllObjWithCaption.SetRange("Object Type", AllObjWithCaption."Object Type"::XMLport);
        AllObjWithCaption.SetRange("Object ID", ObjectID);
        if AllObjWithCaption.FindFirst() then
            exit(AllObjWithCaption."Object Name")

    end;

    procedure CleanBuffer(SnapshotConfig: Record utto9SnapshotConfig)
    var
        O9Buffer: record "UTT IBPO9 Buffer";
    begin
        if SnapshotConfig.KeepHistory then
            exit;

        o9buffer.reset();
        o9buffer.setrange("Export Batch ID", SnapshotConfig.XMLPortName);
        o9buffer.deleteall();

    end;



    var
        TempBlob: Codeunit "Temp Blob";
        OutS: OutStream;
        InS: InStream;
        DataCompression: Codeunit "Data Compression";
        ZipFileName: Text[50];
        PdfFileName: Text[50];
        RefStartDate: date;
        RefEndDate: date;
        Dateformel: DateFormula;
        CompanyInfo: Record "Company Information";
        LegalEntity: text;
        MaterialLbl: Label 'Material';
        Material_SP_Lbl: Label 'Material_SP';
        Materialassoc: Label 'Material_Association';
        CustomerLbl: Label 'Customer';
        CustomerLbl_SP: Label 'Customer_SP';
        CustomerAssocLbl: Label 'Customer_Association';
        ActualSalesLbl: Label 'Actual_Sales';
        InventoryLbl: Label 'OnHandInventory';
        OnHandInventoryLbl: Label 'OnHandInventory';
        SupplierLbl: Label 'Supplier';
        SupplierLbl_SP: Label 'Supplier_SP';
        PO_PKI_Lbl: Label 'PO_KPI';
        PO_PKI_SP_Lbl: Label 'PO_SP_KPI';
        UOMConvLbl: Label 'UOM_Conversiion';
        QualityLbl: Label 'Quality';
        QualityAssocLbl: Label 'Quality_Association';
        UOMLbl: Label 'UOM';
        LocationLbl: Label 'Location';
        LocationLbl_SP: Label 'Location_SP';
        MaterialassocLbl: Label 'Material_Association';
        BomLbl: Label 'BomMaster';
        RtgLbl: Label 'RoutingMaster';
        ResourceAvaillbl: Label 'ResourceAvailability';
        ResourceAvailTimelbl: Label 'ResourceAvailabilityTimeGrain';
        STOLbl: Label 'STO';
        PROLbl: Label 'Pro';
        ActualSales_SPLbl: Label 'OpenSalesOrder';
        InventoryCostPerUnit_SP_Lbl: label 'InventoryCostPerUnit';
        MsgCleanupOldSnapshots: Label 'Are you sure you want to clean up old snapshots? This action cannot be undone.';


}