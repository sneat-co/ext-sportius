export type SportID = string;

export type RoleID =
  | 'player'
  | 'coach'
  | 'assistant-coach'
  | 'team-manager'
  | 'administrator'
  | 'organiser'
  | 'official'
  | 'volunteer'
  | 'supporter'
  | 'parent-guardian'
  | 'medical-welfare'
  | 'equipment-manager'
  | 'president'
  | 'treasurer'
  | 'accountant'
  | 'secretary'
  | 'safeguarding-officer'
  | 'other';

export type RoleScope = 'personal' | 'team' | 'club';
export type ProfileVisibility = 'private' | 'public' | 'hidden';
export type SpaceKind = 'team' | 'club';
export type GenderCategory = 'unspecified' | 'male' | 'female' | 'mixed' | 'other';
export type JoinPolicy = 'open' | 'approval-required' | 'invite-only';
export type JoinStatus = 'joined' | 'requested' | 'invite-required';

export interface RoleDefinition {
  readonly id: RoleID;
  readonly labelKey: string;
  readonly scopes: readonly RoleScope[];
  readonly defaultPersonal?: boolean;
  readonly impliesStaff?: boolean;
}

export const roleCatalog: readonly RoleDefinition[] = [
  { id: 'player', labelKey: 'sportius.role.player', scopes: ['personal', 'team'], defaultPersonal: true },
  { id: 'coach', labelKey: 'sportius.role.coach', scopes: ['personal', 'team', 'club'], defaultPersonal: true, impliesStaff: true },
  { id: 'assistant-coach', labelKey: 'sportius.role.assistant_coach', scopes: ['personal', 'team', 'club'], impliesStaff: true },
  { id: 'team-manager', labelKey: 'sportius.role.team_manager', scopes: ['personal', 'team', 'club'], impliesStaff: true },
  { id: 'administrator', labelKey: 'sportius.role.administrator', scopes: ['personal', 'team', 'club'], impliesStaff: true },
  { id: 'organiser', labelKey: 'sportius.role.organiser', scopes: ['personal', 'team', 'club'], defaultPersonal: true, impliesStaff: true },
  { id: 'official', labelKey: 'sportius.role.official', scopes: ['personal', 'team'], defaultPersonal: true, impliesStaff: true },
  { id: 'volunteer', labelKey: 'sportius.role.volunteer', scopes: ['personal', 'team', 'club'], defaultPersonal: true, impliesStaff: true },
  { id: 'supporter', labelKey: 'sportius.role.supporter', scopes: ['personal'], defaultPersonal: true },
  { id: 'parent-guardian', labelKey: 'sportius.role.parent_guardian', scopes: ['personal'], defaultPersonal: true },
  { id: 'medical-welfare', labelKey: 'sportius.role.medical_welfare', scopes: ['personal', 'team', 'club'], impliesStaff: true },
  { id: 'equipment-manager', labelKey: 'sportius.role.equipment_manager', scopes: ['personal', 'team', 'club'], impliesStaff: true },
  { id: 'president', labelKey: 'sportius.role.president', scopes: ['club'], impliesStaff: true },
  { id: 'treasurer', labelKey: 'sportius.role.treasurer', scopes: ['club'], impliesStaff: true },
  { id: 'accountant', labelKey: 'sportius.role.accountant', scopes: ['club'], impliesStaff: true },
  { id: 'secretary', labelKey: 'sportius.role.secretary', scopes: ['club'], impliesStaff: true },
  { id: 'safeguarding-officer', labelKey: 'sportius.role.safeguarding_officer', scopes: ['club'], impliesStaff: true },
  { id: 'other', labelKey: 'sportius.role.other', scopes: ['personal', 'team', 'club'] },
] as const;

export interface AgeRange {
  minAge?: number;
  maxAge?: number;
  label?: string;
}

export interface GeoPoint {
  latitude: number;
  longitude: number;
}

export interface LocationHint {
  locality?: string;
  region?: string;
  countryID?: string;
  point?: GeoPoint;
  togetheredSpotID?: string;
}

export interface MediaRef {
  fileID: string;
  kind: string;
}

export interface PersonalSport {
  sportID: SportID;
  roleIDs: RoleID[];
  visibility: ProfileVisibility;
}

export interface PersonalSportsProfile {
  userID: string;
  sports: PersonalSport[];
}

export interface TeamBrief {
  spaceID: string;
  name: string;
  sportID: SportID;
  locality?: string;
  clubName?: string;
}

export interface ClubBrief {
  spaceID: string;
  name: string;
  primarySportID?: SportID;
  locality?: string;
}

export interface SportsHome {
  sports: PersonalSport[];
  teams: TeamBrief[];
  clubs: ClubBrief[];
}

export interface TeamProfile {
  spaceID: string;
  name: string;
  sportID: SportID;
  gender: GenderCategory;
  age?: AgeRange;
  location?: LocationHint;
  media?: MediaRef;
  joinPolicy: JoinPolicy;
  club?: ClubBrief;
}

export interface ClubProfile {
  spaceID: string;
  name: string;
  primarySportID?: SportID;
  sportIDs: SportID[];
  location?: LocationHint;
  media?: MediaRef;
}

export interface Participant {
  contactID: string;
  userID?: string;
  displayName: string;
  roleIDs: RoleID[];
  spaceMember: boolean;
}

export interface TeamView {
  profile: TeamProfile;
  players: Participant[];
  staff: Participant[];
}

export interface ClubView {
  profile: ClubProfile;
  teams: TeamBrief[];
  staff: Participant[];
  members: Participant[];
}

export interface PutPersonalSportRequest {
  sportID: SportID;
  roleIDs: RoleID[];
  visibility: ProfileVisibility;
}

export interface SearchRequest {
  name: string;
  sportID?: SportID;
  locality?: string;
}

export interface CreateTeamRequest {
  requestID: string;
  name: string;
  sportID: SportID;
  creatorRoleIDs: RoleID[];
  gender?: GenderCategory;
  age?: AgeRange;
  location?: LocationHint;
  media?: MediaRef;
  joinPolicy?: JoinPolicy;
}

export interface UpdateTeamRequest {
  name?: string;
  sportID?: SportID;
  gender?: GenderCategory;
  age?: AgeRange;
  location?: LocationHint;
  media?: MediaRef;
  joinPolicy?: JoinPolicy;
}

export interface JoinTeamRequest {
  requestID: string;
  roleIDs: RoleID[];
  invitationID?: string;
}

export interface JoinTeamResponse {
  team: TeamBrief;
  status: JoinStatus;
  roleIDs: RoleID[];
}

export interface AddParticipantRequest {
  requestID: string;
  displayName: string;
  roleIDs: RoleID[];
  userID?: string;
  makeSpaceMember: boolean;
}

export interface LinkGuardianRequest {
  requestID: string;
  playerContactID: string;
  guardianContactID?: string;
  guardianDisplayName?: string;
  relationshipRoleID: string;
}

export interface CreateClubRequest {
  requestID: string;
  name: string;
  primarySportID?: SportID;
  sportIDs: SportID[];
  creatorRoleIDs: RoleID[];
  location?: LocationHint;
  media?: MediaRef;
}

export interface UpdateClubRequest {
  name?: string;
  primarySportID?: SportID;
  sportIDs?: SportID[];
  location?: LocationHint;
  media?: MediaRef;
}

export interface LinkTeamToClubRequest {
  requestID: string;
  teamSpaceID: string;
  clubSpaceID: string;
}

export interface CreateInvitationRequest {
  requestID: string;
  spaceID: string;
  kind: SpaceKind;
  suggestedRoleIDs: RoleID[];
}

export interface Invitation {
  invitationID: string;
  spaceID: string;
  kind: SpaceKind;
  suggestedRoleIDs: RoleID[];
  deepLink: string;
}
