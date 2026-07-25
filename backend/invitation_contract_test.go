package sportius

import (
	"encoding/json"
	"strings"
	"testing"
)

func TestInvitationCarriesStableContactIdentity(t *testing.T) {
	value := Invitation{
		InvitationID:       "invite-1",
		SpaceID:            "team-1",
		Kind:               SpaceKindTeam,
		ContactID:          "contact-1",
		InviteeDisplayName: "Alex",
		SuggestedRoleIDs:   []RoleID{RolePlayer},
		DeepLink:           "https://t.me/sneat_bot?start=invite-1",
	}

	data, err := json.Marshal(value)
	if err != nil {
		t.Fatal(err)
	}
	jsonValue := string(data)
	for _, fragment := range []string{
		`"contactID":"contact-1"`,
		`"inviteeDisplayName":"Alex"`,
		`"suggestedRoleIDs":["player"]`,
	} {
		if !strings.Contains(jsonValue, fragment) {
			t.Fatalf("invitation JSON %s does not contain %s", jsonValue, fragment)
		}
	}
}

func TestInvitationAcceptanceReturnsClaimedContact(t *testing.T) {
	value := InvitationAcceptance{
		InvitationID: "invite-1",
		SpaceID:      "team-1",
		Kind:         SpaceKindTeam,
		ContactID:    "contact-1",
	}

	data, err := json.Marshal(value)
	if err != nil {
		t.Fatal(err)
	}
	if !strings.Contains(string(data), `"contactID":"contact-1"`) {
		t.Fatalf("acceptance JSON does not identify the claimed contact: %s", data)
	}
}
