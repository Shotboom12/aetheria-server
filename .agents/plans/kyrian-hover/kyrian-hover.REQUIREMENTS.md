# Ascended Hover first test

Approved by the user on 2026-10-25. Kyrian is race 60; Venthyr is race 61.

- Hover stays close to terrain, with normal movement, collision and combat range.
- One activation provides 15,000ms of total combat hover time.
- Out of combat is indefinite, pausing the remaining combat allowance.
- Re-entering combat resumes the remaining allowance; it never refills it.
- Using Hover from the ground while already in combat grants 3,000ms stun immunity.
- Entering combat during an existing hover gives no immunity.
- Expiry, a successful stun, or manually ending Hover requests descent.
- Landing starts the 120,000ms cooldown. Descent cannot be cancelled by combat dropping.
- Casting the ability again or cancelling its buff manually ends Hover.
- Mounts, vehicles, water, non-native transformations and shapeshifts end Hover.
- Logout, death and map changes terminate the activation and start its cooldown;
  logout does so before the character's cooldown save.
- Only Kyrian receives the ability, including existing characters on login.
- This phase implements Hover only; Charge and the other racials follow separately.

User restrictions: no Devtool, no subagents. Stop before the server build for the
user to switch to Luna. Use four compiler workers when the build is authorized.
