Return-Path: <linux-api+bounces-6790-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oIwtBcJQTmqDKgIAu9opvQ
	(envelope-from <linux-api+bounces-6790-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 08 Jul 2026 15:29:38 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 66274726CC6
	for <lists+linux-api@lfdr.de>; Wed, 08 Jul 2026 15:29:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=WRBzBWCa;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6790-lists+linux-api=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-api+bounces-6790-lists+linux-api=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 710FB3014C39
	for <lists+linux-api@lfdr.de>; Wed,  8 Jul 2026 13:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CFC633689E;
	Wed,  8 Jul 2026 13:24:01 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC05331EC8
	for <linux-api@vger.kernel.org>; Wed,  8 Jul 2026 13:23:59 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783517041; cv=pass; b=ml+cYLbp9tuEaZ6RrKhKwqRkmlV0j1dmPD+uwmjcGOmjvfM6npWGfxihAulp0yNmKSLpzhUm6BbzdvdLKe7QXtH1Jpr0zDNs5MRmtK9zSWFwC4xhJ4aA8SD0UcWABiI24I1rL3z/n2yVsL1Bcc5XCcbo6pbLQNI02XkvPWSJKis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783517041; c=relaxed/simple;
	bh=sjbOYxpVLmqz8Fxaja/dycqeJ93n3DJ33hs2PVMtNjI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kKXlMCDdk1og1tC6NKmXMXWzrT7GJ/vsvU0hz2S1wdvQHSLc0D8XphY3P46SYya3OB3hje9sVYzqOzhgBnX0u9JOeLffTK443cvaYEpeQZ+xInDFCiGljWno0QwiO9YaR4Kk3iPpMwGRYuG3lrxyO8yXk/aavocGE1HJGZIFTYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WRBzBWCa; arc=pass smtp.client-ip=209.85.208.48
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-698bf053053so1197153a12.3
        for <linux-api@vger.kernel.org>; Wed, 08 Jul 2026 06:23:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783517038; cv=none;
        d=google.com; s=arc-20260327;
        b=rT7YSWGJ71uOjBVOMjMkgGys6xyI67QedxVHcngxg41EfMAYB8yseaChXKQHuGYHN5
         FwLJhqPjHv9K+yVIH5KO7u4ifLVZWaNafy0S0HuY9/yqgPWa20PECvQs8EGQFDEl3xim
         6Cij+3rTudBwIbnK1sA0xz02I5c6StnnDQyWKGhHwuPKPe99QKf6GPUFa/FP+7iJ6amc
         ihgzF6Bz0/4eIYXp9TxZgvub3H1UwocjPu1M0xeFMq7dsmsPjgHXLfhfDRN/P8pXMSB+
         SF671iHwxKgIF37ONny5U1yAq3bDy5ddaMKP5xd/fiNPlB0zdkkJ9TQcECTFK5rSpmfO
         s0Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jfSl458gi7ZwFhfzOLWI1yj6B78Eu+Dovf3nllo+0R8=;
        fh=aMDpkZpS1g9c/KX2jgadzOrif6yDqeen+ud/4EygCNc=;
        b=U9hDVkWEV0fLE5Vs+dDQnb2wT8RfxArXaiSdTQJwUeB3QL4YMDs8n37nmV7+i/cKsA
         tIYE5qd9YfamYRCKB/3FK6AESZFQ7efvSddRZ6srNGXplVLeh208VbYT42F+vmtCsSg4
         Qhv/7vH+P+lvUfmr5z2onTEM6E2WH57bynsNQFzxnEW3mcFgXOpiZaa7DL4tZRn0knc2
         OQKInxC5y1lc5lI4o4M4nqP7C5RCl304EDMh8VodC8CFWo3/ZOXh2wYNa1rMLv6uNhwP
         tB+PI944gmeHZMP+217PMvCmFdxYmvtWXzZMdTKAYBEV7A0MPskzS8vpoyw05rDVXF/H
         Rh1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783517038; x=1784121838; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jfSl458gi7ZwFhfzOLWI1yj6B78Eu+Dovf3nllo+0R8=;
        b=WRBzBWCaoMmUjliAlmVrzRTG6jLTIn0C0lrrOMCnjGOwUQGxQACCqC3UoASw0gi8Mq
         0kmtqOFR+EWsGqPydf9z4jsGtocX8TuuWBMjBWXW0xh+iO9cdFJnSltUsSvQ6X5c2NSH
         w+jUxPuiwT1QKqyRB+Xl4HeTDuhMgpptA99HFJwH/HSWfxp9sBQlvx8fsS4g9+u3jH+0
         2UJgvwiNmqlyJQxk4pKiQzwvgKmW/O2MTbg+7eDsBMzSebJ81tupkzxV1eyUdUV7IGzO
         6/wa1Lr/sShT5kn1azvdD1IXypQIMf/kAikFWyp6vYVEDotZY4cnMD1Sgar9YHtN1Wox
         1b6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783517038; x=1784121838;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jfSl458gi7ZwFhfzOLWI1yj6B78Eu+Dovf3nllo+0R8=;
        b=COEVu84u7UVV/4PwruoH9hx6eQcg1QQtnYazPB108umbZZx4Zj+novK346CEyA+mKK
         ywJWqxsOhOQVzaV7mDzaKd0uKa3uYVPrTUhTy5np7xm8WjDPLZC7V4P1qDwru9Mo6veA
         PQ0zX5W2yoVeEqSmWkRmsSioFWf+Br1aZ07t3oVlfjmdKCWy5SXXbHOyzdT/l8minVDF
         mFAljePBNSJzeKIQn9S0XBFKR4/MpicyTwkTXr991vcZ7NSQjQNfeJjqZqdAH02zPtzp
         4AAF7dZwxsVHKVK18Guhfbr2OA6/im/mzw4robW4/6LOPW5Muqa8Bi1KUkQ+1U4DQ5yV
         jtWg==
X-Forwarded-Encrypted: i=1; AHgh+RpyHEyyzIkov29a6kD3WQ7mje6ajAK2KiGxVX1xSFn9jin+PzCLWB2PM/lx5+3nJvB/pEVY/fK43CI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjiFBjN3umKPaYFZ8JW6faFKwE6kn1Z6eoPR+rUrKBvC3InMay
	LVEpQthUMn83YV2spkX5UoGXjVWSQbwCmrb4XrKHO3JmBiGsxXZXjowBKPZfk2YJSidpA2GxRCn
	aMsZvc88OOXa2myv00Fz/BjGXSmQ6dSs=
X-Gm-Gg: AfdE7clKn0LqxvIjpc1WI2DzIGgBHQeNlGovGJQBiWQIPkAJcsEPtVh7Nde+5R7vDM/
	6I/MbnfNvJEHcuLRXiJL9kHQKoh5V+U9PqR6873a3yHDM3pz4iFXxdnCUZ5wvXlT+rG8SU19y3W
	l0o6mkJdHkO9r4Ys1RmNwSQynl3RLax7D5bCSXxn2q6a4VFnUxYmZAx3POulFH8hQbhlqiWkV7e
	ni9eLgdDOZLXQ9a5Gnaz5zdduwSUYPCi2tfrxyOk/YuSR6s5GAhHJZyoG5hknViY0h8FdgjGA==
X-Received: by 2002:a05:6402:1950:b0:698:3e08:29f8 with SMTP id
 4fb4d7f45d1cf-69ab4460d0emr1057676a12.11.1783517037915; Wed, 08 Jul 2026
 06:23:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708095831.3381978-1-gscrivan@redhat.com> <CAJfpegsJON=1_84PCGMjASYPFL=Wqsz7dnTAbO3Tdz5DfRQU+g@mail.gmail.com>
 <878q7l8y4y.fsf@redhat.com>
In-Reply-To: <878q7l8y4y.fsf@redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 8 Jul 2026 15:23:46 +0200
X-Gm-Features: AVVi8CfN8aTjKTMMtRUKrgssp38DeN4Cvtt__3YWqnULwffjjbw8Yi9jHHKR9_c
Message-ID: <CAOQ4uxiiVsp0BsdqfH3rCrpP6fBi-vTyfXd-TcVmFcS34MxzUQ@mail.gmail.com>
Subject: Re: [PATCH] ovl: add ioctls to retrieve layer file descriptors
To: Giuseppe Scrivano <gscrivan@redhat.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:gscrivan@redhat.com,m:miklos@szeredi.hu,m:linux-unionfs@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-api@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[amir73il@gmail.com,linux-api@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-6790-lists,linux-api=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	FREEMAIL_FROM(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 66274726CC6

On Wed, Jul 8, 2026 at 2:31=E2=80=AFPM Giuseppe Scrivano <gscrivan@redhat.c=
om> wrote:
>
> Miklos Szeredi <miklos@szeredi.hu> writes:
>
> > On Wed, 8 Jul 2026 at 12:00, Giuseppe Scrivano <gscrivan@redhat.com> wr=
ote:
> >>
> >> Add two ioctls to overlay filesystem to allow userspace to retrieve
> >> information about the overlay layers:
> >>
> >> OVL_IOC_OPEN_LAYER:     return an O_PATH fd to the root of a layer.
> >>                         arg =3D=3D 0 returns the upper layer (-ENOENT =
if
> >>                         no upper is configured), arg >=3D 1 returns
> >>                         lower layers (-ENOENT if index is out of
> >>                         range).
> >
> > We could do this with a plain open() call.  Something like the magic
> > symlinks we have under /proc/PID/fd/.   Question is where could these
> > live...
>
> is there any existing user of such a mechanism?  I don't see any mount
> specific info under /proc or /sys.
>
> >
> >> OVL_IOC_GET_LAYERS_INFO: copy a struct ovl_layers_info to userspace
> >>                         with numlower, numlowerdata, and has_upper.
> >
> > Isn't this info obtainable via statmount(2) already?  If not, it
> > should be there, instead of a specialized ioctl.
>
> no that is not exposed by statmount and I don't see any way to export
> file system specific data through it.  Do you've anything in mind?
>
> >> --- a/fs/overlayfs/ovl_entry.h
> >> +++ b/fs/overlayfs/ovl_entry.h
> >> @@ -35,6 +35,8 @@ struct ovl_layer {
> >>         struct vfsmount *mnt;
> >>         /* Trap in ovl inode cache */
> >>         struct inode *trap;
> >> +       /* Keeps the original fsmount file alive for OVL_IOC_OPEN_LAYE=
R */
> >> +       struct file *origin;
> >
> > Don't need to keep the file open: the only info missing is the
> > original vfsmount, everything else is already there to reconstruct the
> > file.
>
> I didn't manage to get that to work.  As soon as the userspace process
> closes the mount fd that was passed to fsconfig, the anonymous mount
> namespace is destroyed and dissolve_on_fput sets mnt->mnt_ns to NULL.
>
> So whenever I try to use this mount again from userspace, it is not
> usable because the mount namespace is empty, causing check_mnt() to
> fail.
>
> Do you have any suggestions on how to solve this problem?

The suggestion was to store origin->f_path->mnt instead of storing origin f=
ile,
because you only end up using the origin vfsmount.

Thanks,
Amir.

