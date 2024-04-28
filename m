Return-Path: <linux-api+bounces-1417-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 331D08B4CD3
	for <lists+linux-api@lfdr.de>; Sun, 28 Apr 2024 18:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD92D1F2164E
	for <lists+linux-api@lfdr.de>; Sun, 28 Apr 2024 16:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10EFA73189;
	Sun, 28 Apr 2024 16:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="NW6/8fqJ"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612A573165
	for <linux-api@vger.kernel.org>; Sun, 28 Apr 2024 16:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714322494; cv=none; b=Z4E73rj/27885VxksjPQccjaq8m2fJ68UkQcv10iiQrMAWXX+6jGicOwo+qQ/jTEo5ruXzKinOBxATob5/aWZZwexIUj3+gm+TiOCPykN/V0qtpzBRFR3khTnmljyM/LwSmLOUUM0ZR/qZni4YKI0YHu8E8hl85mmzhsiTBW28w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714322494; c=relaxed/simple;
	bh=e9kozUVYrHIwrCQGcfpV/ZYobiatodQ1z9SiykSi/TI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J73xYDNMdohcUlz91J9ZSOn5ia/LIRsoYZDhOndcoFiRk4rx6XTw0U3vcZbX82cXRjQX8O+O/iZwv5lL3/kiiCwuAO5MhMG9JCUW/HvLplNux48VX6x0FUBFH93FS+/FoFUwh3ch1PDsG4jZTSaK7muFPa1h0WGDg0u4L68T1kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=NW6/8fqJ; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-4affeacaff9so804707e0c.3
        for <linux-api@vger.kernel.org>; Sun, 28 Apr 2024 09:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1714322491; x=1714927291; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=34jZPs9Eiu4Qw7ZtmIIlooQKHvZkQc1XBH5UVUDjhOE=;
        b=NW6/8fqJ+KdO/DzZrbNCTHib82w9uzAfVxzbzF5B174BLRoEJo1OlmWTErs4rBQI1Z
         r00CQkONj79FwD5v3l1P2uOvR3yX4Tbo79HOZw1svG64XX7ksPBYy7E4HlsQb2xJG6QT
         BnkLBfFkT9qz3L6gM3Rb6YN9BQjWQof4fCOnR9DloKu7i0fBMKV+cbCiOGQbjaIO+6oF
         4VLTPAkYRktWEJmAHsJUOg1mS2scXHK1k/kr2lDgRkHbjfyBY/sTKrZjNw1eYOe36Oej
         PhcMckUbpvccKIUrq1v08nnAt5jFpYfnABQr3IOLxePNRj1mzC34SUPxgK+KWOvAQlXS
         M38g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714322491; x=1714927291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=34jZPs9Eiu4Qw7ZtmIIlooQKHvZkQc1XBH5UVUDjhOE=;
        b=vYQvS7eArta5GFW0lxQM1y0eszz/qeufTQTdr+IOpD40XUN/Th6TDkCHyCbvVHqANL
         zVQ+bzN4P5k68TSQqkXQcbQE3YLFZv7lvc55zPvpfE/5G8lkX7D846IIWBXBRb/KJK4P
         TWnY1c3RUoEwxIS+57u4jzMzoC6em4GdOxL2gFzlzE73W/f+m6axRVWELyK2vUGCK1pZ
         ta70MmHhEqO27tWgr14BmTPznnEGrxgCN1SlmfxKlEvuRk5qERoj6qe5ZBAufEzAOSlN
         ZEL3C/ECoKKV19087yz1kV4ybTig2jMUUjJjmlZaQ6AHXhFofZfaJvPstHP53zdAzj4j
         FuOQ==
X-Forwarded-Encrypted: i=1; AJvYcCViAnIvTwtWaN7ivJ06HhRPPKgtaTze88vu0PR7Z0NJWQRQyQ1aVbLY9pdyHFaus56YXb78VyJGwBR9/zAZp9gThW64crsG6csd
X-Gm-Message-State: AOJu0YzgeO1irCWZR4d6TmVOvam24uw9UVwSZXDLx2UikIvgNn6XbQhJ
	2QY2YAt4Q+U56JfwKeUiGZUxsVrx9MGbYE/7FJ6uYAyOlbq/kUK1uE8r8RQlBfCtHlDz+cscd9x
	YfBROlOq0/wHoGu7ySCzu2fOhxOmbC18vvQs7
X-Google-Smtp-Source: AGHT+IHLdpt/9XWo4+d0fq5u+aGoe2Xweu2bbEMtHa8Q4gbQxrfJ/vnch45Ynf8rpTHz6dgnxhOkWQ1+y1wLqy+FQw8=
X-Received: by 2002:a05:6122:251e:b0:4da:704f:7fc6 with SMTP id
 cl30-20020a056122251e00b004da704f7fc6mr8248281vkb.15.1714322491304; Sun, 28
 Apr 2024 09:41:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240426133310.1159976-1-stsp2@yandex.ru>
In-Reply-To: <20240426133310.1159976-1-stsp2@yandex.ru>
From: Andy Lutomirski <luto@amacapital.net>
Date: Sun, 28 Apr 2024 09:41:20 -0700
Message-ID: <CALCETrUL3zXAX94CpcQYwj1omwO+=-1Li+J7Bw2kpAw4d7nsyw@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] implement OA2_CRED_INHERIT flag for openat2()
To: Stas Sergeev <stsp2@yandex.ru>, Aleksa Sarai <cyphar@cyphar.com>, 
	"Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-kernel@vger.kernel.org, Stefan Metzmacher <metze@samba.org>, 
	Eric Biederman <ebiederm@xmission.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Andy Lutomirski <luto@kernel.org>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Alexander Aring <alex.aring@gmail.com>, David Laight <David.Laight@aculab.com>, 
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> On Apr 26, 2024, at 6:39=E2=80=AFAM, Stas Sergeev <stsp2@yandex.ru> wrote=
:
> =EF=BB=BFThis patch-set implements the OA2_CRED_INHERIT flag for openat2(=
) syscall.
> It is needed to perform an open operation with the creds that were in
> effect when the dir_fd was opened, if the dir was opened with O_CRED_ALLO=
W
> flag. This allows the process to pre-open some dirs and switch eUID
> (and other UIDs/GIDs) to the less-privileged user, while still retaining
> the possibility to open/create files within the pre-opened directory set.
>

I=E2=80=99ve been contemplating this, and I want to propose a different sol=
ution.

First, the problem Stas is solving is quite narrow and doesn=E2=80=99t
actually need kernel support: if I want to write a user program that
sandboxes itself, I have at least three solutions already.  I can make
a userns and a mountns; I can use landlock; and I can have a separate
process that brokers filesystem access using SCM_RIGHTS.

But what if I want to run a container, where the container can access
a specific host directory, and the contained application is not aware
of the exact technology being used?  I recently started using
containers in anger in a production setting, and =E2=80=9Canger=E2=80=9D wa=
s
definitely the right word: binding part of a filesystem in is
*miserable*.  Getting the DAC rules right is nasty.  LSMs are worse.
Podman=E2=80=99s =E2=80=9Cbind,relabel=E2=80=9D feature is IMO utterly disg=
usting.  I think I
actually gave up on making one of my use cases work on a Fedora
system.

Here=E2=80=99s what I wanted to do, logically, in production: pick a host
directory, pick a host *principal* (UID, GID, label, etc), and have
the *entire container* access the directory as that principal. This is
what happens automatically if I run the whole container as a userns
with only a single UID mapped, but I don=E2=80=99t really want to do that f=
or
a whole variety and of reasons.

So maybe reimagining Stas=E2=80=99 feature a bit can actually solve this
problem.  Instead of a special dirfd, what if there was a special
subtree (in the sense of open_tree) that captures a set of creds and
does all opens inside the subtree using those creds?

This isn=E2=80=99t a fully formed proposal, but I *think* it should be
generally fairly safe for even an unprivileged user to clone a subtree
with a specific flag set to do this. Maybe a capability would be
needed (CAP_CAPTURE_CREDS?), but it would be nice to allow delegating
this to a daemon if a privilege is needed, and getting the API right
might be a bit tricky.

Then two different things could be done:

1. The subtree could be used unmounted or via /proc magic links. This
would be for programs that are aware of this interface.

2. The subtree could be mounted, and accessed through the mount would
use the captured creds.

(Hmm. What would a new open_tree() pointing at this special subtree do?)


With all this done, if userspace wired it up, a container user could
do something like:

=E2=80=94bind-capture-creds source=3Ddest

And the contained program would access source *as the user who started
the container*, and this would just work without relabeling or
fiddling with owner uids or gids or ACLs, and it would continue to
work even if the container has multiple dynamically allocated subuids
mapped (e.g. one for =E2=80=9Croot=E2=80=9D and one for the actual applicat=
ion).

Bonus points for the ability to revoke the creds in an already opened
subtree. Or even for the creds to automatically revoke themselves when
the opener exits (or maybe when a specific cred-pinning fd goes away).

(This should work for single files as well as for directories.)

New LSM hooks or extensions of existing hooks might be needed to make
LSMs comfortable with this.

What do you all think?

