using {cosmos as db} from '../db/schema';

service CosmosService @(
  odata   : '/cosmos',
  requires: 'authenticated-user'
) {

  @readonly
  entity StarDusts            as projection on db.StarDusts;

  @readonly
  entity Planets              as projection on db.Planets;

  @readonly
  entity SpacefarersStarDusts as projection on db.SpacefarersStarDusts;

  @restrict: [
    {
      grant: 'CREATE',
      to   : 'authenticated-user'
    },
    {
      grant: 'READ',
      to   : 'authenticated-user',
    },
    {
      grant: [
        'UPDATE',
        'DELETE'
      ],
      to   : 'authenticated-user',
      where: 'createdBy = $user.id'
    },
  ]
  @odata.draft.enabled
  entity Spacefarers          as
    projection on db.Spacefarers {
      *,
      origin_planet.name as origin_planet_name
    };
}
