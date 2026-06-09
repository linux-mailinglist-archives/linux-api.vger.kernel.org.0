Return-Path: <linux-api+bounces-6588-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uUPjEJxQKGoyCAMAu9opvQ
	(envelope-from <linux-api+bounces-6588-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Tue, 09 Jun 2026 19:42:52 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB086630AD
	for <lists+linux-api@lfdr.de>; Tue, 09 Jun 2026 19:42:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=johnericson.me header.s=fm3 header.b=HE3ZkDji;
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b="U H5I0Kp";
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6588-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6588-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=johnericson.me;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B011630095E6
	for <lists+linux-api@lfdr.de>; Tue,  9 Jun 2026 17:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F2847DF9D;
	Tue,  9 Jun 2026 17:28:16 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from flow-a3-smtp.messagingengine.com (flow-a3-smtp.messagingengine.com [103.168.172.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5639363C46;
	Tue,  9 Jun 2026 17:28:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781026096; cv=none; b=VxtN1aoPIVRzv3r6eqbd2mMR98q56L9CJb9za48JATJNsJf862CcCBtRSYVlM5hBk4AXCnPdlWeYnkr3PD1J/qU/qbaASNvxLODrojmThIdwdX+UEU+rIP0YlJBhmQU9dDkiOUndkch27DCYsrFDOVgxSOBwIK6GGXfl19yAOfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781026096; c=relaxed/simple;
	bh=RndYqpsRK1cbF9S8uUn0Zc9Z/6z/z+JG0kopFVxnUJQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=HL+QVkcfp+Q4OnDzdva5vboRMHxgYCzuHMqCOttDbqNOeSjxdC8v5iWKfzcPWtLYHzNqikNuGsm62dwpt5UrcF64jhdU4Rz8WvNtiZwUxnOuemf9dMji7QJolodx8DB3o0pLMKgk1gno3fVxjY95rU+lF5wkIAUHzc/Qmhow1Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=johnericson.me; spf=pass smtp.mailfrom=johnericson.me; dkim=pass (2048-bit key) header.d=johnericson.me header.i=@johnericson.me header.b=HE3ZkDji; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UH5I0Kp/; arc=none smtp.client-ip=103.168.172.138
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.phl.internal (Postfix) with ESMTP id C2CE513804A9;
	Tue,  9 Jun 2026 13:28:13 -0400 (EDT)
Received: from phl-imap-16 ([10.202.2.88])
  by phl-compute-05.internal (MEProxy); Tue, 09 Jun 2026 13:28:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=johnericson.me;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1781026093; x=1781033293; bh=snmIR5TlwK9lFoo/BHJwgJJSAFxLeac4
	ICD6l4oUvpg=; b=HE3ZkDji5I5YD9LxdPIcf92Zc+LYhfx40Jg/wbA8GXORicY2
	QaiWMJvbkKCx7kyflIVHAf0X2IZC2s7Uxc7VoTJOtONJLgNixkFVFvKfVzutf3mX
	G6lmVW/BGgpmF5Ai19QSPr9U0SGccEI73IDWbUJASZdWYLS2EKdESKF5mQJlYdQt
	WgAGt3dmqFC2fqC6qGhTb5jJd5gj/GNQnN19p55+qo/mhwNsFkYoas6LUw5GTLJX
	jCKRA5rdGSwMTbeRIAynA6dk105bfMXz+Jn6ZpEQaZGz4pf/vjvLEQx0LPoFbntc
	DUuPxnL0x4ZU62vchhzJp438Naua5Lfqn+wg2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781026093; x=
	1781033293; bh=snmIR5TlwK9lFoo/BHJwgJJSAFxLeac4ICD6l4oUvpg=; b=U
	H5I0Kp/D7aH/EguuehCHLLkrYN9Bp+EY5ICsflRQcHHT+hKGuQwmQDakepYBbcD6
	CXwZ9GTCxQfoaBle1Y3q7rx6jEIXzIAYUr6iPL2KDitv+FibE6k6RVw6nWtlaHss
	sOVsxbYZ40CLIC0Lag/ykPexVQ6Nudu+RICDqHotOhtHWUKHTCg2ZEDJkSsS4gtF
	vaOiZlovRO/pBEUwEhZB/kFYW6Oj/1UnrVCK3xrC50c+w4dCtyfOLyWsA5LNKCoT
	rySdgpTZ+0ceakchtQ2ZiJJDzVMD3KXmCImjonpbbqv7e1O+1fWifjS8AKNNMZJe
	4g/9+/0rFIw/rN3mkjc8A==
X-ME-Sender: <xms:K00oajkRORc133r7PC1IBlKXMDjSqvW9vIjnqG_QZbkAQOYotfILsQ>
    <xme:K00oahpf4FLWEUbd6wOCxg3-u_RCJdbNqACdOD7aR8p36lWn3JPMHHQ58CWH_FVHo
    3LLoLJvohH3MaOvvmfK4gvIdMgmqZ-vDA4y1Xzq4zN0vAr9xnYTw98d>
X-ME-Proxy-Cause: dmFkZTFbWbIVgk3oNIIQ+G+AHYlJwWdcELEDDoIiIUBvnYRJd3CsISE3I/JOVyG2d0IybM
    lj5uQrrQaowMUeTn4kKKsnFzToChT0pwu6ZWOuYIZaTZFJK7mNfbD1w3DbZcQCw8ITSvLG
    oY/9k9GxCUV7/ZlAa32DEFwc1lP/VEBX786Dt0GHxWvqfvPEnbcxdzQC2RraHKCXyD0c+G
    QBNYH0rV6FloMMOiwEzsyT/H/C1ZzgFYQZp2hAg7/d8uHURiK6WYeFwyLQ9VyDwHkmVLQM
    IUqgsriFiBf0fPDUN+cEn2U59ltSXiLLd9IK9k8Y2rbCO86LV+C/AQJFGtHozyB6MGfJRL
    Y4HFNmgYr28jA2vrdstJgPu3J/ljJskwYqY8g5qRoXRlodCXtOlo+zfmpAwUfMqUT+0Ksb
    UQzCGN8T164/oXuv+XWsOh3ppLWk3oKF6KnbkCWj1S+hz1UIGg7wt4nauAWLkDncPtNq+r
    5wvHbtEWlfiN2WuDh9tM+gLZUn21C0mdPOqzgjIpMfftaEDOVhs+L4tpETZ9dA0DHSttkd
    DCazvhjFTaGTVDY4dE6gGV4VMGv0h+vktmXOPmvTtan8nVuvQ0e8dF2TVjIgG3nYoj0TRc
    M8dVN9ly4LG6QhDwxgXQJiXin4CiOh/KmiqdBDpGeU7fArNOWRmEEn5rCPJA
X-ME-Proxy: <xmx:LE0oar9BUiQp_qrgSrScH1M3f-UE7OtajjYJ26_u59UFWO3P90M4Ng>
    <xmx:LE0oarrfVWp2ygG18KNq77pu68TRdhCVd9V3fNc8BttVQO9k9YD-3A>
    <xmx:LE0oahiexkHx_MqYM2F7qOj3QDFZgah_DQDHi_-PN5DcK-BK_aswcw>
    <xmx:LE0oahDxlnOWbriQaaU9aOrsncRT_PUU2vxksIAdCgYbPXnFVrOLqw>
    <xmx:LU0oak0sJQRlsXUCBkAWIgEKRUMvsHFR_SYwXJpDwlB9AROrqdxW8eLT>
Feedback-ID: ieb4144f1:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id DC8082CC0083; Tue,  9 Jun 2026 13:28:11 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AtGJywdvvpER
Date: Tue, 09 Jun 2026 13:27:47 -0400
From: "John Ericson" <mail@johnericson.me>
To: "Li Chen" <me@linux.beauty>, "Andy Lutomirski" <luto@kernel.org>
Cc: "Christian Brauner" <brauner@kernel.org>, "Kees Cook" <kees@kernel.org>,
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
Message-Id: <4e049396-377d-48a7-a34c-91318413a876@app.fastmail.com>
In-Reply-To: <19eacd64508.26b92c022125848.262962729296162879@linux.beauty>
References: <20260528095235.2491226-1-me@linux.beauty>
 <20260528-madig-fachrichtung-fehlinformation-61117ba640da@brauner>
 <CALCETrWJQpLR4n1cpichBk8=uExSKLWTMGU3BufGdk_WE_p5UA@mail.gmail.com>
 <19eacd64508.26b92c022125848.262962729296162879@linux.beauty>
Subject: Re: [RFC PATCH v1 00/13] exec: add spawn templates for repeated executable
 startup
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[johnericson.me,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
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
	TAGGED_FROM(0.00)[bounces-6588-lists,linux-api=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,messagingengine.com:dkim,johnericson.me:dkim,johnericson.me:from_mime,app.fastmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3BB086630AD



On Tue, Jun 9, 2026, at 10:43 AM, Li Chen wrote:
> Hi Andy,
>
> ---- On Tue, 09 Jun 2026 08:01:57 +0800  Andy Lutomirski <luto@kernel.org> wrote ---
> > [...]
> >
> > After contemplating this for a bit... why pidfd?  Doesn't a pidfd
> > refer to an actual process that is, or at least was, running?  This
> > new thing is a process that we are contemplating spawning.  I can
> > imagine that basically all pidfd APIs would be a bit confused by the
> > nonexistence of the process in question.
> >
>
> Yes, I think that is a real concern.
>
> In my current local WIP I tried to keep that distinction explicit.
> pidfd_spawn_open() returns a pidfs-backed builder fd, not a normal pidfd
> referring to a process. The builder fd is allocated as an anonymous pidfs
> file with builder-specific file operations:
>
>     file = pidfs_alloc_anon_file("[pidfd_spawn]",
>                                  &pidfd_spawn_builder_fops, builder,
>                                  O_RDWR);
>

What does your builder fd point to, explicitly? For example in my other reply I
talked about how it was "real" process state. In my FreeBSD patch, for example,
I found there was already a status for a process "in exec", and I figured that
was clean to reuse for one of these "embryonic" processes that also hadn't
started running. I would reckon that Linux probably has some similar notions.

> and the normal pidfd helpers still reject it because it does not use the
> ordinary pidfd file operations:
>
>     struct pid *pidfd_pid(const struct file *file)
>     {
>         if (file->f_op != &pidfs_file_operations)
>             return ERR_PTR(-EBADF);
>         return file_inode(file)->i_private;
>     }
>
> So the current split is:
>
>     builder_fd = pidfd_spawn_open(...);       /* builder object */
>     pidfd_config(builder_fd, ...);
>     child_pidfd = pidfd_spawn_run(builder_fd, ...); /* real pidfd */
>
> Only the last fd is a normal pidfd for an actual child process. The builder
> fd is only accepted by the builder operations.
>
> This avoids having to define what waitid(P_PIDFD), pidfd_send_signal(),
> pidfd_getfd(), poll(), etc. mean before the process exists.

I wouldn't be so sure this is necessary/good. For example, I think it could
make sense to wait on a process that has yet to be started; one just waits for
both the process to start and the process to exit. Obviously a blocking syscall
in the thread that is spawning the process is not useful, but the asynchronous
poll variation seems fine.

As long as there is real process state here, it shouldn't be too hard to
implement.

> The downside is that it adds a separate open-style entry point and is less
> uniform than the pidfd_open(0, PIDFD_EMPTY) spelling Christian sketched.

I do think there is no point having two file descriptors. The file descriptor
that previously referred to the builder/embryonic process then can refer to the
real process, right?

> If people think there is a better way to represent the pre-spawn builder
> state, or if the preference is to integrate it directly into pidfd_open()
> with an explicit empty/future-pidfd state, I would be happy to discuss that.

Hope the above answers your question? I suppose my ideas lean more on the
"future" than "empty" side --- there is indeed a thread in the thread group,
with real VM/namespace/file descriptor etc. state. Moreover, state gets
initialized before the process is started, so the actual start is a pretty
lightweight step of just letting the scheduler know the now-ready process can
be scheduled. The only thing that distinguishes the embryonic process from a
real one is simply that it isn't running --- i.e. isn't (yet) available to be
scheduled --- so the pidfds holders are free to poke at its state.

Cheers,

John

