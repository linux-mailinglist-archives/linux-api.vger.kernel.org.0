Return-Path: <linux-api+bounces-6596-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aDQYIUrMKWoJdgMAu9opvQ
	(envelope-from <linux-api+bounces-6596-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 10 Jun 2026 22:42:50 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E7066CE13
	for <lists+linux-api@lfdr.de>; Wed, 10 Jun 2026 22:42:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=johnericson.me header.s=fm3 header.b=RnQFdc1e;
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b="Q RgU8rR";
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6596-lists+linux-api=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-api+bounces-6596-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=johnericson.me;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EF274303CC67
	for <lists+linux-api@lfdr.de>; Wed, 10 Jun 2026 20:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1193F47ECCE;
	Wed, 10 Jun 2026 20:38:47 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from flow-b2-smtp.messagingengine.com (flow-b2-smtp.messagingengine.com [202.12.124.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FC47DA66;
	Wed, 10 Jun 2026 20:38:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781123926; cv=none; b=GM8uPIp/Jo8kYJcS9UIxQDIblo6M8b4yeF/kU+Gym+h8bfVCjIUS0EMmbf9Q2LrlRE4OBwXF3v3w7wVV/IaGLpLJiFCCNtw/cgO/uxw+jJQ+AVAddXy53/yiUIlQuzsPl9uIA0sInMc1eyl0y/v+IwJ3oVcPlzJmUs8BkdIX76M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781123926; c=relaxed/simple;
	bh=bEDrxC0e7YHTg9BGEJLnFRHo2kndEcLOabEL2KZLl+I=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ZNziSeedN13SbLDzX2OVPsxyZscJFkaLslRzjVc4mn4j9ibUTasvkxOuvbD0hCNA1JJx1thT1LYQMg28GK/ktkm1/NXyDkpMaJKLdlTEVSbtkKc4heKlBQwr/oohJBuWRn2k0lu8919yNeEtM4uFtWyMLCm5ITQ/P8INZavC52s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=johnericson.me; spf=pass smtp.mailfrom=johnericson.me; dkim=pass (2048-bit key) header.d=johnericson.me header.i=@johnericson.me header.b=RnQFdc1e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QRgU8rRJ; arc=none smtp.client-ip=202.12.124.137
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.stl.internal (Postfix) with ESMTP id 19C1E1300074;
	Wed, 10 Jun 2026 16:38:43 -0400 (EDT)
Received: from phl-imap-16 ([10.202.2.88])
  by phl-compute-05.internal (MEProxy); Wed, 10 Jun 2026 16:38:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=johnericson.me;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1781123922; x=1781131122; bh=bEDrxC0e7YHTg9BGEJLnFRHo2kndEcLO
	abEL2KZLl+I=; b=RnQFdc1ehookfxZskeYaO0LGYH4k+xPtvLoa3oFfYCkoTFn0
	Ttg7K+wuvRAF0lBdwJlU+xe/XNjGunYkSuKCPEIknEhzPzuR+tLFnZFZp+ktFnRO
	GtvOk4bBVFEkTto3BzClF+pC5PcukJAHw6OLfB5FVw9Z5v6StXjzNZpCwftoZA11
	7GUuhQ+gmeG6cxKGRIIT9uYk64vQdXsOt6WnVeKNR88DPEnuo6S6Y9Anrp+fqIR8
	jgVpp3+hDQgA6vuVO3RnkA6Er8+Jom9IEvjRo+vghEzZwEXK4LAhm3nCvT+bf3px
	Q5FMMAeS/RTjX/X9FN7Y9OMRbhaFqlVCFS1w2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781123922; x=
	1781131122; bh=bEDrxC0e7YHTg9BGEJLnFRHo2kndEcLOabEL2KZLl+I=; b=Q
	RgU8rRJzIa4UEklCAnc+PAwkaoWMsC+u6PhAtkmGDKTEYl2fN+CtlEyzv1P1ToB+
	epglkq6CbsdgT+alHGBdNXnURyXvky2HS7VQh/nLqR37Y9A134IoyA/ySO7fgvVw
	Irwz7rIbnthhVKH5fgF0qGxvMs+ifWt6xUHAuevWd4KTckK0lhvTVbrwUNP/Vi5Y
	WaGSvS1BZE/88VDpoxmxQ323V3szRJuzPKHYsJPfabCCJafHuRo5C743P29RFY1O
	qCoLP1Hf/ASvZAQCHiNPC2STa8ZxfZaV6Vt/p6XXz0Em9ukXbwLiwm6Bo65rYqPT
	uGd+rWiwYIfxBVjcJAJiQ==
X-ME-Sender: <xms:Ucspaq7ROJCg94S7g4ApNvmWiIM15KYk-FwcGKB01eMGISMqqZWXNA>
    <xme:UcspautuioAppC5EgckFH6FaPBCNDWxu3dOShwhdGeAAVatOQRQ9CxfhwKBfVsEo0
    oJ7xrGp33oWrk_ayvA1VgPv-bTntZ_dF9hhtHT4Xsj6GS4ENM41VrQL>
X-ME-Proxy-Cause: dmFkZTGaNeNTQ3G1F1+JWzJkMGql3D6L8AUgdkqFLx0WG5ejhftcD6XNOk17L4aaI3sLyo
    JMs836zpWnZQRvY3wiKtPAVpFVuFdcwBGOM0exgvpRf4fra7IypSfeU+3Wp4jbrVCLy94M
    NVooNMv5d55qj5zihBo2bVG0kwGZBVLwYdxuS4ieBQ4SBqpCBRuhhnAtTnBGICpgg0fcIe
    nR3Hz/EB3Go9W8jzMC6yHEBv8uBcD2hYbb+iMMYQB2o60laEVAFrKuuSjBswonvVOCc3Gk
    odcH87lSsUh/amBG/pxMLt5RblP2Wa+j2WlJhSp6SQ2RVeTNecZ/Rxy5QSf99EO5UNP9l3
    Se6+hqZ/tYap9i/epw532BHzfBQkdEs5R9F/V1PLK6u6OgDA9T5ub7dSAmN4fFWW9BO637
    EbIERqO3LWEweYPxuggu2I8QB5nG/ZPtxX8+uZKMIJcFOMDx8OzGhDh2c0vlu/dO1syAOq
    svLYMTbXYfn/go0WBEHsfsmnlehos1beHVOBHH3XKslvDcpES7DepH9Ha/h9SZPRPbVkS2
    v/lbpuDzk+lslHGotkLNybQ6pPEzlJI/q9jq3S7DK94vL5G+5dtvEesArzUM80edCJU8IL
    O5fGVCoGommkM13WiiVPQnxH6+WuNSjbPGN3yuNQOUgS+iyp4cJJE3EMqvnw
X-ME-Proxy: <xmx:UcspahQly0uFpZlUjGh--NhkJzJMv4OI3yFazQLn0Zj4Rv8sNw9s1w>
    <xmx:UcspausIaR3QHHlo8gAv8Huxu_KvqCsyrCHfJZUoXhO-7cMmHCwcMQ>
    <xmx:UcspavUtHS9qlU_-DywzPzzLAQrh-65e_La29NAujNrxgwZvHINEzg>
    <xmx:UcspainAboznNphZuC_qA7s4dkyCtpJ5aA7zI5AwFtpde5H2t0LTXA>
    <xmx:UsspahiyYw0Bh2a2JnJpgkhZM9oZYoc2lr4_FWH1CPIAoGZSxqg4pueu>
Feedback-ID: ieb4144f1:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 59E002CC0083; Wed, 10 Jun 2026 16:38:41 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AtGJywdvvpER
Date: Wed, 10 Jun 2026 16:38:21 -0400
From: "John Ericson" <mail@johnericson.me>
To: "Li Chen" <me@linux.beauty>
Cc: "Andy Lutomirski" <luto@kernel.org>,
 "Christian Brauner" <brauner@kernel.org>, "Kees Cook" <kees@kernel.org>,
 "Al Viro" <viro@zeniv.linux.org.uk>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 linux-api <linux-api@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 linux-mm <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>,
 linux-doc <linux-doc@vger.kernel.org>,
 linux-kselftest <linux-kselftest@vger.kernel.org>, x86 <x86@kernel.org>,
 "Arnd Bergmann" <arnd@arndb.de>, "Thomas Gleixner" <tglx@kernel.org>,
 "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, "Jan Kara" <jack@suse.cz>,
 "Jonathan Corbet" <corbet@lwn.net>, "Shuah Khan" <skhan@linuxfoundation.org>
Message-Id: <48594f3a-2ae9-4e1c-a575-ae54a6e1536d@app.fastmail.com>
In-Reply-To: <19eb181fdd4.6d028f442844776.3737831021032223216@linux.beauty>
References: <20260528095235.2491226-1-me@linux.beauty>
 <20260528-madig-fachrichtung-fehlinformation-61117ba640da@brauner>
 <CALCETrWJQpLR4n1cpichBk8=uExSKLWTMGU3BufGdk_WE_p5UA@mail.gmail.com>
 <19eacd64508.26b92c022125848.262962729296162879@linux.beauty>
 <4e049396-377d-48a7-a34c-91318413a876@app.fastmail.com>
 <19eb181fdd4.6d028f442844776.3737831021032223216@linux.beauty>
Subject: Re: [RFC PATCH v1 00/13] exec: add spawn templates for repeated executable
 startup
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[johnericson.me,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[johnericson.me:s=fm3,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:me@linux.beauty,m:luto@kernel.org,m:brauner@kernel.org,m:kees@kernel.org,m:viro@zeniv.linux.org.uk,m:linux-fsdevel@vger.kernel.org,m:linux-api@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:linux-arch@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:x86@kernel.org,m:arnd@arndb.de,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:hpa@zytor.com,m:jack@suse.cz,m:corbet@lwn.net,m:skhan@linuxfoundation.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[mail@johnericson.me,linux-api@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-6596-lists,linux-api=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mail@johnericson.me,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[johnericson.me:+,messagingengine.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,johnericson.me:dkim,johnericson.me:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 01E7066CE13

On Wed, Jun 10, 2026, at 8:29 AM, Li Chen wrote:
> Hi John,
>
> [...]
>
> Thanks, this helped a lot. I looked at FreeBSD/OpenBSD/XNU after your
> note. FreeBSD has P_INEXEC, OpenBSD has PS_INEXEC, and XNU seems even
> closer with P_LINTRANSIT, described as "process in exec or in creation=
".
> Linux does not seem to have a single equivalent today: current->in_exe=
cve
> is only an LSM hint, while the real synchronization is spread across
> exec_update_lock, cred_guard_mutex, and the exec path.

Great! Glad to hear my suggestion (and the patch too I linked in the
other email, I hope?) was useful.

> I am switching my local WIP from the two-fd builder model to one fd,
> closer to Christian's sketch:
>
> fd =3D pidfd_open(0, PIDFD_EMPTY);
> pidfd_config(fd, ...);
> pidfd_spawn_run(fd, ...);

Glad to hear it is also one-fd now.

> In my current local version, I still use copy_process(), so the fd poi=
nts
> at a real task_struct/pid that is not woken until run.

So this is an interesting thing to think about. My hunch is that
`copy_process` is, at least in the longer term, still doing too much! In
particular, `struct kernel_clone_args` has many degrees of freedom, and
might also make assumptions about preserving more of the parent process
than is needed in this case.

This is a bit tangential, but one thing I have thought about is having
"null namespaces". I think the current (i.e. existing clone API) default
of "share with parent process" is a poor security practice (more
privileges, i.e. sharing, should always be opt-in). But the opposite
default of "unshare everything" is expensive since creating new
namespaces is non-free. The goal of the null namespaces would be a cheap
way of creating a more isolated and unprivileged process =E2=80=94 and "=
cheap"
here is literal: a null pointer in `nsproxy`, no allocation, no
namespace object, no ID. This null state would be what
`pidfd_open(0, PIDFD_EMPTY)` (using your example above, or really
whatever the first step is) hands back.

Then, from that maximally cheap and unprivileged initial state, the
`pidfd_config(fd, ...);` calls (plural important, I think!) would opt
into either sharing or unsharing namespaces between the child and parent
as the parent sees fit.

The larger point here is that insofar as there are not good defaults for
things, there is pressure, whether in step 1 or step 2, to make larger
everything-at-once configuration. But when we think a bit outside the
box to create the good defaults where they didn't previously exist, we
can end up in a situation where a minimal initial blank unstarted
process, and the builder pattern to initialize it, are more "natural".

> Following
> Christian's point that existing APIs can handle this not-yet-running c=
ase
> with ESRCH, I currently make ordinary pidfd operations that need a real
> started process return -ESRCH before start.

Also glad to hear.

> I am not sure yet whether Linux should grow a general exec/creation
> transition state like that, or whether a narrower future-process
> lifecycle is enough for this API. I will think more about that when
> working on the pristine process version.

Sounds good, as I think you can guess, my preference is for "yes", but I
agree we can see what you end up with in the next patchset and make more
informed decisions based on that.

Cheers,

John

