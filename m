Return-Path: <linux-api+bounces-6769-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6hOIFIU1Rmo9LwsAu9opvQ
	(envelope-from <linux-api+bounces-6769-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 02 Jul 2026 11:55:17 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC7E6F58DB
	for <lists+linux-api@lfdr.de>; Thu, 02 Jul 2026 11:55:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=e1pHYz6M;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6769-lists+linux-api=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-api+bounces-6769-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BFB86308C28A
	for <lists+linux-api@lfdr.de>; Thu,  2 Jul 2026 09:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA1B42A7B8;
	Thu,  2 Jul 2026 09:29:30 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549714266B1;
	Thu,  2 Jul 2026 09:29:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782984570; cv=none; b=ZjxLoMJiyYr1oOGnJmc2Nco32zueRf6s2a0yfdkP9R0N6Uve6zawXxtIFLhfP6yN/35Q0IsBkI7S2kEqgnk4hWKz6gohkzC4wAe8k8G4d2SQpVhU7ItpnYczB3xG9pkYBV5kiQKcU0QMrNs//Fj0p+II4iZuSuL+CJhhcnKBeNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782984570; c=relaxed/simple;
	bh=BW4Hg/WHgx/wqWP0dHNwLEanMvutIGbvuRLcltLhx2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cblM7e7qzixEeAl2HcKmFvr+48m8dpXfVDRUkNg0G63j1TpLM5+H64UkqDAX+z59PbFFeaXjSnDbY+spQyTZb4HNUZAHKYyehXDqwWLzx/Y72Bhoz1rXknstx0VVRrXpHaU9IPSx+DX3M1p6aGQ5bYVLTv3kHW9dTpiCb7I74yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e1pHYz6M; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 451721F000E9;
	Thu,  2 Jul 2026 09:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782984568;
	bh=dXbKba1B/CK8l+IdjdOVTRZMbCjkk+ESMNksJd+Czxo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=e1pHYz6M5wc22UEPY39S7MqKIR92W35h+OZlUX2//BA9xeVm6wvj0cP/u3aO6dTZv
	 TIGdOAH18KZ9CiNo9hwRzrtH4q3kCxAjc+BVpLC/mE79gxFg34GOJLmNNPVHPwuZwn
	 QTUBMCFpPGmCmUPxtbpGeUX01UhCAbMPQD0nBOccht09xoOs5VOphvm+jF7QvULdP3
	 Bl4QTqSqA42sKKvKE4pWXPHR23G7F3Rvp/m/9dsQxmChy3LNDpRsSKfdg1foo4Hx9e
	 7Pk+jESfziUy3hlUU+M4wL3z9Bt/TjFONYY3iLKAYClvwn7AGspasA4SUBxrZu2Hrb
	 29+piCtGSKm+A==
Date: Thu, 2 Jul 2026 11:29:22 +0200
From: Christian Brauner <brauner@kernel.org>
To: Andy Lutomirski <luto@kernel.org>
Cc: John Ericson <mail@johnericson.me>, Li Chen <me@linux.beauty>, 
	Cong Wang <cwang@multikernel.io>, linux-arch <linux-arch@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	linux-api <linux-api@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.cz>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Kees Cook <kees@kernel.org>, 
	Sergei Zimmerman <sergei@zimmerman.foo>, Farid Zakaria <farid.m.zakaria@gmail.com>
Subject: Re: [RFC] Null Namespaces
Message-ID: <20260702-markt-haifisch-kiesgrube-8580a3636064@brauner>
References: <a49ce818-f38d-41b0-bbf7-80b8aad998b1@app.fastmail.com>
 <20260629-hauer-erhitzen-sobald-96d3dff68707@brauner>
 <eb390c52-eeb3-44b3-88e9-e65c52a26c05@app.fastmail.com>
 <20260630-kippen-jobaussicht-restriktionen-2149cc663b22@brauner>
 <372c1f13-e6eb-46e6-8685-3c39da4e9f72@app.fastmail.com>
 <CALCETrV8T3KOWgjZL6wy2j7E+Y6zOjfN1aCDsVH4PadvE+yxSw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALCETrV8T3KOWgjZL6wy2j7E+Y6zOjfN1aCDsVH4PadvE+yxSw@mail.gmail.com>
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
	TAGGED_FROM(0.00)[bounces-6769-lists,linux-api=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:luto@kernel.org,m:mail@johnericson.me,m:me@linux.beauty,m:cwang@multikernel.io,m:linux-arch@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-api@vger.kernel.org,m:arnd@arndb.de,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:hpa@zytor.com,m:jack@suse.cz,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:viro@zeniv.linux.org.uk,m:kees@kernel.org,m:sergei@zimmerman.foo,m:farid.m.zakaria@gmail.com,m:faridmzakaria@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[brauner@kernel.org,linux-api@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-api@vger.kernel.org];
	FREEMAIL_CC(0.00)[johnericson.me,linux.beauty,multikernel.io,vger.kernel.org,arndb.de,kernel.org,redhat.com,alien8.de,linux.intel.com,zytor.com,suse.cz,lwn.net,linuxfoundation.org,zeniv.linux.org.uk,zimmerman.foo,gmail.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,brauner:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9FC7E6F58DB

> > > I agree with the sentiment
> >
> > Thanks, I appreciate it :).
> >
> > > You know what the easy solution is: don't allow a struct path to be
> > > empty...
> >
> > Just so we're clear, my quibble here is purely behavioral: the nullfs
> > directory can be opened, right? And that open directory can also be
> > getdents64ed (yielding no entries, since it is empty), right? If I am
> > wrong about these things then sure, no objections from me --- let's ship
> > nullfs FDs right away!
> >
> 
> Christian, how would you feel about a variant of nullfs that fails all
> operations instead of acting as if it were empty?  (I'm far from
> convinced that this would actually be better, but it at least seems
> pretty straightforwardly possible.  And obviously the
> nullfs-at-the-root-of-everything would not want this variant.)

I think it would have to be a separate fs type: failfs. The problem is -
if taken to its logical extreme - it would have to refuse statfs and
fstatfs as well which means you can't discover it. You'd still be able
to get your cwd and root of course via /proc/self/{cwd,root}. So for
that we could just add:

FD_FAILFS_ROOT

I don't have quarrels with that. I can add that and it seems genuinely
useful. I'd again keep it as a kernel-only thing (not mountable) for now
until we have an idea whether the semantics work out...

(Btw, I've done something vaguely similar for kthreads in work to be
merged coming cycle. Their root and pwd are in a _separate_ nullfs that
can't even be overmounted. Which means you can't do arbitrary lookup or
I/O in init's fs state from kthreads anymore without having to use an
explicit scoped_with_init_fs() override with init's fs state
temporarily. Which means that hopefully things like ksmbd will not
happen again...)

