Return-Path: <linux-api+bounces-6779-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6NyTIJj4S2pwdwEAu9opvQ
	(envelope-from <linux-api+bounces-6779-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 06 Jul 2026 20:48:56 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CF21C714A9F
	for <lists+linux-api@lfdr.de>; Mon, 06 Jul 2026 20:48:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=bM59pHRQ;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6779-lists+linux-api=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-api+bounces-6779-lists+linux-api=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD01433B1B1D
	for <lists+linux-api@lfdr.de>; Mon,  6 Jul 2026 17:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5622EC0A4;
	Mon,  6 Jul 2026 17:05:12 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD8A2EEE68
	for <linux-api@vger.kernel.org>; Mon,  6 Jul 2026 17:05:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783357512; cv=none; b=eq+JSuTUgMfw6y+8vZWW2TWJDn8QixGcmTFW0rGdjAEvv2JtITa+DLlxKIWHUzuxjc7PFc2tq0TWCqupdWtaQJmeof3pBCG2F1YEk9I3+pSn1N74Oftw70kI35toDIiyHV1FUc29GMtJdx2c6yBo8Rcqlv06BckC0q9gX2wv0b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783357512; c=relaxed/simple;
	bh=L27q0R6YyAhQAd+AUU/QjRgzV3M2j4YatKxa8NAnbBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jz4NV59ePPHyAxdcMH6Jn8yFYGAzBMJ/XCvYLkslpGF9Nvcctx5arIXzunOurhKbuCeaAxTLsLDnVRnC04QWRzOFI20Q4worD8ub6s6seu3nDcXPIHA2A08NQdFwybwRoQAEsYNsa9ovyGWx7EV7iSN9R3Up87gst6z4/WQCHlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bM59pHRQ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13B071F00ADB
	for <linux-api@vger.kernel.org>; Mon,  6 Jul 2026 17:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783357511;
	bh=z93kPEt+tZaBA1w5iH97ApluuGseB7fzewwCAxDvJzE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=bM59pHRQm3M1YRG0EIq7jG9mnj+UKFkAyz3GpEGLAv019MZUGL6VzZ8adwEMeRp9M
	 kMbACv+D4QrFkUAeC55aQWJZGtWrlMCuhoZVQEQJgA1M30veRSXmn4Uu6Y96c9C2CT
	 mHuj2FRuFtkqgj2K6/nekNffQGiY9Cb1r/Ov31Nn3Id7exk8Tc3+BCrvuU6FGsvmwR
	 w0BTy8IFhTAWMN5fWoB8EP/VNE7rJhmHomR30+NUgLtD7dg4J0AQ0muVebDXR0czGx
	 ffjppF3XYxHWtbeH4BhZdXw3Qu6OoUZmpDV7WB7iERKmnGUoJMg+NMRnHvY+0PlbBo
	 uyy1V0CV6EO2A==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5aeb24c0807so2588615e87.0
        for <linux-api@vger.kernel.org>; Mon, 06 Jul 2026 10:05:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrYIcfc5ckyoYeUafQI7fDRIgrblCa/2TZwc92uHJp84IQrO9s+ZLz3+2SsAJJFSh866ikeyQdF/m4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh/j1KftHBb1iYX3CzifX7DZ2Lj1LSsjEm6Q3YJDoK2UrOhSTk
	tBRIwoHi8TFgsEJm0be/NP79Dfg9qB/bhSHjedyiNV72+yMIGPHPchKlhVv38gPmRiAX5dmTQAZ
	2plogGJLf7JRtBPiwTn9AEHiEYVf/Ax3GWIHMXMTZ
X-Received: by 2002:a05:6512:66c7:10b0:5ae:c4e0:6a05 with SMTP id
 2adb3069b0e04-5b007c47a40mr215252e87.50.1783357509203; Mon, 06 Jul 2026
 10:05:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a49ce818-f38d-41b0-bbf7-80b8aad998b1@app.fastmail.com>
 <20260629-hauer-erhitzen-sobald-96d3dff68707@brauner> <CALCETrVuh0-biOw=TgYN9ERTFAoiki57XeZ3S2T3dO2+hL54gA@mail.gmail.com>
 <20260702-entladen-farbkombinationen-klarheit-fe24cb608f23@brauner> <20260706-dabei-radeln-glitzer-71ecb835029c@brauner>
In-Reply-To: <20260706-dabei-radeln-glitzer-71ecb835029c@brauner>
From: Andy Lutomirski <luto@kernel.org>
Date: Mon, 6 Jul 2026 10:04:57 -0700
X-Gmail-Original-Message-ID: <CALCETrXRuJEFQzz5qznVJtSvmsZdc=D7vp271H9j9JyaRdEpxg@mail.gmail.com>
X-Gm-Features: AVVi8Cd36ZOk4eFeLvJ3vCejadYb-et-1LJStHYmB7PpOlauQGmA_yjWX8q1GQQ
Message-ID: <CALCETrXRuJEFQzz5qznVJtSvmsZdc=D7vp271H9j9JyaRdEpxg@mail.gmail.com>
Subject: Re: [RFC] Null Namespaces
To: Christian Brauner <brauner@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>, Jann Horn <jannh@google.com>, 
	John Ericson <mail@johnericson.me>, Li Chen <me@linux.beauty>, Cong Wang <cwang@multikernel.io>, 
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.cz>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Kees Cook <kees@kernel.org>, Sergei Zimmerman <sergei@zimmerman.foo>, 
	Farid Zakaria <farid.m.zakaria@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6779-lists,linux-api=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:brauner@kernel.org,m:luto@kernel.org,m:jannh@google.com,m:mail@johnericson.me,m:me@linux.beauty,m:cwang@multikernel.io,m:linux-arch@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-api@vger.kernel.org,m:arnd@arndb.de,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:hpa@zytor.com,m:jack@suse.cz,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:viro@zeniv.linux.org.uk,m:kees@kernel.org,m:sergei@zimmerman.foo,m:farid.m.zakaria@gmail.com,m:faridmzakaria@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[luto@kernel.org,linux-api@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,google.com,johnericson.me,linux.beauty,multikernel.io,vger.kernel.org,arndb.de,redhat.com,alien8.de,linux.intel.com,zytor.com,suse.cz,lwn.net,linuxfoundation.org,zeniv.linux.org.uk,zimmerman.foo,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luto@kernel.org,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CF21C714A9F

On Mon, Jul 6, 2026 at 8:31=E2=80=AFAM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> On Thu, Jul 02, 2026 at 11:34:01AM +0200, Christian Brauner wrote:
> > On Mon, Jun 29, 2026 at 02:06:55PM -0700, Andy Lutomirski wrote:
> > > On Mon, Jun 29, 2026 at 4:45=E2=80=AFAM Christian Brauner <brauner@ke=
rnel.org> wrote:
> > > >
> > >
> > > > But I guess the even simpler model would be to copy what I've been =
doing
> > > > for pidfs:
> > > >
> > > > +static struct path nullfs_root_path =3D {};
> > > > +
> > > > +void nullfs_get_root(struct path *path)
> > > > +{
> > > > +       *path =3D nullfs_root_path;
> > > > +       path_get(path);
> > > > +}
> > > > +
> > > >  static void __init init_mount_tree(void)
> > > >  {
> > > >         struct vfsmount *mnt, *nullfs_mnt;
> > > > @@ -6209,6 +6217,8 @@ static void __init init_mount_tree(void)
> > > >         /* Mount mutable rootfs on top of nullfs. */
> > > >         root.mnt                =3D nullfs_mnt;
> > > >         root.dentry             =3D nullfs_mnt->mnt_root;
> > > > +       nullfs_root_path.mnt    =3D nullfs_mnt;
> > > > +       pidfs_root_path.dentry  =3D nullfs_mnt->mnt_root;
> > > >
> > > >         LOCK_MOUNT_EXACT(mp, &root);
> > > >         if (unlikely(IS_ERR(mp.parent)))
> > > > diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.=
h
> > > > index aadfbf6e0cb3..f55c87c70b78 100644
> > > > --- a/include/uapi/linux/fcntl.h
> > > > +++ b/include/uapi/linux/fcntl.h
> > > > @@ -124,6 +124,7 @@ struct delegation {
> > > >
> > > >  #define FD_PIDFS_ROOT                  -10002 /* Root of the pidfs=
 filesystem */
> > > >  #define FD_NSFS_ROOT                   -10003 /* Root of the nsfs =
filesystem */
> > > > +#define FD_NULLFS_ROOT                 -10004 /* Root of the nullf=
s filesystem */
> > > >  #define FD_INVALID                     -10009 /* Invalid file desc=
riptor: -10000 - EBADF =3D -10009 */
> > > >
> > > >  /* Generic flags for the *at(2) family of syscalls. */
> > > >
> > > > we then add fchroot() (overdue anyway) and then teach both fchdir()=
 and
> > > > fchroot() to honor FD_NULLFS_ROOT. Then a process may shed its fs s=
tate
> > > > and move itself into nullfs. Restrict *chdir() and *chroot() for sa=
id
> > > > process via seccomp and it's locked in forever as well.
> > > >
> > >
> > > One thing comes to mind that might need a bit of care: this would giv=
e
> > > an API for any task to get an fd to a directory that lives in the ini=
t
> > > mount namespace.  It's not at all obvious to me that this is dangerou=
s
> > > or even observable (you're not about to find a setuid program in
> > > nullfs), but I think it's at least worth a tiny bit of consideration.
> >
> > Yes, I thought about this as well. But it doesn't have to be this way.
> > Every mount namespaces has nullfs as it's root ever since I introduced
> > it. Which means FD_NULLFS_ROOT can also just mean "nullfs within that
> > specific mount namespace". That's fine.
> >
> > For my FD_FAILFS_ROOT proposal it would be enough if we make failfs
> > SB_KERNMOUNT which means it's logically distinct from every mount
> > namespace. I think that might be the right thing to do. I need to spend
> > one or more brain cycles on this though.
>
> I had to take a long drive on Sunday and I kept thinking about both
> FD_NULLFS_ROOT and FD_FAILFS_ROOT and ofc there are some things to
> consider/discuss.
>
> I think the straightforward solution to FD_NULLFS_ROOT would be to just:
>
> - make it always available
> - refer to the caller's mount namespace nullfs
> - work with fchroot()/fchdir()
>
> So I considered two chroot() use-cases for the sake of simplicity:
>
> (1) You want to isolate yourself for the sake of lookup
>
> (2) You want to isolate yourself to assemble a "private mount tree" but
>     not really be in a separate namespace (very odd use-case... but it
>     helps to make a point).
>
> The problem with this approach is that everyone who chroots into the
> nullfs root would suffer from the problem that any mount on top of it is
> still visible. So that kinda makes it pointless for both (1) and (2).

Ugh.

You're at least functionally correct, although this all reminds me
that I have never felt like Linux's vfs mount hierarchy makes any
sense:

root@debian:/mnt/empty# mkdir hidden
root@debian:/mnt/empty# mount --bind /usr .
root@debian:/mnt/empty# ls
hidden
root@debian:/mnt/empty# ls hidden/..
bin  games  include  lib  libexec  local  sbin share  src

>
> FD_FAILFS_ROOT on the other hand should work fine. It would be a shared
> single fs with SB_KERNMOUNT and you can't do anything at all:
>
> - no lookup
> - no creation (duh)
> - no stat
> - no mounting
>
> We could certainly allow a chroot() into this which would mean from that
> point onward all your lookup bust be relative to a given file
> descriptor. Anything that requires absolute paths would fail. Which also
> means any absolute symlink would fail afaict. It's kinda like an
> fs_struct variant of: RESOLVE_BENEATH where a FD_FAILFS_ROOT fs_struct
> forces you to provide an actual dirfd...
>
> chroot()ing back into anything non-empty would necessarily require
> CAP_SYS_CHROOT. And since you're chroot()ed you can't unshare a userns.
> So the only way to get out of this is by having access to a file
> descriptor to a mount namespace that the caller has privilege over and
> can setns() into. So it's mostly a "throw-away-the-key" moment.
>
> > > But if this happens, maybe we could finally land one of the patches t=
o
> > > enable unprivileged chroot?  It's been tried a few times.
> > >
> > > https://lore.kernel.org/lkml/0e2f0f54e19bff53a3739ecfddb4ffa9a6dbde4d=
.1327858005.git.luto@amacapital.net/
> > >
> > > https://lore.kernel.org/all/20210316203633.424794-2-mic@digikod.net/
> > >
> > > I think the need for it has reduced a tiny bit with user namespaces,
> > > as you can sort of emulate it by unsharing your user namespace and
> > > thus getting enough privilege, but this is rather heavyweight and
> > > limiting.
> >
> > I think we could make that work with both FD_NULLFS_ROOT and
> > FD_FAILFS_ROOT...
> >
> > >
> > >
> > > If all of the above landed, then the old chroot /var/empty kludge tha=
t
> > > security-minded programs have done for decades could finally be
> > > modernized and not require any privilege :)
> >
> > I think I like it.
> >
> > > Hmm, thinking aloud: every now and then someone brings up the idea of
> > > having an fd (really an OFD) that points to a file or a directory but
> > > carries less in the way of permissions/capabilities than the usual
> > > OFDs.  If we had a way to make an OFD to a directory that forced
> > > RESOLVE_BENEATH (or RESOLVE_IN_ROOT) and that propagated that
> > > restriction to anything you open using it, and if an unprivileged
> > > process could chroot itself to nullfs, then we would be getting quite
> > > close to what Capsicum can do.
> >
> > Next steps. I hear you volunteering...
>
> Thanks for the braindump. I need to find time to process it all.
>

