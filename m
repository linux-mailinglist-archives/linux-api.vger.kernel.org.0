Return-Path: <linux-api+bounces-6048-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YF8MLxgdzGnHPgYAu9opvQ
	(envelope-from <linux-api+bounces-6048-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Tue, 31 Mar 2026 21:14:32 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6323706F4
	for <lists+linux-api@lfdr.de>; Tue, 31 Mar 2026 21:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AD979305EBAD
	for <lists+linux-api@lfdr.de>; Tue, 31 Mar 2026 19:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADC23A4537;
	Tue, 31 Mar 2026 19:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="GbCrd7S/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UXUZA9Om"
X-Original-To: linux-api@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB093A4F5D;
	Tue, 31 Mar 2026 19:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774984459; cv=none; b=vFtaTat5jHZpACTqfTDWxLtKejWo9nN9Apru91nFvlydsYuFIoXZCctUYiBCan2ftZihcNIj4TNnhVi3pasqOEAgX/JWvOb+BLJEGPRKSa9y/Nm8Rx4HDe1AdwIVdxl9obq6N5gRug2KDQKuSxFEsCNZoZRlirZGz+j+9A+m4UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774984459; c=relaxed/simple;
	bh=6UfukQtBmWKYp02VBb+8KF+mHtOfziVMOpzDUst/kuY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=V9nRJOf3vTVJFmso333jmlyzMd0TR/WK9QxnUKJBqbNErxgHWOP6YuDeGtCJPDXlqkgpIkiMLxf5GUDSj6bFCPaJC11uEb+53P5wpdQLo+wI1z4+I3osuww/B7mIgWTxjulTW+pUXGvVOVcw7JuH1xjgYkZp/jN999vDuhwcPU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=GbCrd7S/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UXUZA9Om; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 800E51400050;
	Tue, 31 Mar 2026 15:14:16 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Tue, 31 Mar 2026 15:14:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774984456;
	 x=1775070856; bh=2qDuSoZzFYhBvW0zARX8aWcBYydHA20yyvvWr3QXkMg=; b=
	GbCrd7S/Hz7kuAczlaApsolK/1cCYgSFtN3DKf5x8jls+WqX1vgAMLjQsChwgJ2c
	ReIc3wjun+nOwci6NBX7pL/43IcVUQAIfijbzf/P3UKePZl3u5oMV2G90Z4GKEIa
	AYcux/qD4OGLbBww2FkDZEs8+6QxCFKVeEyqfk2GDletx4XlV/+Smp/wQubOdNcJ
	PIb7/IpCg1510CapjvpLz/Vj/2LjQ3pLOp8BWsCOup1hicZnCoPK7u7m32guXZh5
	gmM12hVg7Po83jJlA5bUur1sxfzl7GLof/RZORBs3ttHu2g9IwxP8uGzwWirmz9X
	4bCD461wMP3DwOni3oeOvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1774984456; x=
	1775070856; bh=2qDuSoZzFYhBvW0zARX8aWcBYydHA20yyvvWr3QXkMg=; b=U
	XUZA9OmLKQwHTrupNOy1AOBmSGJPjq6d4bTs6eDLJOPbhynRy58J7oo8os41/EtN
	hkfmDLgoFpkBVOyMeVxjhSNBvbcJ2MY2+yw22JQ+iZy/uKCvnHtzYGI53/ZBtI1x
	CAbw89NOFat996CHOzhaRZUCDqGshBBZ14xw3JZEr6PmcsGqu9lPCf0URmtbYxbs
	gETAA2hkQMWG58BvJliCqBpSkcPJvqCP1Yf+C40g4LAw85brtJ8NmKFAMHoJVMPY
	ux6UZ4E8m4CB3JXnECgHYFO04vaD1DgYJ4EWi4eyDipi21wZ71RR9f5DwyPEjkVj
	zt8Te35C8WZlIVRwzugIA==
X-ME-Sender: <xms:Bh3Macrfgd-X-NLeHlo1iaUf1K0mo8uxsNHckkhlhluT95DtperVbA>
    <xme:Bh3MadeYIi-pUfmy4VY8xjiN5B_4JFTltAzCj80PkYeChy3nqOipoyJ6k5L40HWTA
    518izZ1nxP0Vdh-JNvRQGrOa8dfr1pGuvCWkiJlUUVwKEQ8R5DUqmQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhguuceu
    vghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvghrnh
    epjefhudekueettedtffetvefhjeegteekhfehueeliefhhfegveehffehhedvjeffnecu
    ffhomhgrihhnpehgihhthhhusgdrtghomhdplhifnhdrnhgvthenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
    pdhnsggprhgtphhtthhopeefvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsg
    hpsegrlhhivghnkedruggvpdhrtghpthhtoheptgihphhhrghrsegthihphhgrrhdrtgho
    mhdprhgtphhtthhopehmrghthhhivghurdguvghsnhhohigvrhhssegvfhhfihgtihhosh
    drtghomhdprhgtphhtthhopegrlhgvgidrrghrihhnghesghhmrghilhdrtghomhdprhgt
    phhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopegsrh
    gruhhnvghrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhgrhihtohhnsehkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehjohhlshgrsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehluhhtoheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Bh3MaR-M2RqFepVSC2_SnxCbkIyTGO5lbGJocl0F1oiBSBqD2wnXmg>
    <xmx:Bh3MaQFriY_pALQxMNfea6Av6q_Fo2x1zh3wj8Gwm7_h2Va7NjlMkw>
    <xmx:Bh3Maan2arLgExdBizqPD2xsQV-7y-SaatYOjxegUIYX_b8E4GnwUQ>
    <xmx:Bh3MafeWklBtKOIJWYwmtjPWTdfuBgsAzcWGvu7mV3N0Et7wO2slcA>
    <xmx:CB3MaUX2w-QSEjNNZC5v7N-hvAUFEGiBpjHwY5yqrmM9UCL984NfRG5f>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C3FFE700065; Tue, 31 Mar 2026 15:14:14 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ALL_5dcvP_Dc
Date: Tue, 31 Mar 2026 21:13:34 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jori Koolstra" <jkoolstra@xs4all.nl>,
 "Andy Lutomirski" <luto@kernel.org>, "Thomas Gleixner" <tglx@kernel.org>,
 "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jeff Layton" <jlayton@kernel.org>,
 "Chuck Lever" <chuck.lever@oracle.com>, shuah <shuah@kernel.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "H. Peter Anvin" <hpa@zytor.com>, "Jan Kara" <jack@suse.cz>,
 "Alexander Aring" <alex.aring@gmail.com>
Cc: "Peter Zijlstra" <peterz@infradead.org>,
 "Oleg Nesterov" <oleg@redhat.com>,
 "Andrey Albershteyn" <aalbersh@redhat.com>, "Jiri Olsa" <jolsa@kernel.org>,
 "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 "Namhyung Kim" <namhyung@kernel.org>,
 "Arnaldo Carvalho de Melo" <acme@redhat.com>,
 "Aleksa Sarai" <cyphar@cyphar.com>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-kselftest@vger.kernel.org,
 cmirabil@redhat.com, "Masami Hiramatsu" <mhiramat@kernel.org>
Message-Id: <c2ea52f2-b232-404b-9ec6-75d8efae6bea@app.fastmail.com>
In-Reply-To: <20260331172011.3512876-2-jkoolstra@xs4all.nl>
References: <20260331172011.3512876-1-jkoolstra@xs4all.nl>
 <20260331172011.3512876-2-jkoolstra@xs4all.nl>
Subject: Re: [RFC PATCH 1/2] vfs: syscalls: add mkdirat_fd()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arndb.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[arndb.de:s=fm1,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-6048-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[xs4all.nl,kernel.org,redhat.com,alien8.de,linux.intel.com,zeniv.linux.org.uk,oracle.com,linuxfoundation.org,zytor.com,suse.cz,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arnd@arndb.de,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[arndb.de:+,messagingengine.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-api];
	NEURAL_HAM(-0.00)[-0.312];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arndb.de:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 6D6323706F4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026, at 19:19, Jori Koolstra wrote:
> Currently there is no way to race-freely create and open a directory.
> For regular files we have open(O_CREAT) for creating a new file inode,
> and returning a pinning fd to it. The lack of such functionality for
> directories means that when populating a directory tree there's always
> a race involved: the inodes first need to be created, and then opened
> to adjust their permissions/ownership/labels/timestamps/acls/xattrs/...,
> but in the time window between the creation and the opening they might
> be replaced by something else.
>
> Addressing this race without proper APIs is possible (by immediately
> fstat()ing what was opened, to verify that it has the right inode type),
> but difficult to get right. Hence, mkdirat_fd() that creates a directory
> and returns an O_DIRECTORY fd is useful.
>
> This feature idea (and description) is taken from the UAPI group:
> https://github.com/uapi-group/kernel-features?tab=readme-ov-file#race-free-creation-and-opening-of-non-file-inodes
>
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>

I checked that the calling conventions are fine, i.e. this will work
as expected across all architectures. I assume you are also aware
that the non-RFC patch will need to add the syscall number to all
.tbl files.

The hardest problem here does seem to be the naming of the
new syscall, and I'm sorry to not be able to offer any solution
either, just two observations:

- mkdirat/mkdirat_fd sounds similar to the existing
  quotactl/quotactl_fd pair, but quotactl_fd() takes a file
  descriptor argument rather than returning it, which makes
  this addition quite confusing.

- the nicest interface IMO would have been a variation of
  openat(dfd, filename, O_CREAT | O_DIRECTORY, mode)
  but that is a minefield of incompatible implementations[1],
  so we can't do that without changing the behavior for
  existing callers that currently run into an error.

       Arnd

[1] https://lwn.net/Articles/926782/

