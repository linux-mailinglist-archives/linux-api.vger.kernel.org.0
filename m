Return-Path: <linux-api+bounces-6730-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AUneLIPeQmqcFwoAu9opvQ
	(envelope-from <linux-api+bounces-6730-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 29 Jun 2026 23:07:15 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 278636DEC68
	for <lists+linux-api@lfdr.de>; Mon, 29 Jun 2026 23:07:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=WvOADvgw;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6730-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6730-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BD30A303B7F5
	for <lists+linux-api@lfdr.de>; Mon, 29 Jun 2026 21:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68FC23B3C05;
	Mon, 29 Jun 2026 21:07:10 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359E8360ED4
	for <linux-api@vger.kernel.org>; Mon, 29 Jun 2026 21:07:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782767230; cv=none; b=PWCmtXO1tO2p16IQGVZAfQTYPYsuaCwjNdivaRnLqB8TpYvtutr9xRKPxiElg9gDV0TophzyaCeboBhoHOxhO78CM5nSCtkQaWnnchJTq92/zH968eTVI8hAon6M06ppvkug8VwQlDSL/ZEhwsZshp/A1UdbzgqR2669evzgKhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782767230; c=relaxed/simple;
	bh=uRnAtDwCNO9BhCTtGFk7SnQYQafVVJE2jiS6mFdcqFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pn8to2xV5YTPkPPXz1Ae8n749aJUUkMZ8flpDJ8B+XaZwCRpddKz+VWMx45S1Ukfr70wT0Xbxz53cTlD7FdZ+X+fY+FlczjK2kdQ1ftamVwT/TOdQRLhETC4HPqJ98NlacOwB1NaXDGHa1sYFhsT5OT0J8fgJUND3nz9sHhIBaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WvOADvgw; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF8D51F0155C
	for <linux-api@vger.kernel.org>; Mon, 29 Jun 2026 21:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782767228;
	bh=YfIToqSpqLi5Ux4oNUHmwU5C18eq/HPGb1nR21G13hE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=WvOADvgwMQCNYf3xVBU8wXEITYw3J0aqr+SQG5z0hR7kHHv31T3mx+T5Jhg0LGYeZ
	 8iiH19VtqFAsKbIV5bjbf4PoiGmK1M8Sd3ryfOPPvReHKLe+POM6Fciz9T5sS32Oo9
	 JKt8bKLaHMYbBaQf5Z9A6MUpdnvfT7W2nuPnUElqMRZTidM96SDR+/YRY5py2Cxjt4
	 b4uhAY6lmTKstfzhg2HJtVqmP7dODriH1JHhMURygo4pajVVeZMIk6QGX5g/P+GQVy
	 FuPHm3LDLqTicDJ2F5RGOT1SM4kce8EUeaGTMu+C9p30g9LrRb9YcHmEexOLM+aC6R
	 w1A3Bsu7h4e3A==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5aebba706b3so1125695e87.0
        for <linux-api@vger.kernel.org>; Mon, 29 Jun 2026 14:07:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqVTIqldeVjWlJrffH0PVraCUEVjvDLItaaTrQWj5XieaWcHgO15tlS+QrN7HcVQ8GBQzyHizyvt1A=@vger.kernel.org
X-Gm-Message-State: AOJu0YySPadI4LidHRoa4PrxgoLCPml2OAE11YVdILaN5E4QTvtbBvGp
	9nyKM9yBgg08O7PebP3nM03kMT4XV4PjBH/Btst/PhKiI9A9C9qf/nQOn7LgS0RGt/QgEPSlImi
	Ey/knItJpnoEYrdf+sGthn08RHnObf/j5ePpN5jsG
X-Received: by 2002:a05:6512:401f:b0:5ae:b36d:bbb with SMTP id
 2adb3069b0e04-5aebdbe2840mr201140e87.44.1782767227209; Mon, 29 Jun 2026
 14:07:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a49ce818-f38d-41b0-bbf7-80b8aad998b1@app.fastmail.com> <20260629-hauer-erhitzen-sobald-96d3dff68707@brauner>
In-Reply-To: <20260629-hauer-erhitzen-sobald-96d3dff68707@brauner>
From: Andy Lutomirski <luto@kernel.org>
Date: Mon, 29 Jun 2026 14:06:55 -0700
X-Gmail-Original-Message-ID: <CALCETrVuh0-biOw=TgYN9ERTFAoiki57XeZ3S2T3dO2+hL54gA@mail.gmail.com>
X-Gm-Features: AVVi8Cf3LtciGmvZ6gi6NvgR3pE8gOwRXUXdgsUdnKdMuHYPpJ3RHP1m1o_FUek
Message-ID: <CALCETrVuh0-biOw=TgYN9ERTFAoiki57XeZ3S2T3dO2+hL54gA@mail.gmail.com>
Subject: Re: [RFC] Null Namespaces
To: Christian Brauner <brauner@kernel.org>
Cc: John Ericson <mail@johnericson.me>, Li Chen <me@linux.beauty>, 
	Cong Wang <cwang@multikernel.io>, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6730-lists,linux-api=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:brauner@kernel.org,m:mail@johnericson.me,m:me@linux.beauty,m:cwang@multikernel.io,m:linux-arch@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-api@vger.kernel.org,m:arnd@arndb.de,m:luto@kernel.org,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:hpa@zytor.com,m:jack@suse.cz,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:viro@zeniv.linux.org.uk,m:kees@kernel.org,m:sergei@zimmerman.foo,m:farid.m.zakaria@gmail.com,m:faridmzakaria@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[luto@kernel.org,linux-api@vger.kernel.org];
	FREEMAIL_CC(0.00)[johnericson.me,linux.beauty,multikernel.io,vger.kernel.org,arndb.de,kernel.org,redhat.com,alien8.de,linux.intel.com,zytor.com,suse.cz,lwn.net,linuxfoundation.org,zeniv.linux.org.uk,zimmerman.foo,gmail.com];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 278636DEC68

On Mon, Jun 29, 2026 at 4:45=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>

> But I guess the even simpler model would be to copy what I've been doing
> for pidfs:
>
> +static struct path nullfs_root_path =3D {};
> +
> +void nullfs_get_root(struct path *path)
> +{
> +       *path =3D nullfs_root_path;
> +       path_get(path);
> +}
> +
>  static void __init init_mount_tree(void)
>  {
>         struct vfsmount *mnt, *nullfs_mnt;
> @@ -6209,6 +6217,8 @@ static void __init init_mount_tree(void)
>         /* Mount mutable rootfs on top of nullfs. */
>         root.mnt                =3D nullfs_mnt;
>         root.dentry             =3D nullfs_mnt->mnt_root;
> +       nullfs_root_path.mnt    =3D nullfs_mnt;
> +       pidfs_root_path.dentry  =3D nullfs_mnt->mnt_root;
>
>         LOCK_MOUNT_EXACT(mp, &root);
>         if (unlikely(IS_ERR(mp.parent)))
> diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
> index aadfbf6e0cb3..f55c87c70b78 100644
> --- a/include/uapi/linux/fcntl.h
> +++ b/include/uapi/linux/fcntl.h
> @@ -124,6 +124,7 @@ struct delegation {
>
>  #define FD_PIDFS_ROOT                  -10002 /* Root of the pidfs files=
ystem */
>  #define FD_NSFS_ROOT                   -10003 /* Root of the nsfs filesy=
stem */
> +#define FD_NULLFS_ROOT                 -10004 /* Root of the nullfs file=
system */
>  #define FD_INVALID                     -10009 /* Invalid file descriptor=
: -10000 - EBADF =3D -10009 */
>
>  /* Generic flags for the *at(2) family of syscalls. */
>
> we then add fchroot() (overdue anyway) and then teach both fchdir() and
> fchroot() to honor FD_NULLFS_ROOT. Then a process may shed its fs state
> and move itself into nullfs. Restrict *chdir() and *chroot() for said
> process via seccomp and it's locked in forever as well.
>

One thing comes to mind that might need a bit of care: this would give
an API for any task to get an fd to a directory that lives in the init
mount namespace.  It's not at all obvious to me that this is dangerous
or even observable (you're not about to find a setuid program in
nullfs), but I think it's at least worth a tiny bit of consideration.

But if this happens, maybe we could finally land one of the patches to
enable unprivileged chroot?  It's been tried a few times.

https://lore.kernel.org/lkml/0e2f0f54e19bff53a3739ecfddb4ffa9a6dbde4d.13278=
58005.git.luto@amacapital.net/

https://lore.kernel.org/all/20210316203633.424794-2-mic@digikod.net/

I think the need for it has reduced a tiny bit with user namespaces,
as you can sort of emulate it by unsharing your user namespace and
thus getting enough privilege, but this is rather heavyweight and
limiting.


If all of the above landed, then the old chroot /var/empty kludge that
security-minded programs have done for decades could finally be
modernized and not require any privilege :)

Hmm, thinking aloud: every now and then someone brings up the idea of
having an fd (really an OFD) that points to a file or a directory but
carries less in the way of permissions/capabilities than the usual
OFDs.  If we had a way to make an OFD to a directory that forced
RESOLVE_BENEATH (or RESOLVE_IN_ROOT) and that propagated that
restriction to anything you open using it, and if an unprivileged
process could chroot itself to nullfs, then we would be getting quite
close to what Capsicum can do.

--Andy

