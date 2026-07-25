package sportius

import "testing"

func TestRoleCatalogHasStableUniqueCodes(t *testing.T) {
	seen := make(map[RoleID]bool, len(RoleCatalog))
	for _, role := range RoleCatalog {
		if role.ID == "" {
			t.Fatal("role ID is empty")
		}
		if seen[role.ID] {
			t.Fatalf("duplicate role ID: %s", role.ID)
		}
		seen[role.ID] = true
		if role.LabelKey == "" {
			t.Fatalf("role %s has no localisation key", role.ID)
		}
		if len(role.Scopes) == 0 {
			t.Fatalf("role %s has no scope", role.ID)
		}
	}
}

func TestDefaultPersonalRolesStayCompact(t *testing.T) {
	count := 0
	for _, role := range RoleCatalog {
		if role.DefaultPersonal {
			count++
		}
	}
	if count == 0 || count > 8 {
		t.Fatalf("default personal role count = %d, want 1..8", count)
	}
}

func TestGeneralOperationalRolesCanDescribePersonalExperience(t *testing.T) {
	for _, roleID := range []RoleID{RoleAssistantCoach, RoleTeamManager} {
		var role RoleDefinition
		found := false
		for _, candidate := range RoleCatalog {
			if candidate.ID == roleID {
				role = candidate
				found = true
				break
			}
		}
		if !found {
			t.Fatalf("role %q not found", roleID)
		}
		hasPersonalScope := false
		for _, scope := range role.Scopes {
			hasPersonalScope = hasPersonalScope || scope == RoleScopePersonal
		}
		if !hasPersonalScope {
			t.Fatalf("role %q cannot be used on a personal sport profile", roleID)
		}
	}
}
