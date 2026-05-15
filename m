Return-Path: <linux-api+bounces-6333-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCr0OWImB2oEsQIAu9opvQ
	(envelope-from <linux-api+bounces-6333-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Fri, 15 May 2026 15:57:54 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6186A550DE6
	for <lists+linux-api@lfdr.de>; Fri, 15 May 2026 15:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9889230A6D28
	for <lists+linux-api@lfdr.de>; Fri, 15 May 2026 13:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB238481679;
	Fri, 15 May 2026 13:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cdJQ8sq7"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C812D3A69;
	Fri, 15 May 2026 13:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778852964; cv=none; b=QgY5FEcCxNioqyE0M0s5ui+4m2Ml+GMnIPED7i1ro6lhcr+NXz9ufvmegXR9753k4AEjrivnSwFUKfbvaQoztPQCrWYDCPngPT49pt9g/LE78EeIh6GEMxaSL7hJdqh/19Q/20mj2lxAgIHVKpalOTkErxeaSKBURXSrJMnm51I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778852964; c=relaxed/simple;
	bh=pb3y79JMZ+zLBzi+Ay6epkzmseeGxqZrGGdMhUWxek0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pmTA6K021DJm/ZPZOaNnTj57Wm+28PR3y23OggfhKyDyx5uLaZqCDEtEnbbTAckG3Bgs8PEzpH0W3Vhm0rtuJZNHBXdoqRUtDMQC7KAyMvS2BQW+SI2JEi9+T1xwG0eZmeY6amC13SJ93hdLfqt+v9es7N5w0MXLAhC7q/Bqh6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cdJQ8sq7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CCD1C2BCB0;
	Fri, 15 May 2026 13:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778852964;
	bh=pb3y79JMZ+zLBzi+Ay6epkzmseeGxqZrGGdMhUWxek0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cdJQ8sq787lsZtodQ0VynA8X+LgZLDs4wO321slIiPTss4PW2xhgZTImJCRhanM++
	 4/UcHmSS7/06bT9aExQfbXMvYRk0vxeAU+V8E1lNKURgO8Z0RrNiqTH/3NQA+jRkAf
	 v4pErRIrsQywq9JIjpV1RQR3HQ0JegYVAn3NrUEzPCyo3Fn8ktZa5HeII78BgpNExC
	 zB8fp5frszRl2RO9rU8Fh7FUtfWjq0VjNNnwMpJlTWtY87RH5YpXc7gJpEpCBur2C3
	 a/BtbG4u02GSygAzavAIedgIDlqHVW2OjdqYKN9AdkOPYofFJ2pxiWt+bouLCfmrtw
	 YD9QGgxldmXDg==
Date: Fri, 15 May 2026 15:49:15 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Aleksa Sarai <cyphar@cyphar.com>, Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Arnd Bergmann <arnd@arndb.de>, "H . Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.cz>, 
	Peter Zijlstra <peterz@infradead.org>, Andrey Albershteyn <aalbersh@redhat.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	cmirabil@redhat.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/2] vfs: syscalls: add mkdirat2() that returns an
 O_DIRECTORY fd
Message-ID: <20260515-gezeugt-noten-465fda1e9df9@brauner>
References: <20260412135434.3095416-1-jkoolstra@xs4all.nl>
 <20260412135434.3095416-2-jkoolstra@xs4all.nl>
 <20260427-umlegen-aufbau-ee3a97f1528a@brauner>
 <1600596489.77018.1777916475931@kpc.webmail.kpnmail.nl>
 <20260511-hochdekoriert-neoliberale-f7a2922bc57c@brauner>
 <1805140959.1362290.1778842523425@kpc.webmail.kpnmail.nl>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1805140959.1362290.1778842523425@kpc.webmail.kpnmail.nl>
X-Rspamd-Queue-Id: 6186A550DE6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[xs4all.nl];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6333-lists,linux-api=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-api];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Fri, May 15, 2026 at 12:55:23PM +0200, Jori Koolstra wrote:
> Sorry for the double email, this keyboard is so finicky, I really need to fix it.
> 
> > Op 11-05-2026 14:00 CEST schreef Christian Brauner <brauner@kernel.org>:
> > 
> > mkdirat2() is objectively the worse api. It forces userspace to use a
> > separate system call without any reason whatsoever. If you can to
> > O_CREAT you should also be able to to O_DIRECTORY in the same system
> > call. If we support O_DIRECTORY | O_CREAT we get all the lookup
> > restriction niceties RESOLVE_* for free. Plus, it is supportable both in
> > openat() and openat2() because I made that combo return an errno.
> 
> I don't disagree. I know that some of the UAPI feature requests are not fully
> flashed out, but at least it gives a basis to get the discussion going.
> 
> In fact I already have a O_DIRECTORY | O_CREAT patch that at least passes
> the initial tests. However, I need to sit on it a little bit to think whether
> I am not leaving something out. Also, I understand why vfs_create() wasn't used
> in the O_CREAT path, for instance because you cannot just make use of may_create_dentry()
> there. But now that we are going to string another path through lookup_open() it
> would be great if we could reuse some of the logic from vfs_create() and vfs_mkdir().
> 
> Perhaps we could move may_create_dentry() out of the vfs_* calls and let the caller
> take care of that. Then again, this is the pattern for all those calls. You could also
> just accept some redundancies with may_o_create(), or have something like
> static vfs_mkdir/create_common() functions.
> 
> There are also some minor things. If i_op->mkdir is missing this is an EPERM, but with
> i_op->create it is EACCESS (and suggesting ENOSYS). Should this not be a consistent error

ENOSYS is worse because it would indicate to userspace that the whole
system call they're using isn't available. So we can't ever use that.

This is probably just historical baggage. EACCES is especially wrong
because userspace would expect that particular error code to stem from
an LSM.

In both cases the correct error code would be EOPNOTSUPP and we should
aim to be very consistent in such cases and only reserve this for
missing support for a specific functionality.

I would be very surprised if userspace depended on EACCES being returned
though. So I would say let's try and see whether we can correct this and
return EOPNOTSUPP. The amount of filesystems that have no ->create
should be dwarved by those that do.

> code? I also wonder whether there is a nicer way to handle error being returned from
> vfs_mkdir et al. If I am reading
> 
> 	if (!error) {
> 		dentry = vfs_mkdir(mnt_idmap(path.mnt), path.dentry->d_inode,
> 				   dentry, mode, &delegated_inode);
> 		if (IS_ERR(dentry))
> 			error = PTR_ERR(dentry);
> 	}
> 	end_creating_path(&path, dentry);
> 
> it feels like there is a missing return inside the if (IS_ERR(dentry)) block, and I
> have to go several function deep to see that end_creating_path correctly deals with
> error values being passed instead of a dentry. Then again, probably not worth the
> churn...

Not without it being a major clarity win at least.

> > UAPI design often is a nasty mix of performance (context switches),
> > separation of concerns and privileges, tastefulness, and compromises you
> > never thought or wanted to make.
> > 
> 
> Yes, thanks for suggestion this back at FOSDEM. It is quite fun, and lots
> to learn :)

Thanks for working on this. It's helpful.

