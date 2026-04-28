Return-Path: <linux-api+bounces-6215-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCpNJBnC8GloYQEAu9opvQ
	(envelope-from <linux-api+bounces-6215-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Tue, 28 Apr 2026 16:20:09 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06341486CCE
	for <lists+linux-api@lfdr.de>; Tue, 28 Apr 2026 16:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0C0013066BC8
	for <lists+linux-api@lfdr.de>; Tue, 28 Apr 2026 13:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01CA43E4B5;
	Tue, 28 Apr 2026 13:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="1AP2b7xa"
X-Original-To: linux-api@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C5443E9DC;
	Tue, 28 Apr 2026 13:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777383582; cv=none; b=UOLfRiKXK55uy0s+NzYrOOLSgUpMMEX3mnEkmJZAA0m16EIrkuqtMSnzXd/C4wDqcULG/7UcrWHgCL0J5LJJKrSn2RTXQu1fYwQkx2nHznV3MPIWc2oVXGpqiApsg2gXgX7x4un45c4eA9DBWTXSkTM+qHZ7SqNBRvh99j44pxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777383582; c=relaxed/simple;
	bh=hDU4MUttEW0KnaBnd6LnHoXpOyYwAYDMSJIVtmGnHQw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hy1N+p4wyT/OoQOZBbDdnXjKsMMRPwQcpRVePJ9wIHJwFyrcgjqND5jU9OiYfEBpy5FTFkExY0kgRChJ6JriOutLFYKPqj0idiunl3FXQso8+eBpci/7q14aeueItWBNcpdKgExHH0X2YYXLwjrS60PwOSHCEBCH/1P8uzJJpzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=1AP2b7xa; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=From:Cc:To:Date:Message-ID;
	bh=0W7zglKDGqVRDVGfglSXHf2K1q0kLDe+N944NUpFjqc=; b=1AP2b7xa7UQxNPrsH4I1yXjjL+
	+jV4ZLG+WTy61CmOx1RtkDmFJyMnV2Eqv2Tv92xgEVYTFU6iBzZioPi8EZ8B4d7a3jxB38v2xuoUg
	KTXqoNApDciL99qi2A+eWMmc196c53fwbEk2lEKlO/3/Vdf9rI0NtVO65B2TYffe38Z9iBsYrVIzq
	o5ipCwd1usxu+Tco47qOWyjInQr5ncSvZJOK4AdMRQqFqU1M0s10ZRkcApOtsCZEFG6mvEXNyxBVm
	qsszHaD3szmXz/qA+c5LUVfQgTIk9me2js68eDEqv4p3a5OWBrHGSVi5ZYg9jWYJFYcAE9fp7Afv3
	4oAkPmABy7QzPYJwIMD37GaCKk/G5EhHwGZjdbEKo2vXckleKht6co4AAeedVvpIkuIE+r4MK+zXP
	qHQWL8T7SfPVS7oLTTuWkj7knxbB9AK5RFg29j8WFtR83yGrSbhm1H7JisC+OI5PFSMEfGQdKAHZB
	9BDZHSqbjvxfFGC7tkhOft5R;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1wHies-00000004jms-0tbT;
	Tue, 28 Apr 2026 13:39:26 +0000
Message-ID: <b97874a9-9fef-4f7c-8505-cc23e4b45355@samba.org>
Date: Tue, 28 Apr 2026 15:39:24 +0200
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/2] vfs: syscalls: add mkdirat2() that returns an
 O_DIRECTORY fd
To: Christian Brauner <brauner@kernel.org>,
 Jori Koolstra <jkoolstra@xs4all.nl>, Jeff Layton <jlayton@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
 "H . Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.cz>,
 Peter Zijlstra <peterz@infradead.org>,
 Andrey Albershteyn <aalbersh@redhat.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Aleksa Sarai <cyphar@cyphar.com>, cmirabil@redhat.com,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-api@vger.kernel.org, linux-arch@vger.kernel.org
References: <20260412135434.3095416-1-jkoolstra@xs4all.nl>
 <20260412135434.3095416-2-jkoolstra@xs4all.nl>
 <20260427-umlegen-aufbau-ee3a97f1528a@brauner>
Content-Language: en-US
From: Stefan Metzmacher <metze@samba.org>
In-Reply-To: <20260427-umlegen-aufbau-ee3a97f1528a@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 06341486CCE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samba.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[samba.org:s=42];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[kernel.org,xs4all.nl];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6215-lists,linux-api=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[metze@samba.org,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[samba.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,xs4all.nl:email,samba.org:dkim,samba.org:mid]

Am 27.04.26 um 17:48 schrieb Christian Brauner:
> On Sun, Apr 12, 2026 at 03:54:33PM +0200, Jori Koolstra wrote:
>> Currently there is no way to race-freely create and open a directory.
>> For regular files we have open(O_CREAT) for creating a new file inode,
>> and returning a pinning fd to it. The lack of such functionality for
>> directories means that when populating a directory tree there's always
>> a race involved: the inodes first need to be created, and then opened
>> to adjust their permissions/ownership/labels/timestamps/acls/xattrs/...,
>> but in the time window between the creation and the opening they might
>> be replaced by something else.
>>
>> Addressing this race without proper APIs is possible (by immediately
>> fstat()ing what was opened, to verify that it has the right inode type),
>> but difficult to get right. Hence, mkdirat2() that creates a directory
>> and returns an O_DIRECTORY fd is useful.
>>
>> This feature idea (and description) is taken from the UAPI group:
>> https://github.com/uapi-group/kernel-features?tab=readme-ov-file#race-free-creation-and-opening-of-non-file-inodes
>>
>> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
>> ---
>>   arch/x86/entry/syscalls/syscall_64.tbl |  1 +
>>   fs/internal.h                          |  2 ++
>>   fs/namei.c                             | 44 +++++++++++++++++++++++---
>>   include/linux/syscalls.h               |  2 ++
>>   include/uapi/asm-generic/unistd.h      |  5 ++-
>>   scripts/syscall.tbl                    |  1 +
>>   6 files changed, 50 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
>> index 524155d655da..e200ca2067a4 100644
>> --- a/arch/x86/entry/syscalls/syscall_64.tbl
>> +++ b/arch/x86/entry/syscalls/syscall_64.tbl
>> @@ -396,6 +396,7 @@
>>   469	common	file_setattr		sys_file_setattr
>>   470	common	listns			sys_listns
>>   471	common	rseq_slice_yield	sys_rseq_slice_yield
>> +472	common	mkdirat2		sys_mkdirat2
>>   
>>   #
>>   # Due to a historical design error, certain syscalls are numbered differently
>> diff --git a/fs/internal.h b/fs/internal.h
>> index cbc384a1aa09..c6a79afadacf 100644
>> --- a/fs/internal.h
>> +++ b/fs/internal.h
>> @@ -59,6 +59,8 @@ int may_linkat(struct mnt_idmap *idmap, const struct path *link);
>>   int filename_renameat2(int olddfd, struct filename *oldname, int newdfd,
>>   		 struct filename *newname, unsigned int flags);
>>   int filename_mkdirat(int dfd, struct filename *name, umode_t mode);
>> +struct file *do_file_mkdirat(int dfd, struct filename *name, umode_t mode,
>> +		unsigned int flags, bool open);
>>   int filename_mknodat(int dfd, struct filename *name, umode_t mode, unsigned int dev);
>>   int filename_symlinkat(struct filename *from, int newdfd, struct filename *to);
>>   int filename_linkat(int olddfd, struct filename *old, int newdfd,
>> diff --git a/fs/namei.c b/fs/namei.c
>> index a880454a6415..6451e96dc225 100644
>> --- a/fs/namei.c
>> +++ b/fs/namei.c
>> @@ -5255,18 +5255,36 @@ struct dentry *vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
>>   }
>>   EXPORT_SYMBOL(vfs_mkdir);
>>   
>> -int filename_mkdirat(int dfd, struct filename *name, umode_t mode)
>> +static int mkdirat_lookup_flags(unsigned int flags)
>> +{
>> +	int lookup_flags = LOOKUP_DIRECTORY;
>> +
>> +	if (!(flags & AT_SYMLINK_NOFOLLOW))
>> +		lookup_flags |= LOOKUP_FOLLOW;
>> +	if (!(flags & AT_NO_AUTOMOUNT))
>> +		lookup_flags |= LOOKUP_AUTOMOUNT;
>> +
>> +	return lookup_flags;
>> +}
>> +
>> +int filename_mkdirat(int dfd, struct filename *name, umode_t mode) {
>> +	return PTR_ERR_OR_ZERO(do_file_mkdirat(dfd, name, mode, 0, false));
>> +}
>> +
>> +struct file *do_file_mkdirat(int dfd, struct filename *name, umode_t mode,
>> +		unsigned int flags, bool open)
>>   {
>>   	struct dentry *dentry;
>>   	struct path path;
>>   	int error;
>> -	unsigned int lookup_flags = LOOKUP_DIRECTORY;
>> +	struct file *filp = NULL;
>> +	unsigned int lookup_flags = mkdirat_lookup_flags(flags);
>>   	struct delegated_inode delegated_inode = { };
>>   
>>   retry:
>>   	dentry = filename_create(dfd, name, &path, lookup_flags);
>>   	if (IS_ERR(dentry))
>> -		return PTR_ERR(dentry);
>> +		return ERR_CAST(dentry);
>>   
>>   	error = security_path_mkdir(&path, dentry,
>>   			mode_strip_umask(path.dentry->d_inode, mode));
>> @@ -5276,6 +5294,10 @@ int filename_mkdirat(int dfd, struct filename *name, umode_t mode)
>>   		if (IS_ERR(dentry))
>>   			error = PTR_ERR(dentry);
>>   	}
>> +	if (open && !error && !is_delegated(&delegated_inode)) {
>> +		const struct path new_path = { .mnt = path.mnt, .dentry = dentry };
>> +		filp = dentry_open(&new_path, O_DIRECTORY, current_cred());
>> +	}
> 
> So definitely a patchset worthing doing but this will be hairy. And
> Mateusz is right. As written this doesn't work. The canonical pattern
> how e.g., dentry_open() does it is to preallocate the file.
> 
> I do wonder though whether we shouldn't just make O_CREAT | O_DIRECTORY
> work. I remember that I had a vague comment about this in [1] a few
> years ago (cf. [1]). It might even be less hairy to get that one right
> as all the thinking for O_CREAT is already there.
> 
> What was the rationale for mkdirat2() instead of threading this through
> openat()/openat2() with O_CREAT?
> 
> And side-question: @Jeff, can nfs atomic open deal with O_CREAT |
> O_DIRECTORY?

If it helps the SMB2/3 protocol only has a single SMB2 Create operation
that uses FILE_CREATE+FILE_NON_DIRECTORY_FILE or FILE_CREATE+FILE_DIRECTORY_FILE.

Given all the openat() ignores unknown flags or combinations, maybe this
should be openat2 only and even a new flag (at the for the userspace interface).
or do_sys_open() will reject it for open and openat.

While we're there an O_TMPDIR would also be wonderful to have.
Currently samba works around it by using a hidden directory name, invisible
for SMB clients, but nfs and local users see it.

metze

