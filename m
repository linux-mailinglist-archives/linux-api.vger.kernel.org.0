Return-Path: <linux-api+bounces-6727-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Se9+MIBdQmog5gkAu9opvQ
	(envelope-from <linux-api+bounces-6727-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 29 Jun 2026 13:56:48 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C486D9B3C
	for <lists+linux-api@lfdr.de>; Mon, 29 Jun 2026 13:56:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ZCFvIaou;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6727-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6727-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E32033035B69
	for <lists+linux-api@lfdr.de>; Mon, 29 Jun 2026 11:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8283F8EDB;
	Mon, 29 Jun 2026 11:45:33 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424263E1D0B;
	Mon, 29 Jun 2026 11:45:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782733533; cv=none; b=F9la2bS9foX4qKodtJAPd/xZTuLGA6OnPbftNog6FoocloHuXrxopROyPFjYtHTiai8AT7ebXlup3t2pCRyv5VHm8ZaCth8uMsrJupdJ4jh02822fpAUewPNGmhWy/dSnlpwlwBEgGy0Pl6BTlucv20Vvm2ezmwcGoYrNx6aVdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782733533; c=relaxed/simple;
	bh=mO6KBVEcVU6weHyHSOPR/eUgWm69nMeEAxQhCBoxhO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XGCAwVo3xM712B1f5yAGGwi4u0w7c/Ptv//7lqcZ6x1qfp0yK3Gkryt4WqQgnAKdEHhanVbRIsqi8f8YK+84jNxuOzYt+ubhOh9cuGS/xq7UUQ+TcjKbQGt2qzc/mkb11B+q5qrDdPkBqPPyQVE8JRTMJhWbicVke6HAYbishYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZCFvIaou; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C0A81F00A3A;
	Mon, 29 Jun 2026 11:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782733532;
	bh=3EDzNCjzRQuh6bcRTPIewp0CJ8CdNnMKQoMPKCrJ1Bs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZCFvIaouUKUttP0YYQr2mIlykz17U2Jlqi9E1koSxGoRLeARD4ke/DxzYQ8I/jJFi
	 A7xNJo67AYDnJtSjuhxH/8cOx8R5Ts4QIgMx6BjfR+z5kipRDosz/YvP3eAVvKHMS7
	 NlDDiSKMvDrA3WxiRJV7Ijf6s/KFhn9wxfoGxlDMU1N7sV44lOIFk04OsDkgXzFrVO
	 vzdEfwjVFkRa8OjYCevbmK7V0AK6PHf0OUL2OhQ12WH2Y8O/cpsNSHzq3tGKUoT9Pq
	 7Q1idLWhdbr9LzEMZyCVFs9lfUvu1ALPKg0tYwafX6ShYOu5J0+eeo3nwAavmC8RiU
	 rIiuSSAllSmIg==
Date: Mon, 29 Jun 2026 13:45:24 +0200
From: Christian Brauner <brauner@kernel.org>
To: John Ericson <mail@johnericson.me>
Cc: Li Chen <me@linux.beauty>, Cong Wang <cwang@multikernel.io>, 
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.cz>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Kees Cook <kees@kernel.org>, 
	Sergei Zimmerman <sergei@zimmerman.foo>, Farid Zakaria <farid.m.zakaria@gmail.com>
Subject: Re: [RFC] Null Namespaces
Message-ID: <20260629-hauer-erhitzen-sobald-96d3dff68707@brauner>
References: <a49ce818-f38d-41b0-bbf7-80b8aad998b1@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a49ce818-f38d-41b0-bbf7-80b8aad998b1@app.fastmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
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
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_RECIPIENTS(0.00)[m:mail@johnericson.me,m:me@linux.beauty,m:cwang@multikernel.io,m:linux-arch@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-api@vger.kernel.org,m:arnd@arndb.de,m:luto@kernel.org,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:hpa@zytor.com,m:jack@suse.cz,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:viro@zeniv.linux.org.uk,m:kees@kernel.org,m:sergei@zimmerman.foo,m:farid.m.zakaria@gmail.com,m:faridmzakaria@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6727-lists,linux-api=lfdr.de];
	FORGED_SENDER(0.00)[brauner@kernel.org,linux-api@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,brauner:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 24C486D9B3C

On Wed, Jun 24, 2026 at 06:51:47PM -0400, John Ericson wrote:
> Hello, I am hoping to discuss an idea I've had for a while, that I am
> calling "null namespaces" that has become more relevant with some recent
> other discussions. First I'll discuss null namespaces in general terms,
> and then I'll link those recent discussions and relate null namespaces
> to them.
> 
> ### Null namespaces
> 
> The essence of null namespaces is trying to give processes as little
> ambient authority as possible, so they are lighter weight and allowed to
> do even less than fully unshared processes today.
> 
> Namespaces as they exist today are frequently described as an isolation
> mechanism, but I think this is the conflation of two different things.
> *Removing* a new process from its parent's namespaces unquestionably is
> increasing isolation --- no disagreement there. But putting the process
> in new namespaces is something else; I would call it supporting
> "delusions of grandeur" of that process. For example, namespaces allow a
> process to do mounts, have `CAP_SYS_ADMIN`, create network interfaces,
> look up other processes by PID, etc.
> 
> Conceptually, to remove a process from one ambient authority scope (the
> very name "namespaces" indicates they are about ambient authority)
> should not require putting it in some ambient authority scope. Just
> because, for example, the process cannot see one mount tree, doesn't
> mean it needs to see another.
> 
> Here's what I am thinking would happen concretely:
> 
> First, the simpler cases:
> 
> #### Null mount namespace
> 
> - requires:
> 
>   - null root file system: absolute paths don't work.
> 
>   - null current working directory: relative paths with traditional,
>     non-`*at` system calls (and `*at` ones using `AT_FDCWD`) don't work.
> 
> - All operations relating to the "ambient" mount tree don't work.
> 
> - `*at` operations with a file descriptor do work.
> 
> - The new fd-based mount APIs with detached mounts do work, modulo
>   the calling process having enough permissions (as usual).

Nothing here requires you to NULL anything and I oppose this on code
sanity reasons alone. We shoud absolutely not start to stash any NULL
pointers in core kernel objects such as struct path that are used
everywhere.

So I've added nullfs a few releases back. It's currently not mountable
from userspace but I've already mentioned in the commit message that
this is going to change. But I also added:

unshare(UNSHARE_EMPTY_MNTNS)
clone3(CLONE_EMPTY_MNTNS)

In both cases the process is placed into a completely empty mount
namespace with nullfs as it's root and cwd. If you're in a new mount
namespace with CAP_SYS_ADMIN thrown away it means you're going to be in
nullfs forever.

It's possible we can come up with:

unshare(UNSHARE_FS_EMPTY)
clone3(CLONE_FS_EMPTY)

which just moves the task into an isolated nullfs instance (it would
need some thinking about interactions with chroot()).

But I guess the even simpler model would be to copy what I've been doing
for pidfs:

+static struct path nullfs_root_path = {};
+
+void nullfs_get_root(struct path *path)
+{
+       *path = nullfs_root_path;
+       path_get(path);
+}
+
 static void __init init_mount_tree(void)
 {
        struct vfsmount *mnt, *nullfs_mnt;
@@ -6209,6 +6217,8 @@ static void __init init_mount_tree(void)
        /* Mount mutable rootfs on top of nullfs. */
        root.mnt                = nullfs_mnt;
        root.dentry             = nullfs_mnt->mnt_root;
+       nullfs_root_path.mnt    = nullfs_mnt;
+       pidfs_root_path.dentry  = nullfs_mnt->mnt_root;

        LOCK_MOUNT_EXACT(mp, &root);
        if (unlikely(IS_ERR(mp.parent)))
diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
index aadfbf6e0cb3..f55c87c70b78 100644
--- a/include/uapi/linux/fcntl.h
+++ b/include/uapi/linux/fcntl.h
@@ -124,6 +124,7 @@ struct delegation {

 #define FD_PIDFS_ROOT                  -10002 /* Root of the pidfs filesystem */
 #define FD_NSFS_ROOT                   -10003 /* Root of the nsfs filesystem */
+#define FD_NULLFS_ROOT                 -10004 /* Root of the nullfs filesystem */
 #define FD_INVALID                     -10009 /* Invalid file descriptor: -10000 - EBADF = -10009 */

 /* Generic flags for the *at(2) family of syscalls. */

we then add fchroot() (overdue anyway) and then teach both fchdir() and
fchroot() to honor FD_NULLFS_ROOT. Then a process may shed its fs state
and move itself into nullfs. Restrict *chdir() and *chroot() for said
process via seccomp and it's locked in forever as well.

