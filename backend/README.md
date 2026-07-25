# Sportius backend contract

Stable Go DTOs, catalogues and facade interfaces for Sportius. Implementations
belong in `github.com/sneat-co/sportius/backend`.

## Invitation identity

Sportius invitations reuse Sneat's personal contact-invitation model. Creation
targets exactly one existing space contact (`contactID`) or supplies an
`inviteeDisplayName` so the Sportius implementation can create a non-member
contact first. Acceptance claims that contact and returns its stable
`contactID`; Sportius roles are then applied to the same person.

The generic Sneat membership role carried by the invitation is separate from
the zero-or-more Sportius participant roles suggested by the inviter and
confirmed by the invitee.
