xmlport 67001 "UTT O9CustomerDim"
{
    Caption = 'UTT O9CustomerDim_DP';
    Format = VariableText;
    Direction = Export;
    TextEncoding = UTF8;
    UseRequestPage = false;
    FileName = 'CustomerDim_DP.dsv';
    TableSeparator = '<NewLine>';
    FieldSeparator = '|';
    schema
    {
        textelement(Root)
        {

            tableelement(Integer; Integer)
            {
                XmlName = 'Header';
                SourceTableView = SORTING(Number) WHERE(Number = CONST(1));
                textelement(ShipToLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        ShipToLbl := 'ShipTo';
                        IBPO9Buffer."Field 1" := ShipToLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(ShipToDescLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        ShipToDescLbl := 'ShipToDescription';
                        IBPO9Buffer."Field 2" := ShipToDescLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(SoldTocustLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        SoldTocustLbl := 'SoldTo';
                        IBPO9Buffer."Field 3" := SoldTocustLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(SoldToCustDesctLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        SoldToCustDesctLbl := 'SoldToDescription';
                        IBPO9Buffer."Field 4" := SoldToCustDesctLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(KeyAccountLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        KeyAccountLbl := 'KeyAccounts';
                        IBPO9Buffer."Field 5" := KeyAccountLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(KeyAccountDescLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        KeyAccountDescLbl := 'KeyAccountsDescription';
                        IBPO9Buffer."Field 6" := KeyAccountDescLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(KeyCustomerLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        KeyCustomerLbl := 'KeyCustomer';
                        IBPO9Buffer."Field 7" := KeyCustomerLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(CustomerGrpLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        CustomerGrpLbl := 'CustomerGroup';
                        IBPO9Buffer."Field 8" := CustomerGrpLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(CustomerGrpDescLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        CustomerGrpDescLbl := 'CustomerGroupDescription';
                        IBPO9Buffer."Field 9" := CustomerGrpDescLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(RegionLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        RegionLbl := 'Region';
                        IBPO9Buffer."Field 10" := RegionLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(RegionDescLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        RegionDescLbl := 'RegionDescription';
                        IBPO9Buffer."Field 11" := RegionDescLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(CountryLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        CountryLbl := 'Country';
                        IBPO9Buffer."Field 12" := CountryLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(CountryDescLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        CountryDescLbl := 'CountryDescription';
                        IBPO9Buffer."Field 13" := CountryDescLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(SalesManagerLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        SalesManagerLbl := 'SalesManager';
                        IBPO9Buffer."Field 14" := SalesManagerLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(SalesManagerDescLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        SalesManagerDescLbl := 'SalesManagerDescription';
                        IBPO9Buffer."Field 15" := SalesManagerDescLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(SalesOfficeLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        SalesOfficeLbl := 'SalesOffice';
                        IBPO9Buffer."Field 16" := SalesOfficeLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(SalesOfficeDescLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        SalesOfficeDescLbl := 'SalesOfficeDescription';
                        IBPO9Buffer."Field 17" := SalesOfficeDescLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(SalesOrgLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        SalesOrgLbl := 'SalesOrg';
                        IBPO9Buffer."Field 18" := SalesOrgLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(SalesOrgDescLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        SalesOrgDescLbl := 'SalesOrgDescription';
                        IBPO9Buffer."Field 19" := SalesOrgDescLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(SegmentLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        SegmentLbl := 'SegmentCode';
                        IBPO9Buffer."Field 20" := SegmentLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(SegmentDescLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        SegmentDescLbl := 'SegmentDescription';
                        IBPO9Buffer."Field 21" := SegmentDescLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(DistributionLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        DistributionLbl := 'DistributionChannel';
                        IBPO9Buffer."Field 22" := DistributionLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(CustomerTypeLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        CustomerTypeLbl := 'CustomerType';
                        IBPO9Buffer."Field 23" := CustomerTypeLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(IsCustomerActiveLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        IsCustomerActiveLbl := 'IsCustomerActive';
                        IBPO9Buffer."Field 24" := IsCustomerActiveLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(LocationcodeLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        LocationcodeLbl := 'LocationCode';
                        IBPO9Buffer."Field 25" := LocationcodeLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                // textelement(ProductMarketLbl)
                // {
                //     trigger OnBeforePassVariable()
                //     begin
                //         ProductMarketLbl := 'ProductMarket';
                //     end;
                // }

                trigger OnAfterGetRecord()
                var
                    EntryNo: Integer;
                begin
                    EntryNo := IBPO9Buffer.getNextEntry();
                    IBPO9Buffer.Init();
                    IBPO9Buffer."Entry No." := EntryNo;
                    IBPO9Buffer."Export Date" := CurrentDateTime();
                    IBPO9Buffer."Export Batch ID" := o9ProjectLib.GetCurrentXMLPortName(67001);
                    IBPO9Buffer.Insert();
                end;

            }
            tableelement(Customer; Customer)
            {
                XmlName = 'Customer';
                RequestFilterFields = Name;
                SourceTableView = sorting("No.") WHERE(name = filter(<> ''));
                textelement(ShipTo)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        ShipTo := Customer."No.";
                        IBPO9Buffer."Field 1" := ShipTo;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(ShipToDesc)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        ShipToDesc := Customer.Name;
                        IBPO9Buffer."Field 2" := ShipToDesc;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(SoldTocust)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        SoldTocust := Customer."No.";
                        IBPO9Buffer."Field 3" := SoldTocust;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(SoldToCustDesc)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        SoldToCustDesc := Customer.Name;
                        IBPO9Buffer."Field 4" := SoldToCustDesc;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(KeyAccount)
                {
                    trigger OnBeforePassVariable()
                    begin
                        KeyAccount := 'N/A';
                        IBPO9Buffer."Field 5" := KeyAccount;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(KeyAccountDesc)
                {
                    trigger OnBeforePassVariable()
                    begin
                        KeyAccountDesc := 'N/A';
                        IBPO9Buffer."Field 6" := KeyAccountDesc;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(KeyCustomer)
                {
                    trigger OnBeforePassVariable()
                    begin
                        KeyCustomer := 'N/A';
                        IBPO9Buffer."Field 7" := KeyCustomer;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(CustomerGrp)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        CustomerGrp := 'N/A';
                        IBPO9Buffer."Field 8" := CustomerGrp;
                        IBPO9Buffer.Modify();
                    end;
                }

                textelement(CustomerGrpDesc)
                {
                    trigger OnBeforePassVariable()
                    var
                        DimValue: Record "Dimension Value";
                    begin
                        CustomerGrpDesc := 'N/A';
                        IBPO9Buffer."Field 9" := CustomerGrpDesc;
                        IBPO9Buffer.Modify();
                    end;
                }


                textelement(Region)
                {
                    trigger OnBeforePassVariable()
                    begin
                        Region := 'N/A';
                        IBPO9Buffer."Field 10" := Region;
                        IBPO9Buffer.Modify();
                    end;
                }

                textelement(RegionDesc)
                {
                    trigger OnBeforePassVariable()
                    begin
                        RegionDesc := 'N/A';
                        IBPO9Buffer."Field 11" := RegionDesc;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(Country)
                {
                    trigger OnBeforePassVariable()
                    var
                        CompanyInfo: Record "Company Information";
                    begin
                        clear(Country);
                        CompanyInfo.get();
                        Country := Customer."Country/Region Code";
                        if (Country = '') and (customer."Customer Posting Group" in ['Inland', 'NACIONAL']) then
                            Country := CompanyInfo."Country/Region Code";
                        IBPO9Buffer."Field 12" := Country;
                        IBPO9Buffer.Modify();
                    end;
                }

                textelement(CountryDesc)
                {
                    trigger OnBeforePassVariable()
                    var
                        CountryRegion: Record "Country/Region";
                        CompanyInfo: Record "Company Information";
                    begin
                        Clear(CountryDesc);
                        CompanyInfo.get();
                        if (Customer."Country/Region Code" = '') and (customer."Customer Posting Group" in ['Inland', 'NACIONAL']) then
                            Customer."Country/Region Code" := CompanyInfo."Country/Region Code";
                        if CountryRegion.get(Customer."Country/Region Code") then
                            CountryDesc := CountryRegion.Name;
                        IBPO9Buffer."Field 13" := CountryDesc;
                        IBPO9Buffer.Modify();

                    end;
                }
                textelement(SalesManager)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        Clear(SalesManager);
                        SalesManager := 'N/A';
                        IBPO9Buffer."Field 14" := SalesManager;
                        IBPO9Buffer.Modify();

                    end;
                }

                textelement(SalesManagerDesc)
                {
                    trigger OnBeforePassVariable()
                    var
                        Salesperson: Record "Salesperson/Purchaser";
                    begin
                        Clear(SalesManagerDesc);
                        SalesManagerDesc := 'N/A';
                        IBPO9Buffer."Field 15" := SalesManagerDesc;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(SalesOffice)
                {
                    trigger OnBeforePassVariable()
                    var
                        CompanyInfo: Record "Company Information";
                    begin
                        CompanyInfo.get();
                        case CompanyInfo."Country/Region Code" of
                            'DE':
                                SalesOffice := 'IVMK';
                            'MX':
                                SalesOffice := 'IVMP';
                        end;
                        IBPO9Buffer."Field 16" := SalesOffice;
                        IBPO9Buffer.Modify();
                    end;
                }

                textelement(SalesOfficeDesc)
                {
                    trigger OnBeforePassVariable()
                    var
                        CompanyInfo: Record "Company Information";
                    begin
                        CompanyInfo.get();
                        SalesOfficeDesc := CompanyInfo.name;
                        IBPO9Buffer."Field 17" := SalesOfficeDesc;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(SalesOrg)
                {
                    trigger OnBeforePassVariable()
                    var
                        CompanyInfo: Record "Company Information";
                    begin
                        CompanyInfo.get();
                        case CompanyInfo."Country/Region Code" of
                            'DE':
                                SalesOrg := 'IVMK';
                            'MX':
                                SalesOrg := 'IVMP';
                            else
                                SalesOrg := 'N/A';

                        end;
                        IBPO9Buffer."Field 18" := SalesOrg;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(SalesOrgDesc)
                {
                    trigger OnBeforePassVariable()
                    var
                        CompanyInfo: Record "Company Information";
                    begin
                        CompanyInfo.get();
                        case CompanyInfo."Country/Region Code" of
                            'DE':
                                SalesOrgDesc := 'IVMK';
                            'MX':
                                SalesOrgDesc := 'IVMP';
                            else
                                SalesOrgDesc := 'N/A';

                        end;
                        IBPO9Buffer."Field 19" := SalesOrgDesc;
                        IBPO9Buffer.Modify();
                    end;
                }

                textelement(Segment)
                {
                    trigger OnBeforePassVariable()
                    begin
                        Segment := 'Fibers';
                        IBPO9Buffer."Field 20" := Segment;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(SegmentDesc)
                {
                    trigger OnBeforePassVariable()
                    begin
                        SegmentDesc := 'Fibers';
                        IBPO9Buffer."Field 21" := SegmentDesc;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(Distribution)
                {
                    trigger OnBeforePassVariable()
                    begin
                        Distribution := 'N/A';
                        IBPO9Buffer."Field 22" := Distribution;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(CustomerType)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        clear(CustomerType);
                        case customer."Gen. Bus. Posting Group" of
                            'INLAND':
                                CustomerType := 'Local';
                            'NACIONAL':
                                CustomerType := 'Local'
                            else
                                CustomerType := 'Global';
                        end;
                        IBPO9Buffer."Field 23" := CustomerType;
                        IBPO9Buffer.Modify();
                    end;

                }
                textelement(IsCustomerActive)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        if not Customer.KVSInactive then
                            IsCustomerActive := 'Yes'
                        else
                            IsCustomerActive := 'No';
                        IBPO9Buffer."Field 24" := IsCustomerActive;
                        IBPO9Buffer.Modify();

                    end;
                }
                textelement(LocationCode)
                {
                    trigger OnBeforePassVariable()
                    var
                        CompanyInfo: Record "Company Information";
                    begin
                        CompanyInfo.get();
                        case CompanyInfo."Country/Region Code" of
                            'DE':
                                LocationCode := 'IVMK';
                            'MX':
                                LocationCode := 'IVMP';

                        end;
                        IBPO9Buffer."Field 25" := LocationCode;
                        IBPO9Buffer.Modify();
                    end;
                }
                trigger OnAfterGetRecord()
                var
                    EntryNo: Integer;
                begin
                    EntryNo := IBPO9Buffer.getNextEntry();
                    IBPO9Buffer.Init();
                    IBPO9Buffer."Entry No." := EntryNo;
                    IBPO9Buffer."Export Date" := CurrentDateTime();
                    IBPO9Buffer."Export Batch ID" := O9ProjectLib.GetCurrentXMLPortName(67001);
                    IBPO9Buffer.Insert();
                end;

                // textelement(ProductMarket)
                // {
                //     trigger OnBeforePassVariable()
                //     begin
                //         ProductMarket := 'Mobility';
                //     end;
                // }


                trigger OnPreXmlItem()
                var
                    myInt: Integer;
                begin
                    Customer.setfilter("Gen. Bus. Posting Group", '<>%1', '');
                    customer.SetFilter(name, '<>%1', '');

                end;


            }

        }


    }
    var
        IBPO9Buffer: Record "UTT IBPO9 Buffer";
        o9ProjectLib: Codeunit "UTT O9 Project Lib";



}
