Return-Path: <linux-api+bounces-1422-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 604AB8B4DEB
	for <lists+linux-api@lfdr.de>; Sun, 28 Apr 2024 23:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED88C1F210F8
	for <lists+linux-api@lfdr.de>; Sun, 28 Apr 2024 21:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42657AD5D;
	Sun, 28 Apr 2024 21:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="T46qo4nu"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9938F9476
	for <linux-api@vger.kernel.org>; Sun, 28 Apr 2024 21:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714339854; cv=none; b=T1fYXSg5D+5ZI+8gE8U3zLSxToVu2etsmq5wosgpEymgI1t/E8yCBfGZJJbOBIwT0DtruAD94NpD0QjLnxDKAFssSqHoHdHEb0hqZDcFOmfcsrPa0hPuKEKZmtluquo6umIe9gJJCUKP70Cazr2+2+rZw+5bCOXzr3nvuQVyimg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714339854; c=relaxed/simple;
	bh=iGTiqLpUAG8tJk0tZZXhVpkv3sDrq4xQk2Vsf0SnG0c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UkPVr9inEy7oH5dyuFXuCuDoHgTMD8OUrSjsjMjYvmHuX1EZZYHiHjV4Lip5nj5r+eWjgO+UtUPs6MWu8WewW6rIcwYD+MktblQO1H/gy2PqfRF1oGMxSZ3NYOT+T8HxdtobSOj+rcIGfJd8Ojw1NhcL+FXTd1MMEPyLlPo/h4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=T46qo4nu; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-7e128b1ba75so1150110241.3
        for <linux-api@vger.kernel.org>; Sun, 28 Apr 2024 14:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1714339851; x=1714944651; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uJJ35N4q0VyKFRaZhKEeRutim4StKWKCGfhx+lo+8WU=;
        b=T46qo4nuLxB/m8R1EzSBwQiyztMf4/wQbuFE0yGSPR3DlrA8GwtAEBHQ8KJhtz1StC
         TfiPbAQb/M08wrLTbSS7JT6S6uhIzfwvlW4Zbf2SZStO7u5U/GRs0N39qwCGK+8tnttv
         TW15AQx8gmyHloHohM9bVuV2GfLx/yFOEqCeiVpeWbPmSgTrwg4eMGJLqtLkVM+2veru
         XrcXqq88Sj/Nbjn2cMDgI34excSxccFRFAMHkK3pdeCE5oC++yo8MmZKmRI/2vu7g3eP
         BW/JzZ1Y3XSl0bTdpurE1tyGsabsoXyllaEFoXEbXMUIyjuIGxmO0Qg6L/iDbvloHuwA
         qtUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714339851; x=1714944651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uJJ35N4q0VyKFRaZhKEeRutim4StKWKCGfhx+lo+8WU=;
        b=f+GBCt48GVdWG6vWPLiCPDuck/uQpONo9xXF6zS2wlX9e7WDZxp7vugDiIQvs5bGpG
         f+gTGguN5HIltcYQh4iIn46BUFaPUWS9LrrsOe4oHQR9CmAKyMkaf39Iz0Nz9f6oL3En
         tEbqLKemd1/OO65jxyCKMFLpFD9bpWfnEvHhtXcM5KCQyhh2K2UmGAMv3gaW1hAMH7iI
         eV/Rr/BnnNGkl4zS/qs2RWdIDzr646pIzYG3OMiv6xC91w6iVdm+Ui0bqHA6LgRRiEyy
         Bsj1aH2kJ534Y76sSfwdnvqKemyg9SSWnATgLa4+EWBTztLegSTCOdCjs4o6wmOcrmrZ
         oJvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUd53cmYD+HhFB2ucQz0ohH2kK0lWde4CXpRXHHJwEAdnM8WhAiGSAGauWoARIO+5cfgUCARaGfMpWNKDxJq+xANEj/ROm2Cexm
X-Gm-Message-State: AOJu0YxQMQhKHnj6M+ZFG+1vmZuupKpeVPjKz0t1zxHYuSkbOI7kcAEa
	C7KIMuoCdzrEkPkKnioRrf0scc6YFbm9o0XuXdAEw1lT6uW2QMJ+7Gsk51zBLLIOXHXvJYofH5J
	YYZoNu4dVNEtNXh5Us22VKAFm963qpr8Kjbo/
X-Google-Smtp-Source: AGHT+IF8s3jPedCe069Eq93UJ1szjQ8DEEkODSmOra+9QpZeoqVtaQCCYqCnnCYq10+dMd4Mf9SVZZ7nuqKSS4JjZ6Q=
X-Received: by 2002:a05:6122:369f:b0:4c0:24e6:f49d with SMTP id
 ec31-20020a056122369f00b004c024e6f49dmr9623078vkb.1.1714339851513; Sun, 28
 Apr 2024 14:30:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240426133310.1159976-1-stsp2@yandex.ru> <CALCETrUL3zXAX94CpcQYwj1omwO+=-1Li+J7Bw2kpAw4d7nsyw@mail.gmail.com>
 <8e186307-bed2-4b5c-9bc6-bdc70171cc93@yandex.ru> <CALCETrVioWt0HUt9K1vzzuxo=Hs89AjLDUjz823s4Lwn_Y0dJw@mail.gmail.com>
 <33bbaf98-db4f-4ea6-9f34-d1bebf06c0aa@yandex.ru>
In-Reply-To: <33bbaf98-db4f-4ea6-9f34-d1bebf06c0aa@yandex.ru>
From: Andy Lutomirski <luto@amacapital.net>
Date: Sun, 28 Apr 2024 14:30:40 -0700
Message-ID: <CALCETrXPgabERgWAru7PNz6A5rc6BTG9k2RRmjU71kQs4rSsPQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] implement OA2_CRED_INHERIT flag for openat2()
To: stsp <stsp2@yandex.ru>
Cc: Aleksa Sarai <cyphar@cyphar.com>, "Serge E. Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org, 
	Stefan Metzmacher <metze@samba.org>, Eric Biederman <ebiederm@xmission.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, Alexander Aring <alex.aring@gmail.com>, 
	David Laight <David.Laight@aculab.com>, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	=?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 28, 2024 at 2:15=E2=80=AFPM stsp <stsp2@yandex.ru> wrote:
>
> 28.04.2024 23:19, Andy Lutomirski =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >> Doesn't this have the same problem
> >> that was pointed to me? Namely (explaining
> >> my impl first), that if someone puts the cred
> >> fd to an unaware process's fd table, such
> >> process can't fully drop its privs. He may not
> >> want to access these dirs, but once its hacked,
> >> the hacker will access these dirs with the
> >> creds came from an outside.
> > This is not a real problem. If I have a writable fd for /etc/shadow or
> > an fd for /dev/mem, etc, then I need close them to fully drop privs.
>
> But isn't that becoming a problem once
> you are (maliciously) passed such fds via
> exec() or SCM_RIGHTS? You may not know
> about them (or about their creds), so you
> won't close them. Or?

Wait, who's the malicious party?  Anyone who can open a directory has,
at the time they do so, permission to do so.  If you send that fd to
someone via SCM_RIGHTS, all you accomplish is that they now have the
fd.

In my scenario, the malicious party attacks an *existing* program that
opens an fd for purposes that it doesn't think are dangerous.  And
then it gives the fd *to the malicious program* by whatever means
(could be as simple as dropping privs then doing dlopen).  Then the
malicious program does OA2_INHERIT_CREDS and gets privileges it
shouldn't have.

But if the *whole point* of opening the fd was to capture privileges
and preserve them across a privilege drop, and the program loads
malicious code after dropping privs, then that's a risk that's taken
intentionally.  This is like how, if you do curl
http://whatever.com/foo.sh | bash, you are granting all kinds of
permissions to unknown code.

> >> My solution was to close such fds on
> >> exec and disallowing SCM_RIGHTS passage.
> > I don't see what problem this solves.
>
> That the process that received them,
> doesn't know they have O_CRED_ALLOW
> within. So it won't deduce to close them
> in time.

Hold on -- what exactly are you talking about?  A process does
recvmsg() and doesn't trust the party at the other end.  Then it
doesn't close the received fd.  Then it does setuid(getuid()).  Then
it does dlopen or exec of an untrusted program.

Okay, so the program now has a completely unknown fd.  This is already
part of the thread model.  It could be a cred-capturing fd, it could
be a device node, it could be a socket, it could be a memfd -- it
could be just about anything.  How do any of your proposals or my
proposals cause an actual new problem here?

> > This is fundamental to the whole model. If I stick a FAT formatted USB
> > drive in the system and mount it, then any process that can find its
> > way to the mountpoint can write to it.  And if I open a dirfd, any
> > process with that dirfd can write it.  This is old news and isn't a
> > problem.
>
> But IIRC O_DIRECTORY only allows O_RDONLY.
> I even re-checked now, and O_DIRECTORY|O_RDWR
> gives EISDIR. So is it actually true that
> whoever has dir_fd, can write to it?

If the filesystem grants that UID permission to write, then it can write.

