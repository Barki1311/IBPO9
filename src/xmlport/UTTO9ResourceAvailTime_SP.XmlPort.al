xmlport 67024 "UTT O9ResourceAvailTime_SP"
{
    Caption = 'UTT O9 Resource Availabiliy Time';
    Format = VariableText;
    Direction = Export;
    TextEncoding = UTF8;
    UseRequestPage = false;
    FileName = 'IVMK_P_o9ResourceAvaiTime.dsv';
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

                textelement(ResourceCodeLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        ResourceCodeLbl := 'ResourceCode';
                    end;
                }
                textelement(LocationCodeLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        LocationCodelbl := 'LocationCode';
                    end;
                }
                textelement(DayLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        DayLbl := 'Day';
                    end;
                }
                textelement(ResourceAvailabilityLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        ResourceAvailabilityLbl := 'ResourceAvailability(in Hours/Days)';
                    end;
                }
               
            }
            tableelement(MachineCenter; "Machine Center")
            {
                XmlName = 'Data';
                // SourceTableView = sorting("No.") WHERE("KVSTEX Item Type" = filter("Finished Product" | "yarn"));
                RequestFilterFields = "No.";

                textelement(ResourceCode)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        ResourceCode := MachineCenter."No.";

                    end;
                }

                textelement(LocationCode)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                        
                    begin
                      case CompanyInfo."Country/Region Code" of
                            'DE':
                                LocationCode := 'IVMK';
                            'MX':
                                LocationCode := 'IVMP';
                        end;
                    end;
                }
                  textelement(wDayLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        wDayLbl := 'N/A';
                    end;
                }
                textelement(wResourceAvailabilityLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        wResourceAvailabilityLbl := 'N/A';
                    end;
                }

                trigger OnPreXmlItem()
                var
                    myInt: Integer;
                begin

                    // MachineCenter.Setfilter("KVSTEX Item Type", '%1|%2|%3', item."KVSTEX Item Type"::"Finished Product", item."KVSTEX Item Type"::Yarn, item."KVSTEX Item Type"::"KVS Cutset", item."KVSTEX Item Type"::"KVS Colour Ribbon");
                    // item.SetRange("KVSTEX Item Status", item."KVSTEX Item Status"::Certified);

                    companyInfo.get();
                end;

            }
            tableelement(WorkCenter; "Work Center")
            {
                XmlName = 'Data';
                // SourceTableView = sorting("No.") WHERE("KVSTEX Item Type" = filter("Finished Product" | "yarn"));
                RequestFilterFields = "No.";

                textelement(wResourceCode)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        wResourceCode := WorkCenter."No.";

                    end;
                }

              textelement(wLocationCode)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                        
                    begin
                      case CompanyInfo."Country/Region Code" of
                            'DE':
                                wLocationCode := 'IVMK';
                            'MX':
                                wLocationCode := 'IVMP';
                        end;
                    end;
                }
                 textelement(wResourceAvailability)
                {
                    trigger OnBeforePassVariable()
                    begin
                        wResourceAvailability := 'N/A';
                    end;
                }
                textelement(wResourceEfficiency)
                {
                    trigger OnBeforePassVariable()
                    begin
                        wResourceEfficiency := 'N/A';
                    end;
                }
                textelement(wAverageDailyMaintenanceHours)
                {
                    trigger OnBeforePassVariable()
                    begin
                        wAverageDailyMaintenanceHours := 'N/A';
                    end;
                }
                textelement(wAverageDailySetupHours)
                {
                    trigger OnBeforePassVariable()
                    begin
                        wAverageDailySetupHours := 'N/A';
                    end;
                }



                trigger OnPreXmlItem()
                var
                    myInt: Integer;
                begin

                    // MachineCenter.Setfilter("KVSTEX Item Type", '%1|%2|%3', item."KVSTEX Item Type"::"Finished Product", item."KVSTEX Item Type"::Yarn, item."KVSTEX Item Type"::"KVS Cutset", item."KVSTEX Item Type"::"KVS Colour Ribbon");
                    // item.SetRange("KVSTEX Item Status", item."KVSTEX Item Status"::Certified);

                    //companyInfo.get();
                end;

            }


        }

    }
    var
        companyInfo: Record "Company Information";

}
