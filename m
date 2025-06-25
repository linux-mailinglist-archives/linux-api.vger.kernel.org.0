Return-Path: <linux-api+bounces-3989-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC16FAE7AE9
	for <lists+linux-api@lfdr.de>; Wed, 25 Jun 2025 10:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0EC73B9CA9
	for <lists+linux-api@lfdr.de>; Wed, 25 Jun 2025 08:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267872820B6;
	Wed, 25 Jun 2025 08:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yNvBUzm7"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5994727F75F
	for <linux-api@vger.kernel.org>; Wed, 25 Jun 2025 08:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750841582; cv=none; b=MbcWdlq+ygqN6leUje2OYSRdEFPu8nfeUCWz+aB1IBsqREF+arvwBxHDaHY/pvSnnmcfbPn9W20g/jGmmLp736I8Wroml4y1G0ZasEjDWsHsrZE6vrRp08fxY2JuDhpHL98TLrqIKc8M/bWwbmsfWhi2/hlErS2ik6Gm+ptYYQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750841582; c=relaxed/simple;
	bh=/aGMiSWgswdb3PxpszlBovn3np9bIPgjxtNCoeUpgjw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JGxHkDjP7C/58Iveyqfl0rpIf2YLj+2gmCvGIflJd5C3yqQvGGzFNpwMbVjloilDNRn7J0I42Z1q3VJDP6yEqzwT19uTxtrj+wcmTssVx42uiB16Wv5JWqdg2rAmqkTdRivjsmi+K+WW2fzSfgf3l7K8K4pO7JKL4YheBt1kGLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yNvBUzm7; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-32b7cf56cacso12437751fa.1
        for <linux-api@vger.kernel.org>; Wed, 25 Jun 2025 01:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750841578; x=1751446378; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/aGMiSWgswdb3PxpszlBovn3np9bIPgjxtNCoeUpgjw=;
        b=yNvBUzm7HQioAxHvUAItpxKH1RAv/arKTA+stNrfkSkTJkbZIuAk095lskBmUla+B6
         2UQUpfSej9VRX9QLEeFidWzhkHGIRzcrcVff2ri79PHCtz2r3Mmm4Zo1pOfXvsX4PwAY
         4dKY8mqX8SF5/sTlmrkb2EuCbJPvTJmGijpOLmsMg3SZv/5xJ+8g7wsoRAzqOZsF+Qnk
         GZJQa2wVPm5gwARjgYIuBPNLGCtywSxkAIS2DX2HD0YIuiGtm3bRx62ER1oz8J4vMZbh
         o4CJM0I4O6kPtYTE0XjJ81ut61unA/Cu9KDEGE5MKZBOlDYa8Tr9EUk9nCu8iHOa42QZ
         Hepg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750841578; x=1751446378;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/aGMiSWgswdb3PxpszlBovn3np9bIPgjxtNCoeUpgjw=;
        b=af/ku3sL+JFxKOchQlDqwJkx42PnIf3Jy+9szIQ0NYfgD53L4OZbWhjHhVWEHUzsg4
         EV7fyK8I7W3rGzSy0pvzk+Krpo2AZXgxCNWWA6hiQHN7DW5H6gqy1J0S20OMHyqWNh2P
         KBzYf3Xd5aMRtYlOkVtfvQGrSU65JovMPq6EtwBh0TXlVa2PhOfy/wh4V994vcte6yuM
         gwZ3D4r3EXpJnkwFA33y3QYc48aEXgX+8q6b+VtTt31TjEKrYBn3GFhWWuqF2om9vMNN
         HfXXh8eyIdxmcVDWIG5JXRtC03wfIifPO5ptrPqENHmh6ffX8RvrRqrtOmZ3ddq35FG7
         ni/w==
X-Forwarded-Encrypted: i=1; AJvYcCUI3jMeUnBB+uWsoTNhbt6F8jK2n1QAdNc9nhclw/w2/0IElcxSdZZh0z8W7wEUrzMTpvV56xIPgpM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyjfonI+CxVEvXV7Uo4TEe6pOiCxr7MX82JQPLvJpf3ZU3WTQt
	SImIPT9PphANq27A48yoygp2SVwImWoK1mc5O1OkO4o3M53V0IlpaVpwfzTUNnEGdUbXyxPbju7
	08LcNnsamCxKuelUcWofcFC6Lt7zvx++RWejKe9pSjm21IJlEbm+mrUcm
X-Gm-Gg: ASbGncuxQwARNeuhcjmxXr23KO5xx/5KYWWBNeraBfqvITi71Al/8xd78/gYLeniECQ
	tN+nwlZPOaqKtg3ZZh+Pfjdq6+hm99JbX3n1s++4QezMfyK8H44F/WX6WOfO/UEzdIzm2f2h7uw
	D5R/R8qVPjPJmhwQy4DtvJezC/Q4m0hKcbWdCYpPLl9QyylRPb9wmpoOqY2M40/HauaXMDA8Mr/
	lAo
X-Google-Smtp-Source: AGHT+IHn5jN08ujo8GoOIZXJyGKEDPnWbpxEqhAfrT8jEIaoiQ0R+LhHX8niQOlMCvkzPsyqSYJbSovaD/ar3ODPJFY=
X-Received: by 2002:a2e:bb98:0:b0:32c:bc69:e918 with SMTP id
 38308e7fff4ca-32cc641db52mr4677001fa.1.1750841578106; Wed, 25 Jun 2025
 01:52:58 -0700 (PDT)
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
Date: Wed, 25 Jun 2025 10:52:46 +0200
X-Gm-Features: Ac12FXzXBIFSLBsUnXVDMCaUxIQVjV8jup_taqhSUWe1Psb2MF0u58GMi7noczg
Message-ID: <CACT4Y+Y04JC359J3DnLzLzhMRPNLem11oj+u04GoEazhpmzWTw@mail.gmail.com>
Subject: Re: [RFC 00/19] Kernel API Specification Framework
To: Sasha Levin <sashal@kernel.org>
Cc: kees@kernel.org, elver@google.com, linux-api@vger.kernel.org, 
	linux-kernel@vger.kernel.org, tools@kernel.org, workflows@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 24 Jun 2025 at 22:04, Sasha Levin <sashal@kernel.org> wrote:

> >6. What's the goal of validation of the input arguments?
> >Kernel code must do this validation anyway, right.
> >Any non-trivial validation is hard, e.g. even for open the validation function
> >for file name would need to have access to flags and check file precense for
> >some flags combinations. That may add significant amount of non-trivial code
> >that duplicates main syscall logic, and that logic may also have bugs and
> >memory leaks.
>
> Mostly to catch divergence from the spec: think of a scenario where
> someone added a new param/flag/etc but forgot to update the spec - this
> will help catch it.

How exactly is this supposed to work?
Even if we run with a unit test suite, a test suite may include some
incorrect inputs to check for error conditions. The framework will
report violations on these incorrect inputs. These are not bugs in the
API specifications, nor in the test suite (read false positives).

