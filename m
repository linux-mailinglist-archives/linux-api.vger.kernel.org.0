Return-Path: <linux-api+bounces-6217-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHXDMInF8GkqYgEAu9opvQ
	(envelope-from <linux-api+bounces-6217-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Tue, 28 Apr 2026 16:34:49 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20996487121
	for <lists+linux-api@lfdr.de>; Tue, 28 Apr 2026 16:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16DBA31D8D82
	for <lists+linux-api@lfdr.de>; Tue, 28 Apr 2026 14:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D723F9F39;
	Tue, 28 Apr 2026 14:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manguebit.org header.i=@manguebit.org header.b="0Y61hjQs"
X-Original-To: linux-api@vger.kernel.org
Received: from mx1.manguebit.org (mx1.manguebit.org [143.255.12.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC10A44B680;
	Tue, 28 Apr 2026 14:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=143.255.12.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777386005; cv=none; b=cqglollJEUP/cnXgZVTeKAoUSzNW1+/xT/5epX8zAV1IEi0VRdgGD4/QbgccIYhCvhXItVitDbHVyhw+z9Hj5CCqnmoY/hKucPDYgZZQiA1vjrb0KF4ZQKj4YD+y3srwkn0R7aQ6aw9LWHAJxY/pXBTkuS6ukLMtmDGuVt5qzgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777386005; c=relaxed/simple;
	bh=SrEd0BRQfbGqvIciEiYaXwu8ftPz9sbLbRRLn9whx1k=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Date:
	 MIME-Version:Content-Type; b=lCZ9UIvlTilAnbbzSXm6rCqeuLkd/0uX4AUPHsJOlYikS9rT7anv5Udw6K+0OJ+7JKa1ORuZE6P0Yx2Egs0qWq4xV/yNCzG3PtRSDC/LTXxFgJsw/zDWKmmBOsb1khE7MhAxBtTGIAGDZvYASFYsM/EtdyrNh8c7zLyRU8Akd7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.org; spf=pass smtp.mailfrom=manguebit.org; dkim=pass (2048-bit key) header.d=manguebit.org header.i=@manguebit.org header.b=0Y61hjQs; arc=none smtp.client-ip=143.255.12.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manguebit.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=manguebit.org; s=dkim; h=Content-Type:MIME-Version:Date:References:
	In-Reply-To:Subject:Cc:To:From:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wTKkt0JG2TSDuyJt59M5h4HPfYQ2FVZq0uwIo2DWt1s=; b=0Y61hjQsORq1k5ML5LJLAbm3gu
	D+IAU6K3oEOnYC7cF5wsYh2LuxVFWhqDtf9ICqWD6JLri86thfp/K2B4Em24DfXfImLBDmeKNAULS
	FIzUmxePrVWHIIpwFmzIkQjd2YEHdoQq4TRAB+MfsxDn5xFL9dqt6asq/hnQqYIPaRT27tR2P5wM2
	8hwkICykOZgGE5AyxSoY9R1pahX7Bj/b/9xEI+ju1SEqKmu9G9QcenpX+xadO+JWUNiPR29cizTfH
	+CYQsLWrqUWytwTKXf4rpI0b9fiHo0Dza05MJTidfBgbAPBxvbJH60GQILMTtnNDJP5Yyp6GZIF1p
	/dq6UUyg==;
Received: from pc by mx1.manguebit.org with local (Exim 4.99.1)
	id 1wHj0e-000000003AB-37qd;
	Tue, 28 Apr 2026 11:01:56 -0300
Message-ID: <1ace01b0fe22a13795cdb045dce6429b@manguebit.org>
From: Paulo Alcantara <pc@manguebit.org>
To: Stefan Metzmacher <metze@samba.org>, Christian Brauner
 <brauner@kernel.org>, Jori Koolstra <jkoolstra@xs4all.nl>, Jeff Layton
 <jlayton@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave
 Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, Alexander Viro
 <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, "H . Peter
 Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.cz>, Peter Zijlstra
 <peterz@infradead.org>, Andrey Albershteyn <aalbersh@redhat.com>, Masami
 Hiramatsu <mhiramat@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Thomas
 =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, Mathieu
 Desnoyers
 <mathieu.desnoyers@efficios.com>, Aleksa Sarai <cyphar@cyphar.com>,
 cmirabil@redhat.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-api@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/2] vfs: syscalls: add mkdirat2() that returns
 an O_DIRECTORY fd
In-Reply-To: <b97874a9-9fef-4f7c-8505-cc23e4b45355@samba.org>
References: <20260412135434.3095416-1-jkoolstra@xs4all.nl>
 <20260412135434.3095416-2-jkoolstra@xs4all.nl>
 <20260427-umlegen-aufbau-ee3a97f1528a@brauner>
 <b97874a9-9fef-4f7c-8505-cc23e4b45355@samba.org>
Date: Tue, 28 Apr 2026 11:01:56 -0300
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 20996487121
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[manguebit.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[manguebit.org:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6217-lists,linux-api=lfdr.de];
	FREEMAIL_TO(0.00)[samba.org,kernel.org,xs4all.nl];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[manguebit.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pc@manguebit.org,linux-api@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-api];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[samba.org:email,manguebit.org:dkim,manguebit.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,xs4all.nl:email]

Stefan Metzmacher <metze@samba.org> writes:

> Am 27.04.26 um 17:48 schrieb Christian Brauner:
>> On Sun, Apr 12, 2026 at 03:54:33PM +0200, Jori Koolstra wrote:
>>> Currently there is no way to race-freely create and open a directory.
>>> For regular files we have open(O_CREAT) for creating a new file inode,
>>> and returning a pinning fd to it. The lack of such functionality for
>>> directories means that when populating a directory tree there's always
>>> a race involved: the inodes first need to be created, and then opened
>>> to adjust their permissions/ownership/labels/timestamps/acls/xattrs/...,
>>> but in the time window between the creation and the opening they might
>>> be replaced by something else.
>>>
>>> Addressing this race without proper APIs is possible (by immediately
>>> fstat()ing what was opened, to verify that it has the right inode type),
>>> but difficult to get right. Hence, mkdirat2() that creates a directory
>>> and returns an O_DIRECTORY fd is useful.
>>>
>>> This feature idea (and description) is taken from the UAPI group:
>>> https://github.com/uapi-group/kernel-features?tab=readme-ov-file#race-free-creation-and-opening-of-non-file-inodes
>>>
>>> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
>>> ---
>>>   arch/x86/entry/syscalls/syscall_64.tbl |  1 +
>>>   fs/internal.h                          |  2 ++
>>>   fs/namei.c                             | 44 +++++++++++++++++++++++---
>>>   include/linux/syscalls.h               |  2 ++
>>>   include/uapi/asm-generic/unistd.h      |  5 ++-
>>>   scripts/syscall.tbl                    |  1 +
>>>   6 files changed, 50 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
>>> index 524155d655da..e200ca2067a4 100644
>>> --- a/arch/x86/entry/syscalls/syscall_64.tbl
>>> +++ b/arch/x86/entry/syscalls/syscall_64.tbl
>>> @@ -396,6 +396,7 @@
>>>   469	common	file_setattr		sys_file_setattr
>>>   470	common	listns			sys_listns
>>>   471	common	rseq_slice_yield	sys_rseq_slice_yield
>>> +472	common	mkdirat2		sys_mkdirat2
>>>   
>>>   #
>>>   # Due to a historical design error, certain syscalls are numbered differently
>>> diff --git a/fs/internal.h b/fs/internal.h
>>> index cbc384a1aa09..c6a79afadacf 100644
>>> --- a/fs/internal.h
>>> +++ b/fs/internal.h
>>> @@ -59,6 +59,8 @@ int may_linkat(struct mnt_idmap *idmap, const struct path *link);
>>>   int filename_renameat2(int olddfd, struct filename *oldname, int newdfd,
>>>   		 struct filename *newname, unsigned int flags);
>>>   int filename_mkdirat(int dfd, struct filename *name, umode_t mode);
>>> +struct file *do_file_mkdirat(int dfd, struct filename *name, umode_t mode,
>>> +		unsigned int flags, bool open);
>>>   int filename_mknodat(int dfd, struct filename *name, umode_t mode, unsigned int dev);
>>>   int filename_symlinkat(struct filename *from, int newdfd, struct filename *to);
>>>   int filename_linkat(int olddfd, struct filename *old, int newdfd,
>>> diff --git a/fs/namei.c b/fs/namei.c
>>> index a880454a6415..6451e96dc225 100644
>>> --- a/fs/namei.c
>>> +++ b/fs/namei.c
>>> @@ -5255,18 +5255,36 @@ struct dentry *vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
>>>   }
>>>   EXPORT_SYMBOL(vfs_mkdir);
>>>   
>>> -int filename_mkdirat(int dfd, struct filename *name, umode_t mode)
>>> +static int mkdirat_lookup_flags(unsigned int flags)
>>> +{
>>> +	int lookup_flags = LOOKUP_DIRECTORY;
>>> +
>>> +	if (!(flags & AT_SYMLINK_NOFOLLOW))
>>> +		lookup_flags |= LOOKUP_FOLLOW;
>>> +	if (!(flags & AT_NO_AUTOMOUNT))
>>> +		lookup_flags |= LOOKUP_AUTOMOUNT;
>>> +
>>> +	return lookup_flags;
>>> +}
>>> +
>>> +int filename_mkdirat(int dfd, struct filename *name, umode_t mode) {
>>> +	return PTR_ERR_OR_ZERO(do_file_mkdirat(dfd, name, mode, 0, false));
>>> +}
>>> +
>>> +struct file *do_file_mkdirat(int dfd, struct filename *name, umode_t mode,
>>> +		unsigned int flags, bool open)
>>>   {
>>>   	struct dentry *dentry;
>>>   	struct path path;
>>>   	int error;
>>> -	unsigned int lookup_flags = LOOKUP_DIRECTORY;
>>> +	struct file *filp = NULL;
>>> +	unsigned int lookup_flags = mkdirat_lookup_flags(flags);
>>>   	struct delegated_inode delegated_inode = { };
>>>   
>>>   retry:
>>>   	dentry = filename_create(dfd, name, &path, lookup_flags);
>>>   	if (IS_ERR(dentry))
>>> -		return PTR_ERR(dentry);
>>> +		return ERR_CAST(dentry);
>>>   
>>>   	error = security_path_mkdir(&path, dentry,
>>>   			mode_strip_umask(path.dentry->d_inode, mode));
>>> @@ -5276,6 +5294,10 @@ int filename_mkdirat(int dfd, struct filename *name, umode_t mode)
>>>   		if (IS_ERR(dentry))
>>>   			error = PTR_ERR(dentry);
>>>   	}
>>> +	if (open && !error && !is_delegated(&delegated_inode)) {
>>> +		const struct path new_path = { .mnt = path.mnt, .dentry = dentry };
>>> +		filp = dentry_open(&new_path, O_DIRECTORY, current_cred());
>>> +	}
>> 
>> So definitely a patchset worthing doing but this will be hairy. And
>> Mateusz is right. As written this doesn't work. The canonical pattern
>> how e.g., dentry_open() does it is to preallocate the file.
>> 
>> I do wonder though whether we shouldn't just make O_CREAT | O_DIRECTORY
>> work. I remember that I had a vague comment about this in [1] a few
>> years ago (cf. [1]). It might even be less hairy to get that one right
>> as all the thinking for O_CREAT is already there.
>> 
>> What was the rationale for mkdirat2() instead of threading this through
>> openat()/openat2() with O_CREAT?
>> 
>> And side-question: @Jeff, can nfs atomic open deal with O_CREAT |
>> O_DIRECTORY?
>
> If it helps the SMB2/3 protocol only has a single SMB2 Create operation
> that uses FILE_CREATE+FILE_NON_DIRECTORY_FILE or FILE_CREATE+FILE_DIRECTORY_FILE.

Yes.  However cifs.ko will handle atomic open of regular files only.

IIRC, NFS also doesn't handle atomic opens of directories either.  Jeff
could confirm that.

