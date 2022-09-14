page 70100 "Requisition Header List"
{
    PageType = List;
    Editable = true;
    CardPageId = "Purchase Requisition";
    SourceTable = "Purchase Requisition Header";
    UsageCategory = Lists;
    ApplicationArea = All;
    AdditionalSearchTerms = 'Purchase, Requisition';
    Caption = 'Purchase Requisitions';

    layout
    {
        area(Content)
        {
            repeater(PurchaseRequisitionHeader)
            {
                field("PR No."; Rec."PR No.")
                {
                    Caption = 'No.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;

                }
                field(Reason; Rec.Reason)
                {
                    ApplicationArea = All;

                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;

                }
                field("Raised By"; Rec."Raised By")
                {
                    ApplicationArea = All;

                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;

                }

                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;

                }

            }



        }



    }
    //custom button starts here
    actions
    {
        area(processing)
        {

            action("Request Approval")
            {
                //Caption = 'Request Approval';
                ApplicationArea = All;
                Caption = 'Request Approval';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                ShortCutKey = 'Alt+D';
                ToolTip = 'Request approval of the requisition';

                trigger OnAction()
                var
                    varApprovalStatus: Text;
                    varTemp: Record ApprovalTemp;
                    varTemp1: Record "Purchase Requisition History";
                    varTemp2: Record "Purchase Requisition Header";
                    varSubmit: Codeunit RequestApproval;

                begin
                    varApprovalStatus := Rec.Status;
                    if (varApprovalStatus = 'Draft') then begin
                        //inserting data in temp table
                        varTemp.Reset;
                        varTemp.Init;
                        varTemp.Validate("PR No", Rec."PR No.");
                        varTemp.Validate(Email, Rec."Raised By");
                        varTemp.Insert(true);
                        Message('Your Requisiton  ' + Rec."PR No." + ' has been submitted');

                        //Update status to submitted

                        varTemp2.Get(Rec."PR No.", Rec.Reason);
                        //varTemp2."PR No." := Rec."PR No.";
                        //varTemp2.Reason := Rec.Reason;
                        varTemp2.Status := 'Submitted';
                        varTemp2.Modify;

                        //inserting data in history table
                        varTemp1.Reset;
                        varTemp1.Init;
                        varTemp1.Validate("PR No", Rec."PR No.");
                        varTemp1.Validate(Email, Rec."Raised By");
                        varTemp1.Validate("Status To", 'Submitted');
                        varTemp1.Validate("Status From", Rec.Status);
                        varTemp1.Validate("Modified By", Rec."Raised By");
                        varTemp1.Validate("Modified Date", Today());
                        varTemp1.Insert(true);

                        //code unit call when press submit button
                        //varSubmit.GetApprovalRequest()
                    end
                    else begin
                        Message('You can not submit this request.');
                    end;




                end;

            }

        }

    } //ends here





    trigger OnOpenPage()
    var
        varCurrentUser: Record User;
        varPermissions: Record "Access Control";
        varHeadrRecords: Record "Purchase Requisition Header";
        varRoleID: Text;
    begin
        varCurrentUser.SETFILTER("User Name", UserId());
        If varCurrentUser.FindSet() then begin
            varPermissions.SetFilter("User Security ID", varCurrentUser."User Security ID");
            varPermissions.SetFilter("Role ID", 'SUPER');
            if varPermissions.FindSet() then begin

                exit
            end

            else begin
                Rec.FilterGroup(100);
                Rec.SetFilter("Raised By", varCurrentUser."Authentication Email");
                if Rec.FindSet() then begin

                    exit;

                end;
                Rec.FilterGroup(0);
            end;


        end;




    end;

}