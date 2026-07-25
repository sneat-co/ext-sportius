package sportius

import "context"

// Facade is the stable application boundary used by Telegram and other
// Sportius surfaces. actorUserID comes from authenticated host context and is
// never accepted from a wire request body.
type Facade interface {
	GetHome(ctx context.Context, actorUserID string) (SportsHome, error)
	GetPersonalProfile(ctx context.Context, actorUserID string) (PersonalSportsProfile, error)
	PutPersonalSport(ctx context.Context, actorUserID string, request PutPersonalSportRequest) (PersonalSportsProfile, error)
	DeletePersonalSport(ctx context.Context, actorUserID string, sportID SportID) (PersonalSportsProfile, error)

	SearchTeams(ctx context.Context, actorUserID string, request SearchRequest) ([]TeamBrief, error)
	CreateTeam(ctx context.Context, actorUserID string, request CreateTeamRequest) (TeamView, error)
	GetTeam(ctx context.Context, actorUserID, spaceID string) (TeamView, error)
	UpdateTeam(ctx context.Context, actorUserID, spaceID string, request UpdateTeamRequest) (TeamView, error)
	JoinTeam(ctx context.Context, actorUserID, spaceID string, request JoinTeamRequest) (JoinTeamResponse, error)
	AddTeamParticipant(ctx context.Context, actorUserID, spaceID string, request AddParticipantRequest) (Participant, error)
	LinkGuardian(ctx context.Context, actorUserID, spaceID string, request LinkGuardianRequest) (Participant, error)

	SearchClubs(ctx context.Context, actorUserID string, request SearchRequest) ([]ClubBrief, error)
	CreateClub(ctx context.Context, actorUserID string, request CreateClubRequest) (ClubView, error)
	GetClub(ctx context.Context, actorUserID, spaceID string) (ClubView, error)
	UpdateClub(ctx context.Context, actorUserID, spaceID string, request UpdateClubRequest) (ClubView, error)
	LinkTeamToClub(ctx context.Context, actorUserID string, request LinkTeamToClubRequest) (ClubView, error)

	CreateInvitation(ctx context.Context, actorUserID string, request CreateInvitationRequest) (Invitation, error)
}
