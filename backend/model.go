package sportius

type ProfileVisibility string

const (
	VisibilityPrivate ProfileVisibility = "private"
	VisibilityPublic  ProfileVisibility = "public"
	VisibilityHidden  ProfileVisibility = "hidden"
)

type SpaceKind string

const (
	SpaceKindTeam SpaceKind = "team"
	SpaceKindClub SpaceKind = "club"
)

type GenderCategory string

const (
	GenderUnspecified GenderCategory = "unspecified"
	GenderMale        GenderCategory = "male"
	GenderFemale      GenderCategory = "female"
	GenderMixed       GenderCategory = "mixed"
	GenderOther       GenderCategory = "other"
)

type JoinPolicy string

const (
	JoinPolicyOpen             JoinPolicy = "open"
	JoinPolicyApprovalRequired JoinPolicy = "approval-required"
	JoinPolicyInviteOnly       JoinPolicy = "invite-only"
)

type JoinStatus string

const (
	JoinStatusJoined         JoinStatus = "joined"
	JoinStatusRequested      JoinStatus = "requested"
	JoinStatusInviteRequired JoinStatus = "invite-required"
)

type AgeRange struct {
	MinAge *int   `json:"minAge,omitempty"`
	MaxAge *int   `json:"maxAge,omitempty"`
	Label  string `json:"label,omitempty"`
}

type GeoPoint struct {
	Latitude  float64 `json:"latitude"`
	Longitude float64 `json:"longitude"`
}

type LocationHint struct {
	Locality         string    `json:"locality,omitempty"`
	Region           string    `json:"region,omitempty"`
	CountryID        string    `json:"countryID,omitempty"`
	Point            *GeoPoint `json:"point,omitempty"`
	TogetheredSpotID string    `json:"togetheredSpotID,omitempty"`
}

type MediaRef struct {
	FileID string `json:"fileID"`
	Kind   string `json:"kind"`
}

type PersonalSport struct {
	SportID    SportID           `json:"sportID"`
	RoleIDs    []RoleID          `json:"roleIDs"`
	Visibility ProfileVisibility `json:"visibility"`
}

type PersonalSportsProfile struct {
	UserID string          `json:"userID"`
	Sports []PersonalSport `json:"sports"`
}

type TeamBrief struct {
	SpaceID  string  `json:"spaceID"`
	Name     string  `json:"name"`
	SportID  SportID `json:"sportID"`
	Locality string  `json:"locality,omitempty"`
	ClubName string  `json:"clubName,omitempty"`
}

type ClubBrief struct {
	SpaceID        string  `json:"spaceID"`
	Name           string  `json:"name"`
	PrimarySportID SportID `json:"primarySportID,omitempty"`
	Locality       string  `json:"locality,omitempty"`
}

type SportsHome struct {
	Sports []PersonalSport `json:"sports"`
	Teams  []TeamBrief     `json:"teams"`
	Clubs  []ClubBrief     `json:"clubs"`
}

type TeamProfile struct {
	SpaceID    string         `json:"spaceID"`
	Name       string         `json:"name"`
	SportID    SportID        `json:"sportID"`
	Gender     GenderCategory `json:"gender"`
	Age        *AgeRange      `json:"age,omitempty"`
	Location   *LocationHint  `json:"location,omitempty"`
	Media      *MediaRef      `json:"media,omitempty"`
	JoinPolicy JoinPolicy     `json:"joinPolicy"`
	Club       *ClubBrief     `json:"club,omitempty"`
}

type ClubProfile struct {
	SpaceID        string        `json:"spaceID"`
	Name           string        `json:"name"`
	PrimarySportID SportID       `json:"primarySportID,omitempty"`
	SportIDs       []SportID     `json:"sportIDs"`
	Location       *LocationHint `json:"location,omitempty"`
	Media          *MediaRef     `json:"media,omitempty"`
}

type Participant struct {
	ContactID   string   `json:"contactID"`
	UserID      string   `json:"userID,omitempty"`
	DisplayName string   `json:"displayName"`
	RoleIDs     []RoleID `json:"roleIDs"`
	SpaceMember bool     `json:"spaceMember"`
}

type TeamView struct {
	Profile TeamProfile   `json:"profile"`
	Players []Participant `json:"players"`
	Staff   []Participant `json:"staff"`
}

type ClubView struct {
	Profile ClubProfile   `json:"profile"`
	Teams   []TeamBrief   `json:"teams"`
	Staff   []Participant `json:"staff"`
	Members []Participant `json:"members"`
}

type Invitation struct {
	InvitationID     string    `json:"invitationID"`
	SpaceID          string    `json:"spaceID"`
	Kind             SpaceKind `json:"kind"`
	SuggestedRoleIDs []RoleID  `json:"suggestedRoleIDs"`
	DeepLink         string    `json:"deepLink"`
}
