namespace cosmos;

using {
  managed,
  cuid
} from '@sap/cds/common';

aspect primary : managed, cuid {}

type Name            : String(255);

type NavigationSkill : Integer @assert.range: [
  0,
  100
];

type SpaceSuitColor  : String enum {
  white;
  black;
  silver;
  red;
  blue;
  orange;
  green;
};


entity Spacefarer : primary {
  name                      : Name not null;
  wormhole_navigation_skill : NavigationSkill not null;
  spacesuit_color           : SpaceSuitColor not null;
  origin_planet             : Association to Planet not null;
  stardust_collection       : Composition of many SpacefarerStarDust
                                on stardust_collection.spacefarer = $self;
}

entity StarDust : primary {
  name        : Name not null;
  spacefarers : Association to many SpacefarerStarDust
                  on spacefarers.stardust = $self;
}

entity Planet : primary {
  name        : Name not null;
  spacefarers : Association to many Spacefarer
                  on spacefarers.origin_planet = $self;
}


entity SpacefarerStarDust {
  key spacefarer : Association to Spacefarer;
  key stardust   : Association to StarDust;
}
