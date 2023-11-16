Return-Path: <linux-api+bounces-77-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8C87EE89C
	for <lists+linux-api@lfdr.de>; Thu, 16 Nov 2023 22:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62E54281074
	for <lists+linux-api@lfdr.de>; Thu, 16 Nov 2023 21:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54F92596;
	Thu, 16 Nov 2023 21:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="HY01sky1"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E67F9A6
	for <linux-api@vger.kernel.org>; Thu, 16 Nov 2023 13:01:40 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9e1021dbd28so182170066b.3
        for <linux-api@vger.kernel.org>; Thu, 16 Nov 2023 13:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1700168499; x=1700773299; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6Y4PgOUAxNwJ79QhyHTDuCCcxTAOh8OUr8u8cGj3Rqw=;
        b=HY01sky1DkR1tRPxMnZ6SABK1zH3SS6yLEiFs04+r7YkgIXwzPBmSFRbdXXmKIQBu4
         y304N4x1HHBUumBZr+p+Hl/+w+PyU5HuBhfQte9L+RWIKYItW+a5rK2droiKim8fpcM2
         AB/su/oEK65jxLTVJRxcTjlAbHB4/ufB64+Dw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700168499; x=1700773299;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Y4PgOUAxNwJ79QhyHTDuCCcxTAOh8OUr8u8cGj3Rqw=;
        b=IxaOSPyXlb9FqkrgngIbNibJl00Y50Zfvitm7O/t0SkQfpnp0gmATvQx0fyYytDNKo
         O6Z5F+auFblQZuT/usDtUdv7hE36Bgm986ZSqHH/HWAbFd2gWmvaoOwJ/3KFEcb6lZ9R
         QWpN7msz0hYuM0/czVhiBx95lHAU+v4J7l+O+lYNRM94yjfmDlEXxUZglIV5aifRX0zP
         domf1+8gGVRyJ5kavOjtrFvyfZygM7MRLcALVcEpIEZZANYFtCjGYUqlVaLOUvkqBP+w
         0ffAvxy0h7JRtplDR/YnqpbkQjrXSNnKPHvAvqLF9sTDkFZZzDtSPlRVvTTdfYe63EyG
         0ALA==
X-Gm-Message-State: AOJu0YzvF+aGH7k+Gp8qWGnf5f6EHcDTIVq0PUuhZb9XQUDx7Ry2pZR3
	Px4uR4ENMbpJqdb9ZiWxmaC3CaJpuGVWThqlkFQLXA==
X-Google-Smtp-Source: AGHT+IHYshW+mG+gh3izJ3KPm1C4AIy9798YrS6zaKXKNLyM2TyVcs91f3L5hpvQ0JqbQWdSgXbJF93IVYu9wfq2zZg=
X-Received: by 2002:a17:906:f6d4:b0:9be:30c2:b8fd with SMTP id
 jo20-20020a170906f6d400b009be30c2b8fdmr12599757ejb.66.1700168498829; Thu, 16
 Nov 2023 13:01:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJfpegsMahRZBk2d2vRLgO8ao9QUP28BwtfV1HXp5hoTOH6Rvw@mail.gmail.com>
 <87fs15qvu4.fsf@oldenburg.str.redhat.com>
In-Reply-To: <87fs15qvu4.fsf@oldenburg.str.redhat.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 16 Nov 2023 22:01:27 +0100
Message-ID: <CAJfpegvqBtePer8HRuShe3PAHLbCg9YNUpOWzPg-+=gGwQJWpw@mail.gmail.com>
Subject: Re: proposed libc interface and man page for statmount(2)
To: Florian Weimer <fweimer@redhat.com>
Cc: libc-alpha@sourceware.org, linux-man <linux-man@vger.kernel.org>, 
	Alejandro Colomar <alx@kernel.org>, Linux API <linux-api@vger.kernel.org>, 
	linux-fsdevel@vger.kernel.org, Karel Zak <kzak@redhat.com>, 
	Ian Kent <raven@themaw.net>, David Howells <dhowells@redhat.com>, 
	Christian Brauner <christian@brauner.io>, Amir Goldstein <amir73il@gmail.com>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"

On Thu, 16 Nov 2023 at 21:36, Florian Weimer <fweimer@redhat.com> wrote:

> In addition to Adhemerval's observation that we'd prefer to have some
> hint regarding the buffer size, it's probably better to have entirely
> separate interfaces because it makes static analysis easier.  With a
> unified interface, we can still convey the information with an inline
> wrapper function, but we can avoid that complexity.

I'm not against having separate allocating and the non-allocating interfaces.

But I don't think the allocating one needs a size hint.   Your
suggestion of passing a buffer on the stack to the syscall and then
copying to an exact sized malloc should take care of it.   If the
stack buffer is sized generously, then the loop will never need to
repeat for any real life case.

Thanks,
Miklos

