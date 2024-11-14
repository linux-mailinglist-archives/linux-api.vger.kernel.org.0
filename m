Return-Path: <linux-api+bounces-2733-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F019C8D57
	for <lists+linux-api@lfdr.de>; Thu, 14 Nov 2024 15:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C89F2821F1
	for <lists+linux-api@lfdr.de>; Thu, 14 Nov 2024 14:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BBED55887;
	Thu, 14 Nov 2024 14:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="HcJ4KFJM"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D7A36AF5
	for <linux-api@vger.kernel.org>; Thu, 14 Nov 2024 14:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731596038; cv=none; b=tGZT2jmv6b8X93/8Vk8jnlqDvYYx45Udi8Tn9ZicsE4aOhn4fNJJ1UfSQ7NFEhzC/BspIPsCl3+GaGkp993kda3KlrQ3pfeang9UQ/at8ottfaZ3WBqf7oLKolaPgwWCGUR+di5qlO1gb0vmXbLxhW0EmAqswCTYzOmDi/XFE44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731596038; c=relaxed/simple;
	bh=ichDtmcn4VqWhaD5o2vzoVWVKZR/T/6Dh4C/2PfddZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QLrwM5EmB1u3BXNgdKnYRFw1/P0ZRC/Lk6HoT6lsVlHxnaEP97jsNuX24BqmESsNc7UAUlfZmFB6lrZEPO84F4nxVhC4JK6M/cjhL2axwi1bzXO0TSfpQ8CX94nqAWPqC7gY4AM5mO9ZP2OQHEmFm6I2PhPXgXm/iNwauQH/KTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=HcJ4KFJM; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-460d2571033so4727891cf.1
        for <linux-api@vger.kernel.org>; Thu, 14 Nov 2024 06:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1731596035; x=1732200835; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+86fnZDIgALt0lZhwOPgdPrulI5sxfQBGW9Idpd7nro=;
        b=HcJ4KFJMt5+B+M+fqS9TmotqieAS1OAgFjfnX3WZzeTj+/h0zWefEuutaHSsd4oTPZ
         EKlsaR4ouZ/eDL8JgPO5jfHvxKitMteDfsMYemOQf6OENAEbNcBGZtfH262rzPKD+E41
         AUDhLRJgzbURy/bqgHVoFKzayzNuREIWrEPV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731596035; x=1732200835;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+86fnZDIgALt0lZhwOPgdPrulI5sxfQBGW9Idpd7nro=;
        b=Qc1LF9s3v/2wVnk5MkUMWq/00GG/rf1hO+za80G++kD8ePaMeq51xnA10SuM+joQSJ
         YBZa96Gi3Pi7PJ85WbIbTnAtAp886e6BoDk3KE5fb3+lSkpUn/9Pza2lVYximneitAGL
         0CNQHZdpfzioZwMg88QLHKF0XqefVfUOlc/T0TeCjR4cOfR4li1deoVPREgdqzX97WtS
         DdhAwvlbve0OU3398dub+0YZB+g6pG48VXXa1RAHVwoMQGHSq9/C4SvDeMbN21FGXCdD
         LKDpzG+nM7qmh0VOZpm46aX4YHurkIOMRr0wE8Dqv1tIxWFsamrzlxJ+TqKysu6oRamX
         W+tQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6J2kY0fD1Sp3V+MmP8eeCmXFdkgBORPBik8cswCGh0XMj+1fSmT+6hSPLPCWxKLq9Wdx0MotB3t0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAlNttWaejc8dfPtt018cKhO9eWYAKnWzVNnnEhxDiKnQsxx2g
	70JES9YiJCApCTZj1vlhrG0bdsEVDFB7wOVrTZAhsUGPm3b8N+RpsVkrAuodGyMfIP4tibmENyH
	DI3w0Xa7/AXSfFlyUUVvw9+EMwweZ2CejhDlxPQ==
X-Google-Smtp-Source: AGHT+IGv8fD5MP4DNcwQ6K3L8G6IG5FWbOqR+W7GGgSihnm3u4KoOiJuLItkn47KJA8f1Qr6zP6RnlQSXzGvSgRxGgU=
X-Received: by 2002:a05:622a:1988:b0:461:66e0:b676 with SMTP id
 d75a77b69052e-4630934dc6fmr286414141cf.13.1731596035296; Thu, 14 Nov 2024
 06:53:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112101006.30715-1-mszeredi@redhat.com> <20241113-unbeobachtet-unvollendet-36c5443a042d@brauner>
 <20241113-wandmalerei-haben-9b19b61e5118@brauner>
In-Reply-To: <20241113-wandmalerei-haben-9b19b61e5118@brauner>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 14 Nov 2024 15:53:44 +0100
Message-ID: <CAJfpegtLiOjbtP4np-WjJ_oyC-u3FwZ4BWQxGkSSmWxurBOQdA@mail.gmail.com>
Subject: Re: [PATCH] statmount: add flag to retrieve unescaped options
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org, Karel Zak <kzak@redhat.com>, 
	Christian Brauner <christian@brauner.io>, Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 13 Nov 2024 at 17:31, Christian Brauner <brauner@kernel.org> wrote:

> Please take a look at the top of #vfs.misc and tell me whether this is
> ok with you.

One more thing I'd do is:

-       if (seq->count == start)
+       if (seq->count <= start + 1)

This would handle the (broken) case of just a single comma in the
options.  So it's not a bug fix per-se, but would make it clear that
the loop will run at least once, and so the seq->count calculation at
the end won't be skewed.

The buf_start calculation could also be moved further down before the
loop, where it's actually used.

I don't find the variable naming much better, how about taking the
naming from string_unescape:

opt_start -> src - pointer to escaped string
buf_start -> dst - pointer to de-escaped string

The others make sense.

Thanks,
Miklos

