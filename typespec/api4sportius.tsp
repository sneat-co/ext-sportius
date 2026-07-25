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

enum InvitationStatus {
  pending,
  accepted,
  expired,
  revoked,
}

enum ErrorCode {
  validation,
  forbidden,
  `not-found`,
  merged,
  conflict,
  `invitation-expired`,
  `invite-required`,
  retryable,
  internal,
}

@error
model SportiusError {
  @statusCode statusCode: 400 | 403 | 404 | 409 | 410 | 500 | 503;
  code: ErrorCode;
  messageKey: string;
  field?: string;
  retryable: boolean;
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
  gender: GenderCategory;
  age?: AgeRange;
  locality?: string;
  clubSpaceID?: string;
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

model ContactBrief {
  contactID: string;
  userID?: string;
  displayName: string;
}

model GuardianLink {
  contact: ContactBrief;
  relationshipRoleID: string;
}

model PlayerView {
  player: Participant;
  guardians: GuardianLink[];
}

model ViewerCapabilities {
  canEdit: boolean;
  canInvite: boolean;
  canManageParticipants: boolean;
  canManageLinkages: boolean;
}

model TeamView {
  profile: TeamProfile;
  players: Participant[];
  staff: Participant[];
  capabilities: ViewerCapabilities;
}

model ClubView {
  profile: ClubProfile;
  teams: TeamBrief[];
  staff: Participant[];
  members: Participant[];
  capabilities: ViewerCapabilities;
}

model PutPersonalSportRequest {
  roleIDs: string[];
  visibility: ProfileVisibility;
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
  clearAge?: boolean;
  clearLocation?: boolean;
  clearMedia?: boolean;
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
  membershipRequestID?: string;
}

model AddPlayerRequest {
  requestID: string;
  displayName: string;
  roleIDs: string[];
  userID?: string;
}

model AddStaffRequest {
  requestID: string;
  displayName: string;
  roleIDs: string[];
  userID?: string;
}

model SetParticipantRolesRequest {
  requestID: string;
  roleIDs: string[];
}

model LinkGuardianRequest {
  requestID: string;
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
  clearPrimarySport?: boolean;
  replaceSportIDs?: boolean;
  clearLocation?: boolean;
  clearMedia?: boolean;
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
  /** Existing space contact to invite. Mutually exclusive with inviteeDisplayName. */
  contactID?: string;
  /** Creates a non-member space contact before inviting. Mutually exclusive with contactID. */
  inviteeDisplayName?: string;
  suggestedRoleIDs: string[];
}

model Invitation {
  invitationID: string;
  spaceID: string;
  kind: SpaceKind;
  contactID: string;
  inviteeDisplayName: string;
  suggestedRoleIDs: string[];
  /** Creation-only delivery link; omitted from later inspection. */
  deepLink?: string;
}

model InvitationView {
  invitation: Invitation;
  spaceName: string;
  status: InvitationStatus;
  expiresAt?: string;
}

model AcceptInvitationRequest {
  requestID: string;
  /** Opaque proof carried by the personal-invitation deep link. */
  claimToken: string;
  roleIDs: string[];
}

model InvitationAcceptance {
  invitationID: string;
  spaceID: string;
  kind: SpaceKind;
  contactID: string;
  roleIDs: string[];
}

@useAuth(BearerAuth)
interface Personal {
  @get @route("/home")
  home(): SportsHome | SportiusError;

  @get @route("/profile")
  profile(): PersonalSportsProfile | SportiusError;

  @put @route("/profile/sports/{sportID}")
  putSport(
    @path sportID: string,
    @body body: PutPersonalSportRequest,
  ): PersonalSportsProfile | SportiusError;

  @delete @route("/profile/sports/{sportID}")
  deleteSport(@path sportID: string): PersonalSportsProfile | SportiusError;
}

@useAuth(BearerAuth)
interface Teams {
  @get @route("/teams/search")
  search(
    @query name: string,
    @query sportID?: string,
    @query locality?: string,
  ): TeamBrief[] | SportiusError;

  @post @route("/teams")
  create(@body body: CreateTeamRequest): TeamView | SportiusError;

  @get @route("/teams/{spaceID}")
  get(@path spaceID: string): TeamView | SportiusError;

  @put @route("/teams/{spaceID}")
  update(
    @path spaceID: string,
    @body body: UpdateTeamRequest,
  ): TeamView | SportiusError;

  @post @route("/teams/{spaceID}/join")
  join(
    @path spaceID: string,
    @body body: JoinTeamRequest,
  ): JoinTeamResponse | SportiusError;

  @post @route("/teams/{spaceID}/players")
  addPlayer(
    @path spaceID: string,
    @body body: AddPlayerRequest,
  ): PlayerView | SportiusError;

  @post @route("/teams/{spaceID}/staff")
  addStaff(
    @path spaceID: string,
    @body body: AddStaffRequest,
  ): Participant | SportiusError;

  @get @route("/teams/{spaceID}/players/{playerContactID}")
  getPlayer(
    @path spaceID: string,
    @path playerContactID: string,
  ): PlayerView | SportiusError;

  @post @route("/teams/{spaceID}/players/{playerContactID}/guardians")
  linkGuardian(
    @path spaceID: string,
    @path playerContactID: string,
    @body body: LinkGuardianRequest,
  ): PlayerView | SportiusError;
}

@useAuth(BearerAuth)
interface Clubs {
  @get @route("/clubs/search")
  search(
    @query name: string,
    @query sportID?: string,
    @query locality?: string,
  ): ClubBrief[] | SportiusError;

  @post @route("/clubs")
  create(@body body: CreateClubRequest): ClubView | SportiusError;

  @get @route("/clubs/{spaceID}")
  get(@path spaceID: string): ClubView | SportiusError;

  @put @route("/clubs/{spaceID}")
  update(
    @path spaceID: string,
    @body body: UpdateClubRequest,
  ): ClubView | SportiusError;

  @post @route("/clubs/{spaceID}/staff")
  addStaff(
    @path spaceID: string,
    @body body: AddStaffRequest,
  ): Participant | SportiusError;
}

@useAuth(BearerAuth)
interface Participants {
  @put @route("/participants/{kind}/{spaceID}/{contactID}/roles")
  setRoles(
    @path kind: SpaceKind,
    @path spaceID: string,
    @path contactID: string,
    @body body: SetParticipantRolesRequest,
  ): Participant | SportiusError;
}

@useAuth(BearerAuth)
interface Linkages {
  @post @route("/team-club-links")
  linkTeamToClub(
    @body body: LinkTeamToClubRequest,
  ): ClubView | SportiusError;
}

@useAuth(BearerAuth)
interface Invitations {
  @post @route("/invitations")
  create(@body body: CreateInvitationRequest): Invitation | SportiusError;

  @get @route("/invitations/{invitationID}")
  get(
    @path invitationID: string,
    @query claimToken: string,
  ): InvitationView | SportiusError;

  @post @route("/invitations/{invitationID}/accept")
  accept(
    @path invitationID: string,
    @body body: AcceptInvitationRequest,
  ): InvitationAcceptance | SportiusError;
}
