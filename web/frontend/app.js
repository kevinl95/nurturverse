const tbody = document.querySelector("#leaderboard tbody");

const renderRows = (rows) => {
  tbody.innerHTML = "";
  rows.forEach((row) => {
    const tr = document.createElement("tr");
    tr.innerHTML = `
      <td>${row.rank}</td>
      <td>${row.displayName || row.handle}</td>
      <td>${Number(row.points || 0).toLocaleString()}</td>
    `;
    tbody.appendChild(tr);
  });
};

const loadLeaderboard = async () => {
  try {
    const response = await fetch("/leaderboard");
    if (!response.ok) throw new Error("Failed to load leaderboard");
    const data = await response.json();
    renderRows(data.leaders || []);
  } catch (error) {
    renderRows([
      { rank: "—", handle: "Leaderboard unavailable", points: 0 }
    ]);
  }
};

loadLeaderboard();
