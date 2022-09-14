pageextension 70105 ExtendNavigationArea extends "Purchasing Manager Role Center"
{

    actions
    {
        addbefore(Vendors)
        {

            action("Purchase Requisitions")
            {
                RunObject = page "Requisition Header List";
                ApplicationArea = Basic, Suite;
                Caption = 'Purchase Requisitions';
            }


        }
    }
}