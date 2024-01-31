Return-Path: <linux-api+bounces-780-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 304558446E3
	for <lists+linux-api@lfdr.de>; Wed, 31 Jan 2024 19:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A982F1F228BC
	for <lists+linux-api@lfdr.de>; Wed, 31 Jan 2024 18:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B276112FF77;
	Wed, 31 Jan 2024 18:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="zxA9Jx+w"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1013651C2B
	for <linux-api@vger.kernel.org>; Wed, 31 Jan 2024 18:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706724729; cv=none; b=LnJv96t5YCAEpBl8BM6pbuD8f2fDEP9/Annw+dtQ6BDlCrt5aDWuDE2u7OMD7bqlHj4m7M40l1+Ta8EwVOQ4defIvnMqZMWBrJ1sRmrtEKcfgEcwQHw9WuZo4E+WvPpYNX5mLIk2sEBTZjo+Q6nfpeZZ3vf6hK0RmCQWO7inlbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706724729; c=relaxed/simple;
	bh=STgTLQoskTh+8DR2hD5JRM99Mcrb+r/d7oGmIrhDbR4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G8vubF3yV9PKvKy2ENvEnThGc1+rZWFiNZuUHQ/Fi3hoA4xC8nQKUN4xirR4leC3CfvTHBdRAUf83Yfw2xclUiY/ZjWDf1ZJVEigYUTZrTT3axirfClwJ90TkItY94OEhO+UGOnjuMVJVNtchAr7mvaAJOyF0OQkVYCKj/nCz/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=zxA9Jx+w; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-4bd9fd9eb7aso40629e0c.1
        for <linux-api@vger.kernel.org>; Wed, 31 Jan 2024 10:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1706724727; x=1707329527; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GGA0Zqk+riY1KRG9vwSmf4Mk+lzwyAYBV9JiVffdUNU=;
        b=zxA9Jx+wpq6y2kh29ntpvVAdBb2QU4pBsQOGILAlLsouUWTz9yIPv6Zwfa9fvAApBD
         2mQm+H/KIwLWgzQ7qy69FcXVUbQvYMkqTzBhvRxI7LMszqkgMdF42tiISehaPC2jwdFH
         xst+II4syImd1pUKhpXJUvwYSk3sQgMWKcm56MX8e8DEVt/ZV8Dday9oL7nXnHC004r1
         0vpWb0At0+7/DUaFVUgBrUmTmLhGSG5BT+Q/S1z8oR/rF+j45Wm5/rHJiLBO3/0BFw8W
         NXr4CWiUO1m0amm6KBcc2iCQvjK/3czBAWVpJKaQ9i3xU6nXS8CeD8+12/8iqcmbHwMV
         RSOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706724727; x=1707329527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GGA0Zqk+riY1KRG9vwSmf4Mk+lzwyAYBV9JiVffdUNU=;
        b=FBd60QF8VXllBHT5tY6Ud0o2Ysm63oOKcvjbEJZwg8V8xITEKte5DCMo+Ng7KH+AMw
         ysXkZHpubXRk6d1JZPT68ZCHjUvnL6X/Q8jOvFGbg26QNvN/CDse3keeESwdwfqU9+Vt
         XoZC15ybeehcfiALAPemMgEC32OEBvQRHxcOahkUX7SEL75jGpjmvzpKS1YJyrQwJ2Ym
         JBHOGcZiDK8+4thCL5nwC6PM3caWOmtkDXFbRR0UIRWNLaN5o72+XIS2WUYdf61kcnTb
         bZnXyqlIvJq2v3ELWnyXOpZrtzLxxfpr5/ZWlN9aiT1CO8d9NQpl3T8yTN7iaquPC59m
         dBsw==
X-Gm-Message-State: AOJu0Ywm0TnNMIX5dcvBOVn8syvLb5otRZL5Ph8fSH81Zqqr0coKR3nR
	eLR5Ej25QjdAmwaAkWGx83/fLGXuMRtcAq9mVSP86Nn1kGrgw9vKxGcoSCsj1xmG3ueTRLNtjl5
	+2UNdxVcnNn0+QGjKwSFjox5zXdImyMFG9Ecq
X-Google-Smtp-Source: AGHT+IFkr7a2wSPfcQxL+NcIOkwv4R5ssE/UGOW4KTbxhGE7PmX0HB6/IYgYxwhNh4IPK32iKi1cD80qdVW5ZLu3IZA=
X-Received: by 2002:a05:6122:c99:b0:4bd:3b1d:38b8 with SMTP id
 ba25-20020a0561220c9900b004bd3b1d38b8mr2470740vkb.1.1706724726988; Wed, 31
 Jan 2024 10:12:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZbArN3EYRfhrNs3o@tycho.pizza> <20240125140830.GA5513@redhat.com>
 <ZbQpPknTTCyiyxrP@tycho.pizza> <20240127105410.GA13787@redhat.com>
 <ZbUngjQMg+YUBAME@tycho.pizza> <20240127163117.GB13787@redhat.com>
 <ZbU7d0dpTY08JgIl@tycho.pizza> <20240127193127.GC13787@redhat.com>
 <ZbVrRgIvudX242ZU@tycho.pizza> <20240127210634.GE13787@redhat.com> <20240129112313.GA11635@redhat.com>
In-Reply-To: <20240129112313.GA11635@redhat.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Wed, 31 Jan 2024 10:11:55 -0800
Message-ID: <CALCETrUFDkt+K9zG8mczxzAFy9t-6Mx5Cz-Sx+it6a4nt+O0pg@mail.gmail.com>
Subject: Re: [RFC PATCH] pidfd: implement PIDFD_THREAD flag for pidfd_open()
To: Oleg Nesterov <oleg@redhat.com>
Cc: Tycho Andersen <tycho@tycho.pizza>, Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, Tycho Andersen <tandersen@netflix.com>, 
	"Eric W. Biederman" <ebiederm@xmission.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 3:24=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> On 01/27, Oleg Nesterov wrote:
> >
> > I'll (hopefully) send v2 on top of
> >
> >       pidfd: cleanup the usage of __pidfd_prepare's flags
> >       pidfd: don't do_notify_pidfd() if !thread_group_empty()
> >
> > on Monday
>
> Sorry, I don't have time to finish v2 today, I need to update the comment=
s
> and write the changelog.
>
> But the patch itself is ready, I am sending it for review.
>
> Tycho, Christian, any comments?

Right now, pidfd_send_signal() sends signals to processes, like so:

 * The syscall currently only signals via PIDTYPE_PID which covers
 * kill(<positive-pid>, <signal>. It does not signal threads or process
 * groups.

This patch adds PIDFD_THREAD which, potentially confusingly, doesn't
change this (AFAICS).  So at least that should be documented loudly
and clearly, IMO.  But I actually just bumped in to this limitation in
pidfd_send_signal(), like so:

https://github.com/systemd/systemd/issues/31093

Specifically, systemd can't properly emulate Ctrl-C using pidfd_send_signal=
().

I don't know whether implementing the other signal types belongs as
part of this patch, but they're at least thematically related.

--Andy

