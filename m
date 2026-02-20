Return-Path: <linux-api+bounces-5867-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4AP+BMTDmGl/LwMAu9opvQ
	(envelope-from <linux-api+bounces-5867-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Fri, 20 Feb 2026 21:27:48 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D4D16AA05
	for <lists+linux-api@lfdr.de>; Fri, 20 Feb 2026 21:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55E5B301B908
	for <lists+linux-api@lfdr.de>; Fri, 20 Feb 2026 20:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFC62FF154;
	Fri, 20 Feb 2026 20:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="eM5dpppF"
X-Original-To: linux-api@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2852FD1C5;
	Fri, 20 Feb 2026 20:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771619263; cv=none; b=bexwAEGfOkzZ6le9/RLGXQSCLYeoTinwMsSf4hhgJ8CLIZIVruFpfcg1sVhKHfg84RSO2lolF2cvnUNPgVPsMCUoBHj2+crELn6Og++MwU6i4xEIKGa0se2aHGwzz1IzL9M3ajv6EfSmGSJu5xL2BZ+4YowbCN+RcHv7ka2EQ9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771619263; c=relaxed/simple;
	bh=un9uTO1kN/FX/Pulk7o9UNEKszgFzdpeJnURAgqmc54=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CMGHzJJD19IZMKm440zGOcQNl7sD2jceIGqxWFJXe1Kor6gq1HOluAE6dCuzmnoBhWwAYR2x/aIb6PgI+MOYjrkFEzoiFkBaBt6YJ17lEXxKs2J/sjqvefawJywWALMtWBWb+HtyLOvG3461NTD6wvvrz3+kbHH3K8vgvb+dCt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=eM5dpppF; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=3PWDYWt29z/mB21074sPdwQLXpdZUJgh9IqW4IVswuo=; b=eM5dpppFoOLjQIk58qE/h3PTi7
	cc+6ymyfrugVXqyp27YXZ3oAJcYZlzrQw7yLNEXtPuzUKwdatPEtWJ268Mrbpw9wL73kLZ6d11fwu
	ZGskJm5hgUClj0TRPHTSC4fIGFgE/IUQxZXIsOA1A6BlUlO8mAy1dpMPBZxflaZywjHw1faJhdfqn
	MhIp38OEpR9zpdGK3zxeV3L2knj76jJAYjRNH0nROxX1Xe/b2FG6Nw7zCyRYmgQnS1MMWFUAUSDUf
	1BC0VZC040G6lA7labGf3FkMlrcHe+ZXYtXHUklhjjz1tU7Kyi3ttF6DE1szrm9RwNKTJipfmYR4g
	ke2IfQQQ==;
Received: from [187.57.77.133] (helo=computador)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vtX5D-0036Zi-Dk; Fri, 20 Feb 2026 21:26:39 +0100
From: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To: Carlos O'Donell <carlos@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Florian Weimer <fweimer@redhat.com>,
	Rich Felker <dalias@aerifal.cx>,
	Torvald Riegel <triegel@redhat.com>,
	Darren Hart <dvhart@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>
Cc: kernel-dev@igalia.com,
	linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [RFC PATCH 0/2] futex: how to solve the robust_list race condition?
Date: Fri, 20 Feb 2026 17:26:18 -0300
Message-ID: <20260220202620.139584-1-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.64 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[igalia.com:s=20170329];
	SUBJECT_ENDS_QUESTION(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-5867-lists,linux-api=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrealmeid@igalia.com,linux-api@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[igalia.com:-];
	NEURAL_HAM(-0.00)[-0.984];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sourceware.org:url,igalia.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lpc.events:url]
X-Rspamd-Queue-Id: 77D4D16AA05
X-Rspamd-Action: no action

During LPC 2025, I presented a session about creating a new syscall for
robust_list[0][1]. However, most of the session discussion wasn't much related
to the new syscall itself, but much more related to an old bug that exists in
the current robust_list mechanism.

Since at least 2012, there's an open bug reporting a race condition, as
Carlos O'Donell pointed out:

  "File corruption race condition in robust mutex unlocking"
  https://sourceware.org/bugzilla/show_bug.cgi?id=14485

To help understand the bug, I've created a reproducer (patch 1/2) and a
companion kernel hack (patch 2/2) that helps to make the race condition
more likely. When the bug happens, the reproducer shows a message
comparing the original memory with the corrupted one:

  "Memory was corrupted by the kernel: 8001fe8d8001fe8d vs 8001fe8dc0000000"

I'm not sure yet what would be the appropriated approach to fix it, so I
decided to reach the community before moving forward in some direction.
One suggestion from Peter[2] resolves around serializing the mmap() and the
robust list exit path, which might cause overheads for the common case,
where list_op_pending is empty.

However, giving that there's a new interface being prepared, this could
also give the opportunity to rethink how list_op_pending works, and get
rid of the race condition by design.

Feedback is very much welcome.

Thanks!
	André

[0] https://lore.kernel.org/lkml/20251122-tonyk-robust_futex-v6-0-05fea005a0fd@igalia.com/
[1] https://lpc.events/event/19/contributions/2108/
[2] https://lore.kernel.org/lkml/20241219171344.GA26279@noisy.programming.kicks-ass.net/

André Almeida (2):
  futex: Create reproducer for robust_list race condition
  futex: Add debug delays

 kernel/futex/core.c |  10 +++
 robust_bug.c        | 178 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 188 insertions(+)
 create mode 100644 robust_bug.c

-- 
2.53.0


