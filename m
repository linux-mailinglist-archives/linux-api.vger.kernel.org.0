Return-Path: <linux-api+bounces-7-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7A17E4F3E
	for <lists+linux-api@lfdr.de>; Wed,  8 Nov 2023 03:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32375281433
	for <lists+linux-api@lfdr.de>; Wed,  8 Nov 2023 02:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E457ECB;
	Wed,  8 Nov 2023 02:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="BkG4zlNO"
X-Original-To: linux-api@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA09DED4
	for <linux-api@vger.kernel.org>; Wed,  8 Nov 2023 02:58:25 +0000 (UTC)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2979312D
	for <linux-api@vger.kernel.org>; Tue,  7 Nov 2023 18:58:25 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-778999c5ecfso412226585a.2
        for <linux-api@vger.kernel.org>; Tue, 07 Nov 2023 18:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1699412304; x=1700017104; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nzWNvEllLOWjoieBIl2eE6QMomxBf/8hz+/afBXKkOM=;
        b=BkG4zlNOe3dcnPJl63CCIj8LfPp3BOObHbuKDqblU1ZkP8hUf0HZ1/MtZ7wz16iwD3
         BQKZNtBj7B+tTyarMlj+XXP4gtx1vfya1ulFtbvbk7NfyJ4B+tncXfLj1lvaSgJRt+3P
         tMpu9wMww9kzk9mBb1DKFqRuDWSpMdUbAAJry1k1i08FbuyvpsVw9PbXNex4qOfFMbuK
         uNypEmpVrerySWiaqj1E2HssadRmlpcfZ2Z1M10gdxpZMQvinPckqW4UdVy0Kvbb9HTi
         qvVsHTX0wQQj7iAkZNi5Do7gBd5uo1aNglnXokLS/jyHuKDpRTF720VIuE0Z+W0cdPJH
         Iy5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699412304; x=1700017104;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nzWNvEllLOWjoieBIl2eE6QMomxBf/8hz+/afBXKkOM=;
        b=ZAJJLA+KurCu7Y2i+/nDOaOI6L4sCvpH5JzJhw4n1yAPuk/gB425nn93eNElez8Ts+
         wES7xTl12JXkYrol8RIeS4rdntkubHYIwTInCsX8Qy4OUSNJr6i8oU/dvFrhvPJA8JMe
         1XKQNEGfCh1pFk4AvoioRrNQM4EMD92HkPf8E7PAi1g7vmMtq+H8pc76rFAyxs9PDasS
         SFEFyMNEyDPKndAAUpQux2RDyKFWBLrRZEV6hXOugl20698OE0Uzwahi9lC8lUqOC4tB
         zyU6C9MF/2i0TKyYJYtcywAzFANtGrDGto3m+IEyd+M4a97KjOWSI5mzKuzhrMGe1qRt
         Bn9Q==
X-Gm-Message-State: AOJu0YzCCqncLIWeHosN2k4EzW6/7H0duZr3v4BEv3uKjccSLEb0KqBG
	xGXSWYzy57Em/MOemSWDpUeRIYKKipvamkz/oQ==
X-Google-Smtp-Source: AGHT+IEKdmc2nsSq+Is+TUp8xhak7RVs7LNnJraNn4pxrM3/s0fMxmipRfQfJN5klC8msfrNiHUbNw==
X-Received: by 2002:a05:620a:4591:b0:773:a9f7:eaf1 with SMTP id bp17-20020a05620a459100b00773a9f7eaf1mr528210qkb.21.1699412304264;
        Tue, 07 Nov 2023 18:58:24 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id r12-20020a05620a298c00b0077407e3d68asm559832qkp.111.2023.11.07.18.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 18:58:23 -0800 (PST)
Date: Tue, 07 Nov 2023 21:58:23 -0500
Message-ID: <b25f34cd259322582cd1b927a9e50235.paul@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, linux-man@vger.kernel.org, linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>, Ian Kent <raven@themaw.net>, David Howells <dhowells@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <christian@brauner.io>, Amir Goldstein <amir73il@gmail.com>, Matthew House <mattlloydhouse@gmail.com>, Florian Weimer <fweimer@redhat.com>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 5/6] add listmount(2) syscall
References: <20231025140205.3586473-6-mszeredi@redhat.com>
In-Reply-To: <20231025140205.3586473-6-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>

On Oct 25, 2023 Miklos Szeredi <mszeredi@redhat.com> wrote:
> 
> Add way to query the children of a particular mount.  This is a more
> flexible way to iterate the mount tree than having to parse the complete
> /proc/self/mountinfo.
> 
> Allow listing either
> 
>  - immediate child mounts only, or
> 
>  - recursively all descendant mounts (depth first).
> 
> Lookup the mount by the new 64bit mount ID.  If a mount needs to be queried
> based on path, then statx(2) can be used to first query the mount ID
> belonging to the path.
> 
> Return an array of new (64bit) mount ID's.  Without privileges only mounts
> are listed which are reachable from the task's root.
> 
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> Reviewed-by: Ian Kent <raven@themaw.net>
> ---
>  fs/namespace.c             | 93 ++++++++++++++++++++++++++++++++++++++
>  include/linux/syscalls.h   |  3 ++
>  include/uapi/linux/mount.h |  9 ++++
>  3 files changed, 105 insertions(+)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index a980c250a3a6..0afe2344bba6 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -4958,6 +4958,99 @@ SYSCALL_DEFINE4(statmount, const struct __mount_arg __user *, req,
>  	return ret;
>  }
>  
> +static struct mount *listmnt_first(struct mount *root)
> +{
> +	return list_first_entry_or_null(&root->mnt_mounts, struct mount, mnt_child);
> +}
> +
> +static struct mount *listmnt_next(struct mount *curr, struct mount *root, bool recurse)
> +{
> +	if (recurse)
> +		return next_mnt(curr, root);
> +	if (!list_is_head(curr->mnt_child.next, &root->mnt_mounts))
> +		return list_next_entry(curr, mnt_child);
> +	return NULL;
> +}
> +
> +static long do_listmount(struct vfsmount *mnt, u64 __user *buf, size_t bufsize,
> +			 const struct path *root, unsigned int flags)
> +{
> +	struct mount *r, *m = real_mount(mnt);
> +	struct path rootmnt = {
> +		.mnt = root->mnt,
> +		.dentry = root->mnt->mnt_root
> +	};
> +	long ctr = 0;
> +	bool reachable_only = true;
> +	bool recurse = flags & LISTMOUNT_RECURSIVE;
> +	int err;
> +
> +	err = security_sb_statfs(mnt->mnt_root);
> +	if (err)
> +		return err;
> +
> +	if (flags & LISTMOUNT_UNREACHABLE) {
> +		if (!capable(CAP_SYS_ADMIN))
> +			return -EPERM;
> +		reachable_only = false;
> +	}

Similar to my comment in patch 4/6, please move the LSM call after the
capability check.

> +	if (reachable_only && !is_path_reachable(m, mnt->mnt_root, &rootmnt))
> +		return capable(CAP_SYS_ADMIN) ? 0 : -EPERM;
> +
> +	for (r = listmnt_first(m); r; r = listmnt_next(r, m, recurse)) {
> +		if (reachable_only &&
> +		    !is_path_reachable(r, r->mnt.mnt_root, root))
> +			continue;
> +
> +		if (ctr >= bufsize)
> +			return -EOVERFLOW;
> +		if (put_user(r->mnt_id_unique, buf + ctr))
> +			return -EFAULT;
> +		ctr++;
> +		if (ctr < 0)
> +			return -ERANGE;
> +	}
> +	return ctr;
> +}

--
paul-moore.com

