Return-Path: <linux-api+bounces-1479-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7735A8BD704
	for <lists+linux-api@lfdr.de>; Mon,  6 May 2024 23:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33681283F1A
	for <lists+linux-api@lfdr.de>; Mon,  6 May 2024 21:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C78215CD49;
	Mon,  6 May 2024 21:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="b9etqhUY"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA5A15B993
	for <linux-api@vger.kernel.org>; Mon,  6 May 2024 21:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715032417; cv=none; b=grzx6gcTwolI2bBW5D+Kcslmtd6xUEUI2KDO8J17wpaLAEKpjIAv8KzCT4kXGvX+bg/AvAQZrtn5PE12Q3bWIDrS9R0murgmfRYTKBpsY0t0YM3qFZ8n6ORJa1dm/FPllW08G3UTbNHT8ZIid2UFhuzNvlhAfCW/bsmqaZOFc18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715032417; c=relaxed/simple;
	bh=6z2N8CtrbVaimdDtZ0PAq6tAC1qn5J+ZvkytA5tacSE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sGqFgS33UWjcC26reFrw1NJoh+npZgtEZUA7zEH2OpnUjbsmCs5GKGBovrmOPzym6rC0y+t613UdtbC5Fj1bNR4OAZpYRPKsyX96aMUVbf+SsFt+ND+nc37lX/MGU02YA7zOEFEQNDDRkhaYWRpgUhALIru9zjdONyrzewfw22c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=b9etqhUY; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-4df3f7b93a7so346863e0c.1
        for <linux-api@vger.kernel.org>; Mon, 06 May 2024 14:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1715032414; x=1715637214; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EeUVpQq/22mOYcKReCK3JqvU1k/TRLUaHjaQZvRF2NE=;
        b=b9etqhUYq9W3jFOnartK2afBDMImdFDpjRaatf2DWlTDDyA1xcnQQiz2LkJVHLs8tW
         jYQN4mbotk1z7KLgDVp2dWsxEFKpyfbOiLsbJwmNH8r/wntd4XEujLjyfukjD/Ul/JyY
         vgdXTZkzFtiQG+/Ion8mI6XwrnvxIXUty0M81dND19jr5ybsPPqaVwETQVoi+ZP/DCC2
         Ij53kotdedrRJV/iWAoHodKJwpds5Jpe/nSm7J36zT9oGg1lwPI+pPtjZkZroUJdtLW1
         A+i/CiJrrX+OmHQ+yiQw/p3d97+aFCmWvJgeFGziFD69DQJkD0XA5ZDH3KqLB71+lQWt
         Fzog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715032414; x=1715637214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EeUVpQq/22mOYcKReCK3JqvU1k/TRLUaHjaQZvRF2NE=;
        b=OTjovU8CDrxwiNa/gDG0e/6N3mCj8ofuj3hqVzQw1a0iFjIjIKwy0iL+feqQyweCf/
         4Jh55XBC/ychADYlU3O+qzbGpVKgDwcx+mKP4z9R+1xq5Qp/vX2RG23HNUnti7pUCpBK
         nJQC2fCZRopua57UvvxnFuWPNnWGL+JXtASj8G2dtJXLmrD5DefK/eyq6D6Pz5D/2CiU
         m8IWtgtKdPrJgSp15KFifWRsvYMddZNh+qLNw+5J6aTL0f3hspklkDhQ1Nym0XX2kCiT
         f6MwE5eE5ODCTXgqoEsCok3lafxS2cCj7hCAyImb0vKyoyGizxEuFuQRORnvkI0yxNx0
         60tQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTVXimd/4H2MytM1UZf/e2+HwhCc8CALAGPCKih55FrEFzN/tyzHPU11oqeJy9mcp0Q6I5TBIkBfRQ09NFNm9Cb0y9Mb0/OKlK
X-Gm-Message-State: AOJu0YxQhL4qzkYxOZpmy/14x+4GwtMzIG95oo0X72eTC2av/EAlaB6Z
	GtpeKB9wSZedsQ0LLeSYyoyd5ZrsTxpMGO3iDrta+EV5/snL7fq01X/vLB5vJQmWJs5JN74ezRT
	xwH597jnMO4aoO3tg4U26ifQLvnEt6wBBB+HN
X-Google-Smtp-Source: AGHT+IFFGjpc6gurEzgN72E+Wq4iiRoXg5mY38Fpox/mXhnM3mo9+hh8ShKzv7M/jZm4iGVJuVAQTPuxzjnTjoN24H8=
X-Received: by 2002:a05:6122:3089:b0:4da:9d3e:a7df with SMTP id
 cd9-20020a056122308900b004da9d3ea7dfmr11204998vkb.5.1715032414464; Mon, 06
 May 2024 14:53:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240426133310.1159976-1-stsp2@yandex.ru> <CALCETrUL3zXAX94CpcQYwj1omwO+=-1Li+J7Bw2kpAw4d7nsyw@mail.gmail.com>
 <20240428.171236-tangy.giblet.idle.helpline-y9LqufL7EAAV@cyphar.com>
 <CALCETrU2VwCF-o7E5sc8FN_LBs3Q-vNMBf7N4rm0PAWFRo5QWw@mail.gmail.com> <f8fafe1953ed41828a4c98187964477b@AcuMS.aculab.com>
In-Reply-To: <f8fafe1953ed41828a4c98187964477b@AcuMS.aculab.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Mon, 6 May 2024 14:53:23 -0700
Message-ID: <CALCETrXU+F3cHR+RMvvypCPP3pBZK3WkS5sSEVqLp1rjK8yMpQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] implement OA2_CRED_INHERIT flag for openat2()
To: David Laight <David.Laight@aculab.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>, Stas Sergeev <stsp2@yandex.ru>, 
	"Serge E. Hallyn" <serge@hallyn.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Stefan Metzmacher <metze@samba.org>, 
	Eric Biederman <ebiederm@xmission.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Andy Lutomirski <luto@kernel.org>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Alexander Aring <alex.aring@gmail.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	=?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 6, 2024 at 12:35=E2=80=AFPM David Laight <David.Laight@aculab.c=
om> wrote:
>
> ...
> > So I want a way to give *an entire container* access to a directory.
> > Classic UNIX DAC is just *wrong* for this use case.  Maybe idmaps
> > could learn a way to squash multiple ids down to one.  Or maybe
> > something like my silly credential-capturing mount proposal could
> > work.  But the status quo is not actually amazing IMO.
>
> Isn't that what gids are for :-)

I dunno.  How, exactly, is a regular non-root user of a Linux computer
supposed to configure gids in their home directory so that a container
(which uses subgids, possibly dynamically allocated) gets access to
the correct thing?  And why should that poor user need to think about
this at all?

--Andy

