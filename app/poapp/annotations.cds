using CatalogService as service from '../../srv/cat-service';

annotate CatalogService.POs with @(
    UI.SelectionFields : [
        PO_ID,
        GROSS_AMOUNT,
        PATRNER_GUID.COMPANY_NAME,
        PATRNER_GUID.ADDRESS_GUID.COUNTRY
    ],

    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : PO_ID,
        },
        {
            $Type : 'UI.DataField',
            Value : PATRNER_GUID.COMPANY_NAME,
        },
        {
            $Type : 'UI.DataField',
            Value : PATRNER_GUID.BP_ID,
        },
        {
            $Type : 'UI.DataField',
            Value : GROSS_AMOUNT,
        },
        {
            $Type : 'UI.DataField',
            Value : CURRENCY_code,
        },
        {
            $Type: 'UI.DataFieldForAction',
            Action: 'CatalogService.discountPrice',
            Label : 'Discount'
        },
        {
            $Type : 'UI.DataField',
            Value : LStatus,
            Criticality : LSC,
        },
        {
            $Type : 'UI.DataField',
            Value : OStatus,
            Criticality : OSC,
        },
        {
            $Type : 'UI.DataField',
            Value : PATRNER_GUID.ADDRESS_GUID.COUNTRY,
        },
    ],
    UI.HeaderInfo : {
        TypeName : 'Purchase Order',
        TypeNamePlural : 'Purchase Orders',
        Title : {
            Label : 'Purchase Order ID',
            Value : PATRNER_GUID.COMPANY_NAME
        },
        ImageUrl : 'https://www.liblogo.com/img-logo/sa2839sc40-sap-logo-sap-sap-market-capitalization.png'
    },
    UI.Facets : [
        {
          $Type : 'UI.CollectionFacet',
          Label: 'Purchase Order Details',
          Facets : [
            {
                $Type : 'UI.ReferenceFacet',
                Label : 'More Details',
                Target : '@UI.FieldGroup#MoreInfo'
            },
            {
                $Type : 'UI.ReferenceFacet',
                Label : 'Amount Information',
                Target : '@UI.FieldGroup#AmountDet'
            }
          ]
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Purchase Items',
            Target : 'Items/@UI.LineItem'
        }
    ],
    UI.FieldGroup #MoreInfo : {
        Data: [
            {
                $Type : 'UI.DataField',
                Value : PO_ID
            },
            {
                $Type : 'UI.DataField',
                Value : PATRNER_GUID_NODE_KEY
            },
            {
                $Type : 'UI.DataField',
                Value : LStatus,
                Criticality : LSC
            },
            {
                $Type : 'UI.DataField',
                Value : OStatus,
                Criticality : OSC
            }
        ]
    },
    UI.FieldGroup #AmountDet : {
        Data: [
            {
                $Type : 'UI.DataField',
                Value : GROSS_AMOUNT
            },
            {
                $Type : 'UI.DataField',
                Value : NET_AMOUNT
            },
            {
                $Type : 'UI.DataField',
                Value : TAX_AMOUNT
            },
            {
                $Type : 'UI.DataField',
                Value : CURRENCY_code
            }
        ]
    }
);

annotate  CatalogService.poitems with @(
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : PO_ITEM_POS
        },
        {
            $Type : 'UI.DataField',
            Value : PRODUCT_GUID_NODE_KEY
        },
        {
            $Type : 'UI.DataField',
            Value : GROSS_AMOUNT
        },
        {
            $Type : 'UI.DataField',
            Value : NET_AMOUNT
        },
        {
            $Type : 'UI.DataField',
            Value : TAX_AMOUNT
        },
        {
            $Type : 'UI.DataField',
            Value : CURRENCY_code
        }
    ],
    UI.HeaderInfo : {
        TypeName : 'Purchase Item',
        TypeNamePlural : 'Purchase Items',
        Title : {
            $Type : 'UI.DataField',
            Value : PO_ITEM_POS
        }
    },
    UI.Facets : [
        {
            $Type : 'UI.CollectionFacet',
            Label : 'Purchase Item Details',
            Facets : [
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Purchase Item Information',
                    Target : '@UI.FieldGroup#ItemData'
                },
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Product Information',
                    Target : '@UI.FieldGroup#ProductData'
                }
            ]
        }
    ],
    UI.FieldGroup #ItemData : {
        Label : 'Item information',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : PO_ITEM_POS,
            },
            {
                $Type : 'UI.DataField',
                Value : PRODUCT_GUID_NODE_KEY,
            },
            {
                $Type : 'UI.DataField',
                Value : GROSS_AMOUNT,
            },
            {
                $Type : 'UI.DataField',
                Value : NET_AMOUNT,
            },
            {
                $Type : 'UI.DataField',
                Value : TAX_AMOUNT,
            },
            {
                $Type : 'UI.DataField',
                Value : CURRENCY_code,
            }
        ]
    },
    UI.FieldGroup #ProductData : {
        Label : 'Product information',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : PRODUCT_GUID.CATEGORY,
            },
            {
                $Type : 'UI.DataField',
                Value : PRODUCT_GUID.DESCRIPTION,
            },
            {
                $Type : 'UI.DataField',
                Value : PRODUCT_GUID.SUPPLIER_GUID.ADDRESS_GUID.COUNTRY,
            },
            {
                $Type : 'UI.DataField',
                Value : PRODUCT_GUID.SUPPLIER_GUID.COMPANY_NAME,
            },
            {
                $Type : 'UI.DataField',
                Value : PRODUCT_GUID.PRICE,
            },
            {
                $Type : 'UI.DataField',
                Value : PRODUCT_GUID.WIDHT,
            },
            {
                $Type : 'UI.DataField',
                Value : PRODUCT_GUID.HEIGHT,
            },
            {
                $Type : 'UI.DataField',
                Value : PRODUCT_GUID.DEPTH,
            }
        ]
    }
);
