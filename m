Return-Path: <linux-api+bounces-1794-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70995913DD0
	for <lists+linux-api@lfdr.de>; Sun, 23 Jun 2024 21:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D4CF1C20E64
	for <lists+linux-api@lfdr.de>; Sun, 23 Jun 2024 19:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8634218412E;
	Sun, 23 Jun 2024 19:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="OJrysQXD"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012261805E
	for <linux-api@vger.kernel.org>; Sun, 23 Jun 2024 19:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719172739; cv=none; b=T703KxnGwDNGMNQHudAt4oYNIwVX9pAP3Wrfc2aaNBv/3Koh9r8/8NZmVKsUUBEnaFHVrxWgLhdg6UKrYfStHQbigWN4NJw+TE4P5lYwchOsABuUcXMW7sW+52sgm2gc5tz4b250nhUJaAHCzrsb2UQoxpDPaFk/PiK0idjLiVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719172739; c=relaxed/simple;
	bh=jR9bgBA7NYYo6tH/Nt97A1fciIqhK8E1S3zhe9dCOrw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FEdGcVghsvYCNyjv4JtuspTVt3bgfKQIk2FQJxconelnKIrs3eN1An9EB6BXyV0tC1VRF8NSvopUo7QIVrPg4PEKdlyYwlC8Vs+zzx8CpMVgIQh/7eT/tj3Tw4TnUttoQ9qstYVWAGoBtUAxhQHerCIa20791WAm+uZuYhSw3y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=OJrysQXD; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-643efaf0786so4976617b3.1
        for <linux-api@vger.kernel.org>; Sun, 23 Jun 2024 12:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1719172737; x=1719777537; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MPeK97CxUc4C62ykOIb01hARJTE5foK9XL9OL/S8HEM=;
        b=OJrysQXDMr8Q+TpDKYbyoLWzL6ZaTUyztnkfLBcDIvZfIMxfu3ZwNKU9I6+ooQESqc
         sVlcA4C/9ftIq+nj1YJsF2L/tJ4HWHdEkAF0cE5ueoUzTho+B7FT/K++tiHE1SPLBRMW
         XfnDOnQYUmQDP/9CjBxgddaqoZHxva323KvI/QCJVblsnGsEvcamvq3SokFkWP0vYbnz
         0wZXf03W6rVJk3Fg/L5TLkoW4zClP22SD8m2Ma4rdzOrCnqYcNX6szgXaET4oZzhBYFd
         qJmS+GR044F4AGl3ZKoaYCmfIT4ACSGt2pnfC1R+1b0VJ4vjX+KbhAxhLMnvNutAftqn
         N2bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719172737; x=1719777537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MPeK97CxUc4C62ykOIb01hARJTE5foK9XL9OL/S8HEM=;
        b=S8nzPDC/m87OE5+fqk/ckUj3XAMYqhVDn7fhkqvRpQSKyMeafG0ksbv5jvl3GZzVLF
         qSiFTGPYH2zuQTaFymTbrAO5kZVaFA67orYuRMcYL1Li14IVfAlV9FmDjErFTANDye+L
         o/1xXJUjRl8G/WlI6qMksneDZbsz050moVMDZfjwUFYe7sr6fIIpyLZTXwLVfc2rCtqb
         qCBdM7xm1zNlPHfgE/cS2nLCmxlWYaTBU9qqJBGDSU8GafkIBVnOCmppqCa2Yw/aDgcd
         ny7Boltrx6h+uWmBCXmoX66yqfj3200mcHwS9JJB1i/MsPHaNccytx9GhyXZdqYtqPwH
         tEcA==
X-Forwarded-Encrypted: i=1; AJvYcCVJPcRYvUXQ3RJGZ/OT8x6f7AiMT64jyuiov2Ys6/N2lqAiEmz2QRyOOmNVO9S65p1IunA/aIibqfpU+FGSn0FeOuCT0cicQZ5m
X-Gm-Message-State: AOJu0YwoJATFu9ZdTprqn3AtIxRd6xN0sn19SVXX4s/cCzCcwXA/f5Wg
	xYZAD4CDG+VMm6/u4SHmSckWvHpP9+2iEguHu1yFE/JDHMlJ8g8xKIeIGQJMK46k7c4ghCd3dQR
	SYwl+GFYfrQ3H6sgN4MXkbX2ZRYUMrauYWVgG
X-Google-Smtp-Source: AGHT+IGFA9lUJJmnMkAwMpephtbkytW9x1soWCtoiPBgCKUXz3TwA1C4YtW6H+7qK1ib8R0VW+G7w12KOnlD5u81s9Y=
X-Received: by 2002:a81:92d7:0:b0:61a:b199:9313 with SMTP id
 00721157ae682-6433f0e52a0mr20470467b3.16.1719172737018; Sun, 23 Jun 2024
 12:58:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <763db426-6f60-4d36-b3f9-b316008889f7@schaufler-ca.com>
 <83ef6981a29c441b58b525e9292c866a@paul-moore.com> <c59a4954-913b-4672-b502-21aa683d7cdb@schaufler-ca.com>
 <CAHC9VhRjbWuFeprjNP3r7tU27cW6bEZytWq-3XTjzoN7Ki-zzQ@mail.gmail.com> <2cddc480-f911-44e3-b415-33e0cec2964c@schaufler-ca.com>
In-Reply-To: <2cddc480-f911-44e3-b415-33e0cec2964c@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 23 Jun 2024 15:58:46 -0400
Message-ID: <CAHC9VhQBrTo5oXSc=85+ACLF044cDWUbzEt9-b89tHUzK-b8xA@mail.gmail.com>
Subject: Re: [PATCH RFC] LSM, net: Add SO_PEERCONTEXT for peer LSM data
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: LSM List <linux-security-module@vger.kernel.org>, netdev@vger.kernel.org, 
	linux-api@vger.kernel.org, 
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 6:00=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
> On 6/21/2024 12:41 PM, Paul Moore wrote:
> > On Fri, Jun 21, 2024 at 12:06=E2=80=AFPM Casey Schaufler <casey@schaufl=
er-ca.com> wrote:
> >> On 6/20/2024 2:05 PM, Paul Moore wrote:
> >>> On May 13, 2024 Casey Schaufler <casey@schaufler-ca.com> wrote:

...

> > Unrelated to the above, it would also be good to datagram support as a
> > patch 2/2 thing in a future version of this patchset.  Please be
> > careful not to carry over the mistakes we made with SCM_SECURITY (see
> > the GH discussion linked below).
>
> That's "in my queue". I didn't want to spend time on it until I got
> feedback on this one.

Fair enough, thanks.

--=20
paul-moore.com

