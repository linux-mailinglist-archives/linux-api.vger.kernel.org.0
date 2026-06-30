Return-Path: <linux-api+bounces-6731-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0+O8LRkwQ2pRUAoAu9opvQ
	(envelope-from <linux-api+bounces-6731-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Tue, 30 Jun 2026 04:55:21 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1C76DFED0
	for <lists+linux-api@lfdr.de>; Tue, 30 Jun 2026 04:55:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=johnericson.me header.s=fm3 header.b=j0ojmboj;
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b="Q xBzsQk";
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6731-lists+linux-api=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-api+bounces-6731-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=johnericson.me;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 238FF3036E6E
	for <lists+linux-api@lfdr.de>; Tue, 30 Jun 2026 02:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDAC3C3451;
	Tue, 30 Jun 2026 02:52:09 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from flow-b3-smtp.messagingengine.com (flow-b3-smtp.messagingengine.com [202.12.124.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67008248F64;
	Tue, 30 Jun 2026 02:52:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782787929; cv=none; b=DrLe6nmFtwWQbwcUiJKDAYMIaClmst5Ufwf2TCdvV7XQp5vQVjKeMg5N3c7ixd8fr/vtXjE9gmeva2sG17pGYu1ahkeUBIc8U0tudMFTA0sZZDNZ9hVtNFs5hjB8grwINnkkw76Xj1fckpxu16rIYvO5VgHM/Mg1C6gyLwic2WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782787929; c=relaxed/simple;
	bh=hTs0/hVA1FBxLDWAiGpAUUaeU4TRbbhvTyH0rQv4IEw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Roav7v4RmzSICcXKEETakUqEa3OlDR0+Ov7zIpTILw0/A1ljX4luxicnbw25hV19N5uhDvaB5/QRL96WeSqO3E9TjUxxRmJcDwFs1pslw10YmeCmvYAKbBgwZsIyHzBIROl0uXtC88MI/RB5CIAHhv2IE1MEIXKENO9NQCxHIgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=johnericson.me; spf=pass smtp.mailfrom=johnericson.me; dkim=pass (2048-bit key) header.d=johnericson.me header.i=@johnericson.me header.b=j0ojmboj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QxBzsQkM; arc=none smtp.client-ip=202.12.124.138
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.stl.internal (Postfix) with ESMTP id BA7971300086;
	Mon, 29 Jun 2026 22:52:05 -0400 (EDT)
Received: from phl-imap-16 ([10.202.2.88])
  by phl-compute-05.internal (MEProxy); Mon, 29 Jun 2026 22:52:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=johnericson.me;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1782787925; x=1782795125; bh=fHtPYj1Vq9217cMqxqbh4CUFXsI6QZsW
	dmN+9WGCzkE=; b=j0ojmboj1Jz65r79PKN9kopAdp8W3GlQo7NL28aCMlDYVsfE
	XC3wbGsNoJLoa8r0fU4A71QNk5P58t22cH3oMD3hk89H2b3AC1i+qtXESw39IoR5
	cryQqO9GMuz80qzTZxzLEWi/WomWSObWXAZocKKgKRAh8YrEZ2/WWzySUZbvjjQl
	2JkvOVp83hJOETd8Nr43tGy7M/ysNdpM1L/SrgBs8JRU6CJJ8C1GvU9OGefJW3dJ
	yfk8cmMRZ79D91qMWEj1SbuS45JVpn/q6HQuIo0vR6KBKcyCPn0NC+PyKtQX7mXB
	1mML+qqpqOfAn/wKDhLygRmOW3f2vbGwR7L+xw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782787925; x=
	1782795125; bh=fHtPYj1Vq9217cMqxqbh4CUFXsI6QZsWdmN+9WGCzkE=; b=Q
	xBzsQkMSlAfpPzQYTDfwUXWG//FZLkJV9Ssm/pddcbbyqNRHpVzEgdgTcPAlYJIX
	+mPy2VafNqwJiKNi3Js0EJ6qhCThzaaFqbtrQ9mJ2GryGGbZe5aMEanF2torVwN3
	DBFG3+VdGQ4MHFNEucRkW/SQlOq9P8bjHzT+I96atw4Etvf4s6faD8uW0J/YhuDH
	I6Qdwip2d8RHL8aQPL4BxX6033Dc87E3FMyz7oGH0oPcbFfQ0O5e4KvuJRJQJU9g
	Ueoj8oCB+dO0x12y7Rb1KJnu0HSrFfZ8VU7LDkszF0RAnqWRzw+qNNsTrNxrKpZA
	12uuVH3blfS+6oT7cY5fw==
X-ME-Sender: <xms:Uy9DagrsIXHLUchxjo3ZDIGftPw1GSZ-T3Psf4N4wr16B6iRcsaMQw>
    <xme:Uy9DahdQScYfMTFpPfOrmazF9JCsGEiNSVVcM1A-krZPPo4THrKRWxCEMxO9xhXPf
    iRAKlxuNg32AO5itWqEj-aF5Nq_nULPEAzMnHE4vXZkJQt6VkN3>
X-ME-Proxy-Cause: dmFkZTGh88Ny/NSP614TAUmt/Zu/ZyAQDQd3Kc0pxhXkE8DlAE1bg21crdAJgMzKXpWkSQ
    60lHHXkrA6+QRDSsthPUVsekdZKAdo8oMRIL1ljoLTzB4ORvStWc4S1s6le07c/R/ZBfpN
    PliZs+7NViV0ygxfKhs/tFXshhTVIYH86XdGJ5PXcP7JaX5sfciqoA33Bl0qXud0oWQvUQ
    gDeFIMDaXYdyIEkujGxfozpXPiRtANOLMiKtBccjeQiFmouB7U0BZfcg6haduu0zs3meyw
    2FAiK69ZliqABxlwiNkQ9lhvbvdjykoP0nSUQfx9CZ93L+8mTbE/3w2xsJqsasQFD2hhc7
    zlYRtsEFhS3NjG8TaXqQ5plVFdokW/XyXC3jmdiz+kTbAW8wiQprVafJEymhqgomem1Hae
    wFI4fv4G6aXO3sm/a61sai+RzvOwdc/lrRbClaX4qwU8qXqFEUuUEYJOGW6ZgsksZuNYCq
    6kqn3iRtBNrLMy2/NYwPedhYoJ7u9+Kvkadj13PbQV5FDdVDZ37UZUfGZO6HvxYvpIrQVC
    R0E8q2k6xileMO5gVtqGD4OIal3NwOWfT5iXHMK5CxLTqtJez0AB4s13AR7WRHAkJE6+OP
    KjtzZr5qAHD9PhitI2LW1AmAWhId96sF6SnFBxVjhChqqhbFO0G+xE7+QItA
X-ME-Proxy: <xmx:Uy9DamapRexMJYq8G16bWjGVaAY5uV5pBG-TQnFfwEvlJMRbzILGmg>
    <xmx:Uy9DamkbG-QbwotlxwC0U3gzmotugTxevZOReohbo9b0LikzxYuaLw>
    <xmx:Uy9Dald6rsQvhlhYJDcMsr_8oue3VDgghs0M402a9ssilEhHOovZdQ>
    <xmx:Uy9Dak1IMdBKeJgcIQdhPGQBQoHIB7bVOmRHCtRucUUYKWrcqI3mQQ>
    <xmx:VS9DakSD0yTppRQ4i8oyoQAGhnkwhqOLIkAVWwdW_s_t0O5ecUtJ9gM9>
Feedback-ID: ieb4144f1:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 84B382CC0083; Mon, 29 Jun 2026 22:52:03 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AG8qDlxFSDr7
Date: Mon, 29 Jun 2026 22:50:38 -0400
From: "John Ericson" <mail@johnericson.me>
To: "Christian Brauner" <brauner@kernel.org>
Cc: "Li Chen" <me@linux.beauty>, "Cong Wang" <cwang@multikernel.io>,
 linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 linux-api <linux-api@vger.kernel.org>, "Arnd Bergmann" <arnd@arndb.de>,
 "Andy Lutomirski" <luto@kernel.org>, "Thomas Gleixner" <tglx@kernel.org>,
 "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, "Jan Kara" <jack@suse.cz>,
 "Jonathan Corbet" <corbet@lwn.net>, "Shuah Khan" <skhan@linuxfoundation.org>,
 "Al Viro" <viro@zeniv.linux.org.uk>, "Kees Cook" <kees@kernel.org>,
 "Sergei Zimmerman" <sergei@zimmerman.foo>,
 "Farid Zakaria" <farid.m.zakaria@gmail.com>
Message-Id: <eb390c52-eeb3-44b3-88e9-e65c52a26c05@app.fastmail.com>
In-Reply-To: <20260629-hauer-erhitzen-sobald-96d3dff68707@brauner>
References: <a49ce818-f38d-41b0-bbf7-80b8aad998b1@app.fastmail.com>
 <20260629-hauer-erhitzen-sobald-96d3dff68707@brauner>
Subject: Re: [RFC] Null Namespaces
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[johnericson.me,none];
	R_DKIM_ALLOW(-0.20)[johnericson.me:s=fm3,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-6731-lists,linux-api=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:brauner@kernel.org,m:me@linux.beauty,m:cwang@multikernel.io,m:linux-arch@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-api@vger.kernel.org,m:arnd@arndb.de,m:luto@kernel.org,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:hpa@zytor.com,m:jack@suse.cz,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:viro@zeniv.linux.org.uk,m:kees@kernel.org,m:sergei@zimmerman.foo,m:farid.m.zakaria@gmail.com,m:faridmzakaria@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[mail@johnericson.me,linux-api@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[johnericson.me:+,messagingengine.com:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mail@johnericson.me,linux-api@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux.beauty,multikernel.io,vger.kernel.org,arndb.de,kernel.org,redhat.com,alien8.de,linux.intel.com,zytor.com,suse.cz,lwn.net,linuxfoundation.org,zeniv.linux.org.uk,zimmerman.foo,gmail.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,messagingengine.com:dkim,app.fastmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2B1C76DFED0

On Mon, Jun 29, 2026, at 7:45 AM, Christian Brauner wrote:
> But I guess the even simpler model would be to copy what I've been doing
> for pidfs:
>
> [...]
>
> we then add fchroot() (overdue anyway) and then teach both fchdir() and
> fchroot() to honor FD_NULLFS_ROOT. Then a process may shed its fs state
> and move itself into nullfs. Restrict *chdir() and *chroot() for said
> process via seccomp and it's locked in forever as well.

This looks good! It delivers most of what I want, and I do want to be
very clear that while I am responding to your comments on my patch
below, I would still be very pleased if we just did this, much more than
I am pleased with the status quo.

(And also, yes, good to create the long-overdue fchroot regardless of
what we do here.)

> Nothing here requires you to NULL anything and I oppose this on code
> sanity reasons alone. We shoud absolutely not start to stash any NULL
> pointers in core kernel objects such as struct path that are used
> everywhere.

Before we do the "pidfd style" nullfs route, I want to make one thing
clear about my patch: I was *not* trying to relax the invariant across
the board that (live) `struct path` should only contain non-null
pointers. Rather, I just want `struct fs_struct` to contain ("morally")
`Option<struct path>`. My use of the null pointer was merely me doing
the sort of ragged union packing that, for example, Rust does. I think
as a matter of A_B_I (emphasis on "binary"), this is fine, and not
going to cause Armageddon --- `struct path` is widely used, but `struct
fs_struct` is (as far as I can tell) not.

All that said, as a matter of A_P_I (emphasis on "program"), I do see
your point that it's too easy for someone to not read my comment, and
then `struct path` with null pointers starts leaking all over the place,
making a big mess. I think a simple enough fix is to just use another C
encoding, such as a union, for `Option<struct path>`.

For example:

    union optional_path {
        struct {
            void *p0, *p1; /* must be null */
        } __randomize_layout null_path;
        struct path path; /* both fields must be non-null */
    };

To continue saving space, or --- if relying on the overlap of
`null_path` and `path.mnt` is too sketchy --- making a bona fide tagged
union:

    struct optional_path {
        enum {
            OPTIONAL_PATH_ABSENT,
            OPTIONAL_PATH_PRESENT,
        } tag;
        union {
            struct {} null_path;
            struct path path;
        };
    };

And either way, there can be an inline function:

    const struct path * /* nullable */
    get_optional_path(const struct optional_path * /* non-nullable */);

taking a non-null pointer and returning a nullable pointer to help
consumers of `struct fs_struct` not screw up accessing `root` and `pwd`.

A third option is simply copying the definition of `struct path`, doing:

    /* Just like `struct path`, but instead of both fields always being
     * non-null, both fields can also both be null to indicate an absent
     * path. One field null, the other field non-null is still not
     * permitted, however.
     */
    struct optional_path {
            struct vfsmount *optional_mnt;
            struct dentry *optional_dentry;
    } __randomize_layout;

in which case `get_optional_path` works by value instead of by
reference, because in the `CONFIG_RANDSTRUCT`-case the field order may
not be the same.

Any of these 3 variations would make absolutely clear that the
invariants around `struct path` have not changed, and only `struct
fs_struct` is changed. Furthermore, the API breakage on `fs->pwd` and
`fs->root` will mechanically ensure that all consumers get caught and
fixed (with the fix being to use `get_optional_path` and check for the
null case).

I do like these versions better than my original, because I do agree
making a safer C API is worthwhile. And because of the API breakage
forcing a complete patch as discussed above, I think that if I make a v2
along these lines, the diff will either prove or refute my basic premise
that `pwd` and `root` in `struct fs_struct`, unlike `struct path`, are
not widely used, and so changing their definitions like this (from
`struct path` to `... optional_path`) is lightweight.

Thanks,

John

