Return-Path: <linux-api+bounces-253-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A625806AE3
	for <lists+linux-api@lfdr.de>; Wed,  6 Dec 2023 10:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB1EB1F213A1
	for <lists+linux-api@lfdr.de>; Wed,  6 Dec 2023 09:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326191A730;
	Wed,  6 Dec 2023 09:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Q3Sz3vWx"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD2A1A4
	for <linux-api@vger.kernel.org>; Wed,  6 Dec 2023 01:38:54 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-a1ca24776c3so119780366b.0
        for <linux-api@vger.kernel.org>; Wed, 06 Dec 2023 01:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1701855533; x=1702460333; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TYZysdNMtlf+ieWkrppbfc337y9v9xlVK3DBQvAcSIY=;
        b=Q3Sz3vWxRtTPbCXEb3T5h81vaPvZEy+ClAmdKfjwfnDAHqlmVkHn+FVsntVZ7+rmct
         5nSthRg6IDt9G5BP/1oELrLxe4JldnSqZYnd91yTGPX2Zm6MBCN0h2x3aBQRzmSxYwH2
         qAK69faJEc7NuZxmzII91KCag+JsRhl9CiVR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701855533; x=1702460333;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TYZysdNMtlf+ieWkrppbfc337y9v9xlVK3DBQvAcSIY=;
        b=JlzoCaIgYu2mHyNN6ohj6lggJx+w5ajNrBBnuNLN7lj5DEtNCW6C6iKy3pC6rRu6iT
         HzCoFObzEYY21nP6jjNoPZ7/jzlsWeRlv3CbKUXJJqMXu5kMqwwb1Tjv3OFZBkMRoLPP
         9JRJbD8/O+qUXw7JWWXRObsxgA77UBOHLNHZ3hqTOSsFic9iNOtBLHllWE+hBdHh77E+
         HfuNNQ0qvyHd2og5we8gkve8crKuFrLwiN1RpylpxjDzsG6zFMzAlkzSDIz3hlZ08ddx
         zVUq7xWgC9jJ+hZDbZMIk6I2fsBn96C+6lPb+GSDLx5dpaoS4hIlTK6ERapUblucQYws
         H8sw==
X-Gm-Message-State: AOJu0Yy4sQXP/cJO46q3H3qUVwCvmDIpfVcDEoSVEwg8PmX7W/K8ilSo
	P68y2Z92WTbXq6QOW2WXTqgZGJL8aNw7Eihq8hPuiw==
X-Google-Smtp-Source: AGHT+IHSxvjRmB4cOovZ8zqailwQcKq2WgClq7BAg4fC+QzkCYf4/VTwy9T7yn0SG0TpBYhxxOFAyiQTPtWxdweaBbE=
X-Received: by 2002:a17:906:bc95:b0:a19:a409:37ed with SMTP id
 lv21-20020a170906bc9500b00a19a40937edmr2458398ejb.70.1701855533199; Wed, 06
 Dec 2023 01:38:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJfpeguMViqawKfJtM7_M9=m+6WsTcPfa_18t_rM9iuMG096RA@mail.gmail.com>
 <20231205175117.686780-1-mattlloydhouse@gmail.com>
In-Reply-To: <20231205175117.686780-1-mattlloydhouse@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 6 Dec 2023 10:38:41 +0100
Message-ID: <CAJfpegvUWH9uncnxWj50o7p9WGWgV3BL2=EnqKY28S=4J4ywHw@mail.gmail.com>
Subject: Re: [RFC] proposed libc interface and man page for listmount
To: Matthew House <mattlloydhouse@gmail.com>
Cc: libc-alpha@sourceware.org, linux-man <linux-man@vger.kernel.org>, 
	Alejandro Colomar <alx@kernel.org>, Linux API <linux-api@vger.kernel.org>, 
	Florian Weimer <fweimer@redhat.com>, linux-fsdevel@vger.kernel.org, 
	Karel Zak <kzak@redhat.com>, Ian Kent <raven@themaw.net>, David Howells <dhowells@redhat.com>, 
	Christian Brauner <christian@brauner.io>, Amir Goldstein <amir73il@gmail.com>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"

On Tue, 5 Dec 2023 at 18:51, Matthew House <mattlloydhouse@gmail.com> wrote:
>
> On Tue, Dec 5, 2023 at 11:28 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
> > Attaching the proposed man page for listing mounts (based on the new
> > listmount() syscall).
> >
> > The raw interface is:
> >
> >        syscall(__NR_listmount, const struct mnt_id_req __user *, req,
> >                   u64 __user *, buf, size_t, bufsize, unsigned int, flags);
> >
> > The proposed libc API is.
> >
> >        struct listmount *listmount_start(uint64_t mnt_id, unsigned int flags);
> >        uint64_t listmount_next(struct listmount *lm);
> >        void listmount_end(struct listmount *lm);
> >
> > I'm on the opinion that no wrapper is needed for the raw syscall, just
> > like there isn't one for getdents(2).
> >
> > Comments?
>
> One use case I've been thinking of involves inspecting the mount list
> between syscall(__NR_clone3) and _exit(), so it has to be async-signal-
> safe. It would be nice if there were a libc wrapper that accepted a user-
> provided buffer and was async-signal-safe, so that I wouldn't have to add
> yet another syscall wrapper and redefine the kernel types just for this
> use case. (I can't trust the libc not to make its own funny versions of the
> types' layouts for its own ends.)

You can just #include <linux/mount.h> directly.

Thanks,
Miklos

