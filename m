Return-Path: <linux-api+bounces-3988-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B027AE7AD3
	for <lists+linux-api@lfdr.de>; Wed, 25 Jun 2025 10:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D244217EFA7
	for <lists+linux-api@lfdr.de>; Wed, 25 Jun 2025 08:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81E928641B;
	Wed, 25 Jun 2025 08:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rB4k84ZB"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0676D27281C
	for <linux-api@vger.kernel.org>; Wed, 25 Jun 2025 08:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750841363; cv=none; b=DyO9T4POjuIUpcdVIHo5iJmuBJIQ6qxPTVinN/vGUm4VIdfBvu0MKafp2lySm2+PrUhMcgsRcZUWN+ULeUyqCn9ii9jtIu+Pgwk74onpwZuOwqP7iMTZvnZ/sVse9DIytMKPehG1MrfFfq8g0IzQyIkRj75jtxYkCmiambVjSpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750841363; c=relaxed/simple;
	bh=nvqiVYP05gkX+45rgrHxV9tn7/eugPV0r4GU2p4dxOo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A+rJWlBg6xZamqiSKOpqs2Ewsx3LRV2CFA/xII0P9gD4TEUEDaMAED/0r1v1R5jYENB8gyHxYin7tbEiAsBts46ou00bFm/t0xvoeXaig5ukSCiL6O6a2QzXk73pcmQr532DE+TOI09fSX10O4uJleOCemP3CkD8UE8xn4RReXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rB4k84ZB; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-54d98aa5981so8454314e87.0
        for <linux-api@vger.kernel.org>; Wed, 25 Jun 2025 01:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750841360; x=1751446160; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nvqiVYP05gkX+45rgrHxV9tn7/eugPV0r4GU2p4dxOo=;
        b=rB4k84ZBTiQuHqnZzWMlBeIhSbnPol3w6We6JJyc6A36GIsVpwN9sLH0SbFOuLRFoP
         UW6nlTRyXiTO8E5M6L054uwBsnFulRn3F/ElMHYGEqf0EFSLUkko4pxjOZ6aXeaDVgh2
         zTLmGMkaevW9ua2NK7cVfItN8iPbj7pLldaFDSZki7KkE2eHvFlUipNH3vDLL98x7v9n
         ntAKlx9Pawb9eDUQYG5Q3fdIQv7UvDEyUybXClkyOk7HShEOOit42nBzABH4yNncWrFt
         aYGOk1w/U8HspIveNqEbLm0kHBLkM7p407FX8p/U8exeb2NQytEbMRNX9Xt2D4qKJ1iO
         h+3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750841360; x=1751446160;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nvqiVYP05gkX+45rgrHxV9tn7/eugPV0r4GU2p4dxOo=;
        b=PReOm7678ZDWdJ0JZO8JxBiHhPTegbfsbitmuZX2CUIgpTuBvIV10KSTfli0sw0UUg
         0TtUiul5qvY6VAVq6Y2CpsYmbiN+7iY0WcHIw48NRtUUaEkvb9uGsxZVbs70c1I7o3pR
         vnnEtzu8Sndifpqnl5RCxfwfU4RPQsl6l7EIiSDyp1BLQ+qvHqzfdlLzshjMXBL64ghU
         4vLPbdiTpfFF3v2ssieorahdNEeurvjfz5tUcU9tSWkbZhUqrkOIiOvtoPpiq5ebbC2w
         yfXfWMywcD3Dm6YcDHgzPREx1SODXus++L+pwilBf5HOLr2OJhyvcqW5jXhKqC7wiFih
         a4Uw==
X-Forwarded-Encrypted: i=1; AJvYcCU1LAxydAEXI9vc+Brqgww5L03JbHHxeiyfcdP01BHzQAbohYtcw5A0Z+mX5kqViegCy/ZoSR1hc0E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp9TPXWm/MO9BOp0nXcv/u7lRqo9laqMcHon1mIOxYV0Mp9YMn
	qBa4ZVKw4oF9nDvMN/t6/dPla4VsPBzxvUK7noQp+TE4p8mc1QvtepX/9xdCw6iQsN34jP3Gzfu
	IcKvT703vrR6qOGY7D2AobFOHYvbsD3e6aSToeU2G
X-Gm-Gg: ASbGncsNieL/eij4BtTOyeGw+LK9MwcyM/xX8Qa80ECf1Nt2In8fkQvZESgdIZxnMmL
	qp09/hP+udgCmrMBFpghl+HCH6glfO7VnEAV1iODs5nS2z1IAl1T3rym9Jc97aKPUmQJsgUzgQN
	5Vp4ZqYrHJe98RFnR8UVqQXR85sI0BJ47SxLiFhlLbE+NZj4W87PNHtUDkN36QLgl7ox6yQR8CN
	mFU
X-Google-Smtp-Source: AGHT+IH4sD/iS/Fz3AfqY3JjQJ0QSUCwWLiwTVvoLWsrtxEtv0ZKRiY1/QvBZtg02yo3iOHVwYxluGoF+g3P5vNH4Zk=
X-Received: by 2002:a05:6512:334b:b0:553:288e:149 with SMTP id
 2adb3069b0e04-554fdd1b64cmr554545e87.27.1750841359942; Wed, 25 Jun 2025
 01:49:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aFNYQkbEctT6N0Hb@lappy> <20250623132803.26760-1-dvyukov@google.com>
 <aFsE0ogdbKupvt7o@lappy>
In-Reply-To: <aFsE0ogdbKupvt7o@lappy>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Wed, 25 Jun 2025 10:49:08 +0200
X-Gm-Features: Ac12FXxVCyTc9FCprJeDUTUo0n_vww4UVwL3_j6F7uN0V-VcezTdw6FnkszO8VA
Message-ID: <CACT4Y+Y_RQX55fNTLAjEQJYp3TY5a1yYZjx42BYu=vfObWzTBQ@mail.gmail.com>
Subject: Re: [RFC 00/19] Kernel API Specification Framework
To: Sasha Levin <sashal@kernel.org>
Cc: kees@kernel.org, elver@google.com, linux-api@vger.kernel.org, 
	linux-kernel@vger.kernel.org, tools@kernel.org, workflows@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 24 Jun 2025 at 22:04, Sasha Levin <sashal@kernel.org> wrote:

> >3. To reduce duplication we could use more type information, e.g. I was always
> >frustrated that close is just:
> >
> >SYSCALL_DEFINE1(close, unsigned int, fd)
> >
> >whereas if we would do:
> >
> >typedef int fd_t;
> >SYSCALL_DEFINE1(close, fd_t, fd)
> >
> >then all semantic info about the arg is already in the code.
>
> Yup. It would also be great if we completely drop the SYSCALL_DEFINE()
> part and have it be automatically generated by the spec itself, but I
> couldn't wrap my head around doing this in C macro just yet.

At some point I was looking at boost.pp library as the source of info
on how to do things. It provides a set of containers and algorithms on
them:
https://www.boost.org/doc/libs/latest/libs/preprocessor/doc/index.html

Sequences may be the most appealing b/c they support variable number
of elements, and don't need specifying number of elements explicitly:
https://www.boost.org/doc/libs/latest/libs/preprocessor/doc/data/sequences.html
A sequence then allows generating multiple things from it using
foreach over elements.

