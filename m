Return-Path: <linux-api+bounces-1501-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D34508C031D
	for <lists+linux-api@lfdr.de>; Wed,  8 May 2024 19:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B1241F22E02
	for <lists+linux-api@lfdr.de>; Wed,  8 May 2024 17:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E0D12B158;
	Wed,  8 May 2024 17:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="EKOYCDkY"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9859200DD
	for <linux-api@vger.kernel.org>; Wed,  8 May 2024 17:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715189466; cv=none; b=jg4+/C3zhskIXDrgh5M8S3qvZP7JNZxYHR13wsQXbmAFYNH5Lb47KCbYDpEKDCnwVHoHV5qx1eSLETEV/9iBHMJ2nUnKSTK/JyiqHEEbBTaXQhQ+x6rf6GhLEMA4nibgwFkAOSIGWNHMwjoUT3Mf+yw0GQG5NHmZzVxXychPkbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715189466; c=relaxed/simple;
	bh=OfwDpxyqiScR6zhprUMGR6XwrzsPF5VBLMLxJ9wu2Qg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fp7WrEIWUtMmdXwY8J5SXPiBlcL2NtGCHrHcWpjQ7OP1hwQXIOlZ1RlxAxMu5ez9yVGx/uuCMpsZ1PW8iBQvPQgfLvNCQ/5FVvU2kRsq1sItC/H8VmZTcMfNt5Xaog8bPKgu92MK4A7co0GL5rZ+Hrx22mwtPWiAtzuU63zApLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=EKOYCDkY; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-4df3d1076b0so8017e0c.1
        for <linux-api@vger.kernel.org>; Wed, 08 May 2024 10:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1715189462; x=1715794262; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XYHNs3XK4WCLJlrYLVcrMhCbS8TVZdO8Yn1TsyzQ25I=;
        b=EKOYCDkYR+0VZlZnP34FuwtcEeQ2YqX8kRDMpHemSBkoBEgX9WrxFa7kNjICDqLSNU
         hOk7mrxTE8k6Ye7b2S7LoQ8Ouxbm6By30LW2qsv6/lHUN6fyOXBJopCUXFAsRDaR4EZC
         aQe9CQeJSJyHUTh2Po+BqxotfkItlGiGWvX2QPZcyRVVx81mlUzmgcehf7lfcq96bUAc
         H90aEc0566xWH/h0Bjare+mYhRtzVXOHc6Kjl17PyRr4kmlYgayiY2+hNEzskQQuppKW
         wLms70D7PlgzmptN4dj4yL1kFT65vjRtutupPl6bG0GBnqJn1PTC/slhd9YB9f+M3cyr
         EUUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715189462; x=1715794262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XYHNs3XK4WCLJlrYLVcrMhCbS8TVZdO8Yn1TsyzQ25I=;
        b=qI9gubDB05k7mAzfBD+9+7IKiSRLrUcHpcrhxj9OIHU0kuk+hXNprj7bIrSdkyjomX
         CMxrHEcpOsvIlLz+uB6M2nTIpc4eIl16vayk6H+P3tegzFuMakOuSaupU0/QS3YaOGUc
         mYr6qF3UIPiSJCo71BE0BXn6vMufsu3bvhyyJ30wK2m6MC0NUHSowHS0xqLwOF3hKrRD
         uKiC4Y14/+ZfPN2qdoITQee1v6N/auOTfUcVW1kvRFNq35WvDiWDCpbhMF4esKS57Lca
         Z6tJHsqDqzcKA3C3zWpNPYY1WOiQ0swhGOshmzRVp7Rwx42vtM5Ra8hNXKcy2xcH0u0L
         OvBA==
X-Forwarded-Encrypted: i=1; AJvYcCXE0aHCcXSaK8I3gptNMiCFYbWDfD2vtvddR0ZNS342wZICfK1WdfmtiZU2Ns1Oz+C6vYXf5ZVrsf/KaK23ny2wYBcabso7i7ap
X-Gm-Message-State: AOJu0YwUHJXeFR2GRUVehT1Dg7xKrfICj4hTp258qbNjWa/Doy2LYKgS
	Ry1rvDDFxiBcBljOA1FCi1csPBj6oYfvldEnkNm/iin8UzYBJF1gblzQYuW2RlHZ3m0zsPJykSf
	8BHnSOtAZNLcirBEW2J8OUJmXXx6zmRXTKMlc
X-Google-Smtp-Source: AGHT+IHbsrHY0xfhpaS6MiO5kI6jtwoEYY+goIDARLemeQWPf0CECxDmXAYt4b8xzd2tMYkNUCL0wQWtWqEeqJGtRe0=
X-Received: by 2002:a05:6122:2a50:b0:4dc:d7b4:5f7d with SMTP id
 71dfb90a1353d-4df6919da63mr3417762e0c.8.1715189462609; Wed, 08 May 2024
 10:31:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240426133310.1159976-1-stsp2@yandex.ru> <CALCETrUL3zXAX94CpcQYwj1omwO+=-1Li+J7Bw2kpAw4d7nsyw@mail.gmail.com>
 <20240428.171236-tangy.giblet.idle.helpline-y9LqufL7EAAV@cyphar.com>
 <CALCETrU2VwCF-o7E5sc8FN_LBs3Q-vNMBf7N4rm0PAWFRo5QWw@mail.gmail.com>
 <20240507-verpennen-defekt-b6f2c9a46916@brauner> <CALCETrWuVQ-ggnak40AX16PUnM43zhogceFN-3c_YAKZGvs5Og@mail.gmail.com>
 <20240508-flugverbindung-sonnig-dcfa4971152e@brauner>
In-Reply-To: <20240508-flugverbindung-sonnig-dcfa4971152e@brauner>
From: Andy Lutomirski <luto@amacapital.net>
Date: Wed, 8 May 2024 10:30:50 -0700
Message-ID: <CALCETrWEBY6HLyRqgN65YVp0gP0akU_HyVbGctC6sph5NX6RkQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] implement OA2_CRED_INHERIT flag for openat2()
To: Christian Brauner <brauner@kernel.org>
Cc: Aleksa Sarai <cyphar@cyphar.com>, Stas Sergeev <stsp2@yandex.ru>, 
	"Serge E. Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org, 
	Stefan Metzmacher <metze@samba.org>, Eric Biederman <ebiederm@xmission.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Jan Kara <jack@suse.cz>, 
	Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Alexander Aring <alex.aring@gmail.com>, David Laight <David.Laight@aculab.com>, 
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 8, 2024 at 12:32=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Tue, May 07, 2024 at 01:38:42PM -0700, Andy Lutomirski wrote:
> > On Tue, May 7, 2024 at 12:42=E2=80=AFAM Christian Brauner <brauner@kern=
el.org> wrote:
> > >
> > > > With my kernel hat on, maybe I agree.  But with my *user* hat on, I
> > > > think I pretty strongly disagree.  Look, idmapis lousy for
> > > > unprivileged use:
> > > >
> > > > $ install -m 0700 -d test_directory
> > > > $ echo 'hi there' >test_directory/file
> > > > $ podman run -it --rm
> > > > --mount=3Dtype=3Dbind,src=3Dtest_directory,dst=3D/tmp,idmap [debian=
-slim]
> > >
> > > $ podman run -it --rm --mount=3Dtype=3Dbind,src=3Dtest_directory,dst=
=3D/tmp,idmap [debian-slim]
> > >
> > > as an unprivileged user doesn't use idmapped mounts at all. So I'm no=
t
> > > sure what this is showing. I suppose you're talking about idmaps in
> > > general.
> >
> > Meh, fair enough.  But I don't think this would have worked any better
> > with privilege.
> >
> > Can idmaps be programmed by an otherwise unprivileged owner of a
> > userns and a mountns inside?
>
> Yes, but only for userns mountable filesystems that support idmapped
> mounts. IOW, you need privilege over the superblock and the idmapping
> you're trying to use.

Hmm.  Is there a good reason to require privilege over the superblock?
 Obviously creating an idmap that allows one to impersonate someone
else seems like a problem, but if an unprivileged task already "owns"
(see below) a UID or GID, then effectively delegating that UID or GID
is would need caution but is not fundamentally terrible.

So, if I'm 1000:1000, then creating an idmap that makes some other
task (that isn't 1000:1000) get to act as 1000:1000 doesn't grant new
powers.  But maybe something even more general could be done (although
I'm not sure this is worthwhile): if I own a userns and that userns
has an outside UID 1001 mapped (via newuidmap, for example), then
perhaps letting me configure an idmap that grants UID 1001 seems not
especially dangerous.  But maybe that particular job should also be
delegated to newuidmap.

Out of an abundance of caution, maybe this whole thing should be
opt-in.  For example, there could be a new CAP_DELEGATE that allows
delegation of one's own uid and gid.  The idea is that it should be
safe to grant regular users CAP_DELEGATE as an ambient capability.

--Andy

