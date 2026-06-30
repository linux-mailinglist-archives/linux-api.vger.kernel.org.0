Return-Path: <linux-api+bounces-6733-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Aqi8IkJtQ2r/YAoAu9opvQ
	(envelope-from <linux-api+bounces-6733-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Tue, 30 Jun 2026 09:16:18 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AAF66E1058
	for <lists+linux-api@lfdr.de>; Tue, 30 Jun 2026 09:16:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=lF6Bhj9O;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6733-lists+linux-api=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-api+bounces-6733-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 42F553021EA3
	for <lists+linux-api@lfdr.de>; Tue, 30 Jun 2026 07:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC6C3D330C;
	Tue, 30 Jun 2026 07:14:38 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5D53D1CCF;
	Tue, 30 Jun 2026 07:14:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782803678; cv=none; b=HVfPvK2P1CqQmWqC9pG3kfT95Pb5hq7TSs8AVnwru3hcKug+8FC4OSZ+bQR7CNA+pil/KacQnOOnldsLDAWx/EbiO9AuGRZtVTVPaA7FyOVa8J+aTavh/MgwqvfZ4MgYf2C0oFvbNDaN5u5jzGK7duIuqFdezomArtaiPl9N8/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782803678; c=relaxed/simple;
	bh=VICWaE9WUXW2LWdO5r9lbkxHnC+JwXq4KpepnM7pCA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QkJXs8BC9pvEm3+f77B9V7EvylyQh9161F8W/HW6QQuuCBFoYe9gaOG1SHwcq6zBHReOq9kNEk1YmidGEof+6vhuKBzMq7X3ykgZU8XxhsTOH7pxDeqsUtFXQj8EQofqqNtK0bdMZzwjDFBLKmumHMOEr/hgi3rXOlJKB5cws0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lF6Bhj9O; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAE601F00A3A;
	Tue, 30 Jun 2026 07:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782803677;
	bh=+QSVg6eV+J0zaLkGpTTo7MZ6WXU0ihg0UHJ87/LB+6w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lF6Bhj9OoogKud4iTtoRksj3SG8/hInr72NpOxv+PftPWGHJV4EyNPyxPsqL7ND/T
	 HPxN3DCwTGHq+fQubufrypHawzwGcB3ChEl6hr8v+CNSILbRcCHoGoNHOkcQuuloko
	 OhuMoeWIy23ruLd/DRjYuxPubIpK4OvaVWx7qzPh2ndE8B9L2q5pUqWSMpWzrHn+By
	 Uj3NVRJjqGt+fY1aoLJRe9EYTho5ZESjxfkVBNGRFaSm8oNFQOQTQzmKJ6OnXYTk05
	 R9KMYRv0T8qLJRR0Q0meWmz0yOZ2eudt4x3nCrzXpfOpqkGl0BD+1RdHQAciG5MVB7
	 pB5lWonGYgsdQ==
Date: Tue, 30 Jun 2026 09:14:30 +0200
From: Christian Brauner <brauner@kernel.org>
To: John Ericson <mail@johnericson.me>
Cc: Li Chen <me@linux.beauty>, Cong Wang <cwang@multikernel.io>, 
	linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-api <linux-api@vger.kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.cz>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Kees Cook <kees@kernel.org>, 
	Sergei Zimmerman <sergei@zimmerman.foo>, Farid Zakaria <farid.m.zakaria@gmail.com>
Subject: Re: [RFC] Null Namespaces
Message-ID: <20260630-kippen-jobaussicht-restriktionen-2149cc663b22@brauner>
References: <a49ce818-f38d-41b0-bbf7-80b8aad998b1@app.fastmail.com>
 <20260629-hauer-erhitzen-sobald-96d3dff68707@brauner>
 <eb390c52-eeb3-44b3-88e9-e65c52a26c05@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <eb390c52-eeb3-44b3-88e9-e65c52a26c05@app.fastmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_ALL(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-6733-lists,linux-api=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:mail@johnericson.me,m:me@linux.beauty,m:cwang@multikernel.io,m:linux-arch@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-api@vger.kernel.org,m:arnd@arndb.de,m:luto@kernel.org,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:hpa@zytor.com,m:jack@suse.cz,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:viro@zeniv.linux.org.uk,m:kees@kernel.org,m:sergei@zimmerman.foo,m:farid.m.zakaria@gmail.com,m:faridmzakaria@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[brauner@kernel.org,linux-api@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-api@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux.beauty,multikernel.io,vger.kernel.org,arndb.de,kernel.org,redhat.com,alien8.de,linux.intel.com,zytor.com,suse.cz,lwn.net,linuxfoundation.org,zeniv.linux.org.uk,zimmerman.foo,gmail.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,brauner:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8AAF66E1058

On Mon, Jun 29, 2026 at 10:50:38PM -0400, John Ericson wrote:
> On Mon, Jun 29, 2026, at 7:45 AM, Christian Brauner wrote:
> > But I guess the even simpler model would be to copy what I've been doing
> > for pidfs:
> >
> > [...]
> >
> > we then add fchroot() (overdue anyway) and then teach both fchdir() and
> > fchroot() to honor FD_NULLFS_ROOT. Then a process may shed its fs state
> > and move itself into nullfs. Restrict *chdir() and *chroot() for said
> > process via seccomp and it's locked in forever as well.
> 
> This looks good! It delivers most of what I want, and I do want to be
> very clear that while I am responding to your comments on my patch
> below, I would still be very pleased if we just did this, much more than
> I am pleased with the status quo.
> 
> (And also, yes, good to create the long-overdue fchroot regardless of
> what we do here.)
> 
> > Nothing here requires you to NULL anything and I oppose this on code
> > sanity reasons alone. We shoud absolutely not start to stash any NULL
> > pointers in core kernel objects such as struct path that are used
> > everywhere.
> 
> Before we do the "pidfd style" nullfs route, I want to make one thing
> clear about my patch: I was *not* trying to relax the invariant across
> the board that (live) `struct path` should only contain non-null
> pointers. Rather, I just want `struct fs_struct` to contain ("morally")
> `Option<struct path>`. My use of the null pointer was merely me doing
> the sort of ragged union packing that, for example, Rust does. I think
> as a matter of A_B_I (emphasis on "binary"), this is fine, and not
> going to cause Armageddon --- `struct path` is widely used, but `struct
> fs_struct` is (as far as I can tell) not.
> 
> All that said, as a matter of A_P_I (emphasis on "program"), I do see
> your point that it's too easy for someone to not read my comment, and
> then `struct path` with null pointers starts leaking all over the place,
> making a big mess. I think a simple enough fix is to just use another C
> encoding, such as a union, for `Option<struct path>`.
> 
> For example:
> 
>     union optional_path {
>         struct {
>             void *p0, *p1; /* must be null */
>         } __randomize_layout null_path;
>         struct path path; /* both fields must be non-null */
>     };
> 
> To continue saving space, or --- if relying on the overlap of
> `null_path` and `path.mnt` is too sketchy --- making a bona fide tagged
> union:
> 
>     struct optional_path {
>         enum {
>             OPTIONAL_PATH_ABSENT,
>             OPTIONAL_PATH_PRESENT,
>         } tag;
>         union {
>             struct {} null_path;
>             struct path path;
>         };
>     };

I think Al is about to have a stroke reading this... and I might too.
I agree with the sentiment I disagree with the details of this and
touching the whole kernel for this. You know what the easy solution is:
don't allow a struct path to be empty...

