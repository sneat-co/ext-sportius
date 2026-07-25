import "@typespec/http";

using Http;

@route("/v0/api4sportius")
namespace Sportius.Api4Sportius;

enum ProfileVisibility {
  private,
  public,
  hidden,
}

enum SpaceKind {
  team,
  club,
}

enum GenderCategory {
  unspecified,
  male,
  female,
  mixed,
  other,
}

enum JoinPolicy {
  open,
  `approval-required`,
  `invite-only`,
}

enum JoinStatus {
  joined,
  requested,
  `invite-required`,
}

model AgeRange {
  minAge?: int32;
  maxAge?: int32;
  label?: string;
}

model GeoPoint {
  latitude: float64;
  longitude: float64;
}

model LocationHint {
  locality?: string;
  region?: string;
  countryID?: string;
  point?: GeoPoint;
  togetheredSpotID?: string;
}

model MediaRef {
  fileID: string;
  kind: string;
}

model PersonalSport {
  sportID: string;
  roleIDs: string[];
  visibility: ProfileVisibility;
}

model PersonalSportsProfile {
  userID: string;
  sports: PersonalSport[];
}

model TeamBrief {
  spaceID: string;
  name: string;
  sportID: string;
  locality?: string;
  clubName?: string;
}

model ClubBrief {
  spaceID: string;
  name: string;
  primarySportID?: string;
  locality?: string;
}

model SportsHome {
  sports: PersonalSport[];
  teams: TeamBrief[];
  clubs: ClubBrief[];
}

model TeamProfile {
  spaceID: string;
  name: string;
  sportID: string;
  gender: GenderCategory;
  age?: AgeRange;
  location?: LocationHint;
  media?: MediaRef;
  joinPolicy: JoinPolicy;
  club?: ClubBrief;
}

model ClubProfile {
  spaceID: string;
  name: string;
  primarySportID?: string;
  sportIDs: string[];
  location?: LocationHint;
  media?: MediaRef;
}

model Participant {
  contactID: string;
  userID?: string;
  displayName: string;
  roleIDs: string[];
  spaceMember: boolean;
}

model TeamView {
  profile: TeamProfile;
  players: Participant[];
  staff: Participant[];
}

model ClubView {
  profile: ClubProfile;
  teams: TeamBrief[];
  staff: Participant[];
  members: Participant[];
}

model PutPersonalSportRequest {
  sportID: string;
  roleIDs: string[];
  visibility: ProfileVisibility;
}

model SearchRequest {
  name: string;
  sportID?: string;
  locality?: string;
}

model CreateTeamRequest {
  requestID: string;
  name: string;
  sportID: string;
  creatorRoleIDs: string[];
  gender?: GenderCategory;
  age?: AgeRange;
  location?: LocationHint;
  media?: MediaRef;
  joinPolicy?: JoinPolicy;
}

model UpdateTeamRequest {
  name?: string;
  sportID?: string;
  gender?: GenderCategory;
  age?: AgeRange;
  location?: LocationHint;
  media?: MediaRef;
  joinPolicy?: JoinPolicy;
}

model JoinTeamRequest {
  requestID: string;
  roleIDs: string[];
  invitationID?: string;
}

model JoinTeamResponse {
  team: TeamBrief;
  status: JoinStatus;
  roleIDs: string[];
}

model AddParticipantRequest {
  requestID: string;
  displayName: string;
  roleIDs: string[];
  userID?: string;
  makeSpaceMember: boolean;
}

model LinkGuardianRequest {
  requestID: string;
  playerContactID: string;
  guardianContactID?: string;
  guardianDisplayName?: string;
  relationshipRoleID: string;
}

model CreateClubRequest {
  requestID: string;
  name: string;
  primarySportID?: string;
  sportIDs: string[];
  creatorRoleIDs: string[];
  location?: LocationHint;
  media?: MediaRef;
}

model UpdateClubRequest {
  name?: string;
  primarySportID?: string;
  sportIDs?: string[];
  location?: LocationHint;
  media?: MediaRef;
}

model LinkTeamToClubRequest {
  requestID: string;
  teamSpaceID: string;
  clubSpaceID: string;
}

model CreateInvitationRequest {
  requestID: string;
  spaceID: string;
  kind: SpaceKind;
  suggestedRoleIDs: string[];
}

model Invitation {
  invitationID: string;
  spaceID: string;
  kind: SpaceKind;
  suggestedRoleIDs: string[];
  deepLink: string;
}

interface Personal {
  @get @route("/home") home(): SportsHome;
  @get @route("/profile") profile(): PersonalSportsProfile;
  @put @route("/profile/sports/{sportID}")
  putSport(@path sportID: string, @body body: PutPersonalSportRequest): PersonalSportsProfile;
  @delete @route("/profile/sports/{sportID}")
  deleteSport(@path sportID: string): PersonalSportsProfile;
}

interface Teams {
  @get @route("/teams/search")
  search(@query name: string, @query sportID?: string, @query locality?: string): TeamBrief[];
  @post @route("/teams") create(@body body: CreateTeamRequest): TeamView;
  @get @route("/teams/{spaceID}") get(@path spaceID: string): TeamView;
  @put @route("/teams/{spaceID}") update(@path spaceID: string, @body body: UpdateTeamRequest): TeamView;
  @post @route("/teams/{spaceID}/join")
  join(@path spaceID: string, @body body: JoinTeamRequest): JoinTeamResponse;
  @post @route("/teams/{spaceID}/participants")
  addParticipant(@path spaceID: string, @body body: AddParticipantRequest): Participant;
  @post @route("/teams/{spaceID}/guardians")
  linkGuardian(@path spaceID: string, @body body: LinkGuardianRequest): Participant;
}

interface Clubs {
  @get @route("/clubs/search")
  search(@query name: string, @query sportID?: string, @query locality?: string): ClubBrief[];
  @post @route("/clubs") create(@body body: CreateClubRequest): ClubView;
  @get @route("/clubs/{spaceID}") get(@path spaceID: string): ClubView;
  @put @route("/clubs/{spaceID}") update(@path spaceID: string, @body body: UpdateClubRequest): ClubView;
  @post @route("/clubs/{spaceID}/teams")
  linkTeam(@path spaceID: string, @body body: LinkTeamToClubRequest): ClubView;
}

interface Invitations {
  @post @route("/invitations")
  create(@body body: CreateInvitationRequest): Invitation;
}
