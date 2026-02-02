---
layout: default
title: Evan Beller — Open Government
---

<style>
  /* Scoped to the landing container to avoid clobbering global site styles */
  .landing { color: inherit; }
  .landing .wrap { max-width: 760px; margin: 0 auto; padding: 1.25rem; }
  .landing .kicker { font-size: 0.95rem; opacity: 0.85; margin: 0 0 0.25rem; }
  .landing h1 { font-size: 2.15rem; line-height: 1.1; margin: 0.25rem 0 0.75rem; letter-spacing: -0.02em; }
  .landing .tagline { font-size: 1.25rem; line-height: 1.35; margin: 0 0 1rem; }
  .landing .lede { font-size: 1.05rem; line-height: 1.55; margin: 0.75rem 0 1rem; }
  .landing .rulebox {
    border: 1px solid rgba(0,0,0,0.12);
    padding: 0.85rem 1rem;
    margin: 1.25rem 0;
    border-radius: 6px;
  }
  .landing .rulebox h2 { font-size: 1.05rem; margin: 0 0 0.5rem; }
  .landing ul { margin: 0.5rem 0 0.25rem 1.2rem; }
  .landing li { margin: 0.35rem 0; }
  .landing hr { border: 0; border-top: 1px solid rgba(0,0,0,0.12); margin: 1.25rem 0; }
  .landing .section { margin: 1rem 0 1.25rem; }
  .landing .section h2 { font-size: 1.2rem; margin: 0 0 0.5rem; }
  .landing .callout {
    background: rgba(0,0,0,0.03);
    border-left: 4px solid rgba(0,0,0,0.08);
    padding: 0.75rem 0.9rem;
    margin: 1rem 0;
    border-radius: 4px;
  }
  .landing .links { display:flex; flex-wrap:wrap; gap:0.65rem 1.25rem; margin:0.75rem 0 0; padding:0; list-style:none; }
  .landing .links li { margin:0; }
  .landing .meta { font-size:0.9rem; opacity:0.8; }
  .landing .fine { font-size:0.85rem; opacity:0.75; }
  .landing a { text-decoration: underline; color: inherit; }
  .landing a:focus { outline: 2px dotted currentColor; outline-offset: 3px; }
  @media (max-width:680px){
    .landing h1{font-size:1.65rem}
    .landing .tagline{font-size:1.05rem}
  }
</style>

<main class="wrap landing" role="main" aria-labelledby="hero-title">
  <p class="kicker">Open Government • Radical Transparency</p>
  <h1 id="hero-title">Evan Beller</h1>
  <p class="tagline"><strong>Power should be legible.</strong> Decisions should be traceable. Action should be inspectable.</p>

  <p class="lede">
    I’m not here to sound impressive or pretend I have every answer.
    I’m here to listen to normal people, pick the most immediate helpful actions, and <strong>show my work in public</strong>.
  </p>

  <div class="callout" role="note" aria-live="polite">
    <p style="margin:0;">
      <strong>How this works:</strong><br>
      People describe what’s broken → I write it down → we choose an approach → I act → we publish results and receipts.
      <br><em>You don’t have to trust me. You can check.</em>
    </p>
  </div>

  <section class="section" aria-labelledby="why">
    <h2 id="why">Why you should care</h2>
    <p class="lede" style="margin-top:0.5rem;">
      Government fails when reasoning disappears behind closed doors. When decisions aren’t explainable,
      mistakes repeat, waste grows, and trust collapses.
    </p>
    <p class="lede">
      Radical transparency is a simple fix: if thinking is public, bad ideas get caught early, good ideas improve,
      and accountability becomes automatic.
    </p>
  </section>

  <div class="rulebox" aria-labelledby="rules">
    <h2 id="rules">Non-negotiable rules I follow</h2>
    <ul>
      <li><strong>Every major decision gets written down</strong> in plain language.</li>
      <li><strong>Every action has a visible outcome</strong> (or a clear explanation if it failed).</li>
      <li><strong>Every claim gets a receipt</strong> whenever possible.</li>
      <li><strong>Every correction is documented</strong> so nothing is memory-holed.</li>
      <li><strong>Feedback is part of the system</strong>, not a threat to it.</li>
    </ul>
  </div>

  <section class="section" aria-labelledby="your-role">
    <h2 id="your-role">Your role</h2>
    <p class="lede" style="margin-top:0.5rem;">
      You’re not an audience member. You’re a contributor:
    </p>
    <ul>
      <li>Tell me what’s broken (specific beats loud).</li>
      <li>Challenge assumptions and point out blind spots.</li>
      <li>Offer better options, with reasoning.</li>
      <li>Hold me to outcomes, not vibes.</li>
    </ul>
  </section>

  <hr>

  <section class="section" aria-labelledby="start-here">
    <h2 id="start-here">Start here</h2>
    <p class="lede" style="margin-top:0.5rem;">
      Everything below is plain, fast, and public by default.
    </p>

    <!-- Links use site.baseurl so they work on your project site -->
    <ul class="links" role="list">
      <li><a href="{{ site.baseurl }}/manifesto/">Manifesto</a></li>
      <li><a href="{{ site.baseurl }}/plan/">My direct plan</a></li>
      <li><a href="{{ site.baseurl }}/immediate/">If in office</a></li>
      <li><a href="{{ site.baseurl }}/metrics/">Stats &amp; Progress</a></li>
      <li><a href="{{ site.baseurl }}/goals/">Goals</a></li>
      <li><a href="{{ site.baseurl }}/awards/">Good Citizen Awards</a></li>
      <li><a href="{{ site.baseurl }}/contact/">Contact</a></li>
    </ul>
  </section>

  <hr>

  <p class="meta"><strong>Last updated:</strong> {{ site.time | date: "%Y-%m-%d" }}</p>

  <p class="fine">
    <a href="{{ site.baseurl }}/about/">About</a> • <a href="{{ site.baseurl }}/privacy/">Data &amp; privacy disclaimer</a>
  </p>

  <p class="fine" style="margin-top:0.75rem;">
    <em>If you want slogans, this isn’t for you. If you want a system you can inspect and improve, welcome.</em>
  </p>
</main>