Return-Path: <linux-api+bounces-3990-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16457AE7B04
	for <lists+linux-api@lfdr.de>; Wed, 25 Jun 2025 10:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73ACB1893FB1
	for <lists+linux-api@lfdr.de>; Wed, 25 Jun 2025 08:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C3E285C9F;
	Wed, 25 Jun 2025 08:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="op7eE2Zs"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1649270554
	for <linux-api@vger.kernel.org>; Wed, 25 Jun 2025 08:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750841779; cv=none; b=GuedmIK0tETHbYXVPQgjhfLKV0QhbdEe/RazM44omagCH0ADy/LlYIQEqpQW1mWM0mWqubyvdMyPpKYuZ5xMR3y3bBWG0njl9HJ7D3s65PkfIGGUf30Y8FxDMjEBAISx0hDzYvA6FNAJZginBGXGzmEKdjQ3i0pRoeWmkA9ThBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750841779; c=relaxed/simple;
	bh=ol6hG/xIb5bYbNO2SBhx7LVEvxidce1MZgkT1Tx5R7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=agA0Rl6aQhe07/KtqzVWvi4ZnXpVsHslchMc++GrNrss/ZntQ8igTC4v0U2u6yyXnjcAgWLwXzhR9Lb8mIaw+xVa8np+SYjVAw9ls9e/TW1xuyQa5P2sQ1F6G0xCQfpTBgAlSUlIA77oXyYOCxkyyvqJ6Ea+XZzdJa4P4+64VZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=op7eE2Zs; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-30f30200b51so78266981fa.3
        for <linux-api@vger.kernel.org>; Wed, 25 Jun 2025 01:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750841776; x=1751446576; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ol6hG/xIb5bYbNO2SBhx7LVEvxidce1MZgkT1Tx5R7U=;
        b=op7eE2ZserNuvP4n+qRg601caRgmSUFYOiJfvSqdH9Q3uUnh4tTL6C9KwiwaKq3R6+
         5cbdaWLIEazToB0nDTwb4V2rBPDAXNR0h6VtOVq4YZnxPOqhb7xk4BCb2At4K3FjQHDf
         vZhclGWu6AMbMEmzOBPbCJ5o7dOUpcMHi2wlad+6oE5l+HM6GtDfH8vjtJn2BXGK18vI
         +5lt2kykNH0znZ20fnOttuGuUPwZ6/ZkqZMYbg69uzt0OkBtqN/4wjvzfd6DyTXUASbQ
         6XlOKxAeu+Nq4fELwwmTLCnSyXrusKZ+4rmWcAdiYCMrXv1xIZ+T9d7g4KVIOwIMm8yJ
         4Pdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750841776; x=1751446576;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ol6hG/xIb5bYbNO2SBhx7LVEvxidce1MZgkT1Tx5R7U=;
        b=mpXat7X9Zw6A/ZJ2g/XA/52eef1hnvFysCRtE/2jwLU3X9ZdpjQODCdlu9waUk1uY9
         Ykb0KsvLVpA9zs6GaDKRuOJrijxTXaWko6RgfyY8Tk5HssVmU4I7p3QPQeE15et7YBYJ
         vN/0dS7GidPYDYsEPeqUYDDppB8YseaUsJOcEFDE736P4Y1guK4yQVIGuJRT0XgkB8hr
         N5989tXngKsTcH7ZfK9gaU/fnc6JU9qG2wKj384cDxfV2cmUfPvYekH2UnrDN6lO/OgQ
         ywkNIvljl9lbu1CYLosNdyM9zluAzV0p1AMq4oiGyOKu4HDxs3vRtRunoEp8uRJZ/a3X
         LZ9Q==
X-Forwarded-Encrypted: i=1; AJvYcCU7zlkmgB1r3u1JoyqwZVCMHzhICTk08xClmsjyynukiTppLNOpY89OIQh4dtYHkqc5skKqiS+bjwo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCoQZrb4Ydd4ZyNow+9iXVQpm3enJ4wqGNn9/c/lkvxVRKyct9
	1TEba7uZycRkCDfcFOGG12EbzjkoJjrF0slZJZZsVXkT1OANijimR+JyIRYvArEn2MiiCJxV5LS
	9X3iBy2xblzh5XbUyGPmFgTO78q9gYN5aR1S5JluUFBM/7ETueLO/qfQhy40=
X-Gm-Gg: ASbGncvGnx+F6iPQ4/qfI22BrzmebI1bvB/85lRLLmTbUgnZxsXxrerDc/By+yi7Fek
	Iz3YyxOpaUxwTxk+HsvIMv6GDmTkuTCDw+MHvPPn9nwJYXnn9mkvuPLDNNsPTvZHb/qa7a7Hab3
	o5T/PHJ+0lAa2sYMQ7XEc5edBQw/7LbA9Nwo2WA/Yyc529syHj3WottokVJwGnmVhlgb/B0ZvXV
	FRo
X-Google-Smtp-Source: AGHT+IFpgMsBCJNfJjNTqTcRqyvaAq9toiC+ROW42NXwQoaO1HLVScBehwrjaxIyE7j0rk+vG9CVwK1uxS5kBraTZEY=
X-Received: by 2002:a2e:8a90:0:b0:32c:bc69:e91d with SMTP id
 38308e7fff4ca-32cc6591e04mr3745431fa.39.1750841775748; Wed, 25 Jun 2025
 01:56:15 -0700 (PDT)
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
Date: Wed, 25 Jun 2025 10:56:04 +0200
X-Gm-Features: Ac12FXwcV14oy7Lg0QTHJjjjHfOFa5hONjjoyvSSHa4vsJdvjxnzlzXvHlNTG4A
Message-ID: <CACT4Y+bV-3HgNOAd+f7W0RBU2-qoocpMCepKhLEb+BcyiJM5Mg@mail.gmail.com>
Subject: Re: [RFC 00/19] Kernel API Specification Framework
To: Sasha Levin <sashal@kernel.org>
Cc: kees@kernel.org, elver@google.com, linux-api@vger.kernel.org, 
	linux-kernel@vger.kernel.org, tools@kernel.org, workflows@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 24 Jun 2025 at 22:04, Sasha Levin <sashal@kernel.org> wrote:
> >9. I see that syscalls and ioctls say:
> >KAPI_CONTEXT(KAPI_CTX_PROCESS | KAPI_CTX_SLEEPABLE)
> >Can't we make this implicit? Are there any other options?
>
> Maybe? I wasn't sure how we'd describe somthing like getpid() which
> isn't supposed to sleep.
>
> >Similarly an ioctl description says it releases a mutex (.released = true,),
> >all ioctls/syscalls must release all acquired mutexes, no?
> >Generally, the less verbose the descriptions are, the higher chances of their survival.
> >+Marco also works static compiler-enforced lock checking annotations,
> >I wonder if they can be used to describe this in a more useful way.
>
> I was thinking about stuff like futex or flock which can return with a
> lock back to userspace.

I see, this makes sense. Then I would go with explicitly specifying
rare uncommon cases instead, and require 99% of common cases be the
default that does not require saying anything.

E.g. KAPI_CTX_NON_SLEEPABLE, .not_released = true.

KAPI_CTX_NON_SLEEPABLE looks useful, since it allows easy validation:
set current flag, and BUG on any attempt to sleep when the flag is set
(lockdep probably already has required pieces for this).

