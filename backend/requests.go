package sportius

type PutPersonalSportRequest struct {
	SportID    SportID           `json:"sportID"`
	RoleIDs    []RoleID          `json:"roleIDs"`
	Visibility ProfileVisibility `json:"visibility"`
}

type SearchRequest struct {
	Name     string  `json:"name"`
	SportID  SportID `json:"sportID,omitempty"`
	Locality string  `json:"locality,omitempty"`
}

type CreateTeamRequest struct {
	RequestID      string         `json:"requestID"`
	Name           string         `json:"name"`
	SportID        SportID        `json:"sportID"`
	CreatorRoleIDs []RoleID       `json:"creatorRoleIDs"`
	Gender         GenderCategory `json:"gender,omitempty"`
	Age            *AgeRange      `json:"age,omitempty"`
	Location       *LocationHint  `json:"location,omitempty"`
	Media          *MediaRef      `json:"media,omitempty"`
	JoinPolicy     JoinPolicy     `json:"joinPolicy,omitempty"`
}

type UpdateTeamRequest struct {
	Name       *string         `json:"name,omitempty"`
	SportID    *SportID        `json:"sportID,omitempty"`
	Gender     *GenderCategory `json:"gender,omitempty"`
	Age        *AgeRange       `json:"age,omitempty"`
	Location   *LocationHint   `json:"location,omitempty"`
	Media      *MediaRef       `json:"media,omitempty"`
	JoinPolicy *JoinPolicy     `json:"joinPolicy,omitempty"`
}

type JoinTeamRequest struct {
	RequestID    string   `json:"requestID"`
	RoleIDs      []RoleID `json:"roleIDs"`
	InvitationID string   `json:"invitationID,omitempty"`
}

type JoinTeamResponse struct {
	Team    TeamBrief  `json:"team"`
	Status  JoinStatus `json:"status"`
	RoleIDs []RoleID   `json:"roleIDs"`
}

type AddParticipantRequest struct {
	RequestID       string   `json:"requestID"`
	DisplayName     string   `json:"displayName"`
	RoleIDs         []RoleID `json:"roleIDs"`
	UserID          string   `json:"userID,omitempty"`
	MakeSpaceMember bool     `json:"makeSpaceMember"`
}

type LinkGuardianRequest struct {
	RequestID           string `json:"requestID"`
	PlayerContactID     string `json:"playerContactID"`
	GuardianContactID   string `json:"guardianContactID,omitempty"`
	GuardianDisplayName string `json:"guardianDisplayName,omitempty"`
	RelationshipRoleID  string `json:"relationshipRoleID"`
}

type CreateClubRequest struct {
	RequestID      string        `json:"requestID"`
	Name           string        `json:"name"`
	PrimarySportID SportID       `json:"primarySportID,omitempty"`
	SportIDs       []SportID     `json:"sportIDs"`
	CreatorRoleIDs []RoleID      `json:"creatorRoleIDs"`
	Location       *LocationHint `json:"location,omitempty"`
	Media          *MediaRef     `json:"media,omitempty"`
}

type UpdateClubRequest struct {
	Name           *string       `json:"name,omitempty"`
	PrimarySportID *SportID      `json:"primarySportID,omitempty"`
	SportIDs       []SportID     `json:"sportIDs,omitempty"`
	Location       *LocationHint `json:"location,omitempty"`
	Media          *MediaRef     `json:"media,omitempty"`
}

type LinkTeamToClubRequest struct {
	RequestID   string `json:"requestID"`
	TeamSpaceID string `json:"teamSpaceID"`
	ClubSpaceID string `json:"clubSpaceID"`
}

type CreateInvitationRequest struct {
	RequestID        string    `json:"requestID"`
	SpaceID          string    `json:"spaceID"`
	Kind             SpaceKind `json:"kind"`
	SuggestedRoleIDs []RoleID  `json:"suggestedRoleIDs"`
}
