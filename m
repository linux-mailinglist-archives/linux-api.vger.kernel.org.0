Return-Path: <linux-api+bounces-5880-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMVhFXU0oGnyggQAu9opvQ
	(envelope-from <linux-api+bounces-5880-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 26 Feb 2026 12:54:29 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C9F1A563D
	for <lists+linux-api@lfdr.de>; Thu, 26 Feb 2026 12:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B68FF300D173
	for <lists+linux-api@lfdr.de>; Thu, 26 Feb 2026 11:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE08D37AA72;
	Thu, 26 Feb 2026 11:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hAVMQWMa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZDAoyZI8";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qIs99Uwl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2ELRmH1S"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B04364058
	for <linux-api@vger.kernel.org>; Thu, 26 Feb 2026 11:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772106866; cv=none; b=h1zTdr7tQNvE+8YLEcprANii4oJA5hcC+nAgdHDLOykldtq248L/xugOivyf9wRfyef2WJkMToJyQy2bxpo+2RPm1Tfp6ltA8bE/hBs7iLylHHo8GmriKDVn+XhKE2EA5jj5dnvcjKkiQ3O7vosNJmE1hIfFxdJ7Kox1txz+r4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772106866; c=relaxed/simple;
	bh=mkEfYemzIR+QHhtRKvdwkAcl9n+fPDGKeENTRyZ0xek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y8r0IA8TEv9O+Ahb6JM7KME/zh9yXl5G9KqEyUzM+tyzR9jtCHwWiZ0hEkj5RFgizc8gD6bfWZT5tVejo5TztUwtMQ5eXAjT0LUJZwx6wNhsfWpBwGgO1fnjHtXNJmt/Jp0cfaZcDbC3nyyhnvWGS4RI3zV2xCl399vvAqdNNBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hAVMQWMa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZDAoyZI8; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qIs99Uwl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2ELRmH1S; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C24854D21F;
	Thu, 26 Feb 2026 11:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772106864; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X5bBznvZoKbp3YHpDSYOeq/RTIHqXZ4OqLndlPT5A0E=;
	b=hAVMQWMaxU/MN/uMA1vA53yu0R38Td+beuAqGhy4hRZIVgz5VOsN32pL0CMNAUHQ7xUmTI
	6jZmB/yDp3mQOH73R9ksa596ueqwkNLcrUgn7IK3xTkCY383KEEMCgB685W9a/YC1JlNzh
	qxfojwnou2tJCE/JPaFMdZNPFQNyNEw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772106864;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X5bBznvZoKbp3YHpDSYOeq/RTIHqXZ4OqLndlPT5A0E=;
	b=ZDAoyZI8C4hu8IXioAa/i/Zw8xctdqk2OTu39Nw1pKYW7r104iC5Pf4NA1xx7ETmiT+xgx
	AYxjiUU2slpin8DA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=qIs99Uwl;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=2ELRmH1S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772106863; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X5bBznvZoKbp3YHpDSYOeq/RTIHqXZ4OqLndlPT5A0E=;
	b=qIs99UwlRW2BlP+Vwv+l3XflhEh8w1hRizSwIEvxNyaoTcnez1ceoivwAWTPTJbp2jnI+g
	s25bxm/Wiq+M0vGHOngCtufCEANBslFVpOnXWur4yIs0Ks/lr82R62TVbv4K5CbGvc5XZF
	UlQc8oMF3ihXAB3EuYi6zZJ+kvMhMp8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772106863;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X5bBznvZoKbp3YHpDSYOeq/RTIHqXZ4OqLndlPT5A0E=;
	b=2ELRmH1SmgBvGR+QHJVLdwnHOd8iBLL6l9zCBAwkbadswFTGDEkX0rn5S7toG2J2z5w6I8
	/ioR5NNG+fnCOwAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B918A3EA62;
	Thu, 26 Feb 2026 11:54:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sAYkLW80oGmScwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 26 Feb 2026 11:54:23 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7FCFBA0A27; Thu, 26 Feb 2026 12:54:23 +0100 (CET)
Date: Thu, 26 Feb 2026 12:54:23 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Florian Weimer <fweimer@redhat.com>, linux-fsdevel@vger.kernel.org, 
	Jeff Layton <jlayton@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Amir Goldstein <amir73il@gmail.com>, Josef Bacik <josef@toxicpanda.com>, Jan Kara <jack@suse.cz>, 
	Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org, rudi@heitbaum.com
Subject: Re: [PATCH 1/2] mount: add OPEN_TREE_NAMESPACE
Message-ID: <2cy27sadqeldndtkkf47z5bgf6w7yhsg7sp3saz35wu6x65p5b@ul75lea7q4vv>
References: <20251229-work-empty-namespace-v1-0-bfb24c7b061f@kernel.org>
 <20251229-work-empty-namespace-v1-1-bfb24c7b061f@kernel.org>
 <lhuecmaz8p6.fsf@oldenburg.str.redhat.com>
 <20260224-erbitten-kaufleute-6f14e3072c5d@brauner>
 <lhuv7fmxo8y.fsf@oldenburg.str.redhat.com>
 <20260224-kandidat-wohltat-ae8fb7a57738@brauner>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224-kandidat-wohltat-ae8fb7a57738@brauner>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,vger.kernel.org,kernel.org,zeniv.linux.org.uk,gmail.com,toxicpanda.com,suse.cz,cyphar.com,heitbaum.com];
	TAGGED_FROM(0.00)[bounces-5880-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.cz:dkim,suse.com:email,sourceware.org:url];
	DMARC_NA(0.00)[suse.cz];
	DKIM_TRACE(0.00)[suse.cz:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-api@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-api];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B9C9F1A563D
X-Rspamd-Action: no action

On Tue 24-02-26 15:33:13, Christian Brauner wrote:
> On Tue, Feb 24, 2026 at 02:30:37PM +0100, Florian Weimer wrote:
> > * Christian Brauner:
> > 
> > > On Tue, Feb 24, 2026 at 12:23:33PM +0100, Florian Weimer wrote:
> > >> * Christian Brauner:
> > >> 
> > >> > diff --git a/include/uapi/linux/mount.h b/include/uapi/linux/mount.h
> > >> > index 5d3f8c9e3a62..acbc22241c9c 100644
> > >> > --- a/include/uapi/linux/mount.h
> > >> > +++ b/include/uapi/linux/mount.h
> > >> > @@ -61,7 +61,8 @@
> > >> >  /*
> > >> >   * open_tree() flags.
> > >> >   */
> > >> > -#define OPEN_TREE_CLONE		1		/* Clone the target tree and attach the clone */
> > >> > +#define OPEN_TREE_CLONE		(1 << 0)	/* Clone the target tree and attach the clone */
> > >> 
> > >> This change causes pointless -Werror=undef errors in projects that have
> > >> settled on the old definition.
> > >> 
> > >> Reported here:
> > >> 
> > >>   Bug 33921 - Building with Linux-7.0-rc1 errors on OPEN_TREE_CLONE
> > >>   <https://sourceware.org/bugzilla/show_bug.cgi?id=33921>
> > >
> > > Send a patch to change it back, please.
> > > Otherwise it might take a few days until I get around to it.
> > 
> > Rudi, could you post a patch?
> 
> I'm a bit confused though and not super happy that you're basically
> asking us to be so constrained that we aren't even allowed to change 1
> to 1 - just syntactically different.

Agreed, this looks more like a tooling bug than anything else...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

