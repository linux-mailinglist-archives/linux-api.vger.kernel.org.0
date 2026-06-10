Return-Path: <linux-api+bounces-6592-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rrXTEKsSKWrSPwMAu9opvQ
	(envelope-from <linux-api+bounces-6592-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 10 Jun 2026 09:30:51 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C4C666A68
	for <lists+linux-api@lfdr.de>; Wed, 10 Jun 2026 09:30:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=fgvSiRD0;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6592-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6592-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D62D73020D48
	for <lists+linux-api@lfdr.de>; Wed, 10 Jun 2026 07:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D512338D41E;
	Wed, 10 Jun 2026 07:28:42 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AD9233921;
	Wed, 10 Jun 2026 07:28:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781076522; cv=none; b=M3TGiIwef/3Ifr4Bt7VrMucSnDkBnG8ckcnNSj5OSvgP0+Apxu5ah329zKfhBMBM52v1eWyhVPLYrKzqS+iGHMvOxyoY4hjvRVz28Xi26qw1zbeufHBZlzqLoi4C+dZh05BLZfDjzSwzLz7qRzukWsSPS3nFmaqYBAoHybHj9YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781076522; c=relaxed/simple;
	bh=XVzT4dC9J9FFpWrYJ1jidUjuN9wz2V7gqq0wjB+r38s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LUOSeJBZUSZxnvYfJVR0HYtlj7W4K9l17CB18hf3XuzPRkCegJjsLWSb8QiKvmawcaUNXrlO65syW+kzLYOMyQ1Js6229GRgaQJaMRNdp1e3tCTuY7+WWavbHY5cM7Wz9C72PysN3deF80x9KQHCQtEfSreJY6zceU23sFr46ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fgvSiRD0; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D40D1F00893;
	Wed, 10 Jun 2026 07:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781076521;
	bh=Ujw8//AhBz2ofNEZXVOO0whE9ziRkQU7WuP9Q2n1nw4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fgvSiRD0nlrWeKZ00ARxxj8+SIeSOssxKo/IteKl5SNNXShxIV9RzZYZjW2fJDF4Y
	 BRLJiLnad8I+/cgypVTOTIn/c5oxyEme4EK0poeNVEmG9QKE7i/U92Q7yjVt2JPZoo
	 KKab8o9SdIM2XvpGoVICIQ4XwdgAVtaPGhU54ayQfCnfLlEaW3lPQVBllb9BkmzECO
	 nE7j1CjEqBtnt3cNbOS7Erz0xZkaANJGk+ly24VtiJa0PCDT3qoW/N+IRr4nTvwqZd
	 Z5PKSNrIQl7+mm2qzkxCg4AIGhgZkp5e7n9mKFUe2JXKDXK2WgGk0nXZXZ5u3/BshM
	 PjG2C1OvGIzpg==
Date: Wed, 10 Jun 2026 09:28:32 +0200
From: Christian Brauner <brauner@kernel.org>
To: Andy Lutomirski <luto@kernel.org>
Cc: Li Chen <me@linux.beauty>, Kees Cook <kees@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, x86@kernel.org, 
	Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.cz>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [RFC PATCH v1 00/13] exec: add spawn templates for repeated
 executable startup
Message-ID: <20260610-saufen-zerfallen-uncool-5608105e0d8e@brauner>
References: <20260528095235.2491226-1-me@linux.beauty>
 <20260528-madig-fachrichtung-fehlinformation-61117ba640da@brauner>
 <CALCETrWJQpLR4n1cpichBk8=uExSKLWTMGU3BufGdk_WE_p5UA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALCETrWJQpLR4n1cpichBk8=uExSKLWTMGU3BufGdk_WE_p5UA@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[brauner@kernel.org,linux-api@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_RECIPIENTS(0.00)[m:luto@kernel.org,m:me@linux.beauty,m:kees@kernel.org,m:viro@zeniv.linux.org.uk,m:linux-fsdevel@vger.kernel.org,m:linux-api@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:linux-arch@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:x86@kernel.org,m:arnd@arndb.de,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:hpa@zytor.com,m:jack@suse.cz,m:corbet@lwn.net,m:skhan@linuxfoundation.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-6592-lists,linux-api=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[brauner:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 94C4C666A68

On Mon, Jun 08, 2026 at 05:01:57PM -0700, Andy Lutomirski wrote:
> On Thu, May 28, 2026 at 4:05 AM Christian Brauner <brauner@kernel.org> wrote:
> >
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
> > It has all the basic infrastructure in place already. Any implementation
> > should also allow userspace to implement posix_spawn() on top of it.
> >
> > fd = pidfd_open(0, PIDFD_EMPTY /* or better name */)
> >
> > pidfd_config(fd, ...) // modeled similar to fsconfig()
> >
> 
> After contemplating this for a bit... why pidfd?  Doesn't a pidfd
> refer to an actual process that is, or at least was, running?  This
> new thing is a process that we are contemplating spawning.  I can
> imagine that basically all pidfd APIs would be a bit confused by the
> nonexistence of the process in question.

I don't think that would be a problem because every api just needs to
handle ESRCH. Ignoring that for a second: the mount api has a builder fd
that is later transformed into a pidfd. Which is easily doable here as
well. My point is that all the infrastructure building blocks already
exist in pidfs.

