Return-Path: <linux-api+bounces-6349-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJzKCORLC2o7FQUAu9opvQ
	(envelope-from <linux-api+bounces-6349-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 18 May 2026 19:27:00 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 772B15719A6
	for <lists+linux-api@lfdr.de>; Mon, 18 May 2026 19:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9DC373039832
	for <lists+linux-api@lfdr.de>; Mon, 18 May 2026 17:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5864371868;
	Mon, 18 May 2026 17:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Xc+6F+s1"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-24427.protonmail.ch (mail-24427.protonmail.ch [109.224.244.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E07384233;
	Mon, 18 May 2026 17:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779124960; cv=none; b=byXdd/bJBz91lrevoLACiAACTUS0BvIqVe4ibqXEDhHGGG80o+i3UsVyTOy2G9DnPsIOefRjeS3IzaCtJHMWV6kRvnaxYVApPTdPBejD1AuWUBoWSFynrDOLnDJK5lldk9RbtQaAFj2p+VRlZw4HFBl/PUHZgU6Gvr37Jn9dWYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779124960; c=relaxed/simple;
	bh=ydSYadrnu3kkyI9l0uX2fBnLI/6W+uQ1/XQAiBbql2c=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=NWzjWlb5fGkXllmNNGW1G+GF9Aw3Pc7HuiLB6igmXNiBWIE4wzxgk0zsSvvRdcBsoYub5LIsgc56jPoauCb+7tC69FnAV7/3OoFoMAPZan5GhuD7RZf8gAzkuXTgeFyk6Cc/09DDkqeQz6RMs5iV76/SrCO1bS84n2csE+oAC0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Xc+6F+s1; arc=none smtp.client-ip=109.224.244.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1779124950; x=1779384150;
	bh=FM09ImBdxC4h9uzOVnYMi6mtxoZ+gmJ6q8797szrN1Q=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Xc+6F+s1yKgD7dFHQJorESPPveKTx7jisk7/LTb9aHuw3cyGc9ZzJfXdnxbPpAC43
	 duMKvGrbucFqVmXMg1ISwFB+VcecWdp291RZVnyd55S4NbS0zHIuZ8cR+RGr8fz1ec
	 3+bkpdH4B7tYI2RV6WFW1FHDGTcxRUzF/+1vAKT52mxu6e0vCbZalcNHAan9lEZ4Ja
	 HxQAEL3HtBWVHrBCaY0Rq1XUqlhYltjuexL9nDR3xy3488PEGX6C+BkdBmlKOqmC2h
	 g4k5ZLmd+e5+9NuIN1nSkaci+no+U+651fo3Qyjy/ZveZTCAjYXUpkv7dObtELlKbd
	 rNqdj7VybKjAQ==
Date: Mon, 18 May 2026 17:22:24 +0000
To: "luto@amacapital.net" <luto@amacapital.net>
From: Cyber_black <Cyberblackk@proton.me>
Cc: "hch@infradead.org" <hch@infradead.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "tytso@mit.edu" <tytso@mit.edu>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, "djwong@kernel.org" <djwong@kernel.org>, "mark@fasheh.com" <mark@fasheh.com>, "moybs027@gmail.com" <moybs027@gmail.com>
Subject: [5][RFC] fs/ioctl.c: FIBMAP requires CAP_SYS_RAWIO while FIEMAP exposes identical data unprivileged
Message-ID: <-nQmUF-iBsNFQ1Iz2j_cVui7DxnmpAO7z3X7qH8Xzpr7CYXE8j5x5YeFQ39U1wcMFNuVnuxu1pJf7ooiwJYK8ZFJDpjEtifFaBuWNJIi0ak=@proton.me>
Feedback-ID: 117998405:user:proton
X-Pm-Message-ID: b0252c05f510b23cddc2c8e4c94e9647a953e05c
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[proton.me,quarantine];
	R_DKIM_ALLOW(-0.20)[proton.me:s=protonmail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,vger.kernel.org,mit.edu,kernel.org,fasheh.com,gmail.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-6349-lists,linux-api=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[proton.me:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Cyberblackk@proton.me,linux-api@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,proton.me:mid,proton.me:dkim]
X-Rspamd-Queue-Id: 772B15719A6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for raising this important question, Andy. I've been following th=
e discussion as a "listening guest" and I have a thought.

My idea is this: Instead of forcing FIEMAP to become a root-only interface =
(breaking existing tools), or leaving it as-is (with information disclosure=
), what if we design a new, restricted API that is not privileged but also =
not unprivileged in the traditional sense?

Concretely:

1.  The API would be callable by any user, but it would not expose physical=
 block addresses.
   =20
2.  It would answer higher-level questions that tools actually need, such a=
s:
   =20
    -   "Are these two file ranges reflinked (shared)?" (for deduplication)
       =20
    -   "Is this file range sparse (holes)?" (without leaking physical loca=
tions)
       =20
    -   "What is the allocation status (delayed, unwritten, etc.)?"
       =20
3.  The kernel would maintain a capability or permission that is not root-e=
quivalent (e.g., a new `CAP_BLOCK_MAP_QUERY`), but the API would not requir=
e full `CAP_SYS_RAWIO`.
   =20

This way:

-   Tools like `filefrag`, `cp`, and deduplication utilities can work witho=
ut root.
   =20
-   Physical block addresses remain hidden from unprivileged users, closing=
 the information leak.
   =20
-   We avoid forcing users to run these tools as root, which would open up =
far more serious risks (e.g., kernel panic, accidental corruption).
   =20

In short: we don't need to choose between "unprivileged leak" and "root-onl=
y". We can design a purpose=E2=80=91limited API that answers only the neces=
sary questions, with the minimum privilege required.

Would this be acceptable? I'd be happy to help draft a more detailed propos=
al or prototype.

This idea was developed together with my friend playerofficial19 (moybs027@=
gmail.com) through discussion. We hope it's helpful.

