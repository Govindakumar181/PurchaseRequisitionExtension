page 70101 "Purchase Requisition"
{
    Caption = 'Purchase Requisition';
    PageType = Document;
    SourceTable = "Purchase Requisition Header";



    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field("PR No."; Rec."PR No.")
                {
                    ApplicationArea = All;
                    Caption = 'No.';
                    visible = false;
                }
                field(Reason; Rec.Reason)
                {
                    ApplicationArea = All;
                    Caption = 'Reason';
                    Enabled = varIsEditiable;


                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Caption = 'Description';
                    Enabled = varIsEditiable;

                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                    Caption = 'Document Date';
                    Enabled = false;

                }
                field("Raised By"; Rec."Raised By")
                {
                    ApplicationArea = All;
                    Caption = 'Raised By';
                    visible = false;


                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Caption = 'Status';
                    Enabled = false;

                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;
                    Caption = 'Due Date';
                    Enabled = varIsEditiable;
                }

            }
            part(RequisitionLine; "Purchase Requistion SubForm")
            {
                ApplicationArea = All;
                SubPageLink = "PR No." = field("PR No.");
                Enabled = varIsEditiable;
            }
        }
    }

    actions
    {
        area(processing)
        {

            action(ConvertToPO)
            {
                ApplicationArea = All;
                Caption = 'Convert To PO';
                Image = MakeOrder;
                ShortCutKey = 'Alt+D';
                ToolTip = 'Convert purchase requisition to a purchase order. The purchase order will contain the purchase requisition number.';

                trigger OnAction()
                var
                    varPurchReq: Codeunit ConvertToPO;
                    varStatus: Text;
                    varStatusCheck: Record "Purchase Requisition Header";
                    varCurrentUser2: Record User;
                    varPermissions2: Record "Access Control";
                    varPo: Record "Purchase Header";
                    varPORef: Text;


                begin
                    varStatus := Rec.Status;
                    //varPo.SETFILTER("Purchase Requisition", rec."PR No.");
                    //varPORef := varPo."Purchase Requisition";

                    //finding the current user role in PO permission set
                    varCurrentUser2.SETFILTER("User Name", UserId());
                    If varCurrentUser2.FindSet() then begin
                        varPermissions2.SetFilter("User Security ID", varCurrentUser2."User Security ID");
                        varPermissions2.SetFilter("Role ID", '%1|%2', 'PURCHREQPO', 'SUPER');
                        if varPermissions2.FindSet() then begin
                            if (varStatus = 'Approved') then
                                //if (varPORef = '') then
                                    varPurchReq.CreateRecord(Rec)
                            //else
                            //    Message('Record already exist..')
                            else
                                Message('You can not convert this requsition to PO.');
                        end // current user role in PO permission set code end here
                        else
                            Message('You have insufficient permission for this request.');
                    end

                end;
            }


        }


    }
    //Making fields read only when record is in approved or submitted state
    trigger OnAfterGetCurrRecord()
    var

    begin
        if (Rec.Status = 'Approved') or (Rec.Status = 'Submitted') then begin
            varIsEditiable := false;
        end
        else begin
            varIsEditiable := true;
        end;
    end;


    trigger OnOpenPage()
    begin
        CurrentHeaderNo := Rec."PR No.";

    end;

    trigger OnAfterGetRecord()

    begin
        CurrPage.RequisitionLine.Page.globalHeader1(Rec."PR No.");
    end;

    //initializing a global variable
    var
        varCurrLineRecord: Record "Purchase Requistion Line";
        CurrentHeaderNo: code[20];

        varIsEditiable: Boolean;







}
