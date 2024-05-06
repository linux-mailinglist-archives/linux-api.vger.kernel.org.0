Return-Path: <linux-api+bounces-1476-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 413EE8BD3D3
	for <lists+linux-api@lfdr.de>; Mon,  6 May 2024 19:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D6DFB20CEF
	for <lists+linux-api@lfdr.de>; Mon,  6 May 2024 17:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A613F15747D;
	Mon,  6 May 2024 17:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="BUPvsMWm"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D90745D9
	for <linux-api@vger.kernel.org>; Mon,  6 May 2024 17:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715016606; cv=none; b=Q9HXifeL+QEfwdiQz5MCBxo3PXUvIrnAjIt9L2xsh3009LfHgdrqNZA/brqyTe+2rAAn6HBXUTSG2iRqwbqECqJYFjhi9qW4yCgsPfEZFvmKf3rbF5dy6OvLBJAGUkDSVe6zjJ9Ma3HE5zXHFpZ2hRdRkhZwpsK4yf6ysOBP4YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715016606; c=relaxed/simple;
	bh=2m0Apzo9xFxDXw8sTML7iaX9VanueAJ0oBXUB2ncRpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D4mTiZkH3HBN+lhSBF5X8+E2ysSnVbncZXOvDqBJwJkFoPwaskUPV8zasZqqRrVo8Q4zhoVzxsVjPchIb/2+twVpvDV1cfkJpa3XoWaAlGllcBPwj6GYoyFPnqsbqc+9Xb55zNgst+TVQd98YctznCtG+j6yDF9QIL6cBQwZibI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=BUPvsMWm; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-4df32efa5baso711806e0c.2
        for <linux-api@vger.kernel.org>; Mon, 06 May 2024 10:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1715016604; x=1715621404; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cK5ZIv+/3lQIzy70C0Ibh9w+v+69s0hinhfnxG/B7mw=;
        b=BUPvsMWmCd4X2qaPPkpGLxsQXM16NTbxbaiVA2WdYwJM9ais3+u7Z+Hcw2xY4N5yJa
         lLS1yodK7osJcAbc9lGXMPUeRTG9qpf5qYRV0Bz6z4l/1G3EDkXQLwnos9ARNUcdlzm3
         ebklOdTlswwfC0tu6+fAeBHhZiCfu1Xqo1FGJLTE3geirF1iSvIhtGTkCKSDJWmqTkJP
         4C+Dnbzx/UcBYRApRz8c4fCQonZsUhcQw/9S952M+jsSs8Ayxpr3ICkWBTUdvy7VUlL+
         Ni0SiCAUQ6hS8/qN0X2A/2SjMB6TMWNg6L9Lj0Dolnf7C2r+qwWUqU/YmlRckvIGd0t0
         clHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715016604; x=1715621404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cK5ZIv+/3lQIzy70C0Ibh9w+v+69s0hinhfnxG/B7mw=;
        b=tdiCpB1ISQCHS78oZozSjziIg2E0nDmQ+wkv+GQ8fUehJMNgqkEtaYElPhAg3K/6Gs
         RVcgCfhPyl6ndPUFrftXZAh5nCgXWTb6khduFNUG4VZo3hBGpghH0HB/kEAgtfgFzfIu
         GXrOLULl08ft18Nu4m0edHxKK0h5RZyw65y0IAkf6hP2SSUNeUBL0mBGKxmmUIxQYxoP
         EFM2gx6n0Jtdo8Mq1sTFe+yDw34mfwqeVDN64LkFUD0gx0+BmKfTamggAitWP0SaXuVG
         jSqvS4UoI43dJcbKQhgPifWJX0pd/bt+Qo8sySArYGamuY5TVbLQRyOQjpr2zqPHjluJ
         eqwA==
X-Forwarded-Encrypted: i=1; AJvYcCXsnoar03WoA8RLmHZlTl39sjHPpIqUmw+MpXm3/a0cmCLKoFlFZT1Q2t99rJbLuhJlRfjSCFn23TxZr6HvS0ixoWGiFXlKAIC2
X-Gm-Message-State: AOJu0YwgHQlMweT4XjSqeBnZCAKucabRjh96+gjThETq6+rIRltR5o7j
	DPfqGPlnlplKEOtQ9ZhErmixHsznHmDja0IhIRE9P+77I3W8oMsEUIguN4wuInvgPLAVJ7Q/ugw
	8778WO4nPolnSOKkp99cRBIaOkbciWXSd3bkr
X-Google-Smtp-Source: AGHT+IEUiIcy0GOYu8BB1OirIXvX5Yu34V0OsXJvQrj6CB8J0noq/BJOsBMaSMkgqcHRU1CL2GM1OR8B88hj8PARo8U=
X-Received: by 2002:a05:6122:4105:b0:4df:235b:8ba1 with SMTP id
 ce5-20020a056122410500b004df235b8ba1mr9922482vkb.7.1715016603540; Mon, 06 May
 2024 10:30:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240426133310.1159976-1-stsp2@yandex.ru> <CALCETrUL3zXAX94CpcQYwj1omwO+=-1Li+J7Bw2kpAw4d7nsyw@mail.gmail.com>
 <20240428.171236-tangy.giblet.idle.helpline-y9LqufL7EAAV@cyphar.com>
In-Reply-To: <20240428.171236-tangy.giblet.idle.helpline-y9LqufL7EAAV@cyphar.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Mon, 6 May 2024 10:29:52 -0700
Message-ID: <CALCETrU2VwCF-o7E5sc8FN_LBs3Q-vNMBf7N4rm0PAWFRo5QWw@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] implement OA2_CRED_INHERIT flag for openat2()
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: Stas Sergeev <stsp2@yandex.ru>, "Serge E. Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org, 
	Stefan Metzmacher <metze@samba.org>, Eric Biederman <ebiederm@xmission.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, Alexander Aring <alex.aring@gmail.com>, 
	David Laight <David.Laight@aculab.com>, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	=?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Replying to a couple emails at once...

On Mon, May 6, 2024 at 12:14=E2=80=AFAM Aleksa Sarai <cyphar@cyphar.com> wr=
ote:
>
> On 2024-04-28, Andy Lutomirski <luto@amacapital.net> wrote:
> > > On Apr 26, 2024, at 6:39=E2=80=AFAM, Stas Sergeev <stsp2@yandex.ru> w=
rote:
> > > =EF=BB=BFThis patch-set implements the OA2_CRED_INHERIT flag for open=
at2() syscall.
> > > It is needed to perform an open operation with the creds that were in
> > > effect when the dir_fd was opened, if the dir was opened with O_CRED_=
ALLOW
> > > flag. This allows the process to pre-open some dirs and switch eUID
> > > (and other UIDs/GIDs) to the less-privileged user, while still retain=
ing
> > > the possibility to open/create files within the pre-opened directory =
set.
> > >
> >
> > I=E2=80=99ve been contemplating this, and I want to propose a different=
 solution.
> >
> > First, the problem Stas is solving is quite narrow and doesn=E2=80=99t
> > actually need kernel support: if I want to write a user program that
> > sandboxes itself, I have at least three solutions already.  I can make
> > a userns and a mountns; I can use landlock; and I can have a separate
> > process that brokers filesystem access using SCM_RIGHTS.
> >
> > But what if I want to run a container, where the container can access
> > a specific host directory, and the contained application is not aware
> > of the exact technology being used?  I recently started using
> > containers in anger in a production setting, and =E2=80=9Canger=E2=80=
=9D was
> > definitely the right word: binding part of a filesystem in is
> > *miserable*.  Getting the DAC rules right is nasty.  LSMs are worse.
> > Podman=E2=80=99s =E2=80=9Cbind,relabel=E2=80=9D feature is IMO utterly =
disgusting.  I think I
> > actually gave up on making one of my use cases work on a Fedora
> > system.
> >
> > Here=E2=80=99s what I wanted to do, logically, in production: pick a ho=
st
> > directory, pick a host *principal* (UID, GID, label, etc), and have
> > the *entire container* access the directory as that principal. This is
> > what happens automatically if I run the whole container as a userns
> > with only a single UID mapped, but I don=E2=80=99t really want to do th=
at for
> > a whole variety and of reasons.
> >
> > So maybe reimagining Stas=E2=80=99 feature a bit can actually solve thi=
s
> > problem.  Instead of a special dirfd, what if there was a special
> > subtree (in the sense of open_tree) that captures a set of creds and
> > does all opens inside the subtree using those creds?
> >
> > This isn=E2=80=99t a fully formed proposal, but I *think* it should be
> > generally fairly safe for even an unprivileged user to clone a subtree
> > with a specific flag set to do this. Maybe a capability would be
> > needed (CAP_CAPTURE_CREDS?), but it would be nice to allow delegating
> > this to a daemon if a privilege is needed, and getting the API right
> > might be a bit tricky.
>
> Tying this to an actual mount rather than a file handle sounds like a
> more plausible proposal than OA2_CRED_INHERIT, but it just seems that
> this is going to re-create all of the work that went into id-mapped
> mounts but with the extra-special step of making the generic VFS
> permissions no longer work normally (unless the idea is that everything
> would pretend to be owned by current_fsuid()?).

I was assuming that the owner uid and gid would be show to stat, etc
as usual.  But the permission checks would be done against the
captured creds.

>
> IMHO it also isn't enough to just make open work, you need to make all
> operations work (which leads to a non-trivial amount of
> filesystem-specific handling), which is just idmapped mounts. A lot of
> work was put into making sure that is safe, and collapsing owners seems
> like it will cause a lot of headaches.
>
> I also find it somewhat amusing that this proposal is to basically give
> up on multi-user permissions for this one directory tree because it's
> too annoying to deal with. In that case, isn't chmod 777 a simpler
> solution? (I'm being a bit flippant, of course there is a difference,
> but the net result is that all users in the container would have the
> same permissions with all of the fun issues that implies.)
>
> In short, AFAICS idmapped mounts pretty much solve this problem (minus
> the ability to collapse users, which I suspect is not a good idea in
> general)?
>

With my kernel hat on, maybe I agree.  But with my *user* hat on, I
think I pretty strongly disagree.  Look, idmapis lousy for
unprivileged use:

$ install -m 0700 -d test_directory
$ echo 'hi there' >test_directory/file
$ podman run -it --rm
--mount=3Dtype=3Dbind,src=3Dtest_directory,dst=3D/tmp,idmap [debian-slim]
# cat /tmp/file
hi there

<-- Hey, look, this kind of works!

# setpriv --reuid=3D1 ls /tmp
ls: cannot open directory '/tmp': Permission denied

<-- Gee, thanks, Linux!


Obviously this is a made up example.  But it's quite analogous to a
real example.  Suppose I want to make a directory that will contain
some MySQL data.  I don't want to share this directory with anyone
else, so I set its mode to 0700.  Then I want to fire up an
unprivileged MySQL container, so I build or download it, and then I
run it and bind my directory to /var/lib/mysql and I run it.  I don't
need to think about UIDs or anything because it's 2024 and containers
just work.  Okay, I need to setenforce 0 because I'm on Fedora and
SELinux makes absolutely no sense in a container world, but I can live
with that.

Except that it doesn't work!  Because unless I want to manually futz
with the idmaps to get mysql to have access to the directory inside
the container, only *root* gets to get in.  But I bet that even
futzing with the idmap doesn't work, because software like mysql often
expects that root *and* a user can access data.  And some software
even does privilege separation and uses more than one UID.

So I want a way to give *an entire container* access to a directory.
Classic UNIX DAC is just *wrong* for this use case.  Maybe idmaps
could learn a way to squash multiple ids down to one.  Or maybe
something like my silly credential-capturing mount proposal could
work.  But the status quo is not actually amazing IMO.

I haven't looked at the idmap implementation nearly enough to have any
opinion as to whether squashing UID is practical or whether there's
any sensible way to specify it in the configuration.

> On Apr 29, 2024, at 2:12=E2=80=AFAM, Christian Brauner <brauner@kernel.or=
g> wrote:
>
> Nowadays it's extremely simple due tue open_tree(OPEN_TREE_CLONE) and
> move_mount(). I rewrote the bind-mount logic in systemd based on that
> and util-linux uses that as well now.
> https://brauner.io/2023/02/28/mounting-into-mount-namespaces.html
>

Yep, I remember that.

>> Podman=E2=80=99s =E2=80=9Cbind,relabel=E2=80=9D feature is IMO utterly d=
isgusting.  I think I
>> actually gave up on making one of my use cases work on a Fedora
>> system.
>>
>> Here=E2=80=99s what I wanted to do, logically, in production: pick a hos=
t
>> directory, pick a host *principal* (UID, GID, label, etc), and have
>> the *entire container* access the directory as that principal. This is
>> what happens automatically if I run the whole container as a userns
>> with only a single UID mapped, but I don=E2=80=99t really want to do tha=
t for
>> a whole variety and of reasons.
>
> You're describing idmapped mounts for the most part which are upstream
> and are used in exactly that way by a lot of userspace.
>

See above...

>>
>> So maybe reimagining Stas=E2=80=99 feature a bit can actually solve this
>> problem.  Instead of a special dirfd, what if there was a special
>> subtree (in the sense of open_tree) that captures a set of creds and
>> does all opens inside the subtree using those creds?
>
> That would mean override creds in the VFS layer when accessing a
> specific subtree which is a terrible idea imho. Not just because it will
> quickly become a potential dos when you do that with a lot of subtrees
> it will also have complex interactions with overlayfs.

I was deliberately talking about semantics, not implementation. This
may well be impossible to implement straightforwardly.

