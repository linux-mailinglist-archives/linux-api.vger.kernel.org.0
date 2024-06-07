Return-Path: <linux-api+bounces-1691-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F713900BF3
	for <lists+linux-api@lfdr.de>; Fri,  7 Jun 2024 20:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43A0C287752
	for <lists+linux-api@lfdr.de>; Fri,  7 Jun 2024 18:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D59D13FD84;
	Fri,  7 Jun 2024 18:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="lIFmfqmE"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F277A13D8A0
	for <linux-api@vger.kernel.org>; Fri,  7 Jun 2024 18:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717785650; cv=none; b=IP7XS96YIElSVAtjq2LaToGW+gLkrTdu2WJS03Iw1hCQ9grwEOC42KQY2TAkDqkBjJlWCk93lSbhKN0XQTkF/KSMy0uUA9OYhiTIbclJEkrq5Q0l7HcAdtbYllBrq+jrkei5itCFOLumATDKp9cc7njJ4u1CqgsdUC+bp5096gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717785650; c=relaxed/simple;
	bh=nLT1CS3bAADtDvYR/iyCMdc1XfAIDAMUu13CcxexJ8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I5FduQwtYBOc7VzMMA9J1scM+lyL6A179AgVtV7Ofm3JMGL0CmYREpdwXLoNZY/loyN4WF8F0OxnnNtFy2TIXCm6QucbbWyWEbDeL9zDiqJQ9vxb+H53R24ax0ySCvVlTTbF7VIrB4B8D5APmdBAB7Fx6EFlYRiC+FOHgHnmDM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=lIFmfqmE; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3d20697239aso1487994b6e.1
        for <linux-api@vger.kernel.org>; Fri, 07 Jun 2024 11:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1717785648; x=1718390448; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VWP3oVZEyR0+a+YIhKNFwQ+oDZLDTYUDKfQwa7N72nY=;
        b=lIFmfqmEbNvXbeyH1jERzARJtTWuAvqn8uqb5SK7/PMlu5+bWUAmknsp5f1oG/eEGU
         2k7Ykj0gM3WIHu6hZtiEjhFZgBOsLLMSq1rTjGP6vgEZnxK8gzr+ytbTtnkf9q39Cgx+
         1r1FqudUiDptvrkVDye7NpeMW6irl7xOtOzfmLOnK7kgpnAX5oxaskeoorRvA9HhEmVt
         +4WImlEm4LQseVwMZRcD25us6e6AANqC9NMTMMFBNaDP8T7TFdSwd8FHX8XVEwWt4I4J
         ymmTTYL1XE/qlUM0+qdP4PHPYRWPZIPQt+DHQyZij8D0hJox5HXez+0G/7QSJC5tkxFJ
         u4nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717785648; x=1718390448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VWP3oVZEyR0+a+YIhKNFwQ+oDZLDTYUDKfQwa7N72nY=;
        b=V91HV3WAR3rSlbIGxKqnb2rk/OE+ZfdidFUW3hzIHAtYppfVqpQTvrnGBpaPx1p+u3
         lML4/TG/RyQgl6UsaxWn705K21Psr2RbvnF9cK+CEahYtXtjwwkNQ+mGjqd93WYaDYXq
         V0D1Y0s1Wp7gjwI1saAq0Ag/uz2oi5frhj0V7rfi/jV+L+0j3GW8uApwVv9HBFL1R4Hm
         GOfzLg7CaZ0DLRfZdBeG01IZ8GsZOoM+GwH0WZSba+Y6346RdGJuHk86niuuSalYykUO
         gadSbasZ4b95DlE4od3tuIHR4dlyBPXdp78REI2NE0iviNXfzFw1K0Lq7cFS5njrpbNp
         7RKA==
X-Forwarded-Encrypted: i=1; AJvYcCXgk6eR6XSyw9jHuW7mvHViQSnc5kuaoaAKcBF+lVeeMPZxgkcTHElkOepzDN5RW9HBi+KpOkz6oy1RU6HkwEJE37IXxYg97RzS
X-Gm-Message-State: AOJu0YyNaPE10Ss3JXLwwlqImHSJusXKGK7o9EiGG3K7Lp3xZGO0s+94
	fe62Ew2hEpAoHLS5D4ZXmHrurQqUC+lcOiPf4wYQfJ8pojQxCX5bzNW9P5Rxf4QDchfl/oxlZJ0
	IcxNgVn6gnYTpKvc52H/tGhLplOry0bj/O0kO
X-Google-Smtp-Source: AGHT+IGM13uj3U+ARgcKJSVs/VmcSppJ4o+ZTjupN8yH80mNMzyyWgUWj/akZRB539Rs2Rn6cvM6cRncobvhndjrU8I=
X-Received: by 2002:a05:6871:e015:b0:250:7353:c8f2 with SMTP id
 586e51a60fabf-254647efd11mr3404898fac.43.1717785646594; Fri, 07 Jun 2024
 11:40:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528122352.2485958-1-Jason@zx2c4.com> <20240528122352.2485958-2-Jason@zx2c4.com>
In-Reply-To: <20240528122352.2485958-2-Jason@zx2c4.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Fri, 7 Jun 2024 11:40:33 -0700
Message-ID: <CALCETrVJFefyDT6U3QoHdZvNh=3nqk=3AK88eRuqdn4W4t8vsA@mail.gmail.com>
Subject: Re: [PATCH v16 1/5] mm: add VM_DROPPABLE for designating always
 lazily freeable mappings
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: linux-kernel@vger.kernel.org, patches@lists.linux.dev, tglx@linutronix.de, 
	linux-crypto@vger.kernel.org, linux-api@vger.kernel.org, x86@kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>, "Carlos O'Donell" <carlos@redhat.com>, 
	Florian Weimer <fweimer@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, 
	Christian Brauner <brauner@kernel.org>, David Hildenbrand <dhildenb@redhat.com>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 5:24=E2=80=AFAM Jason A. Donenfeld <Jason@zx2c4.com=
> wrote:
>
> The vDSO getrandom() implementation works with a buffer allocated with a
> new system call that has certain requirements:
>
> - It shouldn't be written to core dumps.
>   * Easy: VM_DONTDUMP.

I'll bite: why shouldn't it be written to core dumps?

The implementation is supposed to be forward-secret: an attacker who
gets the state can't predict prior outputs.  And a core-dumped process
is dead: there won't be future outputs.

