report 67035 "UTT O9 Project Jobs"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    Caption = 'UTT O9IBP Jobs';
    ProcessingOnly = true;

    dataset
    {

        dataitem(Integer; Integer)
        {
            DataItemTableView = sorting(Number) where(Number = const(1));

            trigger OnAfterGetRecord()
            var
                OutS: OutStream;
                Ins: InStream;

                ZipFileName: Text[50];
                ZipInS: InStream;
                ZipOutS: OutStream;
                content: text;
                O9Buffer: Record "UTT IBPO9 Buffer";


            begin
                CompanyInfo.get();
              
                DataCompression.CreateZipArchive();

                if MaterialExport then begin
                    clear(TempBlob);
                    if GuiAllowed then begin
                        Window.Update(1, MaterialExportLbl);
                    end;
                    TempBlob.CreateOutStream(OutS);
                    O9ProjectLib.MaterialExport(OutS);

                    TempBlob.CreateInStream(InS);
                    //DataCompression.AddEntry(InS, StrSubstNo('%1_%2_%3%4',LegalEntity,'material_dim',format(CurrentDateTime),'.csv'));
                    DataCompression.AddEntry(InS, LegalEntity + '_' + MaterialLbl + '_' + Format(today, 0, '<year4><month,2><day,2>') + '.csv');
                end;
                if Material_SP_Export then begin
                    clear(TempBlob);
                    if GuiAllowed then begin
                        Window.Update(1, MaterialExport_SP_Lbl);
                    end;
                    TempBlob.CreateOutStream(OutS);
                    O9ProjectLib.Material_SP_Export(OutS);

                    TempBlob.CreateInStream(InS);
                    //DataCompression.AddEntry(InS, StrSubstNo('%1_%2_%3%4',LegalEntity,'material_dim',format(CurrentDateTime),'.csv'));
                    DataCompression.AddEntry(InS, LegalEntity + '_' + Material_SP_Lbl + '_' + Format(today, 0, '<year4><month,2><day,2>') + '.csv');
                end;
                 if InventoryCostPerUnit then begin
                    clear(TempBlob);
                    if GuiAllowed then begin
                        Window.Update(1, InventoryCostPerUnit_SP_Lbl);
                    end;
                    TempBlob.CreateOutStream(OutS);
                    O9ProjectLib.InventoryCostPerUnit_SP_Export(OutS);

                    TempBlob.CreateInStream(InS);
                    //DataCompression.AddEntry(InS, StrSubstNo('%1_%2_%3%4',LegalEntity,'material_dim',format(CurrentDateTime),'.csv'));
                    DataCompression.AddEntry(InS, LegalEntity + '_' + InventoryCostPerUnit_SP_Lbl + '_' + Format(today, 0, '<year4><month,2><day,2>') + '.csv');
                end;



                if MaterialAssoc then begin
                    clear(TempBlob);
                    if GuiAllowed then begin
                        Window.Update(1, MaterialAssocLbl);
                    end;
                    TempBlob.CreateOutStream(OutS);
                    O9ProjectLib.MaterialAssocExport(OutS);

                    TempBlob.CreateInStream(InS);
                    DataCompression.AddEntry(InS, LegalEntity + '_' + MaterialassocLbl + '_' + Format(today, 0, '<year4><month,2><day,2>') + '.csv');
                end;
                if LocationDim then begin
                    clear(TempBlob);
                    if GuiAllowed then begin
                        Window.Update(1, LocationDimLbl);
                    end;

                    TempBlob.CreateOutStream(OutS);
                    O9ProjectLib.LocationExport(OutS);

                    TempBlob.CreateInStream(InS);
                    DataCompression.AddEntry(InS, LegalEntity + '_' + LocationLbl + '_' + Format(today, 0, '<year4><month,2><day,2>') + '.csv');

                end;

                if LocationDim_SP then begin
                    clear(TempBlob);
                    if GuiAllowed then begin
                        Window.Update(1, LocationDimLbl_SP);
                    end;

                    TempBlob.CreateOutStream(OutS);
                    O9ProjectLib.LocationExport_SP(OutS);

                    TempBlob.CreateInStream(InS);
                    DataCompression.AddEntry(InS, LegalEntity + '_' + LocationLbl_SP + '_' + Format(today, 0, '<year4><month,2><day,2>') + '.csv');

                end;
                if ApplicationDim then begin
                    clear(TempBlob);
                    if GuiAllowed then begin
                        Window.Update(1, ApplicationDimLbl);
                    end;

                    TempBlob.CreateOutStream(OutS);
                    O9ProjectLib.ApllcationDimExport(OutS);

                    TempBlob.CreateInStream(InS);
                    DataCompression.AddEntry(InS, LegalEntity + '_' + ApplicationLbl + '_' + Format(today, 0, '<year4><month,2><day,2>') + '.csv');

                end;
                if ApplicationAssociation then begin
                    clear(TempBlob);
                    if GuiAllowed then begin
                        Window.Update(1, ApplicationDimLbl);
                    end;

                    TempBlob.CreateOutStream(OutS);
                    O9ProjectLib.ApplicationAssocExport(OutS);

                    TempBlob.CreateInStream(InS);
                    DataCompression.AddEntry(InS, LegalEntity + '_' + ApplicationAssocLbl + '_' + Format(today, 0, '<year4><month,2><day,2>') + '.csv');

                end;



                if CustomerDim then begin
                    clear(TempBlob);
                    if GuiAllowed then begin
                        Window.Update(1, CustomerDimLbl);
                    end;
                    TempBlob.CreateOutStream(OutS);
                    O9ProjectLib.CustomerExport(OutS);

                    TempBlob.CreateInStream(InS);
                    DataCompression.AddEntry(InS, LegalEntity + '_' + CustomerLbl + '_' + Format(today, 0, '<year4><month,2><day,2>') + '.csv');

                end;
                if CustomerDim_SP then begin
                    clear(TempBlob);
                    if GuiAllowed then begin
                        Window.Update(1, CustomerDimLbl_SP);
                    end;
                    TempBlob.CreateOutStream(OutS);
                    O9ProjectLib.CustomerExport_SP(OutS);

                    TempBlob.CreateInStream(InS);
                    DataCompression.AddEntry(InS, LegalEntity + '_' + CustomerLbl_SP + '_' + Format(today, 0, '<year4><month,2><day,2>') + '.csv');

                end;

                if CustomerAssoc then begin
                    clear(TempBlob);
                    if GuiAllowed then begin
                        Window.Update(1, CustomerAssocLbl);
                    end;
                    TempBlob.CreateOutStream(OutS);
                    O9ProjectLib.CustomerAssoc(OutS);

                    TempBlob.CreateInStream(InS);
                    DataCompression.AddEntry(InS, LegalEntity + '_' + CustomerAssocLbl + '_' + Format(today, 0, '<year4><month,2><day,2>') + '.csv');

                end;


                if SupplierDim then begin
                    clear(TempBlob);
                    if GuiAllowed then begin
                        Window.Update(1, SupplierDimLbl);
                    end;
                    TempBlob.CreateOutStream(OutS);
                    O9ProjectLib.SupplierExport(OutS);

                    TempBlob.CreateInStream(InS);
                    DataCompression.AddEntry(InS, LegalEntity + '_' + SupplierLbl + '_' + Format(today, 0, '<year4><month,2><day,2>') + '.csv');
                end;
                if SupplierDim_SP then begin
                    clear(TempBlob);
                    if GuiAllowed then begin
                        Window.Update(1, SupplierDimLbl_SP);
                    end;
                    TempBlob.CreateOutStream(OutS);
                    O9ProjectLib.SupplierExport_SP(OutS);

                    TempBlob.CreateInStream(InS);
                    DataCompression.AddEntry(InS, LegalEntity + '_' + SupplierLbl_SP + '_' + Format(today, 0, '<year4><month,2><day,2>') + '.csv');
                end;
                if UOMExport then begin
                    clear(TempBlob);
                    if GuiAllowed then begin
                        Window.Update(1, UOMExportLbl);
                    end;
                    TempBlob.CreateOutStream(OutS);
                    O9ProjectLib.UOMExport(OutS);

                    TempBlob.CreateInStream(InS);
                    DataCompression.AddEntry(InS, LegalEntity + '_' + UOMLbl + '_' + Format(today, 0, '<year4><month,2><day,2>') + '.csv');
                end;
                if UOMConversion then begin
                    clear(TempBlob);
                    if GuiAllowed then begin
                        Window.Update(1, UOMConversionLbl);
                    end;
                    TempBlob.CreateOutStream(OutS);
                    O9ProjectLib.UOMCOnvExport(OutS);

                    TempBlob.CreateInStream(InS);
                    DataCompression.AddEntry(InS, LegalEntity + '_' + UOMConversionLbl + '_' + Format(today, 0, '<year4><month,2><day,2>') + '.csv');
                end;
                // if InventoryExport then begin
                //     clear(TempBlob);
                //     if GuiAllowed then begin
                //         Window.Update(1, InventoryExportLbl);
                //     end;
                //     TempBlob.CreateOutStream(OutS);
                //     O9ProjectLib.InventoryExport(OutS);

                //     TempBlob.CreateInStream(InS);
                //     DataCompression.AddEntry(InS,LegalEntity+'_'+ 'Inventory_KPI'+'_'+Format(today,0,'<year4><month,2><day,2>')+ '.csv');
                // end;
                if InventoryExport2 then begin
                    clear(TempBlob);
                    if GuiAllowed then begin
                        Window.Update(1, ItemInventoryExportLbl);
                    end;
                    TempBlob.CreateOutStream(OutS);
                    O9ProjectLib.ItemInventoryExport(OutS);

                    TempBlob.CreateInStream(InS);
                    DataCompression.AddEntry(InS, LegalEntity + '_' + InventoryLbl + '_' + Format(today, 0, '<year4><month,2><day,2>') + '.csv');
                end;
                if QualityDim then begin
                    clear(TempBlob);
                    if GuiAllowed then begin
                        Window.Update(1, QualityDimLbl);
                    end;
                    TempBlob.CreateOutStream(OutS);
                    O9ProjectLib.QualityDimExport(OutS);

                    TempBlob.CreateInStream(InS);
                    DataCompression.AddEntry(InS, LegalEntity + '_' + QualityLbl + '_' + Format(today, 0, '<year4><month,2><day,2>') + '.csv');
                end;


                if SalesExport then begin
                    clear(TempBlob);
                    if GuiAllowed then begin
                        Window.Update(1, SalesExportLbl);
                    end;
                    //O9ProjectLib.SetStartEndDate(StartDate, EndDate, DateFormel);
                    //O9ProjectLib.SalesExport();
                    TempBlob.CreateOutStream(OutS);
                    O9ProjectLib.SetStartEndDate(StartDate, EndDate, DateFormel);
                    O9ProjectLib.SalesExport(OutS);

                    TempBlob.CreateInStream(InS);
                    DataCompression.AddEntry(InS, LegalEntity + '_' + ActualSalesLbl + '_' + Format(today, 0, '<year4><month,2><day,2>') + '.csv');
                end;
                if IncotermExport then begin
                    clear(TempBlob);
                    if GuiAllowed then begin
                        Window.Update(1, SalesExportLbl);
                    end;
                    //O9ProjectLib.SetStartEndDate(StartDate, EndDate, DateFormel);
                    //O9ProjectLib.SalesExport();
                    TempBlob.CreateOutStream(OutS);
                    O9ProjectLib.SetStartEndDate(StartDate, EndDate, DateFormel);
                    O9ProjectLib.IncotermExport(OutS);

                    TempBlob.CreateInStream(InS);
                    DataCompression.AddEntry(InS, LegalEntity + '_' + IncotermLbl + '_' + Format(today, 0, '<year4><month,2><day,2>') + '.csv');
                end;




                if PurchaseExport then begin
                    Clear(TempBlob);
                    if GuiAllowed then begin
                        Window.Update(1, PurchaseExportLbl);
                    end;
                    TempBlob.CreateOutStream(OutS);
                    O9ProjectLib.SetStartEndDate(StartDate, EndDate, DateFormel);
                    O9ProjectLib.PurchaseExport(OutS);

                    TempBlob.CreateInStream(InS);
                    DataCompression.AddEntry(InS, LegalEntity + '_' + PO_KPI_Lbl + '_' + Format(today, 0, '<year4><month,2><day,2>') + '.csv');

                end;
                 if PurchaseExport_SP then begin
                    Clear(TempBlob);
                    if GuiAllowed then begin
                        Window.Update(1, PurchaseExportLbl);
                    end;
                    TempBlob.CreateOutStream(OutS);
                    O9ProjectLib.SetStartEndDate(StartDate, EndDate, DateFormel);
                    O9ProjectLib.PurchaseExport_SP(OutS);

                    TempBlob.CreateInStream(InS);
                    DataCompression.AddEntry(InS, LegalEntity + '_' + PO_KPI_SP_Lbl + '_' + Format(today, 0, '<year4><month,2><day,2>') + '.csv');

                end;



                if QualityAsso then begin
                    clear(TempBlob);
                    if GuiAllowed then begin
                        Window.Update(1, QualityAssocLbl);
                    end;

                    TempBlob.CreateOutStream(OutS);
                    O9ProjectLib.QualityAssociationExport(OutS);

                    TempBlob.CreateInStream(InS);
                    DataCompression.AddEntry(InS, LegalEntity + '_' + QualityAssocLbl + '_' + Format(today, 0, '<year4><month,2><day,2>') + '.csv');

                end;


                if ResourceMaster then begin
                    clear(TempBlob);
                    if GuiAllowed then begin
                        Window.Update(1, ResourceMasterLbl);
                    end;
                    TempBlob.CreateOutStream(OutS);
                    O9ProjectLib.ResourceMasterExport(OutS);

                    TempBlob.CreateInStream(InS);
                    DataCompression.AddEntry(InS, LegalEntity + '_' +ResourceMasterLbl + '_' + Format(today, 0, '<year4><month,2><day,2>') + '.csv');
                end;
                if ResourceAvail then begin
                    clear(TempBlob);
                    if GuiAllowed then begin
                        Window.Update(1, ResourceMasterLbl);
                    end;
                    TempBlob.CreateOutStream(OutS);
                    O9ProjectLib.ResourceAvailabilityExport(OutS);

                    TempBlob.CreateInStream(InS);
                    DataCompression.AddEntry(InS, LegalEntity + '_' +ResourceAvailLbl + '_' + Format(today, 0, '<year4><month,2><day,2>') + '.csv');
                end;
                if ResourceAvailTime then begin
                    clear(TempBlob);
                    if GuiAllowed then begin
                        Window.Update(1, ResourceAvailTimeLbl);
                    end;
                    TempBlob.CreateOutStream(OutS);
                    O9ProjectLib.ResourceAvailabilityTimeExport(OutS);

                    TempBlob.CreateInStream(InS);
                    DataCompression.AddEntry(InS,LegalEntity + '_' + ResourceAvailTimeLbl + '_' + Format(today, 0, '<year4><month,2><day,2>') + '.csv');
                end;
                if BOMMaster then begin
                    clear(TempBlob);
                    if GuiAllowed then begin
                        Window.Update(1, BomMasterLbl);
                    end;
                    TempBlob.CreateOutStream(OutS);
                    O9ProjectLib.BOMMasterExport(OutS);

                    TempBlob.CreateInStream(InS);
                    DataCompression.AddEntry(InS, LegalEntity + '_' +BomMasterLbl+'_' + Format(today, 0, '<year4><month,2><day,2>') + '.csv');
                end;

                if RtgMaster then begin
                    clear(TempBlob);
                    if GuiAllowed then begin
                        Window.Update(1, RtgMasterLbl);
                    end;
                    TempBlob.CreateOutStream(OutS);
                    O9ProjectLib.RtgMasterExport(OutS);

                    TempBlob.CreateInStream(InS);
                    DataCompression.AddEntry(InS, LegalEntity + '_' +routingMasterLbl+'_' + Format(today, 0, '<year4><month,2><day,2>') + '.csv');
                end;
                if STO then begin
                    clear(TempBlob);
                    if GuiAllowed then begin
                        Window.Update(1, STOLbl);
                    end;
                    TempBlob.CreateOutStream(OutS);
                    O9ProjectLib.STO_Export(OutS);

                    TempBlob.CreateInStream(InS);
                    DataCompression.AddEntry(InS,LegalEntity + '_' + STOLbl + '_' + Format(today, 0, '<year4><month,2><day,2>') + '.csv');
                end;
                if PRO then begin
                    clear(TempBlob);
                    if GuiAllowed then begin
                        Window.Update(1, STOLbl);
                    end;
                    TempBlob.CreateOutStream(OutS);
                    O9ProjectLib.SetStartEndDate(StartDate, EndDate, DateFormel);
                    O9ProjectLib.Pro_Export(OutS);

                    TempBlob.CreateInStream(InS);
                    DataCompression.AddEntry(InS, LegalEntity + '_' +ProLbl + '_' + Format(today, 0, '<year4><month,2><day,2>') + '.csv');
                end;

                 if SalesExport_SP then begin
                    clear(TempBlob);
                    if GuiAllowed then begin
                        Window.Update(1, SalesExportLbl);
                    end;
                    //O9ProjectLib.SetStartEndDate(StartDate, EndDate, DateFormel);
                    //O9ProjectLib.SalesExport();
                    TempBlob.CreateOutStream(OutS);
                    O9ProjectLib.SetStartEndDate(StartDate, EndDate, DateFormel);
                    O9ProjectLib.SalesExport_SP(OutS);

                    TempBlob.CreateInStream(InS);
                    DataCompression.AddEntry(InS, LegalEntity + '_' + ActualSales_SPLbl + '_' + Format(today, 0, '<year4><month,2><day,2>') + '.csv');
                end;

                if OnHandInventory_SP then begin
                    clear(TempBlob);
                    if GuiAllowed then begin
                        Window.Update(1, OnHandInventoryLbl);
                    end;
                    TempBlob.CreateOutStream(OutS);
                    O9ProjectLib.OnHandInventory_SP(OutS);

                    TempBlob.CreateInStream(InS);
                    DataCompression.AddEntry(InS, LegalEntity + '_' + OnHandInventoryLbl+ '_' + Format(today, 0, '<year4><month,2><day,2>') + '.csv');
                end;







                createZipFile();

            end;



            trigger OnPreDataItem()
            begin
                CompanyInfo.get();
                case CompanyInfo."Country/Region Code" of
                    'DE':
                        LegalEntity := 'IVMK';
                    'MX':
                        LegalEntity := 'IVMP';
                end;

                if GuiAllowed then begin
                    Window.Open('###################################1#');
                end;
            end;

            trigger OnPostDataItem()
            begin
                if GuiAllowed then begin
                    Window.Close();
                end;
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(DP)
                {
                    Caption = 'Demand planning';
                    field(MaterialExport; MaterialExport)
                    {
                        ApplicationArea = All;
                        Caption = 'Material Export', Comment = 'DEU=Artikel Export';

                    }

                    field(MaterialAssoc; MaterialAssoc)
                    {
                        ApplicationArea = All;
                        Caption = 'Material Association';

                    }
                    field(LocationDim; LocationDim)
                    {
                        ApplicationArea = All;
                        Caption = 'Location Export', Comment = 'DEU=Lagerort Export';

                    }
                    field(CustomerDim; CustomerDim)
                    {
                        ApplicationArea = All;
                        Caption = 'Customer Export', Comment = 'DEU=Debitoren Export';
                    }
                    field(CustomerAssoc; CustomerAssoc)
                    {
                        ApplicationArea = All;
                        Caption = 'Customer Association';
                    }

                    field(SupplierDim; SupplierDim)
                    {
                        ApplicationArea = All;
                        Caption = 'Supplier Export', Comment = 'DEU=Kreditoren Export';

                    }

                    field(UOMConversion; UOMConversion)
                    {
                        Caption = 'UOM Conversion', Comment = 'Einheitenumrechungstabelle';
                        ApplicationArea = All;

                    }
                    // field(UOMExport; UOMExport)
                    // {
                    //     ApplicationArea = All;
                    //     Caption = 'UOM Export', Comment = 'DEU=Einheiten Export';

                    // }
                    // field(InventoryExport; InventoryExport)
                    // {
                    //     ApplicationArea = All;
                    //     Caption = 'Inventory Export', Comment = 'DEU= Lagerbestand Export';

                    // }
                    field(InventoryExport2; InventoryExport2)
                    {
                        ApplicationArea = All;
                        Caption = 'Item Inventory Export', Comment = 'DEU= Artikel Lagerbestand Export';

                    }
                    // field(ApplicationDim; ApplicationDim)
                    // {
                    //     ApplicationArea = All;
                    //     Caption = 'ApplicationDim', Comment = 'DEU= ApplicationDim';

                    // }
                    // field(ApplicationAssoc; ApplicationAssociation)
                    // {
                    //     ApplicationArea = All;
                    //     Caption = 'ApplicationAssociation', Comment = 'DEU= ApplicationAssocation';

                    // }
                    field(QualityDim; QualityDim)
                    {
                        ApplicationArea = All;
                        Caption = 'Quality Dim', Comment = 'DEU= Quality Dim';

                    }
                    field(QualityAsso; QualityAsso)
                    {
                        ApplicationArea = All;
                        Caption = 'Quality Association', Comment = 'DEU= Quality Association';

                    }
                    field(SalesExport; SalesExport)
                    {
                        ApplicationArea = All;
                        Caption = 'Sales Export', Comment = 'DEU= Verkaufszahlen Export';

                    }
                    field(StartDate; StartDate)
                    {
                        ApplicationArea = All;
                    }
                    field(EndDate; EndDate)
                    {
                        ApplicationArea = All;
                    }

                    field(DateFormel; DateFormel)
                    {
                        ApplicationArea = all;
                    }



                    field(PurchaseExport; PurchaseExport)
                    {
                        ApplicationArea = All;
                        Caption = 'Purchase Export', Comment = 'DEU=Einkaufszahlen Export';

                    }
                  



                }
                group(SP)
                {
                    Caption = 'Supply planning';
                    field(MaterialExport_SP; Material_SP_Export)
                    {
                        ApplicationArea = All;
                        Caption = 'Material_SP Export';

                    }
                    field(UOMConversion_SP; UOMConversion)
                    {
                        Caption = 'UOM Conversion', Comment = 'Einheitenumrechungstabelle';
                        ApplicationArea = All;

                    }
                    
                    field(LocationDim_SP; LocationDim_SP)
                    {
                        ApplicationArea = All;
                        Caption = 'Location_SP Export';

                    }
                    field(CustomerDim_SP; CustomerDim_SP)
                    {
                        ApplicationArea = All;
                        Caption = 'Customer SP Export';
                    }
                    field(SupplierDim_SP; SupplierDim_SP)
                    {
                        ApplicationArea = All;
                        Caption = 'Supplier SP Export';

                    }
                    field(ResourceMaster; ResourceMaster)
                    {
                        ApplicationArea = All;
                        Caption = 'Resource Master';
                    }
                    field(ResourceAvail; ResourceAvail)
                    {
                        ApplicationArea = All;
                        Caption = 'Resource Availability';
                    }
                    field(ResourceAvailTime; ResourceAvailTime)
                    {
                        ApplicationArea = All;
                        Caption = 'Resource Availability Time';
                    }

                    field(BOMMaster; BOMMaster)
                    {
                        ApplicationArea = All;
                        Caption = 'BOM Master';
                    }
                    field(RtgMaster; RtgMaster)
                    {
                        ApplicationArea = All;
                        Caption = 'Routing Master';
                    }
                    // field(STO; STO)
                    // {
                    //     ApplicationArea = All;
                    //     Caption = 'STO', Comment = 'DEU=STO Export';

                    // }
                    field(Pro; Pro)
                    {
                        ApplicationArea = All;
                        Caption = 'Pro', Comment = 'DEU=Pro Export';

                    }
                      field(IncotermExport; IncotermExport)
                    {
                        ApplicationArea = All;
                        Caption = 'Incoterm';

                    }
                      field(SalesExport_SP; SalesExport_SP)
                    {
                        ApplicationArea = All;
                        Caption = 'ActualSales_SP';

                    }
                      field(OnHandInventory_SP; OnHandInventory_SP)
                    {
                        ApplicationArea = All;
                        Caption = 'OnHandInventory_SP';

                    }
                       field(PurchaseExport_SP; PurchaseExport_SP)
                    {
                        ApplicationArea = All;
                        Caption = 'Purchase Export SP';

                    }
                      field(InventoryCostPerUnit_SP; InventoryCostPerUnit)
                    {
                        ApplicationArea = All;
                        Caption = 'InventoryCostPerUnit';

                    }





                }
            }
        }
    }
    trigger OnInitReport()
    var
        myInt: Integer;
    begin
        evaluate(DateFormel, '<3y>');
        StartDate := WorkDate();
        EndDate := WorkDate();
    end;


    local procedure createZipFile()
    var

        ZipOutS: OutStream;
        ZipInS: InStream;
        ZipFileName: text;


    begin
        ZipFileName := format('O9Data') + Format(CurrentDateTime) + '.zip';
        TempBlob.CreateOutStream(ZipOutS);
        DataCompression.SaveZipArchive(ZipOutS);
        TempBlob.CreateInStream(ZipInS);
        if GuiAllowed then
            DownloadFromStream(ZipInS, '', '', '', ZipFileName);
    end;

    var
        MaterialExportLbl: Label 'Material Export', MaxLength = 30, Comment = 'DEU=Artikel Export';
        MaterialExport_SP_Lbl: Label 'Material _SP Export', MaxLength = 30, Comment = 'DEU=Artikel Export';

        LocationDimLbl: Label 'Location Export', Comment = 'DEU=Lagerort export';
        LocationDimLbl_SP: Label 'Location Export DP', Comment = 'DEU=Lagerort export DP';
        CustomerDimLbl: Label 'Customer Export.', Comment = 'DEU=Debitoren Export';
        CustomerDimLbl_SP: Label 'Customer DP Export.', Comment = 'DEU=Debitoren DP Export';

        SupplierDimLbl: Label 'Supplier Export', Comment = 'DEU=Kreditoren Export';
        SupplierDimLbl_SP: Label 'Supplier DP Export ', Comment = 'DEU=Kreditoren DP Export';
        UOMExportLbl: Label 'UOM Export', Comment = 'DEU=Einheiten export';
        InventoryExportLbl: Label 'Inventory Export', Comment = 'DEU=Inventory export';
        ItemInventoryExportLbl: Label 'Item Inventory Export', Comment = 'DEU=Item Inventory export';

        UOMConversionLbl: Label 'UOM Conversion', Comment = 'DEU=Einheiten Umtrechnung';
        SalesExportLbl: Label 'Sales Export', Comment = 'DEU=Verkaufszahlen Export';
        PurchaseExportLbl: Label 'Purchase Export', Comment = 'DEU=Einkaufszahlen Export';
     PurchaseExportSPLbl: Label 'Purchase Export SP';
        ApplicationDimLbl: Label 'Application Dim Export';
        QualityDimLbl: Label 'Quality Dim Export';

        Window: Dialog;
        MaterialExport: Boolean;
        Material_SP_Export: Boolean;

        LocationDim: Boolean;
        LocationDim_SP: Boolean;
        CustomerDim: Boolean;
        CustomerDim_SP: Boolean;
        CustomerAssoc: Boolean;
        ApplicationAssociation: Boolean;
        SupplierDim: Boolean;
        SupplierDim_SP: Boolean;
        UOMExport: Boolean;
        UOMConversion: Boolean;
        SalesExport: Boolean;
        PurchaseExport: Boolean;
         PurchaseExport_SP: Boolean;
        InventoryExport: Boolean;
        InventoryExport2: Boolean;
        QualityDim: Boolean;

        O9SalesActualXML: XmlPort "UTT O9SalesActual";
        SIV: Record "UTT SalesBuffer";
        O9SalesActualRep: Report "UTT actualSales";
        StartDate: date;
        EndDate: date;
        DateFormel: DateFormula;
        O9ProjectLib: Codeunit "UTT O9 Project Lib";
        DataCompression: Codeunit "Data Compression";
        TempBlob: Codeunit "Temp Blob";
        ApplicationDim: Boolean;
        QualityAsso: Boolean;

        ResourceMaster: Boolean;
        ResourceAvail: Boolean;
        ResourceAvailTime: Boolean;
        ResourceMasterLbl: Label 'Resource Master Export';

        ResourceAvailLbl: Label 'Resource Availability Export';
        ResourceAvailTimeLbl: Label 'Resource Availability Time Export';
        BomMaster: Boolean;
        BomMasterLbl: Label 'BOM Master Export';

        RtgMaster: Boolean;
        RtgMasterLbl: Label 'Routing Master Export';
        companyInfo: Record "Company Information";
        LegalEntity: text;
        MaterialLbl: Label 'Material';
        Material_SP_Lbl: Label 'Material_SP';
        Materialassoc: Boolean;
        CustomerLbl: Label 'Customer';
        CustomerLbl_SP: Label 'Customer';
        CustomerAssocLbl: Label 'Customer_Association';
        ActualSalesLbl: Label 'Actual_Sales';
        InventoryLbl: Label 'OnHandInventory';
        SupplierLbl: Label 'Supplier';
        SupplierLbl_SP: Label 'Supplier';
        PO_KPI_Lbl: Label 'PO_KPI';
          PO_KPI_SP_Lbl: Label 'PO_SP_KPI';
        UOMConvLbl: Label 'UOM_Conversiion';
        QualityLbl: Label 'Quality';
        QualityAssocLbl: Label 'Quality_Association';
        UOMLbl: Label 'UOM';
        LocationLbl: Label 'Location';
        LocationLbl_SP: Label 'Location_SP';
        MaterialassocLbl: Label 'Material_Association';
        ApplicationLbl: label 'Application';
        ApplicationAssocLbl: Label 'Application_Association';
        STOLbl: Label 'STO';
        STO: Boolean;
        ProLbl: Label 'PrO';
        Pro: Boolean;
        IncotermLbl:label 'Incoterm';
        IncotermExport : Boolean;
        SalesExport_SP:Boolean;
        ActualSales_SPLbl:Label 'cust_orders';
        routingMasterLbl: label 'RoutingMaster';
        OnHandInventory_SP:Boolean;
        OnHandInventoryLbl:label 'OnHandInventory';
        InventoryCostPerUnit:Boolean;
        InventoryCostPerUnit_SP_Lbl :label 'InventoryCostPerUnit';






}