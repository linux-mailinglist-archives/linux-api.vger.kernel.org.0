Return-Path: <linux-api+bounces-6207-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +COkEgeI72mtCQEAu9opvQ
	(envelope-from <linux-api+bounces-6207-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 27 Apr 2026 18:00:07 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EEEEE475D1A
	for <lists+linux-api@lfdr.de>; Mon, 27 Apr 2026 18:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AA94D303016A
	for <lists+linux-api@lfdr.de>; Mon, 27 Apr 2026 15:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CBE534D929;
	Mon, 27 Apr 2026 15:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KJBPu98D"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EFF34BA57;
	Mon, 27 Apr 2026 15:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777304932; cv=none; b=UhgXi7+tOQ9fQEZQiQXPxO1tAmP2+XJjUAeQQfgk/pZgIyjaou6U1Sbaf1vpMaFZebjlIiG2XOTdH6AdkPqgDF/ECcw+Bzfnwj+VF0WSVzlnM1mAyTP+3m+Ki/eQCXu02OcUfz+vVnM2JkaVSG/tF7n00FcNan7+ST1vO2zXlaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777304932; c=relaxed/simple;
	bh=UTSVnEPoVhkyJqqLs0uNoy7WozGaK1Jdj0W4TxA8xGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nafTn1XtjSsS/E0mjGWSL8Vl1g2b5lKC0XaNrv0NOOb/CV+jTkzgNYD8Hj+p8OVbRqn06WGVv03K27h5zMqZrNlAY5nRqGWCINOjO541C0ZGTnvlemd9tfFK8oxgmNhRx5aO+nbetYXEufxKfrwqBuPXgs/YofBhptJId90f2NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KJBPu98D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA8A7C2BCB5;
	Mon, 27 Apr 2026 15:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777304932;
	bh=UTSVnEPoVhkyJqqLs0uNoy7WozGaK1Jdj0W4TxA8xGU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KJBPu98DrSbmu3tm1OTrTuqMzisaF1UMZIYwCo1mOE+CZFYSU14BuKjI/h0iWdJ/h
	 +xc90rBefAlfxownyZ7ukfx2wTrxLFVODyl1PQGGdWDGF5JMJ2prwn15gw0eSF/aKY
	 VaB1cJXhIxeD5mXHZbvGpf2iOrij2VlGa/hoxXq+0S7vVCO5MuoKYh5S0e6iTd2RZf
	 GZGng0Wv1Q81H33mBCnR0fP1nDswmCUDROI7ocGYZWweYFIyJK3bVw+p5gUFykx8Ws
	 zMPoivE2AVTl8b+uIEQzZLk4PPgjeJYZ5816sf2hyoVnj8kKrEs2/KT6qY2nNYkSGq
	 c2w43OVBs4QqA==
Date: Mon, 27 Apr 2026 17:48:43 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jori Koolstra <jkoolstra@xs4all.nl>, Jeff Layton <jlayton@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Arnd Bergmann <arnd@arndb.de>, "H . Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.cz>, 
	Peter Zijlstra <peterz@infradead.org>, Andrey Albershteyn <aalbersh@redhat.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Aleksa Sarai <cyphar@cyphar.com>, cmirabil@redhat.com, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/2] vfs: syscalls: add mkdirat2() that returns an
 O_DIRECTORY fd
Message-ID: <20260427-umlegen-aufbau-ee3a97f1528a@brauner>
References: <20260412135434.3095416-1-jkoolstra@xs4all.nl>
 <20260412135434.3095416-2-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260412135434.3095416-2-jkoolstra@xs4all.nl>
X-Rspamd-Queue-Id: EEEEE475D1A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[xs4all.nl,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6207-lists,linux-api=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-api];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[xs4all.nl:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

On Sun, Apr 12, 2026 at 03:54:33PM +0200, Jori Koolstra wrote:
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
> but difficult to get right. Hence, mkdirat2() that creates a directory
> and returns an O_DIRECTORY fd is useful.
> 
> This feature idea (and description) is taken from the UAPI group:
> https://github.com/uapi-group/kernel-features?tab=readme-ov-file#race-free-creation-and-opening-of-non-file-inodes
> 
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> ---
>  arch/x86/entry/syscalls/syscall_64.tbl |  1 +
>  fs/internal.h                          |  2 ++
>  fs/namei.c                             | 44 +++++++++++++++++++++++---
>  include/linux/syscalls.h               |  2 ++
>  include/uapi/asm-generic/unistd.h      |  5 ++-
>  scripts/syscall.tbl                    |  1 +
>  6 files changed, 50 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
> index 524155d655da..e200ca2067a4 100644
> --- a/arch/x86/entry/syscalls/syscall_64.tbl
> +++ b/arch/x86/entry/syscalls/syscall_64.tbl
> @@ -396,6 +396,7 @@
>  469	common	file_setattr		sys_file_setattr
>  470	common	listns			sys_listns
>  471	common	rseq_slice_yield	sys_rseq_slice_yield
> +472	common	mkdirat2		sys_mkdirat2
>  
>  #
>  # Due to a historical design error, certain syscalls are numbered differently
> diff --git a/fs/internal.h b/fs/internal.h
> index cbc384a1aa09..c6a79afadacf 100644
> --- a/fs/internal.h
> +++ b/fs/internal.h
> @@ -59,6 +59,8 @@ int may_linkat(struct mnt_idmap *idmap, const struct path *link);
>  int filename_renameat2(int olddfd, struct filename *oldname, int newdfd,
>  		 struct filename *newname, unsigned int flags);
>  int filename_mkdirat(int dfd, struct filename *name, umode_t mode);
> +struct file *do_file_mkdirat(int dfd, struct filename *name, umode_t mode,
> +		unsigned int flags, bool open);
>  int filename_mknodat(int dfd, struct filename *name, umode_t mode, unsigned int dev);
>  int filename_symlinkat(struct filename *from, int newdfd, struct filename *to);
>  int filename_linkat(int olddfd, struct filename *old, int newdfd,
> diff --git a/fs/namei.c b/fs/namei.c
> index a880454a6415..6451e96dc225 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -5255,18 +5255,36 @@ struct dentry *vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
>  }
>  EXPORT_SYMBOL(vfs_mkdir);
>  
> -int filename_mkdirat(int dfd, struct filename *name, umode_t mode)
> +static int mkdirat_lookup_flags(unsigned int flags)
> +{
> +	int lookup_flags = LOOKUP_DIRECTORY;
> +
> +	if (!(flags & AT_SYMLINK_NOFOLLOW))
> +		lookup_flags |= LOOKUP_FOLLOW;
> +	if (!(flags & AT_NO_AUTOMOUNT))
> +		lookup_flags |= LOOKUP_AUTOMOUNT;
> +
> +	return lookup_flags;
> +}
> +
> +int filename_mkdirat(int dfd, struct filename *name, umode_t mode) {
> +	return PTR_ERR_OR_ZERO(do_file_mkdirat(dfd, name, mode, 0, false));
> +}
> +
> +struct file *do_file_mkdirat(int dfd, struct filename *name, umode_t mode,
> +		unsigned int flags, bool open)
>  {
>  	struct dentry *dentry;
>  	struct path path;
>  	int error;
> -	unsigned int lookup_flags = LOOKUP_DIRECTORY;
> +	struct file *filp = NULL;
> +	unsigned int lookup_flags = mkdirat_lookup_flags(flags);
>  	struct delegated_inode delegated_inode = { };
>  
>  retry:
>  	dentry = filename_create(dfd, name, &path, lookup_flags);
>  	if (IS_ERR(dentry))
> -		return PTR_ERR(dentry);
> +		return ERR_CAST(dentry);
>  
>  	error = security_path_mkdir(&path, dentry,
>  			mode_strip_umask(path.dentry->d_inode, mode));
> @@ -5276,6 +5294,10 @@ int filename_mkdirat(int dfd, struct filename *name, umode_t mode)
>  		if (IS_ERR(dentry))
>  			error = PTR_ERR(dentry);
>  	}
> +	if (open && !error && !is_delegated(&delegated_inode)) {
> +		const struct path new_path = { .mnt = path.mnt, .dentry = dentry };
> +		filp = dentry_open(&new_path, O_DIRECTORY, current_cred());
> +	}

So definitely a patchset worthing doing but this will be hairy. And
Mateusz is right. As written this doesn't work. The canonical pattern
how e.g., dentry_open() does it is to preallocate the file.

I do wonder though whether we shouldn't just make O_CREAT | O_DIRECTORY
work. I remember that I had a vague comment about this in [1] a few
years ago (cf. [1]). It might even be less hairy to get that one right
as all the thinking for O_CREAT is already there.

What was the rationale for mkdirat2() instead of threading this through
openat()/openat2() with O_CREAT?

And side-question: @Jeff, can nfs atomic open deal with O_CREAT |
O_DIRECTORY?

[1]: 43b450632676 ("open: return EINVAL for O_DIRECTORY | O_CREAT")

