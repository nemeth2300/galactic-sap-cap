using {cosmos as db} from '../db/schema';

service SpacefarerService @(
  odata   : '/spacefarer',
  requires: 'authenticated-user'
) {
  entity Spacefarers as projection on db.Spacefarer;
}
