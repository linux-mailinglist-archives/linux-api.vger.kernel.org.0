Return-Path: <linux-api+bounces-5889-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDxZIEM9pWm36gUAu9opvQ
	(envelope-from <linux-api+bounces-5889-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 02 Mar 2026 08:33:23 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E176D1D3FB7
	for <lists+linux-api@lfdr.de>; Mon, 02 Mar 2026 08:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6BB563013865
	for <lists+linux-api@lfdr.de>; Mon,  2 Mar 2026 07:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF0A383C61;
	Mon,  2 Mar 2026 07:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WcNz45+C"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A4B377031
	for <linux-api@vger.kernel.org>; Mon,  2 Mar 2026 07:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772436705; cv=none; b=E6yff6c/De59LIT1If4oLPJMH2olF3RJRiOfjwz33TmTIac2JeZDfJQ0J8MOT9uNemKSIr/ABkZjJHqi/qANC9eN4P2ZH+2Ucq25Jo0AdNmGk9MRSygscqeFBf3tPozis/h8WVgiEeZfsnnCQ3wFO8lbe0OK7u5NVYPK3cyYX+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772436705; c=relaxed/simple;
	bh=XOIblyUY+naLJJGY0zT6QLnh9tXIuMGdvNV4ZdV35Sc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MAS6H1HCScDeCA0d+ET3Cf+ybsMRvJthgwKUlLEpEWtOB+aRQfy4uh4f4j3r5+wTkeJpkWnbYnVAHcey917BWlDbsN8UNqmuP+yGttc/t5kjZEZ1iMLxKCXeBdv421JtCsyMMIGkog/JnQzD/DlxqkdfBL2RiiX1kl30ZpfAcoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WcNz45+C; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772436703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/2wTkJjwuYIbXyYb8D2J2N4b7CfFVskYwBA2k1/L4eQ=;
	b=WcNz45+CG4TglikNvnexWeLlmWd4Fgl6I3WlrWKdAtOz15E4oDLAUr4C466oGtQZbBsXXg
	HgI7HXM+FNMbzs1a3FvRE8/Vit5h3XUlY95fwHB+aL/DZGbpliNEKJAGn2Ln37GRvpEk7p
	1Z0VHaow+I+71HHmdRSkxu7W7PWCjxI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-451-eGML8WRiM8-J2d48TsPXdA-1; Mon,
 02 Mar 2026 02:31:39 -0500
X-MC-Unique: eGML8WRiM8-J2d48TsPXdA-1
X-Mimecast-MFC-AGG-ID: eGML8WRiM8-J2d48TsPXdA_1772436697
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5478F18004BB;
	Mon,  2 Mar 2026 07:31:35 +0000 (UTC)
Received: from fweimer-oldenburg.csb.redhat.com (unknown [10.44.32.151])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 243EA30001B9;
	Mon,  2 Mar 2026 07:31:26 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>,
  kernel-dev@igalia.com,  "Liam R
 . Howlett" <Liam.Howlett@oracle.com>,  linux-api@vger.kernel.org,  Darren
 Hart <dvhart@infradead.org>,  Thomas Gleixner <tglx@kernel.org>,  Ingo
 Molnar <mingo@redhat.com>,  Peter Zijlstra <peterz@infradead.org>,
  Torvald Riegel <triegel@redhat.com>,  Davidlohr Bueso
 <dave@stgolabs.net>,  Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,  Rich
 Felker <dalias@aerifal.cx>,  Carlos O'Donell <carlos@redhat.com>,  Michal
 Hocko <mhocko@suse.com>,  linux-kernel@vger.kernel.org,  libc-alpha@sourceware.org
 <libc-alpha@sourceware.org>,  Arnd Bergmann <arnd@arndb.de>,  Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [RFC PATCH 0/2] futex: how to solve the robust_list race
 condition?
In-Reply-To: <694424f4-20d1-4473-8955-859acbad466f@efficios.com> (Mathieu
	Desnoyers's message of "Sun, 1 Mar 2026 10:49:15 -0500")
References: <20260220202620.139584-1-andrealmeid@igalia.com>
	<0d334517-63ee-46c9-884d-6c2ae8388b87@efficios.com>
	<67be0aa1-2241-43ef-aa01-a89ced26c8f6@efficios.com>
	<a1e24288-6ffc-438d-8a2a-d152134c9555@efficios.com>
	<ed918547-1406-4ae6-8a94-4e03712a4923@igalia.com>
	<bd7a8dd3-8dee-4886-abe6-bdda25fe4a0d@efficios.com>
	<694424f4-20d1-4473-8955-859acbad466f@efficios.com>
Date: Mon, 02 Mar 2026 08:31:24 +0100
Message-ID: <lhufr6ihelv.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-5889-lists,linux-api=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[fweimer@redhat.com,linux-api@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E176D1D3FB7
X-Rspamd-Action: no action

* Mathieu Desnoyers:

> Of course, we'd have to implement the whole transaction in assembler
> for each architecture.

Could this be hidden ina vDSO call?  It would have to receive a pointer
to the rseq area in addition to other arguments that identify the unlock
operation to be performed.  The advantage is that the kernel would now
the addresses involved, so a single rseq flag should be sufficient.  It
could also vary the LL/SC sequence based on architecture capabilities.

The question is whether we can model the unlock operation so that it's
sufficiently generic.

Thanks,
Florian


