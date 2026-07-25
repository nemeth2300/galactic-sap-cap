using {cosmos as db} from '../db/schema';

service CosmosService @(
  odata   : '/cosmos',
  requires: 'authenticated-user'
) {

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
  entity Spacefarers as projection on db.Spacefarers;
}
