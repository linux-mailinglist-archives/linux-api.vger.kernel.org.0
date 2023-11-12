Return-Path: <linux-api+bounces-36-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6757E9292
	for <lists+linux-api@lfdr.de>; Sun, 12 Nov 2023 21:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BA85280AB3
	for <lists+linux-api@lfdr.de>; Sun, 12 Nov 2023 20:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE3D18622;
	Sun, 12 Nov 2023 20:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="EbahUf9u"
X-Original-To: linux-api@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D3717729
	for <linux-api@vger.kernel.org>; Sun, 12 Nov 2023 20:29:29 +0000 (UTC)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC4EF2129
	for <linux-api@vger.kernel.org>; Sun, 12 Nov 2023 12:29:25 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-da7ea62e76cso4086912276.3
        for <linux-api@vger.kernel.org>; Sun, 12 Nov 2023 12:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1699820965; x=1700425765; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3LEiFRccVX8KiAqr8aLrNuitddMncMWdvOArUdgwYFA=;
        b=EbahUf9u52SAJyhlGTA6PhYxsSBdC5ivLbdab9QagM7D7xxDQhIfR4lPt06NwpUA69
         +i1X+9NFuw3pli+gN48bLsDQbsl8YTF7ghcUQrpsb79jZnMcwmeJMIaFP9ZOX6jb7GEw
         yO593/1b+5NSBLPMTFwX91PPOEAjVekAXWSW/u9HIUuqSrOb8XLP7t1zXJFD5PZ6Grvb
         oAQBMMu2/ThkLnxJFrBJ6vT5dmnYPmzFrdaFMcI3lDyHeH7+psGnxZAI36wyjVtyqMVz
         wsd+S97EYB5QLGU411A/MEm+AHrLZoqD2ifQD8yCVCclZucWe6gUob8eX16OfSLO3KCL
         zfbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699820965; x=1700425765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3LEiFRccVX8KiAqr8aLrNuitddMncMWdvOArUdgwYFA=;
        b=qLf9fAgy6gM+VhNaVRKOs8xmUi3OhqvobrqdS8TgxGa7GryUyXwlVCGlA60RQmV5MX
         4OMkSxUyqle/RAIAzn6n1HNuLSzXSI+r489zodCgoQRy6llJaW9clgc2HFiZiXLcf5N3
         UPmWFBaofe6Bn1CZneDREIM6T/i8NS9UpHYnucDQSokmOLwQmFVON6Mwt2h9LUS3oB1W
         Q2q6vpFhvxV0lop/E8Zd8StM6BwtrJNXfV/oOj7GY5aYF0czauX+XvwG/GIL1ZPhmsND
         h+kUC33IoT9hJgR9SMRvJaSBt4GATlIsICieKK+umHXCCjSbsVgX71RlHHAF8hwQX1wD
         NtvQ==
X-Gm-Message-State: AOJu0YyWEKrjLOiGqV+uioUuioVz0p5QpDOeDDkmhftgk8JIWA28PCFj
	myzZhnO9vWZWyWclmIDs+eymFlSudb3cM/MQnsdx
X-Google-Smtp-Source: AGHT+IHaPPV9MIlPUjLJpHPXhDxxIxEWB2lJUF4iF2LdqVMFQe8W4EmWqUG+SJbhoKCVuZ2gV/1GlgKZCNnUWcv98GE=
X-Received: by 2002:a25:cc8:0:b0:dae:b67e:7cd4 with SMTP id
 191-20020a250cc8000000b00daeb67e7cd4mr4193804ybm.46.1699820965122; Sun, 12
 Nov 2023 12:29:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231025140205.3586473-5-mszeredi@redhat.com> <4ab327f80c4f98dffa5736a1acba3e0d.paul@paul-moore.com>
 <20231108-zwerge-unheil-b3f48a84038d@brauner> <CAHC9VhSLGyFRSbeZXE7z61Y2aDJi_1Dedjw0ioFOckRCs0CRaA@mail.gmail.com>
 <CAHC9VhRvYua4noiHbMqcAqz=Rkz=pxSgp5fVxXX+uhz61jYFag@mail.gmail.com> <20231112-gemessen-lauschangriff-3352c19e676a@brauner>
In-Reply-To: <20231112-gemessen-lauschangriff-3352c19e676a@brauner>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 12 Nov 2023 15:29:14 -0500
Message-ID: <CAHC9VhRYtjJ9q4B_wLe89d5RBxWqpWzsKqAeAiDo5NhAYccVaQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] add statmount(2) syscall
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-man@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Karel Zak <kzak@redhat.com>, Ian Kent <raven@themaw.net>, David Howells <dhowells@redhat.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <christian@brauner.io>, Amir Goldstein <amir73il@gmail.com>, 
	Matthew House <mattlloydhouse@gmail.com>, Florian Weimer <fweimer@redhat.com>, 
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 12, 2023 at 8:06=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
> On Fri, Nov 10, 2023 at 12:00:22PM -0500, Paul Moore wrote:
> > On Wed, Nov 8, 2023 at 3:10=E2=80=AFPM Paul Moore <paul@paul-moore.com>=
 wrote:
> > > On Wed, Nov 8, 2023 at 2:58=E2=80=AFAM Christian Brauner <brauner@ker=
nel.org> wrote:
> > > > > > +static int do_statmount(struct stmt_state *s)
> > > > > > +{
> > > > > > +   struct statmnt *sm =3D &s->sm;
> > > > > > +   struct mount *m =3D real_mount(s->mnt);
> > > > > > +   size_t copysize =3D min_t(size_t, s->bufsize, sizeof(*sm));
> > > > > > +   int err;
> > > > > > +
> > > > > > +   err =3D security_sb_statfs(s->mnt->mnt_root);
> > > > > > +   if (err)
> > > > > > +           return err;
> > > > > > +
> > > > > > +   if (!capable(CAP_SYS_ADMIN) &&
> > > > > > +       !is_path_reachable(m, m->mnt.mnt_root, &s->root))
> > > > > > +           return -EPERM;
> > > > >
> > > > > In order to be consistent with our typical access control orderin=
g,
> > > > > please move the security_sb_statfs() call down to here, after the
> > > > > capability checks.
> > > >
> > > > I've moved the security_sb_statfs() calls accordingly.
> > >
> > > Okay, good.  Did I miss a comment or a patch where that happened?  I
> > > looked over the patchset and comments yesterday and didn't recall
> > > seeing anything about shuffling the access control checks.
> >
> > Gentle ping on this.  I'm asking because I know there have been issues
> > lately with the lists and some mail providers and I want to make sure
> > I'm not missing anything, I double checked lore again and didn't see
> > anything there either, but I might be missing it.
>
> Sorry, I'm traveling so I just didn't see this. Please see:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/commit/?h=3Dv=
fs.mount&id=3Ddc14fa93943918bee898d75d7ae72fc3623ce9ce
> https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/commit/?h=3Dv=
fs.mount&id=3Dde17643cbf9b0282990bb9cf0e0bf01710c9ec03
>
> I've folded the fixup into these patches. I probably just accidently
> dropped the diff from my reply.

Okay, no worries, like I said I was mostly worried about mail/list
problems eating the response.

Thanks for fixing the access control ordering, but FWIW I was a little
surprised not to see a note, e.g. "[CB: changed access control
ordering]" or similar, in the metadata.

--=20
paul-moore.com

