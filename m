Return-Path: <linux-api+bounces-6770-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qXA7JR03RmqSLwsAu9opvQ
	(envelope-from <linux-api+bounces-6770-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 02 Jul 2026 12:02:05 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9CE6F59A3
	for <lists+linux-api@lfdr.de>; Thu, 02 Jul 2026 12:02:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=R3FyXP42;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6770-lists+linux-api=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-api+bounces-6770-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2340031F6084
	for <lists+linux-api@lfdr.de>; Thu,  2 Jul 2026 09:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD0147CC9B;
	Thu,  2 Jul 2026 09:34:09 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACF73C585B;
	Thu,  2 Jul 2026 09:34:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782984849; cv=none; b=o5PfxQYRjeTxjzq2mINfJ0VK04ogKwFeXJKaLm5794i86Cjn9n/r/s3YHKix1tJq5mnUK5+RE7zrUfObLkad1ObjA/q2u3QUApD8A9YjZ6RhgAbUOEGfcscwyW4UCQzfSRzikRefW9RmFlZ9JeuW94BAWDfSplVC7XZY27oBiCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782984849; c=relaxed/simple;
	bh=OQGQJ9k7AjYDuJr9gGYov76Q+MbkBhbJjTVHEbYsBjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jRaypVCAOLySkMzCkA0FqdlFxUpu+S1rK3QN2voxh1Uxx/YMkT+QFSmK0Gz1B3WehYberFY644dYg4dcbuqGm+MVlKbK2z0L615uRcQRZmkVIw0ovsVyco6mVlvSCieer5vUMrTSQWigDoyu1h6gRG5XdkasCUSSaD32aVagY/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R3FyXP42; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B21C61F00A3A;
	Thu,  2 Jul 2026 09:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782984848;
	bh=I6ljKjFilDZDw8eVEUNLqFNyOGzShy3qTsG1Pdqsu2s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=R3FyXP42pzYYWvmmy6o99v7zM015UzCtT7KGWYJyZEIrp+tnoMOnMURDmzLkXEb1S
	 +4DnOSB6HmieRiwwwEwIV+IhHfLLBVHPeVciwUgxy0bCUHJNL5HRZ+3r0UjtqHDppV
	 8rMCIn41+fouCViD13NAjp4UDO80IJhg7tRuqHiynrdcMAq5Odi96MyYL4VZtRhsN4
	 FOEbU8sGISNsXsx4vGmaMAd0ZDwepDWteOq2P2JfyWYPnV0lFdIU9p93b3dTSI1XdC
	 PZmcF1tfFhpVT5lF4zUu9Q0V63Z9rulVuMcnDlxOWlaxnBDSuCiGZWAN3oPKw++tWx
	 ZP2078bgeg5Nw==
Date: Thu, 2 Jul 2026 11:34:01 +0200
From: Christian Brauner <brauner@kernel.org>
To: Andy Lutomirski <luto@kernel.org>
Cc: John Ericson <mail@johnericson.me>, Li Chen <me@linux.beauty>, 
	Cong Wang <cwang@multikernel.io>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.cz>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Kees Cook <kees@kernel.org>, 
	Sergei Zimmerman <sergei@zimmerman.foo>, Farid Zakaria <farid.m.zakaria@gmail.com>
Subject: Re: [RFC] Null Namespaces
Message-ID: <20260702-entladen-farbkombinationen-klarheit-fe24cb608f23@brauner>
References: <a49ce818-f38d-41b0-bbf7-80b8aad998b1@app.fastmail.com>
 <20260629-hauer-erhitzen-sobald-96d3dff68707@brauner>
 <CALCETrVuh0-biOw=TgYN9ERTFAoiki57XeZ3S2T3dO2+hL54gA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALCETrVuh0-biOw=TgYN9ERTFAoiki57XeZ3S2T3dO2+hL54gA@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_RECIPIENTS(0.00)[m:luto@kernel.org,m:mail@johnericson.me,m:me@linux.beauty,m:cwang@multikernel.io,m:linux-arch@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-api@vger.kernel.org,m:arnd@arndb.de,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:hpa@zytor.com,m:jack@suse.cz,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:viro@zeniv.linux.org.uk,m:kees@kernel.org,m:sergei@zimmerman.foo,m:farid.m.zakaria@gmail.com,m:faridmzakaria@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6770-lists,linux-api=lfdr.de];
	FORGED_SENDER(0.00)[brauner@kernel.org,linux-api@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,brauner:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4D9CE6F59A3

On Mon, Jun 29, 2026 at 02:06:55PM -0700, Andy Lutomirski wrote:
> On Mon, Jun 29, 2026 at 4:45 AM Christian Brauner <brauner@kernel.org> wrote:
> >
> 
> > But I guess the even simpler model would be to copy what I've been doing
> > for pidfs:
> >
> > +static struct path nullfs_root_path = {};
> > +
> > +void nullfs_get_root(struct path *path)
> > +{
> > +       *path = nullfs_root_path;
> > +       path_get(path);
> > +}
> > +
> >  static void __init init_mount_tree(void)
> >  {
> >         struct vfsmount *mnt, *nullfs_mnt;
> > @@ -6209,6 +6217,8 @@ static void __init init_mount_tree(void)
> >         /* Mount mutable rootfs on top of nullfs. */
> >         root.mnt                = nullfs_mnt;
> >         root.dentry             = nullfs_mnt->mnt_root;
> > +       nullfs_root_path.mnt    = nullfs_mnt;
> > +       pidfs_root_path.dentry  = nullfs_mnt->mnt_root;
> >
> >         LOCK_MOUNT_EXACT(mp, &root);
> >         if (unlikely(IS_ERR(mp.parent)))
> > diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
> > index aadfbf6e0cb3..f55c87c70b78 100644
> > --- a/include/uapi/linux/fcntl.h
> > +++ b/include/uapi/linux/fcntl.h
> > @@ -124,6 +124,7 @@ struct delegation {
> >
> >  #define FD_PIDFS_ROOT                  -10002 /* Root of the pidfs filesystem */
> >  #define FD_NSFS_ROOT                   -10003 /* Root of the nsfs filesystem */
> > +#define FD_NULLFS_ROOT                 -10004 /* Root of the nullfs filesystem */
> >  #define FD_INVALID                     -10009 /* Invalid file descriptor: -10000 - EBADF = -10009 */
> >
> >  /* Generic flags for the *at(2) family of syscalls. */
> >
> > we then add fchroot() (overdue anyway) and then teach both fchdir() and
> > fchroot() to honor FD_NULLFS_ROOT. Then a process may shed its fs state
> > and move itself into nullfs. Restrict *chdir() and *chroot() for said
> > process via seccomp and it's locked in forever as well.
> >
> 
> One thing comes to mind that might need a bit of care: this would give
> an API for any task to get an fd to a directory that lives in the init
> mount namespace.  It's not at all obvious to me that this is dangerous
> or even observable (you're not about to find a setuid program in
> nullfs), but I think it's at least worth a tiny bit of consideration.

Yes, I thought about this as well. But it doesn't have to be this way.
Every mount namespaces has nullfs as it's root ever since I introduced
it. Which means FD_NULLFS_ROOT can also just mean "nullfs within that
specific mount namespace". That's fine.

For my FD_FAILFS_ROOT proposal it would be enough if we make failfs
SB_KERNMOUNT which means it's logically distinct from every mount
namespace. I think that might be the right thing to do. I need to spend
one or more brain cycles on this though.

> 
> But if this happens, maybe we could finally land one of the patches to
> enable unprivileged chroot?  It's been tried a few times.
> 
> https://lore.kernel.org/lkml/0e2f0f54e19bff53a3739ecfddb4ffa9a6dbde4d.1327858005.git.luto@amacapital.net/
> 
> https://lore.kernel.org/all/20210316203633.424794-2-mic@digikod.net/
> 
> I think the need for it has reduced a tiny bit with user namespaces,
> as you can sort of emulate it by unsharing your user namespace and
> thus getting enough privilege, but this is rather heavyweight and
> limiting.

I think we could make that work with both FD_NULLFS_ROOT and
FD_FAILFS_ROOT...

> 
> 
> If all of the above landed, then the old chroot /var/empty kludge that
> security-minded programs have done for decades could finally be
> modernized and not require any privilege :)

I think I like it.

> Hmm, thinking aloud: every now and then someone brings up the idea of
> having an fd (really an OFD) that points to a file or a directory but
> carries less in the way of permissions/capabilities than the usual
> OFDs.  If we had a way to make an OFD to a directory that forced
> RESOLVE_BENEATH (or RESOLVE_IN_ROOT) and that propagated that
> restriction to anything you open using it, and if an unprivileged
> process could chroot itself to nullfs, then we would be getting quite
> close to what Capsicum can do.

Next steps. I hear you volunteering...

