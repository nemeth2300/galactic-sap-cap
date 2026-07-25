using CosmosService as service from '../../srv/cosmos-service';

annotate service.Spacefarers with @fiori.draft.enabled;
annotate service.Planets with @cds.odata.valuelist;

annotate service.Spacefarers with @(
    UI.FieldGroup #GeneratedGroup: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: name,
                Label: '{i18n>Name}',
            },
            {
                $Type: 'UI.DataField',
                Label: '{i18n>WormholeSkill}',
                Value: wormhole_navigation_skill,
            },
            {
                $Type: 'UI.DataField',
                Label: '{i18n>SpacesuitColor}',
                Value: spacesuit_color,
            },
            {
                $Type : 'UI.DataField',
                Value : origin_planet_ID,
                Label : '{i18n>OriginPlanet}',
            },
            {
                $Type : 'UI.DataField',
                Value : stardust_collection.stardust_ID,
                Label : '{i18n>StardustCollection}',
            },
        ],
    },
    UI.Facets                    : [
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'GeneratedFacet1',
            Label : 'General Information',
            Target: '@UI.FieldGroup#GeneratedGroup',
        },
    ],
    UI.LineItem                  : [
        {
            $Type         : 'UI.DataField',
            Label         : '{i18n>Name}',
            Value         : name,
            @UI.Importance: #High,
        },
        {
            $Type         : 'UI.DataField',
            Value         : origin_planet_name,
            Label         : '{i18n>OriginPlanet}',
            @UI.Importance: #Medium,
        },
        {
            $Type         : 'UI.DataField',
            Label         : '{i18n>SpacesuitColor}',
            Value         : spacesuit_color,
            @UI.Importance: #Medium,
        },
        {
            $Type: 'UI.DataField',
            Label: '{i18n>WormholeSkill}',
            Value: wormhole_navigation_skill,
        },
        {
            $Type         : 'UI.DataField',
            Value         : stardust_collection.stardust.name,
            Label         : '{i18n>StardustCollection}',
            @UI.Importance: #Medium,
        },
    ],
    UI.SelectionFields           : [
        name,
        spacesuit_color,
    ],
);

annotate service.Spacefarers with {
    name @(
        Common.Label: '{i18n>Name}',
        Common.ExternalID : name,
    )
};

annotate service.Spacefarers with {
    spacesuit_color @Common.Label: '{i18n>SpacesuitColor}'
};

annotate service.Spacefarers with {
    origin_planet @(
        Common.Label                   : '{i18n>OriginPlanet}',
        Common.Text                    : origin_planet.name,
        Common.TextArrangement         : #TextOnly,
        Common.ValueListWithFixedValues: true,
        Common.ValueList               : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'Planets',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: origin_planet,
                    ValueListProperty: 'ID',
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'name',
                },
            ],
        },
    )
};

annotate service.SpacefarersStarDusts with @(UI.LineItem #Stardusts: [{
    $Type: 'UI.DataField',
    Value: stardust.name,
    Label: 'name',
}, ], );
annotate service.Spacefarers with {
    origin_planet @Common.ExternalID : origin_planet.name
};

annotate service.SpacefarersStarDusts with {
    spacefarer @Common.ExternalID : stardust.name
};

annotate service.SpacefarersStarDusts with {
    stardust @Common.ExternalID : stardust.name
};

