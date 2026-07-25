using CosmosService as service from '../../srv/cosmos-service';
annotate service.Spacefarers with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : name,
                Label : '{i18n>Name}',
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>WormholeSkill}',
                Value : wormhole_navigation_skill,
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>SpacesuitColor}',
                Value : spacesuit_color,
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : 'General Information',
            Target : '@UI.FieldGroup#GeneratedGroup',
        },
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Label : '{i18n>Name}',
            Value : name,
            @UI.Importance : #High,
        },
        {
            $Type : 'UI.DataField',
            Value : origin_planet_name,
            Label : '{i18n>OriginPlanet}',
            @UI.Importance : #Medium,
        },
        {
            $Type : 'UI.DataField',
            Label : '{i18n>SpacesuitColor}',
            Value : spacesuit_color,
            @UI.Importance : #Medium,
        },
        {
            $Type : 'UI.DataField',
            Label : '{i18n>WormholeSkill}',
            Value : wormhole_navigation_skill,
        },
        {
            $Type : 'UI.DataField',
            Value : stardust_collection.stardust.name,
            Label : '{i18n>StardustCollection}',
            @UI.Importance : #Medium,
        },
    ],
    UI.SelectionFields : [
        name,
        spacesuit_color,
    ],
);

annotate service.Spacefarers with {
    name @Common.Label : 'name'
};

annotate service.Spacefarers with {
    spacesuit_color @Common.Label : 'spacesuit_color'
};

