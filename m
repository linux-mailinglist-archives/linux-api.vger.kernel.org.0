Return-Path: <linux-api+bounces-1347-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0508AF487
	for <lists+linux-api@lfdr.de>; Tue, 23 Apr 2024 18:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A7E21F26616
	for <lists+linux-api@lfdr.de>; Tue, 23 Apr 2024 16:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CEAC13D526;
	Tue, 23 Apr 2024 16:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="QPbiyC5c"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C71813D287
	for <linux-api@vger.kernel.org>; Tue, 23 Apr 2024 16:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713890706; cv=none; b=hkGbdFv4CFpWi1B+t39ccw/HL3bUdmFVwGJqGdmvGa2OPruozD5UtJB2tRddNDLkZobP23d2+K+SGU7qLYWiTupN3BEtLygnzcHauc3d/2ChuC855G9+ig8BiuMeIka6Ed3ihIegH2iS2L9hwmiX1wIs++9FyGUWync4VrTplow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713890706; c=relaxed/simple;
	bh=i+NB4eOEdWNDg9BzHPTFWjZ8Vmz5Dk3Bt6ZggFv1VGk=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=l2OqGVwslXJhM/GLOMgzwENFKV9vpr/nxD5KxkuZYXdhzvH0Iy9UgIB9LWU/eVYlpDYP8C3K6nnqWoN5DznMUyp8eyZXe/MNRQQdm8YJcJhBI+yB/jm877wTAXo2/z9yVH6Ql6JN6EHlWeRQeANyVM3jEyLpKYzNtnMl0lWb+CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=QPbiyC5c; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1e4bf0b3e06so55664915ad.1
        for <linux-api@vger.kernel.org>; Tue, 23 Apr 2024 09:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1713890704; x=1714495504; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sPjAjYNLyOr/W5Uow8fuoPqi9jTuVqit1qFTrYBLQC0=;
        b=QPbiyC5cz+b9R23nh3aSaXzciCOecrd8AwqECtmTO0Ia48IPwMSBLwCif4F5FMA/Ii
         3FnTWJ+HGG20V2u29YQ12u3IdFtk5k4iCuZ9siFp6G3ucvHemUvTJ/GeP2fX1aYS540P
         IFvpjUyl7JzecJ4o57D/Apluk1JXCFeCIDbPyEmODW90PJWizR5wZQf+PBZMkf5P9x0s
         AQD5fup82gjTbcq3V7opocsOHqChKOUp6Gh6qgIfmh43liTHks8p9VB3jRkdZhf+DloY
         kU6T6ml+e7xhZDjGRLpNk/T5m/U5jslQN2nqb1AzlGrsQeXCe0LKHCagSzF3l9YAjDXB
         q/mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713890704; x=1714495504;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sPjAjYNLyOr/W5Uow8fuoPqi9jTuVqit1qFTrYBLQC0=;
        b=v4TOkBH7JkB2gNoMFNQGkQGr1B9ZIhcDH55mG4K+WV5/EjQfQ5ylzPPBzw4awFgudh
         djhLruaoZn0mXNyfWwZSY00m5GA2M8Rm5QD4t3P57cYRGtvOZhtkcGAsIKmh9v9kWlm1
         jeJ3q6wE7yaLV8pwwIkh0ccY+K8bCvbci/PYnthuNJWUWkywLgjlS404ZVLPIh5/vUkA
         6+C0VNikSVjqwe8N4ni4I+5wNmFzaHAz1Vpq8UwYselAx1F4XV5MLYUjFv+zW/RW0Ftc
         Y9YW8cwNOyIIUyDwxi6H/ZefWIEzilWys0E58b/GJGG06eHSY1hPqeENOaCH9f4YmqoO
         B5LQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2QwHoMAZmz2/YuxNpOBI/Bjgf5gP71o5Nv2KQxIDeUT5qeFGANgryc57wQd/rOAo1Rfy60rbUYzWhS2oH4k8ot06kJVZf+I1T
X-Gm-Message-State: AOJu0YxBY8AJFBEvKWtO/BUZDX71VU8q9Ny75NeN1NpH9noWNhbD9jS1
	SO3P1zcvK90zLGCX7S+fJcJPX8v5m8WndMbkipX8ODtq/O/RQP/5Hya2dzZY2+FlmkFg0qVhL+Q
	=
X-Google-Smtp-Source: AGHT+IHnfLVV05vFXn7wb2ygCmRJcEa2gV2WCAU/7zFz67fopheRhLDhLyxMtjE32lIMnUHvzVyGRA==
X-Received: by 2002:a17:902:e843:b0:1e4:c75e:aae2 with SMTP id t3-20020a170902e84300b001e4c75eaae2mr19481727plg.59.1713890704016;
        Tue, 23 Apr 2024 09:45:04 -0700 (PDT)
Received: from smtpclient.apple ([76.14.15.177])
        by smtp.gmail.com with ESMTPSA id y4-20020a170902864400b001e49428f313sm10223458plt.261.2024.04.23.09.45.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 09:45:02 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Andy Lutomirski <luto@amacapital.net>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 0/2] implement OA2_INHERIT_CRED flag for openat2()
Date: Tue, 23 Apr 2024 09:44:50 -0700
Message-Id: <4D2A1543-273F-417F-921B-E9F994FBF2E8@amacapital.net>
References: <20240423110148.13114-1-stsp2@yandex.ru>
Cc: linux-kernel@vger.kernel.org, Stefan Metzmacher <metze@samba.org>,
 Eric Biederman <ebiederm@xmission.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Andy Lutomirski <luto@kernel.org>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>,
 Chuck Lever <chuck.lever@oracle.com>,
 Alexander Aring <alex.aring@gmail.com>, linux-fsdevel@vger.kernel.org,
 linux-api@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
In-Reply-To: <20240423110148.13114-1-stsp2@yandex.ru>
To: Stas Sergeev <stsp2@yandex.ru>
X-Mailer: iPhone Mail (21E236)


> On Apr 23, 2024, at 4:02=E2=80=AFAM, Stas Sergeev <stsp2@yandex.ru> wrote:=

>=20
> =EF=BB=BFThis patch-set implements the OA2_INHERIT_CRED flag for openat2()=
 syscall.
> It is needed to perform an open operation with the creds that were in
> effect when the dir_fd was opened. This allows the process to pre-open
> some dirs and switch eUID (and other UIDs/GIDs) to the less-privileged
> user, while still retaining the possibility to open/create files within
> the pre-opened directory set.

I like the concept, as it=E2=80=99s a sort of move toward a capability syste=
m. But I think that making a dirfd into this sort of capability would need t=
o be much more explicit. Right now, any program could do this entirely by ac=
cident, and applying OA2_INHERIT_CRED to an fd fished out of /proc seems haz=
ardous.

So perhaps if an open file description for a directory could have something l=
ike FMODE_CRED, and if OA2_INHERIT_CRED also blocked .., magic links, symlin=
ks to anywhere above the dirfd (or maybe all symlinks) and absolute path loo=
kups, then this would be okay.

Also, there are lots of ways that f_cred could be relevant: fsuid/fsgid, eff=
ective capabilities and security labels. And it gets more complex if this ev=
er gets extended to support connecting or sending to a socket or if someone o=
pens a device node.  Does CAP_SYS_ADMIN carry over?

>=20
> Changes in v2:
> - capture full struct cred instead of just fsuid/fsgid.
>  Suggested by Stefan Metzmacher <metze@samba.org>
>=20
> CC: Stefan Metzmacher <metze@samba.org>
> CC: Eric Biederman <ebiederm@xmission.com>
> CC: Alexander Viro <viro@zeniv.linux.org.uk>
> CC: Andy Lutomirski <luto@kernel.org>
> CC: Christian Brauner <brauner@kernel.org>
> CC: Jan Kara <jack@suse.cz>
> CC: Jeff Layton <jlayton@kernel.org>
> CC: Chuck Lever <chuck.lever@oracle.com>
> CC: Alexander Aring <alex.aring@gmail.com>
> CC: linux-fsdevel@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
> CC: linux-api@vger.kernel.org
> CC: Paolo Bonzini <pbonzini@redhat.com>
> CC: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>=20
> Stas Sergeev (2):
>  fs: reorganize path_openat()
>  openat2: add OA2_INHERIT_CRED flag
>=20
> fs/internal.h                |  2 +-
> fs/namei.c                   | 52 +++++++++++++++++++++++++++++-------
> fs/open.c                    |  2 +-
> include/linux/fcntl.h        |  2 ++
> include/uapi/linux/openat2.h |  3 +++
> 5 files changed, 50 insertions(+), 11 deletions(-)
>=20
> --
> 2.44.0
>=20
>=20

