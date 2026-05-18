xmlport 67020 "UTT O9LocationDim_SP"
{
    Caption = 'UTT O9LocationDim_SP';
    Format = VariableText;
    Direction = Export;
    TextEncoding = UTF8;
    UseRequestPage = false;
    FileName = 'IVMK_LocationDim_SP.dsv';
    TableSeparator = '<NewLine>';
    FieldSeparator = '|';
    schema
    {
        //Location Code	Location Description	Legal Entity Code	Legal Entity Description	Segment	Segment Description	Country	Region
        textelement(Root)
        {

            tableelement(Integer; Integer)
            {
                XmlName = 'Header';
                SourceTableView = SORTING(Number) WHERE(Number = CONST(1));
                textelement(LocationLabel)
                {
                    trigger OnBeforePassVariable()
                    begin
                        LocationLabel := 'LocationCode';
                        IBPO9Buffer."Field 1" := LocationLabel;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(LocationDescLabel)
                {
                    trigger OnBeforePassVariable()
                    begin
                        LocationDescLabel := 'LocationDescription';
                        IBPO9Buffer."Field 2" := LocationDescLabel;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(LegalEntityLabel)
                {
                    trigger OnBeforePassVariable()
                    begin
                        LegalEntityLabel := 'LegalEntityCode';
                        IBPO9Buffer."Field 3" := LegalEntityLabel;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(LegalEntityDescLabel)
                {
                    trigger OnBeforePassVariable()
                    begin
                        LegalEntityDescLabel := 'LegalEntityDescription';
                        IBPO9Buffer."Field 4" := LegalEntityDescLabel;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(SegmentLabel)
                {
                    trigger OnBeforePassVariable()
                    begin
                        SegmentLabel := 'Segment';
                        IBPO9Buffer."Field 5" := SegmentLabel;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(SegmentDescLabel)
                {
                    trigger OnBeforePassVariable()
                    begin
                        SegmentDescLabel := 'SegmentDescription';
                        IBPO9Buffer."Field 6" := SegmentDescLabel;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(ContryLabel)
                {
                    trigger OnBeforePassVariable()
                    begin
                        ContryLabel := 'Country';
                        IBPO9Buffer."Field 7" := ContryLabel;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(CountryDescLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        CountryDescLbl := 'CountryDescription';
                        IBPO9Buffer."Field 8" := CountryDescLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(RegionLabel)
                {
                    trigger OnBeforePassVariable()
                    begin
                        RegionLabel := 'Region';
                        IBPO9Buffer."Field 9" := RegionLabel;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(RegioDescLbl)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        RegioDescLbl := 'RegionDescription';
                        IBPO9Buffer."Field 10" := RegioDescLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(PlanningLocationCodeLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        PlanningLocationCodeLbl := 'PlanningLocationCode';
                        IBPO9Buffer."Field 11" := PlanningLocationCodeLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(PlanningLocationDescriptionLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        PlanningLocationDescriptionLbl := 'PlanningLocationDescription';
                        IBPO9Buffer."Field 12" := PlanningLocationDescriptionLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(LocationTypeLbl)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        LocationTypeLbl := '';
                        IBPO9Buffer."Field 13" := LocationTypeLbl;
                        IBPO9Buffer.Modify();
                    end;
                }

                // textelement(ProductMarketLbl)
                // {
                //     trigger OnBeforePassVariable()
                //     var
                //         myInt: Integer;
                //     begin
                //         ProductMarketLbl := 'ProductMarket'
                //     end;
                // }
                // textelement(PlanningLocationLbl)
                // {
                //     trigger OnBeforePassVariable()
                //     var
                //         myInt: Integer;
                //     begin
                //         PlanningLocationLbl := 'PlanningLocation'
                //     end;
                // }

                trigger OnAfterGetRecord()
                begin
                    IBPO9Buffer.Init();
                    if not IBPO9Buffer.FindLast() then begin
                        IBPO9Buffer."Entry No." := 1;
                    end else begin
                        IBPO9Buffer."Entry No." := IBPO9Buffer."Entry No." + 1;
                    end;
                    IBPO9Buffer."Export Date" := CurrentDateTime();
                    IBPO9Buffer."Export Batch ID" := 'LOCATION_SP';
                    IBPO9Buffer.Insert();
                end;

            }
            tableelement(Location; Integer)
            {
                XmlName = 'Location';
                SourceTableView = SORTING(Number) WHERE(Number = CONST(1));

                textelement(Locationcode)
                {
                    trigger OnBeforePassVariable()
                    begin
                        case CompanyInfo."Country/Region Code" of
                            'DE':
                                Locationcode := 'IVMK';
                            'MX':
                                Locationcode := 'IVMP';
                        end;
                        IBPO9Buffer."Field 1" := Locationcode;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(Description)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        case CompanyInfo."Country/Region Code" of
                            'DE':
                                Description := 'IVMK';
                            'MX':
                                Description := 'IVMP';
                        end;
                        IBPO9Buffer."Field 2" := Description;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(LegalEntity)
                {
                    trigger OnBeforePassVariable()
                    begin
                        case CompanyInfo."Country/Region Code" of
                            'DE':
                                LegalEntity := 'IVMK';
                            'MX':
                                LegalEntity := 'IVMP';
                        end;
                        IBPO9Buffer."Field 3" := LegalEntity;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(LegalEntityDesc)
                {
                    trigger OnBeforePassVariable()
                    begin
                        LegalEntityDesc := CompanyInfo.Name;
                        IBPO9Buffer."Field 4" := LegalEntityDesc;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(Segment)
                {
                    trigger OnBeforePassVariable()
                    begin
                        Segment := 'Fibers';
                        IBPO9Buffer."Field 5" := Segment;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(SegmentDesc)
                {
                    trigger OnBeforePassVariable()
                    begin
                        SegmentDesc := 'Fibers';
                        IBPO9Buffer."Field 6" := SegmentDesc;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(Country)
                {
                    trigger OnBeforePassVariable()
                    begin
                        Country := CompanyInfo."Country/Region Code";
                        if Country = '' then begin
                            Country := CompanyInfo."Country/Region Code"
                        end;
                        IBPO9Buffer."Field 7" := Country;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(CountryDesc)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        CountryDesc := 'N/A';
                        IBPO9Buffer."Field 8" := CountryDesc;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(Region)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        Region := 'N/A';
                        IBPO9Buffer."Field 9" := Region;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(RegionDesc)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        RegionDesc := 'N/A';
                        IBPO9Buffer."Field 10" := RegionDesc;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(PlanningLocationCode)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        case CompanyInfo."Country/Region Code" of
                            'DE':
                                PlanningLocationCode := 'IVMK';
                            'MX':
                                PlanningLocationCode := 'IVMP';
                        end;
                        IBPO9Buffer."Field 11" := PlanningLocationCode;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(PlanningLocationDescription)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        case CompanyInfo."Country/Region Code" of
                            'DE':
                                PlanningLocationDescription := 'IVMK';
                            'MX':
                                PlanningLocationDescription := 'IVMP';
                        end;
                        IBPO9Buffer."Field 12" := PlanningLocationDescription;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(LocationType)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        LocationType := 'Plant';
                        IBPO9Buffer."Field 13" := LocationType;
                        IBPO9Buffer.Modify();
                    end;
                }

                // textelement(ProductMarket)
                // {
                //     trigger OnBeforePassVariable()
                //     var
                //         myInt: Integer;
                //     begin
                //         ProductMarket := 'Mobility'
                //     end;
                // }
                // textelement(PlanningLocation)
                // {
                //     trigger OnBeforePassVariable()
                //     var
                //         myInt: Integer;
                //     begin
                //         case CompanyInfo."Country/Region Code" of
                //             'DE':
                //                 PlanningLocation := 'IVMK';
                //             'MX':
                //                 PlanningLocation := 'IVMP';
                //         end;
                //         ;
                //     end;
                // }

                trigger OnAfterGetRecord()
                begin
                    IBPO9Buffer.Init();
                    if not IBPO9Buffer.FindLast() then begin
                        IBPO9Buffer."Entry No." := 1;
                    end else begin
                        IBPO9Buffer."Entry No." := IBPO9Buffer."Entry No." + 1;
                    end;
                    IBPO9Buffer."Export Date" := CurrentDateTime();
                    IBPO9Buffer."Export Batch ID" := 'LOCATION_SP';
                    IBPO9Buffer.Insert();
                end;

                trigger OnPreXmlItem()
                var
                    myInt: Integer;
                begin
                    CompanyInfo.get();
                end;
            }

        }


    }
    var
        CompanyInfo: record "Company Information";
        IBPO9Buffer: Record "UTT IBPO9 Buffer";

}
