Return-Path: <linux-api+bounces-81-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4287EF4ED
	for <lists+linux-api@lfdr.de>; Fri, 17 Nov 2023 16:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47DAE1F25E12
	for <lists+linux-api@lfdr.de>; Fri, 17 Nov 2023 15:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83EC37140;
	Fri, 17 Nov 2023 15:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="JrPCTJa+"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4574D57
	for <linux-api@vger.kernel.org>; Fri, 17 Nov 2023 07:13:58 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9d0b4dfd60dso277274866b.1
        for <linux-api@vger.kernel.org>; Fri, 17 Nov 2023 07:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1700234037; x=1700838837; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7Oo189R36r9S1P5c11qiLhRbRaLL1RPe2gX3RGHrDug=;
        b=JrPCTJa+oNx/yxLHdc3BtbQcpBIUyO8JIu7mx0UHx5aE5JWC+19EWeeF19Y7fdRYi9
         AhrY69cGPvg+Mi4vQ4aNRVd2QRVykNAtY5UGKg4lv9v6YULNBQVHuvaDyGlPeHoZ1YFd
         6zvucP6pd1P3jlWeBnTgXS5sy2q823MHMHBrE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700234037; x=1700838837;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Oo189R36r9S1P5c11qiLhRbRaLL1RPe2gX3RGHrDug=;
        b=FMWXOIp+tOIM1A2QUuxBanMlSzWvHRDGhtRjH5kBwUW3CtI0IULVDyDDBdMHrKExze
         6drfS2JuNMDV5ZFZ/9ezB9JmUSwCYjxZljlv5+C/UPZcN3u0Dls6tPvgEUHuUmR0nIsG
         BQaz3u1Y0qZE5f/axuh7seyYsupTvzHTwa9Nld2xwJaVq5EjV3k7xuDJPHsEzkYI2JDj
         5B/jidUmZUP6qw6eGA73gHnF5Ojr9Z2+H8/4A5csBWhW324xjxbECldt85zw78N/PcIf
         2QQDiJnqbL6IM6sCIjH5/GaFTo7e10YaN1/SNoevSUIGDpgB2viy929bA1m5rwTOYHF5
         ZoYA==
X-Gm-Message-State: AOJu0YyhzV2pVELhUM52I5RFBM1xLsrGgWlpBT0ZDvuyFDwIy4STPj9G
	nm94nMC19w025F32GHIvHoC0R2KS0BcmIMv8ZNBSgQ==
X-Google-Smtp-Source: AGHT+IHMUXnjmlNoD8wvqNvaWmdh3jNGp37NhE+vXpAEq21urujA7z030N8vV5bqDLo2H5+mjckvnRSnPDlR0gomq3o=
X-Received: by 2002:a17:906:738d:b0:9f8:a622:d670 with SMTP id
 f13-20020a170906738d00b009f8a622d670mr1439944ejl.19.1700234037204; Fri, 17
 Nov 2023 07:13:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJfpegsMahRZBk2d2vRLgO8ao9QUP28BwtfV1HXp5hoTOH6Rvw@mail.gmail.com>
 <87fs15qvu4.fsf@oldenburg.str.redhat.com> <CAJfpegvqBtePer8HRuShe3PAHLbCg9YNUpOWzPg-+=gGwQJWpw@mail.gmail.com>
 <87leawphcj.fsf@oldenburg.str.redhat.com>
In-Reply-To: <87leawphcj.fsf@oldenburg.str.redhat.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 17 Nov 2023 16:13:45 +0100
Message-ID: <CAJfpegsCfuPuhtD+wfM3mUphqk9AxWrBZDa9-NxcdnsdAEizaw@mail.gmail.com>
Subject: Re: proposed libc interface and man page for statmount(2)
To: Florian Weimer <fweimer@redhat.com>
Cc: libc-alpha@sourceware.org, linux-man <linux-man@vger.kernel.org>, 
	Alejandro Colomar <alx@kernel.org>, Linux API <linux-api@vger.kernel.org>, 
	linux-fsdevel@vger.kernel.org, Karel Zak <kzak@redhat.com>, 
	Ian Kent <raven@themaw.net>, David Howells <dhowells@redhat.com>, 
	Christian Brauner <christian@brauner.io>, Amir Goldstein <amir73il@gmail.com>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"

On Fri, 17 Nov 2023 at 15:47, Florian Weimer <fweimer@redhat.com> wrote:

> The strings could get fairly large if they ever contain key material,
> especially for post-quantum cryptography.

A bit far fetched, but okay.

> We have plenty of experience with these double-buffer-and-retry
> interfaces and glibc, and the failure mode once there is much more data
> than initially expected can be quite bad.  For new interfaces, I want a
> way to avoid that.  At least as long applications use statmount_allloc,
> we have a way to switch to a different interface if that becomes
> necessary just with a glibc-internal change.

Fair enough.

And that brings us to listmount(2) where I'm less sure that the
alloc+retry strategy is the right one.  I still think that a namespace
with millions of mounts is unlikely, but it's not completely out of
the question.   Also a listmount_alloc(3) API is less obvious since
the mount ID array as well as its size needs to be returned.    So I'm
thinking whether it's a good idea to turn this into a
open/list/.../close style of interface in libc?  We could do that in
the kernel as well, but I'm not sure it's worth it at this point.

Thanks,
Miklos

