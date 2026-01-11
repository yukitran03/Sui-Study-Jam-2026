"use client";

import { useEffect, useState } from "react";
import {
  ConnectButton,
  useCurrentAccount,
  useSuiClient,
  useSignAndExecuteTransaction,
} from "@mysten/dapp-kit";
import { Transaction } from "@mysten/sui/transactions";

const PACKAGE_ID = "0x15fa4c6de9dc36e1b405c8ae6a2b9785f4fbdafa1ae8f882131c2cd2fdb791bf";
const VOTING_ID = "0x0798cc3c7a62fe44c5f2c477d811e5a8450ca3d3d17d53e02e4921965130f15e";

export default function App() {
  const account = useCurrentAccount();
  const suiClient = useSuiClient();
  const { mutateAsync: signAndExecute } =
    useSignAndExecuteTransaction();

  const [optionA, setOptionA] = useState<number>(0);
  const [optionB, setOptionB] = useState<number>(0);
  const [status, setStatus] = useState<string>("");

  async function fetchVotingState() {
  const obj = await suiClient.getObject({
    id: VOTING_ID,
    options: { showContent: true },
  });

  // @ts-expect-error -- Move object fields are dynamic
  const fields = obj.data?.content?.fields;

  setOptionA(Number(fields.option_a));
  setOptionB(Number(fields.option_b));
}

  /**
   * 📦 Fetch on-chain voting state
   */
  useEffect(() => {
  if (!VOTING_ID) return;
    // eslint-disable-next-line react-hooks/set-state-in-effect
    fetchVotingState();
  }, [suiClient]);

  /**
   * 🗳 Vote (PTB)
   */
  async function vote(choice: boolean) {
  if (!account) {
    setStatus("❌ Please connect wallet first");
    return;
  }

  try {
    setStatus("⏳ Submitting transaction...");

    const tx = new Transaction();
    tx.moveCall({
      target: `${PACKAGE_ID}::voting::vote`,
      arguments: [
        tx.object(VOTING_ID),
        tx.pure.bool(choice),
      ],
    });

    await signAndExecute({ transaction: tx });

    setStatus("✅ Vote successful!");
    await fetchVotingState();

  } catch (err) {
    console.error(err);
    setStatus("❌ Vote failed (already voted or invalid)");
  }
}

  return (
    <div
      style={{
        padding: 40,
        fontFamily: "system-ui, sans-serif",
        maxWidth: 600,
        margin: "0 auto",
      }}
    >
      <h1>🗳 Simple Voting DApp (Sui)</h1>

      <ConnectButton />

      {account && (
        <>
          <p style={{ marginTop: 12 }}>
            <strong> Wallet address:</strong>
            <br />
            <code>{account.address}</code>
          </p>

          <p style={{ marginTop: 12 }}>
            <strong> Package ID:</strong>
            <br />
            <code>{PACKAGE_ID}</code>
          </p>

          <hr style={{ margin: "24px 0" }} />

          <h2>📊 Total Results</h2>
          <p>Option A: <b>{optionA}</b></p>
          <p>Option B: <b>{optionB}</b></p>

          <hr style={{ margin: "24px 0" }} />

          <h2>🗳 Vote</h2>

          <div style={{ display: "flex", gap: 12 }}>
            <button
              onClick={() => vote(true)}
              style={{
                padding: "10px 16px",
                cursor: "pointer",
              }}
            >
              Vote Option A
            </button>

            <button
              onClick={() => vote(false)}
              style={{
                padding: "10px 16px",
                cursor: "pointer",
              }}
            >
              Vote Option B
            </button>
          </div>

          <p style={{ marginTop: 16 }}>{status}</p>
        </>
      )}
    </div>
  );
}