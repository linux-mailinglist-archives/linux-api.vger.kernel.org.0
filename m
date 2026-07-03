Return-Path: <linux-api+bounces-6775-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gutZHf7yR2ruhwAAu9opvQ
	(envelope-from <linux-api+bounces-6775-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Fri, 03 Jul 2026 19:35:58 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB06704AAB
	for <lists+linux-api@lfdr.de>; Fri, 03 Jul 2026 19:35:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=mO0zYr2i;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6775-lists+linux-api=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-api+bounces-6775-lists+linux-api=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AE46630264D2
	for <lists+linux-api@lfdr.de>; Fri,  3 Jul 2026 17:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C96A30ACF0;
	Fri,  3 Jul 2026 17:35:53 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBD530B50D
	for <linux-api@vger.kernel.org>; Fri,  3 Jul 2026 17:35:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783100153; cv=none; b=e/NWMJiV/XNoQIIWgq3GXp9j6EnUy/Z4dtRQeHOnHwZSlfQ7HfAljMH+QxZMJ6TQuyLJdBrjg6ar4wZXAxPqiDSN2j7138Oi1eVJ1S3L+JuCs34KEs48+uFN9zp7yorbgcny1RiQ1S1dzGcY0nwc5vRwxLyH2EyV291cMrVc5Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783100153; c=relaxed/simple;
	bh=AbEmXxgy/FDmbds8Ppv+0UauIp43P/HY1boqMBn225U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h6QddRpMVJnwfQNa56o3IdZ8b3nOtmcRmjY/zjQlgbKxDD5z5jjFCnZP7rJii6P5cDFG8oht3y/B+M1BcwKanXOJ55tExU1kymAI19gCgF8txqwtiaeEW7H8tKH9Fzp0xaRe1Df+EoxlrIXeWdLd4Z4mWVymBBt0SelyYWIvf6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mO0zYr2i; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD7F91F00A3A
	for <linux-api@vger.kernel.org>; Fri,  3 Jul 2026 17:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783100150;
	bh=h6pMdw59YeAPW8oCGL6skH/PxCmKpbckddnagWCxG8g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=mO0zYr2iAksadMVlcSFH+oTsGEHRq6izb8vXeC66nG6KepwsAoNNoFD9BahlOZ5xS
	 W6yUqe2Hj0tAEAeM9ox1ap2hMl6PV5d77AOmwiyu2+c5o04fyPJCqMPjdTPOcRwmxv
	 buCRm5qLkqI13T0uBFAAsBVRoUcfbXM2DjdtKiGzpPtOACwpvjUUn2X1ULFea3tIyA
	 fML83/pJLS4zTMeSqPMMFXAGiDlUUTFOM9jHp9Yn/9uIuLs6aw8krbLAP9VOwPSZXI
	 UQC4NvwkgP+xSnomxCKYks7kzQLFii9sdAqYv1Zq46Z89TGg50WZDQ9K+SCSAma2aX
	 qS+V7DZqo453Q==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5aeb89359a3so669693e87.3
        for <linux-api@vger.kernel.org>; Fri, 03 Jul 2026 10:35:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqBO0yhI3TTzRUNLEJ7YARAfdiZf0D74Mo3ySbPPjYV2Dx2pV9oNLmb8ie806vzYK5WjrNklhQAWlY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx00K2kni3isCi+y/Bl11Hh5nQHMY+oCDdI4fedWn7SPPVjsJvo
	EOh5D6CxfUHHJ7/wfv3SCVCT7oMeX8GGnGiYiSL6PaNu7wIoL7m4t13+X/w3MkAymSNNbG4ekJD
	jzp64Wk2anhuMvMBNkPH51WYanHd3k7azgdSEyv+R
X-Received: by 2002:a05:6512:224e:b0:5ae:bf17:c4e2 with SMTP id
 2adb3069b0e04-5aed452e549mr161744e87.9.1783100149019; Fri, 03 Jul 2026
 10:35:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a49ce818-f38d-41b0-bbf7-80b8aad998b1@app.fastmail.com>
 <20260629-hauer-erhitzen-sobald-96d3dff68707@brauner> <CALCETrVuh0-biOw=TgYN9ERTFAoiki57XeZ3S2T3dO2+hL54gA@mail.gmail.com>
 <20260702-entladen-farbkombinationen-klarheit-fe24cb608f23@brauner>
In-Reply-To: <20260702-entladen-farbkombinationen-klarheit-fe24cb608f23@brauner>
From: Andy Lutomirski <luto@kernel.org>
Date: Fri, 3 Jul 2026 10:35:35 -0700
X-Gmail-Original-Message-ID: <CALCETrXLBw0DxtYa_ipaSQRbkptphEonsq3CojFv7NJk9pFOzA@mail.gmail.com>
X-Gm-Features: AVVi8CcIFTahLBIuvl-mgzlcM0nbdwIDoF801puOt51jvhgWAPRDcVEllZN1QQg
Message-ID: <CALCETrXLBw0DxtYa_ipaSQRbkptphEonsq3CojFv7NJk9pFOzA@mail.gmail.com>
Subject: Directory capability brain dump (Re: [RFC] Null Namespaces)
To: Christian Brauner <brauner@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>, John Ericson <mail@johnericson.me>, Li Chen <me@linux.beauty>, 
	Cong Wang <cwang@multikernel.io>, linux-arch <linux-arch@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Linux FS Devel <linux-fsdevel@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, 
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6775-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:brauner@kernel.org,m:luto@kernel.org,m:mail@johnericson.me,m:me@linux.beauty,m:cwang@multikernel.io,m:linux-arch@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-api@vger.kernel.org,m:arnd@arndb.de,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:hpa@zytor.com,m:jack@suse.cz,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:viro@zeniv.linux.org.uk,m:kees@kernel.org,m:sergei@zimmerman.foo,m:farid.m.zakaria@gmail.com,m:faridmzakaria@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[luto@kernel.org,linux-api@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,johnericson.me,linux.beauty,multikernel.io,vger.kernel.org,arndb.de,redhat.com,alien8.de,linux.intel.com,zytor.com,suse.cz,lwn.net,linuxfoundation.org,zeniv.linux.org.uk,zimmerman.foo,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luto@kernel.org,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2BB06704AAB

On Thu, Jul 2, 2026 at 3:02=E2=80=AFAM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> On Mon, Jun 29, 2026 at 02:06:55PM -0700, Andy Lutomirski wrote:
> > On Mon, Jun 29, 2026 at 4:45=E2=80=AFAM Christian Brauner <brauner@kern=
el.org> wrote:
> > >
> >
> > > But I guess the even simpler model would be to copy what I've been do=
ing
> > > for pidfs:
> > >
> > > +static struct path nullfs_root_path =3D {};
> > > +
> > > +void nullfs_get_root(struct path *path)
> > > +{
> > > +       *path =3D nullfs_root_path;
> > > +       path_get(path);
> > > +}
> > > +
> > >  static void __init init_mount_tree(void)
> > >  {
> > >         struct vfsmount *mnt, *nullfs_mnt;
> > > @@ -6209,6 +6217,8 @@ static void __init init_mount_tree(void)
> > >         /* Mount mutable rootfs on top of nullfs. */
> > >         root.mnt                =3D nullfs_mnt;
> > >         root.dentry             =3D nullfs_mnt->mnt_root;
> > > +       nullfs_root_path.mnt    =3D nullfs_mnt;
> > > +       pidfs_root_path.dentry  =3D nullfs_mnt->mnt_root;
> > >
> > >         LOCK_MOUNT_EXACT(mp, &root);
> > >         if (unlikely(IS_ERR(mp.parent)))
> > > diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
> > > index aadfbf6e0cb3..f55c87c70b78 100644
> > > --- a/include/uapi/linux/fcntl.h
> > > +++ b/include/uapi/linux/fcntl.h
> > > @@ -124,6 +124,7 @@ struct delegation {
> > >
> > >  #define FD_PIDFS_ROOT                  -10002 /* Root of the pidfs f=
ilesystem */
> > >  #define FD_NSFS_ROOT                   -10003 /* Root of the nsfs fi=
lesystem */
> > > +#define FD_NULLFS_ROOT                 -10004 /* Root of the nullfs =
filesystem */
> > >  #define FD_INVALID                     -10009 /* Invalid file descri=
ptor: -10000 - EBADF =3D -10009 */
> > >
> > >  /* Generic flags for the *at(2) family of syscalls. */
> > >
> > > we then add fchroot() (overdue anyway) and then teach both fchdir() a=
nd
> > > fchroot() to honor FD_NULLFS_ROOT. Then a process may shed its fs sta=
te
> > > and move itself into nullfs. Restrict *chdir() and *chroot() for said
> > > process via seccomp and it's locked in forever as well.
> > >
> >
> > One thing comes to mind that might need a bit of care: this would give
> > an API for any task to get an fd to a directory that lives in the init
> > mount namespace.  It's not at all obvious to me that this is dangerous
> > or even observable (you're not about to find a setuid program in
> > nullfs), but I think it's at least worth a tiny bit of consideration.
>
> Yes, I thought about this as well. But it doesn't have to be this way.
> Every mount namespaces has nullfs as it's root ever since I introduced
> it. Which means FD_NULLFS_ROOT can also just mean "nullfs within that
> specific mount namespace". That's fine.
>
> For my FD_FAILFS_ROOT proposal it would be enough if we make failfs
> SB_KERNMOUNT which means it's logically distinct from every mount
> namespace. I think that might be the right thing to do. I need to spend
> one or more brain cycles on this though.
>
> >
> > But if this happens, maybe we could finally land one of the patches to
> > enable unprivileged chroot?  It's been tried a few times.
> >
> > https://lore.kernel.org/lkml/0e2f0f54e19bff53a3739ecfddb4ffa9a6dbde4d.1=
327858005.git.luto@amacapital.net/
> >
> > https://lore.kernel.org/all/20210316203633.424794-2-mic@digikod.net/
> >
> > I think the need for it has reduced a tiny bit with user namespaces,
> > as you can sort of emulate it by unsharing your user namespace and
> > thus getting enough privilege, but this is rather heavyweight and
> > limiting.
>
> I think we could make that work with both FD_NULLFS_ROOT and
> FD_FAILFS_ROOT...
>
> >
> >
> > If all of the above landed, then the old chroot /var/empty kludge that
> > security-minded programs have done for decades could finally be
> > modernized and not require any privilege :)
>
> I think I like it.
>
> > Hmm, thinking aloud: every now and then someone brings up the idea of
> > having an fd (really an OFD) that points to a file or a directory but
> > carries less in the way of permissions/capabilities than the usual
> > OFDs.  If we had a way to make an OFD to a directory that forced
> > RESOLVE_BENEATH (or RESOLVE_IN_ROOT) and that propagated that
> > restriction to anything you open using it, and if an unprivileged
> > process could chroot itself to nullfs, then we would be getting quite
> > close to what Capsicum can do.
>
> Next steps. I hear you volunteering...
>

Haha.  I volunteer to give somewhat of a brain dump, which is very
incomplete.  Doing a decent job of this would be maybe 90% figuring
out nasty details and 10% implementation.  I might even volunteer to
do some implementation if there is anything resembling agreement on a
design.

First of all, I was way too glib with "OFD", because OFD doesn't cover
cwd, root, or any of the magic links in /proc, nor does OFD cover
mountpoints.

Second, I confess to having my brain dump be hopelessly polluted by a
substantial ulterior motive: I want fds (or whatevers)-as-capabilities
to go both ways, which means that I want to be able to open an fd that
captures certain of my privileges such that someone with different
current->cred can use it.  And I want *that* ability to work with bind
mounts and such.  The main motivation for this is that I *despise* the
way that outside-a-container filesystem modes interact with
containers.  It makes me extremely disappointed that I can take an
ordinary subdirectory of my home directory and mount it into a Linux
container on a Mac running MacOS without mucking with permissions at
all, but trying to do the same thing on the average Linux distro plus
the average container runtime is an exercise in hair pulling,
especially when SELinux is involved.  *Why* can't it just work?

So let's call the directory version of this thing a "directory
capability", and directory capabilities can live in OFDs or in cwd,
root, or a vfsmount.

The default directory capability (IMO) ought to be exactly equivalent
to O_PATH or a cwd.  But I think one should be able to make a
restricted one with bits like:

- read: if not set, you can't read the files in here. executing
unconditionally counts as reading for this purpose.

- execute: If not set, you can't execute the files in here.  (This
kind of "execute" has nothing to do with opening subdirectories.
we're not talking about POSIX.)  Everyone can argue about whether
running a shell script and/or loading a shared library counts as
executing.

- write: If not set, you can't write the files in here.

- create: If not set, you can't create files in here.  (How does this
interact with write?)

- maybe some bits to prevent writing metadata, fs-specific ioctls, etc.

- dotdot and/or ancestor: needs thought.  One way would be what I
mentioned above: any path resolution starting at this directory
capability or anything derived from it forces RESOLVE_BENEATH.

- open question: what happens if i open a directory and then unmount
something that was mounted on one of its subdirectories?  Does this
matter?

The general idea of using these things is that one might open an fd
with constraints:

fd =3D open_with_constraints(..., read | execute);

Now using fd in openat forces RESOLVE_BENEATH (because I didn't say
dotdot), and any attempt to open a file for write or to create a new
file will fail.  And if I fchdir or fchroot to fd, then those
constraints still apply.  And if I do:

fd =3D open_with_constraints(..., read);
fd2 =3D open_with_constraints(fd, ..., read | execute);

then we need to decide whether to fail outright or to return something
that doesn't have execute.

If I do:

fd =3D open_with_constraints(..., read);
fchdir(fd);
open("/proc/self/cwd/../foo") needs to fail (or perhaps just open ~/foo?)

If I take that same fd and bind-mount it on /mnt/restricted, then I
should not be able to find its ancestors via /mnt/restricted/..
(obviously -- that doesn't work anyway).  (But maybe there should be
an extra flag "seethrough" which, if not set, would prevent a
non-recursive bind mount like that, since it would let someone see
through mounts on the tree referred to by fd.)  And I should also not
be able to write to /mnt/restricted/foo.


For added fun (see above), I want an ability to "delegate" my own
permissions into an fd.

fd =3D open_delegate(..., read);

Now *anyone* with a copy of fd (or access via cwd, etc) can read files
in the subtree using my credentials, as captured when I called
open_delegate.  And this should survive bind mounting, so I could
finally do:

my_favorite_container_tool --delegate /home/username/foo,/mnt/mountpoint,re=
ad

and the things in the container, even if they use a dynamic subuid or
have some funky SELinux context, could actually read via
/mnt/mountpoint, and I could stop cursing at my computer.

- Open question: what happens to /proc/.../exe?  IMO it would be
*really* nice if we could get away with applying this sort of system
to /proc/.../exe.  There are ABI compatibility concerns here.  A whole
class of old nasty vulnerabilities would go away if writing through
/proc/.../exe were simply impossible.


Okay, there's my brain dump.  Feel free to make fun of it.  No LLMs
were roused from their slumber in the writing of this email :)

