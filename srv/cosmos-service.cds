using {cosmos as db} from '../db/schema';

service CosmosService @(
  odata   : '/cosmos',
  requires: 'authenticated-user'
) {
  entity Spacefarers as projection on db.Spacefarers;
}
