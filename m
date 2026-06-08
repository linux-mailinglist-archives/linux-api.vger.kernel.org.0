Return-Path: <linux-api+bounces-6584-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xobVHwtLJ2rjuQIAu9opvQ
	(envelope-from <linux-api+bounces-6584-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Tue, 09 Jun 2026 01:06:51 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D691365B208
	for <lists+linux-api@lfdr.de>; Tue, 09 Jun 2026 01:06:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=johnericson.me header.s=fm3 header.b=LyDNtmsk;
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b="Q EH0pQ/";
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6584-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6584-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=johnericson.me;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BCE963025912
	for <lists+linux-api@lfdr.de>; Mon,  8 Jun 2026 23:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07CC83876A4;
	Mon,  8 Jun 2026 23:06:46 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from flow-b5-smtp.messagingengine.com (flow-b5-smtp.messagingengine.com [202.12.124.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D333590A9;
	Mon,  8 Jun 2026 23:06:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780960005; cv=none; b=m9l0ISEcASAlflaiPMcN0TUu3DXa0DMwa0CQaLwVmcq5l5spjuKXIXO1HpYQPftIMGsDLjlbMHSC7ymhJ6Nw2zZl4pMe+0kMX/466bQWlScrs1leRkQRq08IuUchVPyyQCNNnIqYVP2uCiUTgpfpmt5Y4FEftVrsmQSLFJFWUts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780960005; c=relaxed/simple;
	bh=yBxrBI7scw/rrUgNj3qsgsUg5GImppSy4hShJYxsOKQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=TtD0/NSQErSncdJ7jXVBwIA9ZGjQyjyx7O3F5sL5IEl5Z1VVEt+u3g8Fy9tvzFLDhak6J3byxR//819hm9QSE+bPT/zh5JhWVbx02hE/GdhtleEBJ34nd/OfF377JjhzNkJWjBQZD2xjNwET+seFDzJuwsBRehDCIDPUUZ2RIhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=johnericson.me; spf=pass smtp.mailfrom=johnericson.me; dkim=pass (2048-bit key) header.d=johnericson.me header.i=@johnericson.me header.b=LyDNtmsk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QEH0pQ/1; arc=none smtp.client-ip=202.12.124.140
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.stl.internal (Postfix) with ESMTP id 650A713002F9;
	Mon,  8 Jun 2026 19:06:42 -0400 (EDT)
Received: from phl-imap-16 ([10.202.2.88])
  by phl-compute-05.internal (MEProxy); Mon, 08 Jun 2026 19:06:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=johnericson.me;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1780960002; x=1780967202; bh=rLquViJ1BJjkvxIEZyfcq9Ou395GapTi
	UI7VA10/Tak=; b=LyDNtmskr02dMGaG40+nQ6JSSiYbncUNfAZ7FVM68h5E+rU5
	6gj9GkhfxBr/dUCljddn+TvPjP06W8UWSqL/KrIdHevpe7OoUzstv+NAHiAQuSuH
	Rmlcxn1MWRh1rKHsNSj513XDVYpIFRh0Re+j8Gd31tKv3oe65scLtyudQ2MTw/Xn
	O+Goi/OZ5BqBSc6p1BOo9NmuD5l6gC5S0EuU6OteqAg4Yus84EkiZGb4I2QadPGp
	HVV8mjk3LqfVuDqYHjsjevGbqwE5S+n3n7XjtMHjqk7D78F0NyjwUZcNLkt5rOiN
	U9dygeIwvXxqYWjhBmxwbCfT4uasXv8j6H57/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780960002; x=
	1780967202; bh=rLquViJ1BJjkvxIEZyfcq9Ou395GapTiUI7VA10/Tak=; b=Q
	EH0pQ/1p0KA0IuCeKMJwAeQYFCldYIkufFy4tG8TLmfBLVkT3958nv48qQdWycfL
	/onv8UqieEOg5xTlOiEIOi5L7EQLWx3WRki8i2ccUtoeV77R3M3JCKNZjwZhImL9
	XgnpgzkFNAMzTZBW7TF83maUOgoEUaJ5PfM7S9DDnRDnY9AX+Va12IHF+zjr5sji
	RqTJJCq2DRe/4IwNHi9grz8mCREYTdzmnLGvQUbJ417PziyMR8D2bOlhdu0/FuZ1
	s/0ZTeOcCMezLPbpO7cNbWdIIp9b2l6fXr5ln0ESf0P9A5637Ry8zf/nxBx/r6XD
	chYlzyVVM62jg6hT/BsGA==
X-ME-Sender: <xms:AEsnavbvsfSPeyfeqJgyRkUJsavFNsBIC4G0QI55KxyH6dT2nQpoUA>
    <xme:AEsnapMDsXP61PoopAKWHm-uzmdEh1-tS-k9k5eIr5QjH2gpD4TeuTUFYs1GJJml3
    XEDVPOddJcHPZrw6w-3JIYx90sj0nIevtvf0eHjnZRa4lumnDvpYYdN>
X-ME-Proxy-Cause: dmFkZTG3M8rrZKU4tEtLU06spritGrGuTfKJVQXIx2FU5uZZPOaKLPmrDThQIuvwoWk4jo
    cvonQ2H7LlVykVmZdrTtJG0h1QiQ9kYzy3i8jZV8s9GXNKnXPK/DbS5uTXbqOaPvaJbbUp
    1T/0A5PxUyRHO8mDYHABJQ9Fwc/i5szi3FrdkuHdSIRHMgqxhk9tk3CC1Kx/AvSjRjdLCY
    37nDeR38bJYMU6pS5aSnx43vwDOXd/v3s5NJP42LGAH1YFuRhFyXvo6P+C2bSV6/m5FQri
    oiTF5K4o3uO774TQ/2z3MQAjkpoeqqg2skr7CyEFnPwXcrsquyVX9U2gD9s19OYtJ69Opf
    5bwDYi1R86DaJYRP+VD3bcbUaRU5+AMeNyR6icipOA/1mw+nKkxHviCeEfOJoBMG+29EwR
    QM6EJ+0IkMJEBfVrKocHcA2DcxDrmMAN+2DPrWm3fgcPWw3tayEZi3u2KbWII1C44X4D67
    BbSXAq1AAKHTXBZx4SvNGsg5hP0N3I+yzSnyTPYb39Dxsz1c4bidls/W2YgGZr9yNaMCRp
    OogjDoVNeXBTn1AV3wehnkVDx0fjxkT7gLpGepKUMOdJoSG1G+4sfH4eEV2keVBqtuZq4S
    HUbSHW6yA8Qgl2bmCdbSn1pkq/0g21wvpo7Lun6zfD570fb3FbxQLT/dTi9g
X-ME-Proxy: <xmx:AEsnalw2GkBVKFH4dsOqHwhO7VtRJcwqDr8mYqhH8oYxdlMGQn_YvQ>
    <xmx:AEsnapMU-or6IQ93qWEL17HeQbxw_yx3UTIWbn5bH80TMmvtRSADsg>
    <xmx:AEsnan0UOJWU84HjrdOEVb3nNdNh3byuSVYmcgg19InzZW_z-x6OIg>
    <xmx:AEsnahEYYaYlWhyiRNsDk2-V_UweIdAp2FczeeI1qinIwZMlgoLPhQ>
    <xmx:AksnappV2XjMPgA6aR4BMh__jA1M9d-2rARIx37CuQ1d9WTX-C8NTsHm>
Feedback-ID: ieb4144f1:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id CF5942CC0083; Mon,  8 Jun 2026 19:06:40 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AtGJywdvvpER
Date: Mon, 08 Jun 2026 19:06:20 -0400
From: "John Ericson" <mail@johnericson.me>
To: "Li Chen" <me@linux.beauty>, "Christian Brauner" <brauner@kernel.org>
Cc: "Kees Cook" <kees@kernel.org>, "Al Viro" <viro@zeniv.linux.org.uk>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 linux-api <linux-api@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 linux-mm <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>,
 linux-doc <linux-doc@vger.kernel.org>,
 linux-kselftest <linux-kselftest@vger.kernel.org>, x86 <x86@kernel.org>,
 "Arnd Bergmann" <arnd@arndb.de>, "Andy Lutomirski" <luto@kernel.org>,
 "Thomas Gleixner" <tglx@kernel.org>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, "Jan Kara" <jack@suse.cz>,
 "Jonathan Corbet" <corbet@lwn.net>, "Shuah Khan" <skhan@linuxfoundation.org>
Message-Id: <ce71d6df-6851-4e4b-9603-1d55d8d522b8@app.fastmail.com>
In-Reply-To: <19e8113d290.893abab26142069.5024234139508454104@linux.beauty>
References: <20260528095235.2491226-1-me@linux.beauty>
 <20260528-madig-fachrichtung-fehlinformation-61117ba640da@brauner>
 <19e8113d290.893abab26142069.5024234139508454104@linux.beauty>
Subject: Re: [RFC PATCH v1 00/13] exec: add spawn templates for repeated executable
 startup
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[johnericson.me,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
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
	FORGED_RECIPIENTS(0.00)[m:me@linux.beauty,m:brauner@kernel.org,m:kees@kernel.org,m:viro@zeniv.linux.org.uk,m:linux-fsdevel@vger.kernel.org,m:linux-api@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:linux-arch@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:x86@kernel.org,m:arnd@arndb.de,m:luto@kernel.org,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:hpa@zytor.com,m:jack@suse.cz,m:corbet@lwn.net,m:skhan@linuxfoundation.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[mail@johnericson.me,linux-api@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-6584-lists,linux-api=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	DBL_BLOCKED_OPENRESOLVER(0.00)[raw.githubusercontent.com:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,messagingengine.com:dkim,johnericson.me:dkim,johnericson.me:from_mime,app.fastmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D691365B208

Hi all,

I am happy to see this thread appear. I emailed Christian and others ~5 years
ago about this in this thread[1]; it would be great to see it finally happen!

I very much agree that the new process spawning should be pidfd based. I also
want to emphasize that the crux of the matter is that code needed to set up the
initial unscheduled process --- which I do think should be "real state" and
more than a mere template --- is currently chopped up between clone and exec.
So the real meat of the implementation would be factoring out a bunch of stuff
so it can be reused in both the legacy clone+exec and modern code paths.

I'll say a bit more about this "real state" vs "mere template" distinction,
which is that the latter is effectively some sort of ad-hoc operation batching
language, and always runs the risk of falling behind what the kernel actually
supports. The "real state" approach, where we have honest-to-goodness process
state, just in some partially initialized fashion and thus it's not yet
scheduled, always supports everything the kernel supports in principle.

Yes, alternative syscalls that specify which "embryonic" process (as opposed to
always the current active process) need to be created, but that is less bad
than trying to stuff things into flags etc. for a single existing system call,
and also one can imagine a world (as described in
https://catern.com/rsys21.pdf) where the exact "which process?" parameter
starts getting added to new process modifying machinery by *default*, with a
sentinel value analogous to `AT_FDCWD` used to mean "the current process" for
the legacy used-between-fork-and-exec usecase.

---

Anyways, years ago, after taking a glance at the relevant code in Linux and
FreeBSD, I figured that it would be easier for me personally to first implement
this functionality in FreeBSD, and then, once I had a feel for some of the
refactoring, take a stab at it in Linux. This is because Linux's feature set,
especially things like `binfmt_misc`, makes its clone and exec quite a bit more
complex, and thus the (IMO) necessary heavy refactoring quite a bit more
extensive too.

I never got around to it in the 5 years, but these days, with LLMs, doing an
"exploratory refactor" (to get a sketch of a patch that is fodder for discussion
not yet fit for actual submission) is much easier. So inspired by this thread, I
took a few hours to do the exploratory FreeBSD refactor in [2]. The man page for
the new syscalls, [3], might be a good place to start reading. (This, being from
a FreeBSD patch, describes the change in terms of "proc fds", but the switch to
Linux's "pidfds" should be self-explanatory. The former after all inspired the
latter.)

Hope discussion of such a patch isn't too off topic here, but there is an
interesting thing to note that would also apply to a Linux implementation. It
took *more* factored out helper functions than I thought. The current count is
over 15(!) --- there didn't seem to be a way to build both the old and new way
of doing things with fewer, coarser building blocks. Now, granted, maybe
someone more familiar with either kernel than me could do a better job, but I
think it will still be a number of functions. This indicates just how much
untangling there is to do. And the number will surely be much higher for Linux.

[1]: https://lore.kernel.org/all/f8457e20-c3cc-6e56-96a4-3090d7da0cb6@JohnEricson.me/

[2]: https://github.com/obsidiansystems/freebsd-src/commit/better-proc-spawn
     239dcdefe6ad244e58d998155b527375e5293ff7 for posterity

[3]: https://raw.githubusercontent.com/obsidiansystems/freebsd-src/refs/heads/better-proc-spawn/lib/libsys/proc_new.2


On Sun, May 31, 2026, at 10:47 PM, Li Chen wrote:
> Hi Christian,
>
> Thanks a lot for your great review!
>
> ---- On Thu, 28 May 2026 19:02:53 +0800  Christian Brauner <brauner@kernel.org> wrote ---
> > On Thu, May 28, 2026 at 05:52:21PM +0800, Li Chen wrote:
> > > Hi,
> > >
> > > This is an early RFC for an idea that is probably still rough in both the
> > > UAPI and implementation details. Sorry for the rough edges; I am sending
> > > it now to check whether this direction is worth pursuing and to get
> > > feedback on the kernel/userspace boundary.
> >
> > The idea of having a builder api for exec isn't all that crazy. But it
> > should simply be built on top of pidfds and thus pidfs itself instead.
> > It has all the basic infrastructure in place already.
>
> Yes, that makes a lot more sense. I was staring too hard at the "hot
> executable" part and made the cache/template the API, which was probably
> the wrong thing to expose. Sorry about that.
>
> > Any implementation
> > should also allow userspace to implement posix_spawn() on top of it.
>
> That's so cool, and this is a really useful point. I had not thought about this as
> something that could sit under posix_spawn(), but that makes the target
> much clearer. It should be a generic exec/spawn builder first, and the
> agent use case should just be one user of it.
>
> > fd = pidfd_open(0, PIDFD_EMPTY /* or better name */)
> >
> > pidfd_config(fd, ...) // modeled similar to fsconfig()
>
> Reusing pidfd_open() with an empty target is nice because it keeps the API close
> to pidfds, but I wonder if a separate entry point such as
> pidfd_spawn_open() or pidfd_create() would make the "new process
> builder" case a bit more explicit? Either way, the configuration side
> being fsconfig-like makes sense to me.

Yeah check out my syscalls [3] on that front. It's important to design the
workflow / state machine in a good way. Performance/efficiency, security (share
less state/privileges by default!), and extensibility (where will newer
concepts, like a new type of namespace, fit in?) are all competing concerns,
but I think they mostly pull in the same direction. (Only no ambient authority,
back compat, and extensibility exist in some tension.)

> Thanks again for pointing me in this direction. It helps a lot.
>
> Regards,
> Li

Glad you are sold on pidfds, and more broadly, best of luck! You'll be a hero
to everyone else that has wanted this over the years :)

John

