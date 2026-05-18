xmlport 67012 "UTT O9ApplicationAssoc"
{
    Caption = 'UTT O9ApplicationAssocation';
    Format = VariableText;
    Direction = Export;
    TextEncoding = UTF8;
    UseRequestPage = false;
    FileName = 'ApplicarionAssociation.dsv';
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
                textelement(ApplicationLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        ApplicationLbl := 'Application';
                    end;
                }
                textelement(MaterialLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        MaterialLbl := 'Material';
                    end;
                }

                textelement(SoldToLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        SoldToLbl := 'Sold-To';
                    end;
                }

            }
            tableelement(Customer; Customer)
            {
                XmlName = 'Customer';
                RequestFilterFields = Name;
                SourceTableView = sorting("No.") WHERE(name = filter(<> ''));
                textelement(application)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        case customer."KVS Customer Group" of
                            '100':
                                Application := 'Airbag';
                            '501':
                                Application := 'Airbag';
                            else
                                Application := 'Specialties';
                        end

                    end;
                }
                textelement(Material)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        Material := 'N/A';

                    end;
                }
                fieldelement(SoldTocust; customer."No.") { }
                
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



}
