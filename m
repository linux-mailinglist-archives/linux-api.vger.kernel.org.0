Return-Path: <linux-api+bounces-4638-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 200D5B39018
	for <lists+linux-api@lfdr.de>; Thu, 28 Aug 2025 02:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A301C9808C8
	for <lists+linux-api@lfdr.de>; Thu, 28 Aug 2025 00:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8DD1B4F08;
	Thu, 28 Aug 2025 00:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EA8XhiSf"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38150189B80
	for <linux-api@vger.kernel.org>; Thu, 28 Aug 2025 00:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756341136; cv=none; b=tSIN09EZcoKGp7TDpoJc/iTdc3be7NQgmBHOLLo3dSm4EMbv/3mzIxdMkzyPhPu0sXomMP5cCq47duJDkWo8Nv1lL62uxXIx6o48jD8iEh1LAps9x6XxBZgycfoF/ulF99X560lWkhvjzo2ISBmKl46WgiUhZnel9eNkvJ5PUQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756341136; c=relaxed/simple;
	bh=yFq2/idFtNoKxfqONa3lFVunxo2YTbhdRw8i4j3V+8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=huf2+95XNZtmcGvnKx5VA0yag2YtNyovi3sHtCVFVYF+NDIlsRppU2GCOcz8wInhuKQaxXeAH2lcNUbz/ccf2xUB1FZNo3ReNIrJ3x0tvOB5rpa46B2n3oiBKLr+DLgRCqT/hSoFswYNPMgFBKGu5FyjzKh6e7dPd+FlulVZ31E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EA8XhiSf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D38CAC116B1
	for <linux-api@vger.kernel.org>; Thu, 28 Aug 2025 00:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756341135;
	bh=yFq2/idFtNoKxfqONa3lFVunxo2YTbhdRw8i4j3V+8g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EA8XhiSf/lo2qcM2h4VuqYyTStml9z3qYv9HADb/U0c8W0v7mkhdd9EmrTXJaUY0C
	 WiRRZPSsrxSSvoKGfxZZyfgINy5UU5Jqln/hlmNNYNk5N6qqhuhEtCVc38/ttNbEPR
	 iKbnBwF/i7CLj9viqyizkL5uCxk32UTrNpikYG1DmWGNy9RiyFgU25aDGP65NTsmZ6
	 B22pHDsEMSBmrDfGCorUM3pSKq+VOrqTFePxai/RgDhFPiEo/WGp96rWAnMi0HLOqn
	 /LVdU36a2hdmfxMbU7lgExYaeM+MGyB/TNMrmUfjcJc28HA+Nm02elsX8zANSShoOl
	 5BYQNjv/Ak+mw==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-55f527db6f6so490981e87.2
        for <linux-api@vger.kernel.org>; Wed, 27 Aug 2025 17:32:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUmXTNBVFji/X/wBWlY43Pos4S1S7dcAdSTsHmWcriKwUfSeDij1IFxIjq3cJpc7GbnYAIeRKRvdOs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhrYRiDNGknxl4RHiocuEMwBSd/LBO67MQe7yOkdBVBgmIJVkn
	0NPLKQkebFAnfuvQv/foMFWM8epv85qw3YrdmDc6KK45w6UWv0Ry9lT6fn5kwSvu9Vr9uK5MnMZ
	U64zIfb6zvX5IoBSXnq2D16qsjVUjceq673+3La4q
X-Google-Smtp-Source: AGHT+IFBs4E/ufqmFInmmCfp8Nwce44WjgaXqekpIOhAHuwl87Hc2TiTY2CPCDgnPsJSmqV5fcG8a1TMiCPT2sNMeO0=
X-Received: by 2002:a05:6512:258d:b0:55f:596f:2ec4 with SMTP id
 2adb3069b0e04-55f596f3039mr681952e87.23.1756341133959; Wed, 27 Aug 2025
 17:32:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822170800.2116980-1-mic@digikod.net> <20250826-skorpion-magma-141496988fdc@brauner>
 <20250826.aig5aiShunga@digikod.net> <2025-08-27-obscene-great-toy-diary-X1gVRV@cyphar.com>
In-Reply-To: <2025-08-27-obscene-great-toy-diary-X1gVRV@cyphar.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Wed, 27 Aug 2025 17:32:02 -0700
X-Gmail-Original-Message-ID: <CALCETrWHKga33bvzUHnd-mRQUeNXTtXSS8Y8+40d5bxv-CqBhw@mail.gmail.com>
X-Gm-Features: Ac12FXxg-YalsCfcTcpKiyudyQQfe_FOt5x1XpJ9sIiByXo4by4N2XquUDNMVBc
Message-ID: <CALCETrWHKga33bvzUHnd-mRQUeNXTtXSS8Y8+40d5bxv-CqBhw@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/2] Add O_DENY_WRITE (complement AT_EXECVE_CHECK)
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Kees Cook <keescook@chromium.org>, Paul Moore <paul@paul-moore.com>, 
	Serge Hallyn <serge@hallyn.com>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Christian Heimes <christian@python.org>, Dmitry Vyukov <dvyukov@google.com>, 
	Elliott Hughes <enh@google.com>, Fan Wu <wufan@linux.microsoft.com>, 
	Florian Weimer <fweimer@redhat.com>, Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Jordan R Abrahams <ajordanr@google.com>, 
	Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, Luca Boccassi <bluca@debian.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Miklos Szeredi <mszeredi@redhat.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, Robert Waite <rowait@microsoft.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Scott Shell <scottsh@microsoft.com>, 
	Steve Dower <steve.dower@python.org>, Steve Grubb <sgrubb@redhat.com>, 
	kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 5:14=E2=80=AFPM Aleksa Sarai <cyphar@cyphar.com> wr=
ote:
>
> On 2025-08-26, Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> wrote:
> > On Tue, Aug 26, 2025 at 11:07:03AM +0200, Christian Brauner wrote:
> > > Nothing has changed in that regard and I'm not interested in stuffing
> > > the VFS APIs full of special-purpose behavior to work around the fact
> > > that this is work that needs to be done in userspace. Change the apps=
,
> > > stop pushing more and more cruft into the VFS that has no business
> > > there.
> >
> > It would be interesting to know how to patch user space to get the same
> > guarantees...  Do you think I would propose a kernel patch otherwise?
>
> You could mmap the script file with MAP_PRIVATE. This is the *actual*
> protection the kernel uses against overwriting binaries (yes, ETXTBSY is
> nice but IIRC there are ways to get around it anyway).

Wait, really?  MAP_PRIVATE prevents writes to the mapping from
affecting the file, but I don't think that writes to the file will
break the MAP_PRIVATE CoW if it's not already broken.

IPython says:

In [1]: import mmap, tempfile

In [2]: f =3D tempfile.TemporaryFile()

In [3]: f.write(b'initial contents')
Out[3]: 16

In [4]: f.flush()

In [5]: map =3D mmap.mmap(f.fileno(), f.tell(), flags=3Dmmap.MAP_PRIVATE,
prot=3Dmmap.PROT_READ)

In [6]: map[:]
Out[6]: b'initial contents'

In [7]: f.seek(0)
Out[7]: 0

In [8]: f.write(b'changed')
Out[8]: 7

In [9]: f.flush()

In [10]: map[:]
Out[10]: b'changed contents'

