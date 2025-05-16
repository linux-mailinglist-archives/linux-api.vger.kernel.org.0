Return-Path: <linux-api+bounces-3793-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F37ABA2A8
	for <lists+linux-api@lfdr.de>; Fri, 16 May 2025 20:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D430F3B1D4D
	for <lists+linux-api@lfdr.de>; Fri, 16 May 2025 18:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95D827CB16;
	Fri, 16 May 2025 18:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EBhQiOH2"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1010278751
	for <linux-api@vger.kernel.org>; Fri, 16 May 2025 18:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747419587; cv=none; b=NvrZYeuyHfEOEZSHab8XEqml3t8jSuZvr+KB6okWKqDlGuTYjhbUI+CNbFrYEYa37uL9JpLJ6Iokhv0Q4ieMp00R6+uxMZJV7B6GElC25YBo/hVDRGLNA+cvjHGc+j10UsrdCmDTyy4zBCaxrQGan69Oim0x3nJ3Xw9cRFcR2eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747419587; c=relaxed/simple;
	bh=tJ7YIAtE7EoxZl8QEWxoCzjLy7ASc0H8Ww+yLbLg/lQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CCu8svUHNX/mEXjp+yDQ2AEiI9gXGZ3AxYV4kv1iHezslDJ5/JiSr6okW2hwjZb1ot7hhnYBy92ZygcTFWsKw7SLYOYi8jZzi0peSGHUQNiQkWxZspIjC7aqtekRRP/1YAsC98N9L8aUULHNH7bOUqqUsxoFrMsQRod1eq58968=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EBhQiOH2; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4774611d40bso27351cf.0
        for <linux-api@vger.kernel.org>; Fri, 16 May 2025 11:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747419584; x=1748024384; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tJ7YIAtE7EoxZl8QEWxoCzjLy7ASc0H8Ww+yLbLg/lQ=;
        b=EBhQiOH2KPraXG/2+qzQCQWtp0sbXrlXEWCckGEX3Fr7pHaOd1WSc7P6u0O7M8Uj3V
         tAJTyLDIhMI2vxFSiSXIOjOvVfGoxtvJVzKtBWJuahnnHXFIM2ov0oToGTe3SkAgFrWU
         YDT5XePDMAbJnWj7sL/qeutQwOHFOnU3y7dQJ03j5vtGNkccRVU3qMzvspqs2aDrJEOy
         3MPfNf1C9V9MnP7QJgsSK4RZlWycJdyfl3fMoN5b2/pVMz+/R/ZcmFePUfCB1l6x8vdr
         s+EhMtdv+7zC38MyKbEBkNkC4YjoulczDaBfFFA0MzggzfoNgOroinTmg9xRn2ZJ4Qa9
         /sqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747419584; x=1748024384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tJ7YIAtE7EoxZl8QEWxoCzjLy7ASc0H8Ww+yLbLg/lQ=;
        b=hTdg8i4ucw+xpeklrhlj+lcTzyFK67soYgtVTeLOIYvdhehuI4OVOHj1tGSf0HH9U+
         p9msUF8tRWb4CA5OOB/QPSCmKthYWFhDJLenyqWxxp3swPrAJ4B2nwikTjl/ST94AJsd
         j79jy9fXhlfslBZNYrf1XZV8mXKe6G03pgL0/sb5lqtsc+YAX/ThxJhYZWEJ8POi1fQA
         7G//Km1vF9n6unbNfATrRZRE+x6BQiSQTvf6/tO7HLppUkS8CYhAAlY31RoMkuhAT/Hw
         46XhdNkx0JZnu6WDZg9NFrvSzQwKA2CALZ5SSDEv6eGi/mC/Yx3KtWrg97IQ1x9U3jCp
         3S6g==
X-Forwarded-Encrypted: i=1; AJvYcCW3yWZVNEznStTyBy8J4xjH8MFJthASHIS0Ft/sJb1GZY3F5XJenLV60b9l/XVkSvAY0w9a3+JOLWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQsWsTWETgq+CbaHBxWw3gsO0rhh48TN1tnht2FnIhaExwFlhO
	qlxkxbg+QLcCUurvkhyQyzmiYhRHhwu5UL8AtYh6sE8+X4aWLYvKn9yYuqFa8iAnyGCYKuG0HJ+
	fOYlZOfUO/WFWVvUGvY7tFAyIMPb5l+Vzq8o53mGDvsKXtSFijvh6a3uT2Xw=
X-Gm-Gg: ASbGncu/4UVoVhxR/uRTO3rnWzAo40iLlQBS+Yy1Vp3xdJMzwFBskF4GUOKJOZ8gg7e
	GvpMLNaCVNmm8AHMN7M9RQx3AMdlzua6ux0yFtcGuaAZJ24LnxtLGvbXDv7x6eX0Iq4yR4NZB7d
	fuheKm+VMgeyT1jVeIYUbVsb2Dg+xy/EI5q4cj1SgOdMXwSiC7GD+wSp8goQJ2EM6eEA==
X-Google-Smtp-Source: AGHT+IH/YcjxPjaWTFHg5OttoL041EYSiajQrOYey/besh0rkqKTz7c7ZmilRcnNRdGKAuzHyH60KgVbxm6XAQsJi5M=
X-Received: by 2002:a05:622a:48:b0:494:b641:4851 with SMTP id
 d75a77b69052e-495a13664admr63871cf.27.1747419583586; Fri, 16 May 2025
 11:19:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1747409911.git.jgh@exim.org>
In-Reply-To: <cover.1747409911.git.jgh@exim.org>
From: Neal Cardwell <ncardwell@google.com>
Date: Fri, 16 May 2025 14:19:26 -0400
X-Gm-Features: AX0GCFu2hXoSeLLlHSvvIRxhQsSctc4ES_5VsUpD7-rF6_xu0_bcrjgpr3OFHpg
Message-ID: <CADVnQymxsOGLnUfurhDLXNUaK4gpaYm2zTDEWRxy8JPqH6O6vg@mail.gmail.com>
Subject: Re: [PATCH 0/6] tcp: support preloading data on a listening socket
To: Jeremy Harris <jgh@exim.org>
Cc: netdev@vger.kernel.org, linux-api@vger.kernel.org, edumazet@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 16, 2025 at 11:55=E2=80=AFAM Jeremy Harris <jgh@exim.org> wrote=
:
>
> Support write to a listen TCP socket, for immediate
> transmission on passive connection establishments.
>
> On a normal connection transmission is triggered by the receipt of
> the 3rd-ack. On a fastopen (with accepted cookie) connection the data
> is sent in the synack packet.
>
> The data preload is done using a sendmsg with a newly-defined flag
> (MSG_PRELOAD); the amount of data limited to a single linear sk_buff.
> Note that this definition is the last-but-two bit available if "int"
> is 32 bits.

Can you please add a bit more context, like:

+ What is the motivating use case? (Accelerating Exim?) Is this
targeted for connections using encryption (like TLS/SSL), or just
plain-text connections?

+ What are the exact performance improvements you are seeing in your
benchmarks that (a) motivate this, and (b) justify any performance
impact on the TCP stack?

+ Regarding "Support write to a listen TCP socket, for immediate
transmission on passive connection establishments.": can you please
make it explicitly clear whether the data written to the listening
socket is saved and transmitted on all future successful passive
sockets that are created for the listener, or is just transmitted on
the next connection that is created?

thanks,
neal

