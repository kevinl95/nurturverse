const { onRequest } = require("firebase-functions/v2/https");
const admin = require("firebase-admin");
const Filter = require("bad-words");

admin.initializeApp();

const db = admin.firestore();
const filter = new Filter();

// Anonymous handle model: client submits a locally generated handle and
// optional display name; backend accepts submissions as-is.

const containsProfanity = (value) => {
  if (!value) return false;
  return filter.isProfane(String(value));
};

exports.submitScore = onRequest(async (req, res) => {
  if (req.method !== "POST") {
    res.status(405).send("Method Not Allowed");
    return;
  }

  const { handle, points, displayName } = req.body || {};

  if (!handle || typeof points !== "number") {
    res.status(400).json({ error: "Missing handle or points" });
    return;
  }

  if (containsProfanity(displayName) || containsProfanity(handle)) {
    res.status(400).json({ error: "Display name not allowed" });
    return;
  }

  if (!Number.isFinite(points) || points <= 0) {
    res.status(400).json({ error: "Invalid points" });
    return;
  }

  const ref = db.collection("leaderboard").doc(handle);

  await db.runTransaction(async (tx) => {
    const snap = await tx.get(ref);
    const current = snap.exists ? snap.data().points || 0 : 0;
    const updated = current + points;
    tx.set(
      ref,
      {
        handle,
        displayName: displayName || handle,
        points: updated,
        updatedAt: admin.firestore.FieldValue.serverTimestamp()
      },
      { merge: true }
    );
  });

  res.json({ ok: true, handle });
});

exports.leaderboard = onRequest(async (_req, res) => {
  const snapshot = await db
    .collection("leaderboard")
    .orderBy("points", "desc")
    .limit(100)
    .get();

  const leaders = snapshot.docs.map((doc, index) => ({
    rank: index + 1,
    handle: doc.data().handle,
    displayName: doc.data().displayName || doc.data().handle,
    points: doc.data().points
  }));

  res.json({ leaders });
});
