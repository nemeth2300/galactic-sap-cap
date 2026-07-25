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


entity Spacefarers : primary {
  name                      : Name not null;
  wormhole_navigation_skill : NavigationSkill not null;
  spacesuit_color           : String(255) not null;
  origin_planet             : Association to Planets not null;
  stardust_collection       : Composition of many SpacefarersStarDusts
                                on stardust_collection.spacefarer = $self;
}

entity StarDusts : primary {
  name        : Name not null;
  spacefarers : Association to many SpacefarersStarDusts
                  on spacefarers.stardust = $self;
}

entity SpacefarersStarDusts {
  key spacefarer : Association to Spacefarers;
  key stardust   : Association to StarDusts;
}

entity Planets : primary {
  name        : Name not null;
  spacefarers : Association to many Spacefarers
                  on spacefarers.origin_planet = $self;
}
